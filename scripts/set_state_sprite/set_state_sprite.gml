// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @function		set_state_sprite(_sprite_name, _image_speed, _initial_image_index)
/// @param {string} _sprite_name
/// @param {real}	_image_speed
/// @param {real}	_image_speed
function set_state_sprite(_sprite_name, _image_speed, _initial_image_index = 0) {
	if (sprite_index != _sprite_name)
	{
		sprite_index = _sprite_name;
		image_speed = _image_speed;
		image_index = _initial_image_index;
	}
}