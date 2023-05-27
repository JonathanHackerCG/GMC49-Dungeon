/// @desc CAMERA: Draw

var inst_num = ds_grid_height(depthgrid);
for (var i = 0; i < inst_num; i++)
{
	var inst = depthgrid[# 0, i];
	if (!inst.is_visible) { continue; }
	with (inst)
	{
		draw_self();
		event_user(15);
	}
}