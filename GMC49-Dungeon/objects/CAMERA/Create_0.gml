/// @description Camera initialization and methods.

#region EDIT: Camera settings.
cam_speed_arrow = 0;		//Panning speed with WASD.
cam_speed_mouse = 0;		//Panning speed with mouse.
clamp_cursor = false;		//Clamp cursor within game window.

fullscreen = true;			//Fullscreen or windowed.

//Potential user zoom values.
zoom_options = [1];
zoom_index = 0; //Default zoom value (index).

//Pre-scaling options. Recommendation: DO NOT MODIFY.
prescale_options = [1, 2, 4];		//Prescale options. Whole numbers only.
prescale_index = 1;							//Default prescale value (index).

//Post-scaling options.
//prescale_index is chosen automatically.
postscale_options = [1, 2, 3, 4];						//Final canvas scaling to fit the screen.
array_push(postscale_options, 1.5);					//Works if prescale_options includes 2.
//array_push(postscale_options, 1.25, 1.75);	//Works if prescale_options includes 4.
#endregion
#region Single-time initialization.
cam_id = camera_create_view(0, 0, 0, 0, 0, noone, -1, -1, -1, -1);

fade_color = c_black;
fade_alpha = 0.0;
fade_alpha_real = fade_alpha;
fade_time = second(2.0);

scale_override = 0;

shake = 0;

target_zoom = 2;
max_zoom = 4;
min_zoom = 1;
zoom = 1;

cam_panning_buffer = 10;
#endregion

