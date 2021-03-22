varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vScreenPos;
uniform vec4 u_fLightProperties;        // x=lightx, y=lighty, z=light radius, w=canvas size
uniform vec4 u_fLightColor; //RGBA
uniform bool u_bColorize;
uniform float u_fFalloffMult;

void main()
{
    // Work out vector from room location to the light
    vec2 vect = v_vScreenPos.xy-u_fLightProperties.xy;

    // work out the length of this vector
    float dist = sqrt(vect.x*vect.x + vect.y*vect.y);
	
    // if in range use the shadow texture, if not it's black.
if( dist< u_fLightProperties.w ){
	if(texture2D( gm_BaseTexture, v_vTexcoord ).a >= 0.6)
		{
		gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
		}
	else
		{
	    // work out the 0 to 1 value from the centre to the edge of the radius
	    float falloff = dist/u_fLightProperties.z;          
	    // get the shadow texture
		gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	    // now LERP from the shadow volume shape to total shadow
		if(u_bColorize == false)
			{
			gl_FragColor = mix(vec4(1.0, 1.0, 1.0, 1.0), vec4(0.0, 0.0, 0.0, 0.0), falloff);
			}
		else
			{
			//gl_FragColor = mix(u_fLightColor, vec4(0.0, 0.0, 0.0, 0.0), falloff);
			float colMult = 1.25;
			vec4 newCol = vec4 (u_fLightColor.x * colMult, u_fLightColor.y * colMult,u_fLightColor.z * colMult, u_fLightColor.w);
			gl_FragColor = mix(newCol, vec4(0.0, 0.0, 0.0, 0.0), falloff/colMult);
			
			//gl_FragColor = vec4 (u_fLightColor.x * _nFalloff, u_fLightColor.y * _nFalloff,u_fLightColor.z * _nFalloff, u_fLightColor.w * _nFalloff) 
			//					 + vec4(0.0, 0.0, 0.0, 0.0);
			}
		}
}else{
    // outside the radius - totally in shadow
	gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);     
}
}

