
var _dt = delta_time / 1000000;

if (vsp < 10) vsp += grav * _dt;

var _player_dist = distance_to_object(o_player);

if (!taking_damage)
{
	if (_player_dist < 230 && _player_dist > 20)
	{
		var _player_x = o_player.x;
		if (_player_x < x) horDir = -1;
		else if (_player_x > x) horDir = 1;
	
		hsp = movespeed * horDir * _dt;
	}
	else
	{
		hsp = 0;
	}
}

if (place_meeting(x+hsp, y, o_floor))
{
	while (!place_meeting(x+sign(hsp),y, o_floor))
	{
		x += sign(hsp);
	}
	hsp = 0;
}
x += hsp;

if (place_meeting(x, y+vsp, o_floor))
{
	while (!place_meeting(x, y+sign(vsp), o_floor)) 
	{
		y += sign(vsp);
	}
	vsp = 0;
}
y += vsp;

if (!taking_damage)
{
	if (hsp < 0)
	{
		image_xscale = 1;
		sprite_index = spr_skeleton_walk;
		facing_dir = 1;
	}
	else if (hsp > 0)
	{
		image_xscale = -1;
		sprite_index = spr_skeleton_walk;
		facing_dir = -1;
	}
	else
	{
		sprite_index = spr_skeleton_idle;
	}
}

if (hit_flash > 0) hit_flash = lerp(hit_flash, 0, 0.4);