#region init();
/// @description Create the camera data and initialize.
/// @function init_camera();
function init()
{
	//Width variables
	width = 1;
	height = 1;
	wcenter = width / 2;
	hcenter = height / 2;
	
	//GUI variables
	gui_w = 1;
	gui_h = 1;
	
	//Coordinate variables
	xpos = 0;
	ypos = 0;
	xpos_target = 0;
	ypos_target = 0;
	xpos_base = xpos;
	ypos_base = ypos;
	xcenter = xpos + wcenter;
	ycenter = ypos + hcenter;
	
	camera_set_view_pos(cam_id, xpos, ypos);
	camera_set_view_size(cam_id, width, height);

	view_camera[0] = cam_id;
	view_visible[0] = true;
	view_enabled[0] = true;
}
#endregion
#region update();
/// @description Updates camera variables.
function update()
{
	//Caching values.
	var w = width / zoom;
	var h = height / zoom;
	
	//Camera move settings. (Does nothing currently).
	xmove = 0;
	ymove = 0;
	spd_move = 0;
	
	//Center camera position and clamp within room.
	var set_xpos = xpos - (w / 2) + random_range(-shake, shake);
	var set_ypos = ypos - (h / 2) + random_range(-shake, shake);
	set_xpos = clamp(set_xpos, 0, room_width - w);
	set_ypos = clamp(set_ypos, 0, room_height - h);
	
	camera_set_view_pos(cam_id, set_xpos, set_ypos);
	camera_set_view_size(cam_id, w, h);
}
#endregion
#region set_position(xpos, ypos);
function set_position(_xpos, _ypos)
{
	xpos = _xpos;
	ypos = _ypos;
}
#endregion
#region in_view(x, y);
/// @func in_view(x, y):
/// @desc Returns true if position is in view of the camera.
/// @arg x
/// @arg y
/// @arg {Real} [buffer]
function in_view(_x, _y, _buffer = 0)
{
	var x1 = xpos - (width  / zoom / 2) + _buffer;
	var y1 = ypos - (height / zoom / 2) + _buffer;
	var x2 = xpos + (width  / zoom / 2) - _buffer;
	var y2 = ypos + (height / zoom / 2) - _buffer;
	return (_x >= x1 && _y >= y1 && _x <= x2 && _y <= y2);
}
#endregion
#region follow(inst, factor, [xoffset], [yoffset]);
/// @description The camemra follows an instance
/// @function follow(instance, factor, [xoffset], [yoffset]);
/// @param instance
/// @param factor
/// @param [xoffset]
/// @param [yoffset]
function follow(_inst, _factor, _xoff, _yoff)
{
	//NOTE: This follow method no longer works, please update before using.
	if (is_undefined(_xoff)) { _xoff = 0; }
	if (is_undefined(_yoff)) { _yoff = 0; }
	if (is_undefined(_inst) || !instance_exists(_inst)) { return false; }

	//Find target locations.
	var targetx = rdec(_inst.x - wcenter + _xoff);
	var targety = rdec(_inst.y - hcenter + _yoff);
	targetx = clamp(targetx, 0, room_width - width);
	targety = clamp(targety, 0, room_height - height);
	
	var minimum = 0.25;
	if (xpos == targetx && ypos == targety) {	_moving = false; return false; }
	
	#region X-Movement
	var xdis = targetx - xpos;
	if (xdis > minimum) {	xpos += ceil_divd(xdis / _factor, 4); }
	else if (xdis < -minimum)	{ xpos += floor_divd(xdis / _factor, 4);	}
	else { xpos = targetx; }
	xpos_base = xpos - _xoff;
	#endregion
	#region Y-Movement
	var ydis = targety - ypos;
	if (ydis > minimum)	{	ypos += ceil_divd(ydis / _factor, 4); }
	else if (ydis < -minimum)	{	ypos += floor_divd(ydis / _factor, 4);	}
	else { ypos = targety; }
	ypos_base = ypos - _yoff;
	#endregion
	
	update();
	_moving = true;
	return true;
}
#endregion
#region is_moving();
function is_moving()
{
	return _moving;
}
#endregion
#region init_screen(width_min, width_max, height_min, height_max, scale_base, fullscreen, [original]);
/// @description Initializes the screen display / scaling.
/// @param width_min
/// @param width_max
/// @param height_min
/// @param height_max
/// @param scale_base
/// @param fullscreen
/// @param [original]
function init_screen(w_min, w_max, h_min, h_max, scale_base, fullscreen, original)
{
	if (is_undefined(original)) { original = false; }
	#region Updating parameter values.
	w_min	*= scale_base;
	h_min	*= scale_base;
	w_max	*= scale_base;
	h_max	*= scale_base;
	var buffer_w = 64;
	var buffer_h = 128;
	#endregion
	#region Calculating target width and height.
	var target_w, target_h;
	var screen_w = display_get_width();	 //Screen width  (real).
	var screen_h = display_get_height(); //Screen height (real).
	if (fullscreen)
	{
		target_w = screen_w; //Target final width.
		target_h = screen_h; //Target final height.
	}
	else
	{
		target_w = screen_w - buffer_w; //Target final width.
		target_h = screen_h - buffer_h; //Target final height.
	}
	#endregion
	#region Determining the scale factor.
	var a, a_max = 0;
	var scale_w = clamp(w_max, w_min, target_w);
	var scale_h = clamp(h_max, h_min, target_h);
	var scale_real = 1;
	#endregion
	#region Choosing viable scale factors from the base scale value
	var scale_list;
	if (original) { scale_list = [1]; }
	else
	{
		scale_list = postscale_options;
	}
	#endregion
	#region Calculate the largest possible scale factor based on target size.
	var _size = array_length(scale_list);
	var _scale_base = prescale_options[prescale_index];
	var s, w_min_scaled, w_max_scaled, h_min_scaled, h_max_scaled;
	for (var i = 0; i < _size; i++)
	{
		s = scale_list[i];
		
		w_min_scaled = w_min * s;
		h_min_scaled = h_min * s;
		w_max_scaled = min(w_max * s, target_w);
		h_max_scaled = min(h_max * s, target_h);
		if (w_max_scaled < w_min_scaled || h_max_scaled < h_min_scaled) { continue; }
		
		a = w_max_scaled * h_max_scaled;
		if (a > a_max)
		{
			a_max = a;
			scale_real = s;
			scale_w = floor(w_max_scaled / s);
			scale_h = floor(h_max_scaled / s);
		}
	}
	#endregion
	#region Set window size/fullscreen enabled.
	if (fullscreen)
	{
		window_set_fullscreen(true);
		offx = (screen_w - (scale_w * scale_real)) / 2;
		offy = (screen_h - (scale_h * scale_real)) / 2;
	}
	else
	{
		window_set_fullscreen(false);
		window_set_size(scale_w * scale_real, scale_h * scale_real);
		offx = 0;
		offy = 0;
	}
	surface_resize(application_surface, scale_w,  scale_h);
	s_base = scale_base;
	s_real = scale_real;
	#endregion
	#region Resize the CAMERA.
	width  = scale_w / scale_base;
	height = scale_h / scale_base;
	wcenter = width  / 2;
	hcenter = height / 2;
	camera_set_view_size(cam_id, width, height);
	#endregion
	#region Resize the GUI.
	display_set_gui_maximize(s_base, s_base, 0, 0);
	gui_w = display_get_gui_width() * s_real;
	gui_h = display_get_gui_height() * s_real;
	#endregion
	#region Set camera view values.
	view_camera[0] = cam_id;
	view_visible[0] = true;
	view_enabled[0] = true;
	#endregion
	//update();
	alarm[0] = 1; //Update Window
}
#endregion
#region set_fade(alpha, [time], [color]);
function set_fade(_alpha, _time = second(2.0), _color = c_black)
{
	fade_alpha = _alpha;
	fade_time = _time;
	fade_color = _color;
	
	if (fade_time <= 0)
	{
		//Intantly set.
		fade_alpha_real = fade_alpha;
	}
}
#endregion
#region is_fading();
function is_fading()
{
	return (fade_alpha_real != fade_alpha);
}
#endregion

//Custom functions.
#region init_screen_default();
function init_screen_default()
{
	var _s_base = prescale_options[prescale_index];
	CAMERA.scale_override = 0;
	CAMERA.init_screen(320, 320, 180, 180, 4, fullscreen);
}
#endregion
#region toggle_fullscreen();
function toggle_fullscreen()
{
	fullscreen = !fullscreen;
	init_screen_default();
}
#endregion

init();