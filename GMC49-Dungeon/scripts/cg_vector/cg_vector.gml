/// @desc 2D Vector class. NOTE: Slow.
#region _Vector() constructor
function _Vector() constructor
{
	xx = 0;
	yy = 0;
	
	#region set(xx, yy);
	static set = function(_xx, _yy)
	{
		xx = _xx;
		yy = _yy;
		return self;
	}
	#endregion
	#region add(vector);
	/// @func add
	/// @arg vector
	static add = function(_vec)
	{
		xx += _vec.xx;
		yy += _vec.yy;
		return self;
	}
	#endregion
	#region add_xy(xx, yy);
	/// @func add_xy
	/// @arg xx
	/// @arg yy
	static add_xy = function(_xx, _yy)
	{
		xx += _xx;
		yy += _yy;
		return self;
	}
	#endregion
	#region add_ld(len, dir);
	/// @func add_ld
	/// @arg len
	/// @arg dir
	static add_ld = function(_len, _dir)
	{
		xx += lengthdir_x(_len, _dir);
		yy += lengthdir_y(_len, _dir);
		return self;
	}
	#endregion
	#region len();
	/// @func len
	static len = function()
	{
		return point_distance(0, 0, xx, yy);
	}
	#endregion
	#region dir();
	/// @func dir
	static dir = function()
	{
		return point_direction(0, 0, xx, yy);
	}
	#endregion
	#region normalize([len]);
	/// @func normalize
	/// @arg {Real} [len]
	static normalize = function(_max = 1)
	{
		var _len = len();
		if (_len != 0)
		{
			var _factor = _max / _len;
			xx *= _factor;
			yy *= _factor;
		}
		return self;
	}
	#endregion
	#region limit(len);
	static limit = function(_len)
	{
		if (len() > _len)
		{
			normalize(_len);
		}
		return self;
	}
	#endregion
	#region multiply(val);
	static multiply = function(_val)
	{
		xx = xx * _val;
		yy = yy * _val;
		return self;
	}
	#endregion
	#region is_zero();
	static is_zero = function()
	{
		return xx == 0 && yy == 0;
	}
	#endregion
}
#endregion
#region VectorZero() constructor
/// @func VectorZero
function VectorZero() : _Vector() constructor
{
	xx = 0;
	yy = 0;
}
#endregion
#region VectorXY(xx, yy) constructor
/// @func VectorXY
/// @arg xx
/// @arg yy
function VectorXY(_xx, _yy) : _Vector() constructor
{
	xx = _xx;
	yy = _yy;
}
#endregion
#region VectorLD(len, dir) constructor
/// @func VectorLD
/// @arg len
/// @arg dir
function VectorLD(_len, _dir) : _Vector() constructor
{
	xx = lengthdir_x(_len, _dir);
	yy = lengthdir_y(_len, _dir);
}
#endregion