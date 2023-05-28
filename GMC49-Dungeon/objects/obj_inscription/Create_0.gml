/// @desc Inscription: Create

back_color = c_black;
back_alpha = 0.5;

text_string = "";
text_scribble = undefined;
text_font = font_get_name(fnt_main);

#region set_font(font);
/// @func set_font
/// @arg	font
function set_font(_font)
{
	text_font = font_get_name(_font);
	_set_scribble();
}
#endregion
#region set_text(text);
/// @func set_text
/// @arg	text
function set_text(_text)
{
	text_string = _text;
	_set_scribble();
}
#endregion
#region _set_scribble();
/// @func _set_scribble
function _set_scribble()
{
	text_scribble = scribble($"[pin_center]{text_string}")
		.starting_format(text_font, c_white)
		.align(fa_center, fa_middle);
}
#endregion