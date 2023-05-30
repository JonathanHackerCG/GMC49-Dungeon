//General movement functions/collision checking.
//These functions are likely unstable--need more testing.
#region step_direction(direction, speed);
/// @description Causes an instance to step in a particular direction.
/// @function step_direction
/// @param direction
/// @param speed
function step_direction(dir, spd) {
	#region Adjusting parameters.
	var x1 = x; var y1 = y;
	
	//Exit if it will not move at all.
	if (spd == 0)
	{
		return false;
	}
	
	//Make speed absolute and correct direction.
	if (spd < 0)
	{
		dir += 180;
		spd = abs(spd);
	}
	#endregion
	#region Getting x and y components of the movement.
	var xx = lengthdir_x(spd, dir);
	var yy = lengthdir_y(spd, dir);
	#endregion
	#region Periodic rate change (for slow speeds). DISABLED
	//var xrate = 1;
	//if (abs(xx) <= 0.25 && xx != 0)
	//{
	//	xrate = ceil(0.25 / abs(xx));
	//	if (GAMETICK % xrate == 0) { xx = xx * xrate; }
	//	else { xx = 0; }
	//}
	//
	//var yrate = 1;
	//if (abs(yy) <= 0.25 && yy != 0)
	//{
	//	yrate = ceil(0.25 / abs(yy));
	//	if (GAMETICK % yrate == 0) { yy = yy * yrate; }
	//	else { yy = 0; }
	//}
	#endregion
	#region Final Movement.
	xx = rdec(xx);
	yy = rdec(yy);
	x += xx;
	y += yy;
	#endregion
	return (x != x1 || y != y1);
}
#endregion
#region step_direction_solid(direction, speed);
/// @description Causes an instance to step in a particular direction. Stops if it collides with solid objects.
/// @function step_direction_solid
/// @param direction
/// @param speed
function step_direction_solid(dir, spd) {
	#region Adjusting parameters.
	var x1 = x;
	var y1 = y;
	
	//Exit if it will not move at all.
	if (spd == 0)
	{
		return false;
	}
	
	//Make speed absolute and correct direction.
	if (spd < 0)
	{
		dir += 180;
		spd = abs(spd);
	}
	dir = dir % 360;
	#endregion
	#region Getting x and y components of the movement.
	var xx = lengthdir_x(spd, dir);
	var yy = lengthdir_y(spd, dir);
	#endregion
	#region Collision checking and movement.
	if (place_free(x + xx, y) && tile_free(x + xx, y)) { x += xx; }
	//else
	//{
	//	//Moving up against walls horizontally.
	//	if (xx > 0) { move_contact_solid(000, xx); }
	//	else { move_contact_solid(180, -xx); }
	//}
	
	if (place_free(x, y + yy) && tile_free(x, y + yy)) { y += yy; }
	//else
	//{
	//	//Moving up against walls vertically.
	//	if (yy > 0) { move_contact_solid(270, yy); }
	//	else { move_contact_solid(090, -yy); }
	//}
	#endregion
	return (x != x1 || y != y1);
}
#endregion
#region step_direction_solid_simple(direction, speed);
/// @description Causes an instance to step in a particular direction. Stops if it collides with given object.
/// @function step_direction_solid_simple
/// @param direction
/// @param speed
function step_direction_solid_simple(dir, spd) {
	#region Adjusting parameters
	if (spd < 0)
	{
		dir += 180;
		spd = abs(spd);
	}
	if (spd == 0)
	{
		return false;
	}
	#endregion
	#region Final movement.
	var xx = x + lengthdir_x(spd, dir);
	var yy = y + lengthdir_y(spd, dir);

	if (!place_free(xx, yy))
	{
		move_contact_solid(dir, spd);
	}
	else
	{
		x = xx;
		y = yy;
	}
	#endregion
	return (x != xprevious || y != yprevious);
}
#endregion
#region step_towards_point(x, y, distance);
/// @description Moves the instances towards a particular point a particular distance.
/// Returns true/false if it has moved or not.
/// @function step_towards_point(x, y, distance);
/// @param xx
/// @param yy
/// @param distance
function step_towards_point(xx, yy, dis)
{
	//Far enough to move. This check prevents vibrating once reached the position.
	if (point_distance(x, y, xx, yy) >= dis)
	{
		var dir = point_direction(x, y, xx, yy);
		step_direction(dir, dis);

		return true;
	}
	else
	{
		//Set the position exactly.
		x = xx;
		y = yy;
		return false;
	}
}
#endregion
#region step_towards_point_solid(xx, yy, distance);
/// @description Moves the instances towards a particular point a particular distance.
/// Returns true/false if it has moved or not.
/// @function step_towards_point_solid(x, y, distance);
/// @param x
/// @param y
/// @param distance
function step_towards_point_solid(xx, yy, dis)
{
	//Far enough to move. This check prevents vibrating once reached the position.
	dis = min(dis, point_distance(x, y, xx, yy));
	var dir = point_direction(x, y, xx, yy);

	return step_direction_solid(dir, dis);
}
#endregion
#region rdec();
/// @description Rounds a coordinate value to the 1/4 grid
/// @function rdec(value);
/// @param value
/// @param decimal
function rdec() {
	var value = argument[0];
	var ratio = 4;
	return round(value * ratio) / ratio;
}
#endregion
#region snap_to_grid(xsize, ysize, [xoff], [yoff]);
/// @function snap_to_grid
/// @param xsize
/// @param ysize
/// @param {Real} [xoff]
/// @param {Real} [yoff]
function snap_to_grid(_xsize, _ysize, _xoff = 0, _yoff = 0)
{
	x = ceil_mult(x + _xoff, _xsize) - _xoff;
	y = ceil_mult(y + _yoff, _ysize) - _yoff;
}
#endregion

