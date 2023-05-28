#macro RW room_width
#macro RH room_height
#macro bbox_xcenter (bbox_left + (bbox_right - bbox_left) / 2)
#macro bbox_ycenter (bbox_top + (bbox_bottom - bbox_top) / 2)

/// @func get_bbox_xcenter
/// @arg	inst
function get_bbox_xcenter(_inst)
{
	with (_inst) { return bbox_xcenter; }
}

/// @func get_bbox_ycenter
/// @arg	inst
function get_bbox_ycenter(_inst)
{
	with (_inst) { return bbox_ycenter; }
}

