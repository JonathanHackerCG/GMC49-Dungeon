/// @desc Inscription Utilities

function show_inscription(_text)
{
	with (obj_inscription) { instance_destroy(); }
	var _inst = instance_create_layer(0, 0, "Control", obj_inscription);
	_inst.set_text(_text);
	return _inst;
}