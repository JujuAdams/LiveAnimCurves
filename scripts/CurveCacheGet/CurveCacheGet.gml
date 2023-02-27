/// @desc  Returns the animation curve from the cache, if available
/// 
/// If the "safe" argument is set to <false>, this function will return <undefined> if the
/// animation curve has not been reloaded using the CurveCacheReload() function. Otherwise,
/// if an animation curve has not been reloaded then the original animation curve will be
/// returned.
/// 
/// Animation curves returned by this function are liable to be destroyed unexpectedly at a
/// later date if CurveCacheReload() is successfully called. You should be wary about storing
/// references to animation curves returned by this function as a result.
/// 
/// @param animCurve
/// @param [safe=true]

function CurveCacheGet(_animCurve, _safe = true)
{
    static _cache = __CurveCache();
    var _originalCurve = animcurve_get(_animCurve);
    var _curve = _cache[$ _originalCurve.name];
    return _safe? (_curve ?? _originalCurve) : _curve;
}