/// @description Draw Lights
// Prepare Surface
if(!global.RenderLights)
	{
	ds_queue_clear(LightQueue);
	exit;
	}

if!(surface_exists(RawLightSurf))
	RawLightSurf = surface_create(room_width, room_height);
	
surface_set_target(RawLightSurf);
draw_clear_alpha(0, 0);
surface_reset_target();

var tS = surface_create(64, 64);

/// Draw Event
var lightProp = shader_get_uniform(shdRealtimeLighting,"u_fLightProperties");
	
while(!ds_queue_empty(LightQueue))
	{
	var curLight = ds_queue_head(LightQueue);
		
	if(is_array(curLight))
		{
		var lx = curLight[lightSys.lx],
			ly = curLight[lightSys.ly],
			rad = curLight[lightSys.rad],
			col = curLight[lightSys.col],
			alpha = curLight[lightSys.alpha],
			FGmult = abs(curLight[lightSys.FGmult]),
			colorize = shader_get_uniform(shdRealtimeLighting,"u_bColorize"),
			circleDraw = true;
				
		if(FGmult != 0)
			{
			if(!surface_exists(tS))
				tS = surface_create(rad*2*FGmult, rad*2*FGmult);
			surface_resize(tS, rad*2*FGmult, rad*2*FGmult);
			surface_set_target(tS);
			draw_clear_alpha(0, 0);
			surface_reset_target();
			}

		if(FGmult != 1)
			{
			circleDraw = light_shadowcast(curLight, Tilesize);
			
			if(circleDraw)
				{
				shader_set(shdRealtimeLighting);
			
				surface_set_target(global.AmbientSurf);
			
				gpu_set_blendmode(bm_subtract);
						
				shader_set_uniform_f(lightProp, lx, ly, rad, rad);
				//shader_set_uniform_f(shader_get_uniform(shdRealtimeLighting,"u_fLightColor"), color_get_red(col), color_get_green(col), color_get_blue(col), alpha);
			
				shader_set_uniform_f(colorize, false);
				draw_surface_part(RawLightSurf, lx-rad, ly-rad, rad*2, rad*2, lx-rad, ly-rad);
					
				surface_reset_target();
				}
			}
			
		//Draw Foreground Light Circle
		if(FGmult != 0)
			{
			shader_set(shdRealtimeLighting);
			surface_set_target(global.AmbientSurf);
			gpu_set_blendmode(bm_subtract);
			shader_set_uniform_f(lightProp, lx, ly, rad*FGmult, rad*FGmult);
			//shader_set_uniform_f(shader_get_uniform(shdRealtimeLighting,"u_fLightColor"), color_get_red(col), color_get_green(col), color_get_blue(col), alpha);
			shader_set_uniform_f(colorize, false);
			draw_surface(tS, lx-rad*FGmult, ly-rad*FGmult);
			}
			
		gpu_set_blendmode(bm_normal);
			
		if(alpha != 0)
			{
			if(!curLight[lightSys.atop])
				{
				surface_reset_target();
				surface_set_target(global.BacklightSurf);
				}
					
			if(circleDraw)
				{
				shader_set_uniform_f(shader_get_uniform(shdRealtimeLighting,"u_fLightProperties"), lx, ly, rad*FGmult, rad);
				shader_set_uniform_f(shader_get_uniform(shdRealtimeLighting,"u_fLightColor"), color_get_red(col)/255, color_get_green(col)/255, color_get_blue(col)/255, alpha);
				shader_set_uniform_f(colorize, true);
				shader_set_uniform_f(shader_get_uniform(shdRealtimeLighting, "u_fFalloffMult"), FGmult);
				draw_surface_part(RawLightSurf, lx-rad, ly-rad, rad*2, rad*2, lx-rad, ly-rad);
				}
			}
			
		surface_reset_target();
		shader_reset();
		}
	
	curLight[@ lightSys.enqueued] = false;
	ds_queue_dequeue(LightQueue);
	}
		
surface_free(tS);