/// @desc DEBUG: Step

if (keyboard_check_pressed(vk_f12))
{
	game_end();
}

if (keyboard_check_pressed(vk_numpad1))
{
	move_to_past();
}

if (keyboard_check_pressed(vk_numpad2))
{
	move_to_future();
}