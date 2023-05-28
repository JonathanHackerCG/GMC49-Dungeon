//LAYER MANAGEMENT
#macro IN_PAST global.__in_past
#macro IN_FUTURE global.__in_future

#region swap_worlds();
/// @func swap_worlds();
/// @desc Swaps between times/worlds.
function swap_worlds()
{
	if (IN_FUTURE) { move_to_past(); }
	else { move_to_future(); }
}
#endregion
#region move_to_future();
/// @func move_to_future():
/// @desc Transition to the Future.
function move_to_future()
{
	IN_FUTURE = true;
	IN_PAST = false;
	
	_set_active_layer(LAYERS.future);
	with (ALL)
	{
		sprite_index = sprite_future;
	}
	set_background(bkg_F);	
}
#endregion
#region move_to_past();
/// @func move_to_past();
/// @desc Transition to the Past.
function move_to_past()
{
	IN_FUTURE = false;
	IN_PAST = true;
	
	_set_active_layer(LAYERS.past);
	with (ALL)
	{
		sprite_index = sprite_past;
	}
	set_background(bkg_P);
}
#endregion
#region _set_active_layer(lay_id);
/// @func _set_active_layer(lay_id):
/// @desc Change which layer is activated.
function _set_active_layer(_lay_id)
{
	static _previous_layer = undefined;
	if (_previous_layer != _lay_id)
	{
		with (ALL)
		{
			if (linked) { layer = _lay_id; }
		}
		with (PLAYER)
		{
			for (var i = 0; i < crate_count; i++)
			{
				var _crate = crates[i];
				_crate.layer = _lay_id;
			}
		}
		
		instance_deactivate_layer(LAYERS.past);
		instance_deactivate_layer(LAYERS.future);
		instance_activate_layer(_lay_id);
		_previous_layer = _lay_id;
	}
}
#endregion

#region set_background(sprite);
/// @func set_background
/// @arg	sprite
function set_background(_sprite)
{
	var lay_id = layer_get_id("Background");
	var back_id = layer_background_get_id(lay_id);
	layer_background_sprite(back_id, _sprite);
}
#endregion