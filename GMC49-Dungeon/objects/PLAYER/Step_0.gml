/// @desc PLAYER: Step

_depth = -bbox_bottom;
#region Movement
var DIR = input_direction("left", "right", "up", "down");
var DIS = input_distance("left", "right", "up", "down");

if (DIS > 0 && DIR != undefined)
{
	step_direction_solid(DIR, DIS * move_speed);
}
#endregion
#region Grabbing Crates
var _inst = instance_place(x, y, CRATE);
if (instance_exists(_inst) && !_inst.grabbed)
{
	with (_inst)
	{
		grabbed = true;
		x = -100;
		y = -100;
	}
	
	array_push(crates, _inst);
	crate_count ++;
}
#endregion
#region Placing Crates
if (input_check_pressed("action") && crate_count > 0)
{
	_inst = crates[0];
	with (_inst)
	{
		x = PLAYER.x;
		y = PLAYER.y;
	}
	
	array_delete(crates, 0, 1);
	crate_count --;
}
#endregion