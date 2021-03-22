/// @description Draw the shadows and block light. Returns true if completed and the light isn't blocked from the source
/// @param light_id
/// @param layer_id
/// @param tilesize
/*
Based on Mike Dailly's posts about realtime lighting:
https://www.yoyogames.com/blog/419/realtime-2d-lighting-in-gamemaker-studio-2-part-1
https://www.yoyogames.com/blog/420/realtime-2d-lighting-in-gamemaker-studio-2-part-2
*/
var Light = argument0,
	lx = Light[lightSys.lx],
	ly = Light[lightSys.ly],
	rad = Light[lightSys.rad];

		surface_set_target(RawLightSurf);
		draw_clear_alpha(0, 0);

var startx = floor(lx-rad);
var endx = floor(lx+rad);
var starty = floor(ly-rad);
var endy = floor(ly+rad);

//if(tilemap_get_at_pixel(tilemap,lx,ly) != 0)
if(TilemapOpacityGrid[# clamp(lx, 0, room_width - 1), clamp(ly, 0, room_height - 1)] != 0)
	{
	surface_reset_target();
	return false;
	}
else
	{	
	for(var yy = starty; yy <= endy; yy++)
		{
		for(var xx = startx; xx <= endx; xx++)
			{
		    if(((xx >= 0 && xx < room_width) && (yy >= 0 && yy < room_height)) && ((TilemapOpacityGrid[# xx, yy] !=0)))
				{	
				var angle = -point_direction(lx,ly,xx,yy);
				//draw_set_color(c_black);
				draw_point_color(xx, yy, c_black);
				
				draw_primitive_begin(pr_trianglestrip);
				    draw_vertex(xx, yy);
				    draw_vertex(xx+rad, yy+rad);
				    draw_vertex(xx+rad*dcos(angle), yy+rad*dsin(angle));
				draw_primitive_end();
				//draw_line_width(xx, yy, xx+rad*dcos(angle), yy+rad*dsin(angle), 5);
				
			
				/*if( !scrSignTest( px1,py1, px2,py1, lx,ly) )
					    scrProjectShadow(VBuffer,  px1,py1, px2,py1, lx,ly, rad);*/    
				}
			}
		}
	}

surface_reset_target();
return true;