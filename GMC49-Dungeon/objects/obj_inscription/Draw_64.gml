/// @desc Inscription: Draw GUI

var GUI_W = CAMERA.gui_w;
var GUI_H = CAMERA.gui_h;

draw_rectangle_set(0, 0, GUI_W, GUI_H, false, back_color, back_alpha);
if (text_scribble != undefined)
{
	text_scribble.draw(GUI_W / 2, GUI_H / 2);
}