//An IndexMap is a wrapper for a ds_map for index tables.
function IndexMap() constructor
{
	_map = ds_map_create();
	array = array_create(0, "");
	_size = 0;
	
	#region IndexMap.add_key(key, value);
	/// @function add_key
	/// @param key
	/// @param value
	static add_key = function(_key, _value)
	{
		_key = string(_key);
		if (is_undefined(get_value(_key)))
		{
			_map[? _key] = _value;
			_size ++;
			array_push(array, _key);
		}
		else
		{
			show_error("Key: " + _key + " already exists in IndexMap " + string(self), false);
		}
	}
	#endregion
	#region IndexMap.get_value(key);
	/// @function get_value
	/// @param key
	static get_value = function(_key)
	{
		return _map[? _key];
	}
	#endregion
	#region IndexMap.get_size();
	static get_size = function()
	{
		return _size;
	}
	#endregion
	#region IndexMap.sort();
	static sort = function()
	{
		array_sort(array, true);
	}
	#endregion
	#region IndexMap.clear();
	/// @function clear
	static clear = function()
	{
		array_delete(array, 0, _size);
		ds_map_clear(_map);
		_size = 0;
	}
	#endregion
	#region IndexMap.destroy();
	/// @function destroy
	static destroy = function()
	{
		ds_map_destroy(_map);
	}
	#endregion
}