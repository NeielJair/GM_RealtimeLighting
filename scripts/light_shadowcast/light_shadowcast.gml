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
	rad = Light[lightSys.rad],
	VBuffer = Light[lightSys.VBuffer],
	VFormat = Light[lightSys.VFormat];
	
var tile_size = argument1;     // size of a tile

		surface_set_target(RawLightSurf);
		draw_clear_alpha(0, 0);

var startx = floor((lx-rad)/tile_size);
var endx = floor((lx+rad)/tile_size);
var starty = floor((ly-rad)/tile_size);
var endy = floor((ly+rad)/tile_size);

//if(tilemap_get_at_pixel(tilemap,lx,ly) != 0)
if(TilemapOpacityGrid[# clamp(lx, 0, room_width - 1), clamp(ly, 0, room_height - 1)] != 0)
	{
	surface_reset_target();
	return false;
	}
else
	{
	vertex_begin(VBuffer, VFormat);
	for(var yy=starty;yy<=endy;yy++)
		{
		for(var xx=startx;xx<=endx;xx++)
			{
		    //var tile = tilemap_get_at_pixel(tilemap,xx*tile_size,yy*tile_size);
			var tile = TilemapOpacityGrid[# clamp(xx*tile_size, 0, room_width-1), clamp(yy*tile_size, 0, room_height-1)];
		    if( tile!=0 )
				{
				// get corners of the tile
		        var px1 = xx*tile_size;     // top left
		        var py1 = yy*tile_size;
		        var px2 = px1+tile_size;    // bottom right
		        var py2 = py1+tile_size;


		        scrProjectShadow(VBuffer,  px1,py1, px2,py1, lx,ly, rad);
		        scrProjectShadow(VBuffer,  px2,py1, px2,py2, lx,ly, rad);
		        scrProjectShadow(VBuffer,  px2,py2, px1,py2, lx,ly, rad);
		        scrProjectShadow(VBuffer,  px1,py2, px1,py1, lx,ly, rad);
			
				if( !scrSignTest( px1,py1, px2,py1, lx,ly) )
					    scrProjectShadow(VBuffer,  px1,py1, px2,py1, lx,ly, rad);
			    
				if( !scrSignTest( px2,py1, px2,py2, lx,ly) )
					    scrProjectShadow(VBuffer,  px2,py1, px2,py2, lx,ly, rad);
			    
				if( !scrSignTest( px2,py2, px1,py2, lx,ly) )
					    scrProjectShadow(VBuffer,  px2,py2, px1,py2, lx,ly, rad);
			    
				if( !scrSignTest( px1,py2, px1,py1, lx,ly) )
					    scrProjectShadow(VBuffer,  px1,py2, px1,py1, lx,ly, rad);       
				}
			}
		}

	vertex_end(VBuffer);    
	vertex_submit(VBuffer,pr_trianglelist,-1);
	}

surface_reset_target();
return true;