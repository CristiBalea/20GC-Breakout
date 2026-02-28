shader_type canvas_item;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    // This checks if the pixel is "Magic Pink" (Red: 1.0, Green: 0.0, Blue: 1.0)
    if (color.r > 0.9 && color.g < 0.1 && color.b > 0.9) {
        discard; // This makes the pixel invisible
    }
    COLOR = color;
}