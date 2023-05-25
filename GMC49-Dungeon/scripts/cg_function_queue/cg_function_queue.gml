//FunctionQueue. Essentially a function based state machine.
function FunctionQueue() constructor
{
	_functions = ds_list_create();
	_parameters = ds_list_create();
	_target = noone;
	_pos = 0;
	_length = 0;
	
	//FunctionQueue setters/getters.
	#region FunctionQueue.clear();
	/// @function clear();
	/// @description Clears the FunctionQueue and resets pos.
	static clear = function()
	{
		ds_list_clear(_functions);
		ds_list_clear(_parameters);
		_length = 0;
		reset();
	}
	#endregion
	#region FunctionQueue.skip_to_match(_func, _param);
	/// @func skip_to_match(func, param):
	/// @desc Moves the FunctionQueue forward until it reaches a matching value, or the end of the queue.
	///				If undefined, the comparison will assume true.
	/// @arg	func
	/// @arg	[param]
	static skip_to_match = function(_func, _param = undefined)
	{
		do
		{
			_pos ++;
			if (_func == undefined || _func == _functions[| _pos])
			{
				if (_param == undefined || _param == _parameters[| _pos])
				{
					return true;
				}
			}
		} until (_pos >= _length);
		clear();
		return false;
	}
	#endregion
	#region FunctionQueue.reset();
	/// @function reset();
	/// @description Sets the FunctionQueue to the start.
	static reset = function()
	{
		_pos = -1;
	}
	#endregion
	#region FunctionQueue.size();
	/// @function size();
	/// @description Returns the current size of the queue.
	static size = function()
	{
		return _length;
	}
	#endregion
	#region FunctionQueue.empty();
	/// @function empty();
	/// @description Returns true for empty FunctionQueue.
	static empty = function()
	{
		return _length == 0;
	}
	#endregion
	#region FunctionQueue.set_target(target);
	/// @function set_target(target);
	/// @description Sets the target instance to perform the functions.
	/// @param target
	static set_target = function(_target)
	{
		self._target = _target;
	}
	#endregion
	#region FunctionQueue.print();
	/// @function print();
	/// @description Outputs the contents of the FunctionQueue as a string.
	static print = function()
	{
		var _size = _length;
		if (_size == 0) { return "FunctionQueue: EMPTY"; }
		
		var output = "FunctionQueue:\n";
		show_debug_message(string(_size) + ", " + string(ds_list_size(_functions)) + ", " + string(ds_list_size(_parameters)));
		for (var i = 0; i < _size; i++)
		{
			if (i == _pos) { output += "> "; }
			show_debug_message(string(_functions[| i]));
			output += script_get_name(_functions[| i]) + "(" + string(_parameters[| i]) + ")\n";
		}
		return output;
	}
	#endregion
	
	//FunctionQueue operations.
	#region FunctionQueue.update();
	/// @function update();
	/// @description Run current function and update conditionally.
	static update = function()
	{
		//Check for functions in the queue.
		if (empty()) { return false; }
		if (_pos == -1) { _pos = 0; }
		
		//Run the function, if it returns true progress to the next function in the queue.
		var func = _functions[| _pos];
		var params = _parameters[| _pos];
		var done = false;
		
		if (is_undefined(func) || func == noone)
		{
			done = true;
		}
		else
		{
			if (_target == noone) { done = func(params); }
			else
			{
				with(_target) { done = func(params); }
				if (!instance_exists(_target)) { return false; }
			}
		}
		
		if (done)
		{
			_pos++;
			if (_pos >= _length)
			{
				clear();
				return false;
			}
			else
			{
				update();
			}
			return true;
		}
	}
	#endregion
	#region FunctionQueue.insert_pos(pos, function);
	/// @function insert_pos(pos, function);
	/// @description Inserts a function at a position.
	/// @param pos
	/// @param function
	/// @param [params]
	static insert_pos = function(_pos, _func, _params = undefined)
	{
		ds_list_insert(_functions, _pos + i - 1, _func);
		ds_list_insert(_parameters, _pos + i - 1, _params);
		_length++;
	}
	#endregion
	#region FunctionQueue.insert_now(function, [params]);
	/// @function insert_now(function, [params]):
	/// @desc Inserts a function before the current position, interrupting the current action.
	/// @param function
	/// @param [params]
	static insert_now = function(_func, _params = undefined)
	{
		if (_pos == -1) { _pos = 0; }
		ds_list_insert(_functions, _pos, _func);
		ds_list_insert(_parameters, _pos, _params);
		_length++;
	}
	#endregion
	#region FunctionQueue.insert_next(function, [params]);
	/// @function insert_next(function, [params]):
	/// @description Inserts a function after the current position.
	/// @param function
	/// @param [params]
	static insert_next = function(_func, _params = undefined)
	{
		ds_list_insert(_functions, _pos + 1 + i, _func);
		ds_list_insert(_parameters, _pos + 1 + i, _params);
		_length++;
	}
	#endregion
	#region FunctionQueue.insert_append(function, [params]);
	/// @function insert_append(function, [params]):
	/// @description Inserts a function at the end of the FunctionQueue.
	/// @param function
	/// @param [params]
	static insert_append = function(_func, _params = undefined)
	{
		//Insert every input into the functions list.
		ds_list_add(_functions, _func);
		ds_list_add(_parameters, _params);
		_length++;
	}
	#endregion
	#region FunctionQueue.delete_this();
	/// @function delete_this
	static delete_this = function()
	{
		ds_list_delete(_functions, _pos);
		ds_list_delete(_parameters, _pos);
		_pos--;
		_length--;
	}
	#endregion
	#region FunctionQueue.back();
	/// @function back();
	/// @description Moves the queue back one position.
	static back = function()
	{
		if (_pos > 0) { _pos --; return true; }
		return false;
	}
	#endregion
		
	//FunctionQueue cleanup.
	#region FunctionQueue.destroy();
	/// @description Clears all dynamic memory from the FunctionQueue.
	function destroy()
	{
		ds_list_destroy(_functions);
		ds_list_destroy(_parameters);
	}
	#endregion
}

#region function_ext(_function, _params);
/// @description Runs a functin/method with a list of parameters.
/// @param function
/// @param parameters
function function_ext(_function, _params)
{
	var size = ds_list_size(_params);
	switch(size)
	{
		case 0: return _function();
		case 1: return _function(_params[| 0]);
		case 2: return _function(_params[| 0], _params[| 1]);
		case 3: return _function(_params[| 0], _params[| 1], _params[| 2]);
		case 4: return _function(_params[| 0], _params[| 1], _params[| 2], _params[| 3]);
		case 5: return _function(_params[| 0], _params[| 1], _params[| 2], _params[| 3], _params[| 4]);
		case 6: return _function(_params[| 0], _params[| 1], _params[| 2], _params[| 3], _params[| 4], _params[| 5]);
		case 7: return _function(_params[| 0], _params[| 1], _params[| 2], _params[| 3], _params[| 4], _params[| 5], _params[| 6]);
		case 8: return _function(_params[| 0], _params[| 1], _params[| 2], _params[| 3], _params[| 4], _params[| 5], _params[| 6], _params[| 7]);
		case 9: return _function(_params[| 0], _params[| 1], _params[| 2], _params[| 3], _params[| 4], _params[| 5], _params[| 6], _params[| 7], _params[| 8]);
		default: show_error("Too many arguments. Update function_ext to make it work, you nitwit!", false); return false;
	}
}
#endregion