var _dt = delta_time / 1000000;

var _right_key = keyboard_check(ord("D")) || keyboard_check(vk_right);
var _left_key = -(keyboard_check(ord("A")) || keyboard_check(vk_left));
var _jump_key = keyboard_check_pressed(vk_space);
var _attack_key = keyboard_check_pressed(ord("J"));
var _roll_key = keyboard_check_pressed(vk_shift);

hor_dir = _left_key + _right_key;

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
	set_state_sprite(s_player_idle, idle_image_speed);
	
	if (hor_dir != 0 && !place_meeting(x+hor_dir, y, o_floor))
	{
		current_state = "Move";
	}
	
	if (_jump_key)
	{
		last_state = "Idle";
		current_state = "Jump";
	}
	
	if (_attack_key)
	{
		current_state = "Attack1";
	}
}
else if (current_state == "Move")
{
	set_state_sprite(s_player_run, move_image_speed);
	
	hsp = hor_dir * move_speed;
	
	if (!place_meeting(x+hor_dir, y, o_floor))
	{
		if (hor_dir < 0)
		{
			image_xscale = -1;
		}
		else if (hor_dir > 0)
		{
			image_xscale = 1;
		}
		else 
		{
			current_state = "Idle";
		}
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
	
	if (_attack_key)
	{
		current_state = "Attack1";
	}
	
	if (_roll_key)
	{
		if (!place_meeting(x+move_speed*_dt*image_xscale, y, o_floor))
		{
			last_state = "Move";
			current_state = "Roll";
			hsp = hor_dir * roll_speed;
		}
		
	}
}
else if (current_state == "Attack1")
{
	set_state_sprite(s_player_attack1, attack_image_speed);
	
	if !(instance_exists(o_attack_collider))
	{
		var _x = x + 36 * image_xscale;
		var _hit_box = instance_create_layer(_x, y, "Instances", o_attack_collider);
		_hit_box.alarm[0] = 0.1 * game_get_speed(gamespeed_fps);
	}
	
	if (_attack_key && animation_hit_frame_range(2))
	{
		current_state = "Attack2";
	}
}
else if (current_state == "Attack2")
{
	set_state_sprite(s_player_attack2, attack_image_speed);
	
	if !(instance_exists(o_attack_collider))
	{
		var _x = x + 36 * image_xscale;
		var _hit_box = instance_create_layer(_x, y, "Instances", o_attack_collider);
		_hit_box.alarm[0] = 0.1 * game_get_speed(gamespeed_fps);
	}
}
else if (current_state == "Roll")
{
	set_state_sprite(s_player_roll, roll_image_speed);
}


if (current_state == "Jump")
{
	if (place_meeting(x, y+1, o_floor))
	{
		vsp = _jump_key * -jump_force;
	}
	if (vsp == 0)
	{
		if (hor_dir != 0)
			current_state = "Move";
		else
			current_state = "Idle";
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