/// @desc PLAYER: Draw

for (var i = 0; i < crate_count; i++)
{
	var _crate = crates[i];
	var xx = 0;
	var yy = i * 10;
	draw_sprite(_crate.sprite_index, 0, x - xx, y - yy);
}