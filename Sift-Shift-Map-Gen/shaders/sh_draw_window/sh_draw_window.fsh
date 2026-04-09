//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 window;
uniform vec2 resolution;

void main()
{
	float x1_pos = window.x / resolution.x;
	float x2_pos = window.z / resolution.x;
	float y1_pos = window.y / resolution.y;
	float y2_pos = window.w / resolution.y;
	
	vec4 col = vec4(v_vColour.xyz * 0.6, v_vColour.w);
	
	if(x1_pos <= v_vTexcoord.x && v_vTexcoord.x <= x2_pos && y1_pos <= v_vTexcoord.y && v_vTexcoord.y <= y2_pos)
	{
		col = v_vColour;	
	}

    gl_FragColor = col * texture2D( gm_BaseTexture, v_vTexcoord );
}
