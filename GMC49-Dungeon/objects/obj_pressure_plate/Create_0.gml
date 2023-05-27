/// @desc Pressure Plate: Create
event_inherited();
_depth = RH;

image_speed = 0;
image_index = 0;
active = false;

sprite_past = spr_pressure_plate_P;
sprite_future = spr_pressure_plate_F;

function activate()
{
	active = true;
	image_index = 1;
}

function deactivate()
{
	active = false;
	image_index = 0;
}