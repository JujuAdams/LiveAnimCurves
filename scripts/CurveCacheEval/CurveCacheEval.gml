/// @desc  Evaluates a channel from a cached animation curve
/// 
/// If an animation curve has not been reloaded then the initial state of the animation curve
/// is used for evaluation.
/// 
/// @param animCurve
/// @param channel
/// @param parameter

function CurveCacheEval(_animCurve, _channel, _parameter)
{
    return CurveEval(CurveCacheGet(_animCurve), _channel, _parameter);
}