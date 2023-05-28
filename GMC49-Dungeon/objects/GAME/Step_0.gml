/// @desc GAME: Step

if (input_check_pressed("help"))
{
	if (!instance_exists(obj_inscription))
	{
		show_inscription("Hello");
	}
	else
	{
		with (obj_inscription) { instance_destroy(); }
	}
}