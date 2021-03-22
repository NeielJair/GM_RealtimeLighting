/// @description Check and Reset Surfaces
if!(surface_exists(global.AmbientSurf))
	global.AmbientSurf = surface_create(room_width, room_height);
surface_set_target(global.AmbientSurf);
draw_clear_alpha(global.AmbientColor, global.AmbientAlpha);
surface_reset_target();

if!(surface_exists(global.BacklightSurf))
	global.BacklightSurf = surface_create(room_width, room_height);
surface_set_target(global.BacklightSurf);
draw_clear_alpha(0, 0);
surface_reset_target();