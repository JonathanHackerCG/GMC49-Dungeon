//LAYER MANAGEMENT
#region move_to_future();
/// @func move_to_future():
/// @desc Transition to the Future.
function move_to_future()
{
	_set_active_layer(LAYERS.future);
	with (ALL)
	{
		sprite_index = sprite_future;
	}
}
#endregion
#region move_to_past();
/// @func move_to_past();
/// @desc Transition to the Past.
function move_to_past()
{
	_set_active_layer(LAYERS.past);
	with (ALL)
	{
		sprite_index = sprite_past;
	}
	
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