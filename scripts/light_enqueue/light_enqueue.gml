/// @description Add light to the lights queue.
/// @params light_id Light to add to queue
if(!instance_exists(objLightController) || (!is_array(argument0)) || (argument0[lightSys.enqueued] == true) || (global.AmbientAlpha == 0))
	exit;
	
ds_queue_enqueue(objLightController.LightQueue, argument0);
argument0[@ lightSys.enqueued] = true;