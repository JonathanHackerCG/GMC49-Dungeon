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
if (keyboard_check_pressed(vk_space) && crate_count > 0)
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