/// @description Update light's parameters
/// @param light_id
/// @param index
/// @param newValue
var light = argument[0];

for(i = 1; i < argument_count; i++)
	{
	if(argument_count < i+1)
		exit;
		
	light[@ argument[i]] = argument[i+1];
	}