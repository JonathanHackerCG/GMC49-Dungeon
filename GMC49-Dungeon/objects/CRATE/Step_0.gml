/// @desc CRATE: Step

_depth = -bbox_bottom;
if (grabbed)
{
	if (x > 0 && y > 0)
	{
		if (!place_meeting(x, y, PLAYER)) { grabbed = false; }
	}
}