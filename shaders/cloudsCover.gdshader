shader_type canvas_item;

uniform vec2 Direction = vec2(1.0,0.0);

uniform float Speed = 0.02f;

void fragment() {
	COLOR = texture(TEXTURE, UV + (Direction * TIME * Speed));
}
