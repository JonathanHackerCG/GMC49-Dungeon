/// @desc Pressure Plate: Step
event_inherited();

if (place_meeting(x, y, CRATE) || place_meeting(x, y, PLAYER))
{
	activate();
}
else
{
	deactivate();
}