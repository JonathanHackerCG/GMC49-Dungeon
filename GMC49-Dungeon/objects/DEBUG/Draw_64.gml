/// @desc DEBUG: Draw GUI

if (instance_exists(PLAYER))
{
	draw_text(8, 8, layer_get_name(PLAYER.layer));
}