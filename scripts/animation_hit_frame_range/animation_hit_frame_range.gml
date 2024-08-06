/// @function	  animation_hit_frame_range(_initial_frame, _last_frame)
/// @param {real} _initial_frame
/// @param {real} _last_frame
/// will return `true` if the current frame is between `_initial_frame` and
/// `_last_frame`
/// `_last_frame` is optional (default: last animation frame)
function animation_hit_frame_range(_initial_frame, _last_frame = image_number - 1)
{
	return image_index >= _initial_frame && image_index <= _last_frame;
}