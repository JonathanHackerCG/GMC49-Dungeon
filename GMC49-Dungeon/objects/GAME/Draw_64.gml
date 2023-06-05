/// @desc GAME: Draw GUI

draw_set_font(fnt_ui);
draw_set_valign(fa_center);
if (secrets > 0)
{
	draw_sprite_ext(spr_secret, 0, 32, 32, 4, 4, 0, c_white, 1.0);
	draw_text(32 + 32, 32, $"Secrets: {secrets}/{secrets_max}");
}

draw_set_halign(fa_right);
draw_text(CAMERA.gui_w - 32, 32, "Help - F1");

draw_reset();