if (current_state == "Attack1")
{
	image_index = 0;
	current_state = last_state;
	current_attack_combo = 2;
	alarm[0] = 1 * game_get_speed(gamespeed_fps);
}
else if (current_state == "Attack2")
{
	image_index = 0;
	current_state = last_state;
	current_attack_combo = 0;
}