#region step_direction_solid_fast(direction, speed);
/// @func step_direction_solid_fast
/// @desc Moves in a direction avoiding solid objects.
///				Does NOT move to contact. This is fine when using delta time.
///				DOES move smoothly if blocked in one direction.
/// @arg	xspeed
/// @arg	yspeed
/// @arg	{Real} [friction]
/// @arg	{Real} [angle]
function step_direction_solid_fast(_xspd, _yspd, _friction = 1.00, _angle = undefined)
{
	var gox = x + _xspd;
	var goy = y + _yspd;
	if (place_free(gox, goy))
	{
		x = gox;
		y = goy;
	}
	else
	{
		//CG_OPTIMIZE: This math could be performed for each direction only when actually applying bonus speed.
		//Would improve performance when NOT colliding against walls, a little bit. (One less trig function, at least!)
		//NOTE: This code also is rather imperfect. For now I am going to address the rest of the issues using tethers.
		
		//Calculating direction to apply bonus speed.
		var _xang, _yang;
		if (!is_undefined(_angle))
		{
			_xang = sign(lengthdir_x(1, _angle));
			_yang = sign(lengthdir_y(1, _angle));
		}
		else
		{
			_xang = sign(_xspd);
			_yang = sign(_yspd);
		}
		
		//Calculating base bonus speed.
		var _bxspd = abs(_yspd * _friction) * _xang;
		var _byspd = abs(_xspd * _friction) * _yang;
		var newx = x + _bxspd;
		var newy = y + _byspd;
		
		//H Movement + Bonus V Movement
		if (place_free(gox, y)) { x += _xspd; }
		else if (place_free(x, newy)) { y += _byspd; }
		
		//V Movement + Bonus H Movement
		if (place_free(x, goy)) { y += _yspd; }
		else if (place_free(newx, y)) { x += _bxspd; }
	}
}
#endregion

#region tile_free(x, y, layer)
/// @func tile_free(x, y, layer):
/// @arg	x
/// @arg	y
/// @arg	[layer]
function tile_free(_x, _y, _layer = "TilesWalls")
{
  var _tm = layer_tilemap_get_id(_layer);

	var _x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (_x - x), y),
		  _y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (_y - y)),
		  _x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (_x - x), y),
		  _y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (_y - y));

	for (var xx = _x1; xx <= _x2; xx++) {
	for (var yy = _y1; yy <= _y2; yy++) {
    if (tile_get_index(tilemap_get(_tm, xx, yy)))
		{
			return false;
    }
	} }

return true;
}
#endregion

//Movement Component Calculations
//These are essentially vector functions with instance variables. Specialized use.
#region init_movement();
function init_movement()
{
	movement_x = 0;
	movement_y = 0;
	velocity_x = 0;
	velocity_y = 0;
}
#endregion

#region movement_set(x, y);
function movement_set(_xx, _yy)
{
	movement_x = _xx;
	movement_y = _yy;
}
#endregion
#region movement_add_xy(x, y);
function movement_add_xy(_xx, _yy)
{
	movement_x += _xx;
	movement_y += _yy;
}
#endregion
#region movement_is_zero();
function movement_is_zero()
{
	return (movement_x == 0 && movement_y == 0);
}
#endregion
#region movement_magnitude();
function movement_magnitude()
{
	if (movement_is_zero()) { return 0; }
	return (point_distance(0, 0, movement_x, movement_y));
}
#endregion
#region movement_normalize([magnitude]);
function movement_normalize(_max = 1)
{
	var _magnitude = movement_magnitude();
	if (_magnitude != 0)
	{
		var _factor = _max / _magnitude;
		movement_x *= _factor;
		movement_y *= _factor;
	}
}
#endregion
#region movement_limit(max);
function movement_limit(_max)
{
	if (movement_magnitude() > _max)
	{
		movement_normalize(_max);
	}
}
#endregion

#region velocity_set(x, y);
function velocity_set(_xx, _yy)
{
	velocity_x = _xx;
	velocity_y = _yy;
}
#endregion
#region velocity_add_xy(x, y);
function velocity_add_xy(_xx, _yy)
{
	velocity_x += _xx;
	velocity_y += _yy;
}
#endregion
#region velocity_is_zero();
function velocity_is_zero()
{
	return (velocity_x == 0 && velocity_y == 0);
}
#endregion
#region velocity_magnitude();
function velocity_magnitude()
{
	if (velocity_is_zero()) { return 0; }
	return (point_distance(0, 0, velocity_x, velocity_y));
}
#endregion
#region velocity_direction();
function velocity_direction()
{
	if (velocity_is_zero()) { return 0; }
	return (point_direction(0, 0, velocity_x, velocity_y));
}
#endregion
#region velocity_normalize([magnitude]);
function velocity_normalize(_max = 1)
{
	
	if (!velocity_is_zero())
	{
		var _magnitude = velocity_magnitude();
		var _factor = _max / _magnitude;
		velocity_x *= _factor;
		velocity_y *= _factor;
	}
}
#endregion
#region velocity_limit(max);
function velocity_limit(_max)
{
	if (velocity_magnitude() > _max)
	{
		velocity_normalize(_max);
	}
}
#endregion