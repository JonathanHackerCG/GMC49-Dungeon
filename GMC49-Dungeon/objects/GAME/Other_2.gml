/// @desc GAME: Game Start
room_goto(rm_main);

function initialize_wires()
{
	#region _copy_targets(object);
	static _copy_targets = function(_object)
	{
		static temp = ds_list_create();
		ds_list_clear(temp);
		var num = instance_place_list(x, y, _object, temp, false);
		for (var i = 0; i < num; i++)
		{
			var inst = temp[| i];
			targets = array_union(targets, inst.targets);
		}
	}
	#endregion
	
	static MAX_COUNT = 10;
	var count = 0;
	var done, num, init_size;
	var temp = ds_list_create();
	do
	{
		done = true;
		
		with (obj_wire)
		{
			init_size = array_length(targets);
			ds_list_clear(temp);
			num = instance_place_list(x,  y, obj_door, temp, false);
			for (var i = 0; i < num; i++)
			{
				array_push(targets, temp[| i]);
			}
			targets = array_unique(targets);
			
			_copy_targets(obj_wire);
			if (init_size != array_length(targets)) { done = false; }
		}
		
		with (obj_pressure_plate)
		{
			init_size = array_length(targets);
			_copy_targets(obj_wire);
			if (init_size != array_length(targets)) { done = false; }
			
			show_debug_message($"Found Targets: {targets}");
		}
		
		count ++;
		show_debug_message(count);
	} until (done || count > MAX_COUNT);
	ds_list_destroy(temp);
	
	with (obj_pressure_plate)
	{
		array_foreach(targets, function(_element, _index)
		{
			_element.triggers_required ++;
		});
	}
}