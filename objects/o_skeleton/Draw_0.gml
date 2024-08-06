draw_self();
if (hit_flash > 0)
{
	gpu_set_fog(true, c_white, 0, 0)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_white, hit_flash);
	gpu_set_fog(false, c_white, 0, 0);
}