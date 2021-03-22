/// @description Create Realtime Lighting Light
/// @param light_x
/// @param light_y
/// @param radius
/// @param color
/// @param alpha
/// @param atop
/// @param FGmult

var light;

light[lightSys.enqueued] = false;
light[lightSys.lx] = argument0;
light[lightSys.ly] = argument1;
light[lightSys.rad] = argument2;
light[lightSys.col] = argument3;
light[lightSys.alpha] = argument4;
light[lightSys.atop] = argument5;
light[lightSys.FGmult] = clamp(argument6, 0, 1);

//init shadow casting
vertex_format_begin();
vertex_format_add_position();
vertex_format_add_color();
light[lightSys.VFormat] = vertex_format_end();

light[lightSys.VBuffer] = vertex_create_buffer();

return light;