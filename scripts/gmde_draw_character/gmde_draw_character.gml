/// @arg char
/// @arg index
/// @arg color
/// @arg font
/// @arg effect
/// @arg shader
/// @arg cdata

#macro CDATA_X 0
#macro CDATA_Y 1
#macro CDATA_LINE_HEIGHT 2

var data = [];
data[0] = 0; // Inc Width
data[1] = 0; // Inc Height
data[2] = 0; // Char Height
data[3] = 0; // Line Width

var char = argument0, index = argument1, color = argument2, font = argument3, effect = argument4, shader = argument5, cdata = argument6;

if(char == "\n") {
	data[0] = -cdata[3];
	data[1] = cdata[CDATA_LINE_HEIGHT];
	data[2] = -cdata[CDATA_LINE_HEIGHT];
	data[3] = -cdata[3];
	return data;
}

data[0] = string_width(char);
if(cdata[CDATA_LINE_HEIGHT] < string_height(char))data[2] = string_height(char) - cdata[CDATA_LINE_HEIGHT];

var character = char, xpos = cdata[CDATA_X], ypos = cdata[CDATA_Y], color1 = color, color2 = color, color3 = color, color4 = color;

for(var i = 0; i < ds_list_size(effect); i++) {
	var efct = effect[|i];
	
	// You can add your own effects below
	switch(efct) {
		case "shaking":
			xpos += irandom(2) - 1;
			ypos += irandom(2) - 1;
			break;
		case "twitching":
			var r = irandom(10) == 0;
			
			if(r) {
				xpos += irandom(2) - 1;
				ypos += irandom(2) - 1;
			}
			
			break;
		case "spinning":
			xpos += cos(index + current_time * 0.01) * 2;
			ypos += sin(index + current_time * 0.01) * 2;
			break;
		case "random":
			character = chr(irandom_range(32, 127));
			break;
		case "rainbow":
			var col1 = make_color_hsv((current_time * 0.05 + index * 15) % 256, 255, 255);
			var col2 = make_color_hsv((current_time * 0.05 + (index + 1) * 15) % 256, 255, 255);
			
			color1 = col1;
			color2 = col2;
			color3 = col1;
			color4 = col2;
			
			break;
	}
}

var sh = shader_current();
shader_reset();

surface_set_target(global.gmde_char_surface);

draw_clear_alpha(c_black, 0);

data[0] = string_width(character);
data[3] = data[0];
draw_text_color(0, 0, character, color1, color2, color3, color4, draw_get_alpha());

surface_reset_target();

shader_set(sh);
draw_surface(global.gmde_char_surface, xpos, ypos);

return data;