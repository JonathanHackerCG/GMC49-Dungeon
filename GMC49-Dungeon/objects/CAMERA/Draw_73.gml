/// @description Rendering all objects.

#region Screen fade effect.
if (fade_alpha_real > 0.0)
{
	draw_set_color(fade_color);
	draw_set_alpha(fade_alpha_real);
	draw_rectangle(xpos, ypos, xpos + width, ypos + height, false);
	draw_set_color(c_white);
	draw_set_alpha(1.0);
}
#endregion

//con.draw();
