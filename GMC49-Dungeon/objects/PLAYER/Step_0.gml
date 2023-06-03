/// @desc PLAYER: Step

_depth = -bbox_bottom;
#region Movement
var DIR = input_direction("left", "right", "up", "down");
var DIS = input_distance("left", "right", "up", "down");

if (DIS > 0 && DIR != undefined)
{
	step_direction_solid(DIR, DIS * move_speed);
	
	sprite_dir = round(DIR / 90) % 4;
	sprite_index = sprites_walk[sprite_dir];
}
else
{
	sprite_index = sprites_idle[sprite_dir];
}
#endregion
#region Plaques
can_interact = false;
var _plaque = instance_nearest(x, y, obj_plaque);
if (instance_exists(_plaque) && distance_to_object(_plaque) <= 20)
{
	can_interact = true;
	if (input_check_pressed("action") && !instance_exists(obj_inscription))
	{
		show_inscription(_plaque.text);
	}
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
if (!can_interact && input_check_pressed("action") && crate_count > 0)
{
	if (instance_exists(obj_inscription))
	{
		with (obj_inscription) { instance_destroy(); }
	}
	else
	{
		_inst = crates[0];
		with (_inst)
		{
			x = PLAYER.x;
			y = PLAYER.y + 4;
		}
	
		array_delete(crates, 0, 1);
		crate_count --;
	}
}
#endregion
#region Time Portals
if (place_meeting(x, y, obj_time_portal))
{
	if (can_portal)
	{
		swap_worlds();
		can_portal = false;
	}
}
else { can_portal = true; }
#endregion