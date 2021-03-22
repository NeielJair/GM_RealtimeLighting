/// @description Gets each pixel's opacity values in a tilemap
/// @param TilemapIds

var tilemap = argument0,
	surf = surface_create(room_width, room_height),
	grid = ds_grid_create(room_width, room_height);
	
surface_set_target(surf);
draw_clear_alpha(0, 0);

if(!is_array(tilemap))
	draw_tilemap(tilemap, 0, 0);
else
	{
	for(i = 0; i < array_length_1d(tilemap); i++)
		{
		draw_tilemap(tilemap[i], 0, 0);
		}
	}
	
surface_reset_target();

var buff = buffer_getpixel_begin(surf);

for(i = 0; i < room_width; i++)
	{
	for(j = 0; j < room_height; j++)
		{
			grid[# i, j] = (buffer_getpixel_a(buff, i, j, room_width, room_height));
		}
	}
	
surface_free(surf);

return grid;