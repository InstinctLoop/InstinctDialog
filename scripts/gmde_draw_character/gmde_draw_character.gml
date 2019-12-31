/// @func gmde_draw_character(char, index, color, font, effect, shader, cdata)
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


var char = argument0, index = argument1, color = argument2, font = argument3, effect = argument4, shader = argument5, cdata = argument6;

if(char == "\n") {
	data[0] = -cdata[CDATA_X];
	data[1] = cdata[CDATA_LINE_HEIGHT];
	return data;
}

data[0] = string_width(char);


// You can add your own effects below
switch(effect) {
	case "normal":
		draw_text(cdata[CDATA_X], cdata[CDATA_Y], char);
		break;
	case "shaking":
		draw_text(cdata[CDATA_X] + irandom(2) - 1, cdata[CDATA_Y] + irandom(2) - 1, char);
		break;
	case "twitching":
		var r = irandom(20) == 0;
		draw_text(cdata[CDATA_X] + (irandom(2) - 1) * r, cdata[CDATA_Y] + (irandom(2) - 1) * r, char);
		break;
	case "spinning":
		draw_text(cdata[CDATA_X] + cos(index + current_time * 0.075), cdata[CDATA_Y] + sin(index + current_time * 0.075), char);
		break;
	case "random":
		char = irandom_range(32, 127);
		data[0] = string_width(char);
		
		draw_text(cdata[CDATA_X], cdata[CDATA_Y], char);
		break;
	case "rainbow":
		var col1 = make_color_hsv((current_time * 0.05 + index * 15) % 256, 255, 255);
		var col2 = make_color_hsv((current_time * 0.05 + (index + 1) * 15) % 256, 255, 255);
		
		draw_text_color(cdata[CDATA_X], cdata[CDATA_Y], char, col1, col2, col1, col2, draw_get_alpha());
		break;
}
