/// @desc Pressure Plate: Create
event_inherited();

targets = [];

_depth = RH;
image_speed = 0;
image_index = 0;
active = false;

sprite_past = spr_pressure_plate_P;
sprite_future = spr_pressure_plate_F;

function activate()
{
	if (active) { return false; }
	
	active = true;
	image_index = 1;
	
	array_foreach(targets, function(_element, _index)
	{
		_element.trigger();
	});
	
	return true;
}

function deactivate()
{
	if (!active) { return false; }
	
	active = false;
	image_index = 0;
	
	array_foreach(targets, function(_element, _index)
	{
		_element.detrigger();
	});
	
	return true;
}