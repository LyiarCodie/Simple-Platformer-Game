var _dt = delta_time / 1000000;

var _right_key = keyboard_check(ord("D")) || keyboard_check(vk_right);
var _left_key = -(keyboard_check(ord("A")) || keyboard_check(vk_left));
var _jump_key = keyboard_check_pressed(vk_space);
var _attack_key = keyboard_check_pressed(ord("J"));

var _hor_dir = _left_key + _right_key;

if (vsp < 10) {
	vsp += grav * _dt;
	is_grounded = 0;
}

#region Collision
// horizontal
if (place_meeting(x+hsp, y, o_floor))
{
	while (!place_meeting(x+sign(hsp), y, o_floor))
	{
		x += sign(hsp);
	}
	hsp = 0;
}
x += hsp;

// vertical
if (place_meeting(x, y+vsp, o_floor))
{
	while (!place_meeting(x, y+sign(vsp), o_floor))
	{
		y += sign(vsp);
	}
	vsp = 0;
	is_grounded = 1;
}
y += vsp;
#endregion

if (current_state == "Idle")
{
	sprite_index = s_player_idle;
	image_speed = idle_image_speed;
	
	if (_hor_dir != 0)
	{
		current_state = "Move";
		image_index = 0;
	}
	
	if (_jump_key)
	{
		last_state = "Idle";
		current_state = "Jump";
	}
	
	if (_attack_key && current_attack_combo <= 0)
	{
		image_index = 0;
		last_state = "Idle";
		current_state = "Attack1";
	}
	else if (_attack_key && current_attack_combo >= 2)
	{
		image_index = 0;
		last_state = "Idle";
		current_state = "Attack2";
	}
}
else if (current_state == "Move")
{
	hsp = _hor_dir * move_speed * _dt;
	image_speed = move_image_speed;
	
	if (_hor_dir < 0)
	{
		image_xscale = -1;
		sprite_index = s_player_run;
	}
	else if (_hor_dir > 0)
	{
		image_xscale = 1;
		sprite_index = s_player_run;
	}
	else 
	{
		image_index = 0;
		current_state = "Idle";
	}
	
	if (_jump_key)
	{
		last_state = "Move";
		current_state = "Jump";
	}
	
	if (_attack_key && current_attack_combo <= 0)
	{
		image_index = 0;
		last_state = "Move";
		current_state = "Attack1";
	}
	else if (_attack_key && current_attack_combo >= 2)
	{
		image_index = 0;
		last_state = "Move";
		current_state = "Attack2";
	}
}
else if (current_state == "Attack1")
{
	image_speed = attack_image_speed;
	
	current_attack_combo = 1;
	sprite_index = s_player_attack1;
	
	if !(instance_exists(o_attack_collider))
	{
		var _x = x + 36 * image_xscale;
		var _hit_box = instance_create_layer(_x, y, "Instances", o_attack_collider);
		_hit_box.alarm[0] = 0.1 * game_get_speed(gamespeed_fps);
	}
}
else if (current_state == "Attack2")
{
	image_speed = attack_image_speed;
	
	sprite_index = s_player_attack2;
	
	if !(instance_exists(o_attack_collider))
	{
		var _x = x + 36 * image_xscale;
		var _hit_box = instance_create_layer(_x, y, "Instances", o_attack_collider);
		_hit_box.alarm[0] = 0.1 * game_get_speed(gamespeed_fps);
	}
}


if (current_state == "Jump")
{
	if (place_meeting(x, y+1, o_floor))
	{
		vsp = _jump_key * -jump_force;
	}
	if (vsp == 0)
	{
		image_index = 0;
		current_state = last_state;
	}
	
	if (vsp < 0)
	{
		sprite_index = s_player_jump;
	}
	else if (vsp > 0)
	{
		sprite_index = s_player_fall;
	}
}

if (current_state == "Idle" || current_state == "Jump" || current_state == "Attack1" || current_state == "Attack2")
{
	
	if (vsp != 0)
	{
		hsp = lerp(hsp, 0, 0.01);
	}
	else 
	{
		hsp = 0;
	}
}

show_debug_message(current_state);