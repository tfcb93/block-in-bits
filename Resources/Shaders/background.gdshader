shader_type canvas_item;
	
void fragment() {
	COLOR = vec4(abs(cos(TIME * 0.2)) * UV.r, abs(sin(TIME * 0.4)) * UV.g, abs(cos(TIME * 0.1)) + 0.3, 1.0);
}

void vertex() {
	// VERTEX += vec2(.5,.5);
	// VERTEX += vec2(cos(TIME)*100.0, sin(TIME)*100.0);
}