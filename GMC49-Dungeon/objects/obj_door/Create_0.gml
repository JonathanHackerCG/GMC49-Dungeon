/// @desc Door: Create
event_inherited();

triggers = 0;
image_speed = 0;

sprite_past = spr_door_P;
sprite_future = spr_door_F;

function trigger()
{
	triggers ++;
	if (triggers >= triggers_required)
	{
		image_index = 1;
	}
}

function detrigger()
{
	triggers --;
	if (triggers < triggers_required)
	{
		image_index = 0;
	}
}