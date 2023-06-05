/// @desc LAYERS: Room Start

GAME.secrets_max = instance_number(obj_secret);

// Move to the default layer.
if (DEFAULT_LAYER == LAYERS.past) { move_to_past(); }
else { move_to_future(); }