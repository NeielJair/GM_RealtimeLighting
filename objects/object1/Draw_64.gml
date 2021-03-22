/// @description Insert description here
// You can write your code in this editor
draw_set_color(color);
draw_text(0, 0, fgmult);

draw_set_color(make_color_rgb(colR, 0, 0));
draw_text(0, 32, colR);
draw_set_color(make_color_rgb(0, colG, 0));
draw_text(32, 32, colG);
draw_set_color(make_color_rgb(0, 0, colB));
draw_text(64, 32, colB);

draw_set_color(c_white);
draw_text(0, 64, alpha);

draw_set_color(c_olive);
draw_text(0, 96, point_direction(room_width/2, room_height/2, mouse_x, mouse_y));

if(object_exists(objLightController))
	{
	var lightController = instance_find(objLightController, 0);
	if(lightController != noone)
		{
		draw_set_color(c_teal);
		draw_text(0, 128, lightController.TilemapOpacityGrid[# clamp(mouse_x, 0, room_width), clamp(mouse_y, 0, room_height)]);
		}
	}
	
draw_set_color(c_white);