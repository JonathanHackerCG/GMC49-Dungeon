/// @desc LAYERS: Create

// Initialize layers.
#macro DEFAULT_LAYER LAYERS.future
control = layer_get_id("Control");
future	= layer_get_id("Future");
past		= layer_get_id("Past");
both		= layer_get_id("Both");

// Set link status for ALL objects.
with (ALL)
{
	linked = false;
	if (layer == LAYERS.both)
	{
		linked = true;
		layer = DEFAULT_LAYER;
	}
}