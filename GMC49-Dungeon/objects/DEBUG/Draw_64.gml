/// @desc DEBUG: Draw GUI

if (!enabled) { exit; }
if (instance_exists(PLAYER))
{
	draw_text(8, 8, layer_get_name(PLAYER.layer));
}