/// @description Initialize camera view.

switch (scale_override)
{
	case 0: { CAMERA.init_screen_default(); } break;
	case 1: { CAMERA.init_screen(320, 332, 180, 192, 4, fullscreen, true); } break; //Orignal Scale
	case 2: { CAMERA.init_screen(300, 300, 169, 169, 4, fullscreen, true); } break; //Twitter Scale
}

if (instance_exists(PLAYER))
{
	follow(PLAYER, 0);
}