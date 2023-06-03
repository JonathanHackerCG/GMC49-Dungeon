/// @desc PLAYER: Draw

draw_sprite(spr_player_shadow, 0, x, y + 2);
draw_self();
for (var i = 0; i < crate_count; i++)
{
	var _crate = crates[i];
	var xx = 0;
	var yy = i * 7;
	draw_sprite(_crate.sprite_index, 0, x - xx, y - yy - 12);
}

if (can_interact)
{
	draw_sprite(spr_exclaim, 0, x + 0.5, y - 16 + animate_sin(second(0.5)));
}