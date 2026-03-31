//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	float avg = gl_FragColor.x + gl_FragColor.y + gl_FragColor.z;
	avg /= 3.0;
	
	gl_FragColor.xyz = vec3(avg, avg, avg);
}
