/// @desc PLAYER: Step

#region Movement
var xx = keyboard_check(vk_right) - keyboard_check(vk_left);
var yy = keyboard_check(vk_down)	- keyboard_check(vk_up);

if (xx != 0 || yy != 0)
{
	x += xx * move_speed;
	y += yy * move_speed;
}
#endregion
#region Grabbing Crates
var _inst = instance_place(x, y, obj_crate);
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

#endregion