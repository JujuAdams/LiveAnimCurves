var _curve = CurveCacheGet(acTest);

var _j = 0;
repeat(array_length(_curve.channels))
{
    switch(_j)
    {
        case 0: draw_set_colour(c_blue  ); break;
        case 1: draw_set_colour(c_red   ); break;
        case 2: draw_set_colour(c_lime  ); break;
        case 3: draw_set_colour(c_yellow); break;
    }
    
    draw_primitive_begin(pr_linestrip);
    
    var _i = 0;
    repeat(101)
    {
        draw_vertex(_i*room_width, room_height*(0.5 - 0.5*CurveEval(_curve, _j, _i)));
        _i += 1/100;
    }
    
    draw_primitive_end();
    
    ++_j;
}

draw_set_colour(c_white);
draw_text(10, 10, "Anim Curve live updating    @jujuadams 2023-02-27\nPress F5 to reload acTest (make sure to save your changes in the IDE first!)");