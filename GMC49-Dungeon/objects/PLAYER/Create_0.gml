/// @desc PLAYER: Create
event_inherited();

skip_draw_self = true;

move_speed = 2.0;

crates = [];
crate_count = 0;

sprite_dir = 3;
sprites_idle = [spr_player_idle_E, spr_player_idle_N, spr_player_idle_W, spr_player_idle_S];
sprites_walk = [spr_player_walk_E, spr_player_walk_N, spr_player_walk_W, spr_player_walk_S];