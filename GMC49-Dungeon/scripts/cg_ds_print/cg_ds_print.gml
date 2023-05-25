/// @desc Printing the contents of data structures (for debugging).
#region ds_list_print(list);
/// @func ds_list_print
/// @arg	list
function ds_list_print(_list)
{
	var _output = string(_list) + ": [ ";
	var _size = ds_list_size(_list);
	for (var i = 0; i < _size; i++)
	{
		_output += "(" + string(_list[| i]) + ") ";
	}
	return _output + "]";
}
#endregion