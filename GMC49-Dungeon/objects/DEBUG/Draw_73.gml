/// @desc DEBUG: Draw End
if (!enabled) { exit; }

with (obj_pressure_plate)
{
	var _size = array_length(targets);
	for (var i = 0; i < _size; i++)
	{
		var _inst = targets[i];
		draw_line_set(bbox_xcenter, bbox_ycenter, get_bbox_xcenter(_inst), get_bbox_ycenter(_inst), c_aqua);
	}
}
draw_reset();