/// @description Updating.

if (instance_exists(PLAYER)) { follow(PLAYER, 10, width / 2, height / 2); }
update();

if (is_fading())
{
	fade_alpha_real += (1.0 / fade_time) * sign(fade_alpha - fade_alpha_real);
	fade_alpha_real = clamp(fade_alpha_real, 0.0, 1.0);
}

if (keyboard_check_pressed(vk_f11))
{
	toggle_fullscreen();
	init_screen_default();
}