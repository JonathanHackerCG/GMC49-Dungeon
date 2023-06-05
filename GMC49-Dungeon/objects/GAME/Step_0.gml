/// @desc GAME: Step

if (input_check_pressed("help"))
{
	if (!instance_exists(obj_inscription))
	{
		show_inscription(help_string);
	}
	else
	{
		with (obj_inscription) { instance_destroy(); }
	}
}

if (keyboard_check_pressed(vk_escape))
{
	game_end();
}