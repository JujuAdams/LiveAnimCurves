/// @desc  Evaluates a channel from an animation curve
/// 
/// This function does not explicitly check the animation curve cache and is provided for
/// convenience only.
/// 
/// @param animCurve
/// @param channel
/// @param parameter

function CurveEval(_animCurve, _channel, _parameter)
{
    return animcurve_channel_evaluate(animcurve_get_channel(_animCurve, _channel), _parameter);
}