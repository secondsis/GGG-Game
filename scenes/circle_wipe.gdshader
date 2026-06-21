shader_type canvas_item;

uniform vec2 screen_size;
uniform vec2 center = vec2(0.5, 0.5);
uniform float radius : hint_range(0.0, 1.5) = 1.0;
uniform float softness = 0.1;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	// Called for every pixel the material is visible on.
	vec2 uv = (FRAGCOORD.xy - 0.5 * screen_size) / max(screen_size.x, screen_size.y);
	
	float dist = distance(uv, center);
	
	float alpha = smoothstep(radius, radius + softness, dist);
	
	COLOR = vec4(38.0f/255.0f, 13.0f/255.0f, 52.0f/255.0f, alpha);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
