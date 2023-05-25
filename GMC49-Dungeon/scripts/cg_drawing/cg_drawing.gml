/// @desc Quick functions for drawing simple things.
#region draw_reset();
function draw_reset()
{
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_set_alpha(1.0);
}
#endregion
#region draw_text_set(x, y, string, [font], [halign], [valign], [color], [alpha]);
/// @function draw_text_set
/// @param x
/// @param y
/// @param string
/// @param [font]
/// @param [halign]
/// @param [valign]
/// @param [color]
/// @param {Real} [alpha]
function draw_text_set(_x, _y, _string, _font = fnt_default, _halign = fa_left, _valign = fa_top, _color = c_white, _alpha = 1.0)
{
	draw_set_font(_font);
	draw_set_halign(_halign);
	draw_set_valign(_valign);
	draw_set_color(_color);
	draw_set_alpha(_alpha);
	draw_text(_x, _y, _string);
}
#endregion
#region draw_rectangle_set(x1, y1, x2, y2, outline, [color], [alpha]);
/// @function draw_rectangle_set
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param outline
/// @param [color]
/// @param {Real} [alpha]
function draw_rectangle_set(_x1, _y1, _x2, _y2, _outline, _color = c_white, _alpha = 1.0)
{
	draw_set_color(_color);
	draw_set_alpha(_alpha);
	draw_rectangle(_x1, _y1, _x2, _y2, _outline);
}
#endregion
#region draw_line_set(x1, y1, x2, y2, outline, [color], [alpha]);
/// @function draw_line_set
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param [color]
/// @param {Real} [alpha]
function draw_line_set(_x1, _y1, _x2, _y2, _color = c_white, _alpha = 1.0)
{
	draw_set_color(_color);
	draw_set_alpha(_alpha);
	draw_line(_x1, _y1, _x2, _y2);
}
#endregion
#region animate_sin(rate, [offset]);
/// @func animate_sin
/// @arg rate
/// @arg [offset]
function animate_sin(_rate, _offset = 0)
{
	return sin((GAMETICK + _offset) / _rate);
}
#endregion
#region animate_cos(rate, [offset]);
/// @func animate_cos
/// @arg rate
/// @arg [offset]
function animate_cos(_rate, _offset = 0)
{
	return cos((GAMETICK + _offset) / _rate);
}
#endregion