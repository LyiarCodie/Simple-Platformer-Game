if (!took_damage)
{
	took_damage = 1;
	hit_flash = 1
	current_state = "Damage";
	damage_count++;
	image_index = 0;
	alarm[0] = 0.5 * game_get_speed(gamespeed_fps);
}