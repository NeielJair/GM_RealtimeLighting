/// @description Init Variables
global.RenderLights = true;

global.AmbientColor = $000000;
global.AmbientAlpha = .7;
global.AmbientSurf = surface_create(64, 64);
global.BacklightSurf = surface_create(64, 64);

enum lightSys
	{
	enqueued, //(bool) is in queue?
	lx,		  //light's position X
	ly,		  //light's position Y 
	rad,	  //light's radius
	col,      //light's color
	alpha,	  //light's alpha
	atop,	  //(bool) does it avoid colliding with tiles?
	FGmult,	  //relative intensity of the foreground illumination (0 = none; 1 = max)
	VBuffer,  //(don't touch) vertex buffer to draw the shadows on
	VFormat   //(don't touch) vertex format for the shadows to be drawn
	}