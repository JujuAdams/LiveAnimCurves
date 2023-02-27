/// @desc  Reloads an animation curve from your project
/// 
/// This function will only work when running from the IDE, and targeting either Windows, Mac,
/// or Linux. Additionally, this function will *always* reload an animation curve and does no
/// work to consider if the animation curve has changed.
/// 
/// @param animCurve

function CurveCacheReload(_animCurve)
{
    static _cache = __CurveCache();
    
    if ((os_type != os_windows) && (os_type != os_macosx) && (os_type != os_linux))
    {
        show_debug_message("Cannot reload anim curve: This platform is not supported");
        return;
    }
    
    if (GM_build_type != "run")
    {
        show_debug_message("Cannot reload anim curve: Not running from IDE");
        return;
    }
    
    var _animCurveData = animcurve_get(_animCurve);
    var _name = _animCurveData.name;
    var _filename = filename_dir(GM_project_filename) + "\\animcurves\\" + _name + "\\" + _name + ".yy";
    
    var _buffer = buffer_load(_filename);
    if (_buffer < 0) show_error("Could not load " + _filename + "\nCheck that you have disabled the file system sandbox\n ", true);
    
    var _jsonString = buffer_read(_buffer, buffer_text);
    buffer_delete(_buffer);
    
    var _json = json_parse(_jsonString);
    
    var _newCurve = animcurve_create();
    if (variable_struct_exists(_cache, _name)) animcurve_destroy(_cache[$ _name]);
    _cache[$ _name] = _newCurve;
    
    switch(_json[$ "function"])
    {
        case 0:
            var _jsonCurveType = animcurvetype_linear;
        break;
        
        case 1:
            var _jsonCurveType = animcurvetype_catmullrom;
        break;
        
        case 2:
            show_error("Bezier-type curves not supported due to GameMaker deficiencies", true);
        break;
        
        default:
            show_error("Unhandled curve type " + string(_json[$ "function"]), true);
        break;
    }
    
    var _jsonChannels = _json.channels;
    var _newChannels  = array_create(array_length(_jsonChannels), undefined);;
    
    var _i = 0;
    repeat(array_length(_jsonChannels))
    {
        var _jsonChannel = _jsonChannels[_i];
        var _newChannel = animcurve_channel_new();
        _newChannels[@ _i] = _newChannel;
        
        _newChannel.type = _jsonCurveType;
        
        var _jsonPoints = _jsonChannel.points;
        var _newPoints = array_create(array_length(_jsonPoints), undefined);
        
        var _p = 0;
        repeat(array_length(_jsonPoints))
        {
            var _jsonPoint = _jsonPoints[_p];
            var _newPoint = animcurve_point_new();
            _newPoints[@ _p] = _newPoint;
            
            _newPoint.posx  = _jsonPoint.x;
            _newPoint.value = _jsonPoint.y;
            
            ++_p;
        }
        
        _newChannel.points = _newPoints;
        
        ++_i;
    }
    
    _newCurve.channels = _newChannels;
    
    show_debug_message("Reloaded \"" + _filename + "\"");
}