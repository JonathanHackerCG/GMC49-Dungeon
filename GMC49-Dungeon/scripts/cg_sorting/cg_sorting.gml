//For miscellaneous sorting and shuffling purposes. Some is obsolete.
//This CG Module is incomplete.
#region ds_list_sort_stable(list, sort_or_func);
/// @function ds_list_sort_stable(list, sort_or_func);
/// @param list
/// @param sort_or_func
function ds_list_sort_stable(_list, _sort_or_func)
{
	switch (_sort_or_func)
	{
		case undefined:
		case true  : _sort_or_func = function(_a, _b) { return _a > _b }; break;
		case false : _sort_or_func = function(_a, _b) { return _a < _b }; break;
	}
	
	var _size = ds_list_size(_list);
	for (var i = 0; i < _size; i++)
	{
		var key = _list[| i];
		var j = i - 1;
		while (j >= 0 && _sort_or_func(_list[| j], key))
		{
			_list[| j + 1] = _list[| j];
			j --;
		}
		_list[| j + 1] = key;
	}
}
#endregion
#region array_create_from_list();
/// @function array_create_from_list
/// @param list
function array_create_from_list(_list)
{
	var _size = ds_list_size(_list);
	var _array = array_create(_size);
	for (var i = 0; i < _size; i++)
	{
		_array[i] = _list[| i];
	}
	return _array;
}
#endregion
#region list_create_from_array();
/// @function list_create_from_array
/// @param array
function list_create_from_array(_array)
{
	var _size = array_length(_array);
	var _list = ds_list_create();
	for (var i = 0; i < _size; i++)
	{
		ds_list_add(_list, _array[i]);
	}
	return _list;
}
#endregion
#region array_shuffle(_array);
/// @function array_shuffle
/// @param array
function array_shuffle(_array)
{
	static _swap = function(_array, a, b)
	{
		var neo = _array[a];
		_array[@ a] = _array[b];
		_array[@ b] = neo;
	}
	
	var _size = array_length(_array);
	for (var i = 0; i < _size; i++)
	{
		var neo = irandom(_size - 1);
		_swap(_array, i, neo);
	}
}
#endregion