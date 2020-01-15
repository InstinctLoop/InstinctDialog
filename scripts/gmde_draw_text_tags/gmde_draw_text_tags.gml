/// @func gmde_draw_text_tags(x, y, string)

var color = ds_list_create(), font = ds_list_create(), effect = ds_list_create(), shader = ds_list_create();

ds_list_add(color,  global.gmde_default_color);
ds_list_add(font,   global.gmde_default_font);
ds_list_add(effect, global.gmde_default_effect);
ds_list_add(shader, global.gmde_default_shader);

var str = argument0;
var strlen = string_length(str);

var ignore = false;

var index = 0;
var cdata = [0, 0, 0];

for(var i = 1; i < strlen + 1; i++) {
	var char = string_char_at(str, i);
	
	if(ignore) {
		var data = gmde_draw_character_prepare(char, index++, color[|ds_list_size(color) - 1], font[|ds_list_size(font) - 1], effect[|ds_list_size(effect) - 1], shader[|ds_list_size(shader) - 1], cdata);
		cdata[0] += data[0];
		cdata[1] += data[1];
		cdata[2] += data[2];
		break;
	}
	
	if(char == global.gmde_tag_open_character) {
		var tag = "", value = "", swch = false, j = 1;
		
		while(string_char_at(str, i + j) != global.gmde_tag_close_character && (i + j) <= string_length(str)) {
			if(!swch) {
				if(string_char_at(str, i + j) == global.gmde_tag_value_separator) swch = true;
				else tag += string_char_at(str, i + j);
			}
			else value += string_char_at(str, i + j);
			
			j++;
		}
		
		// You can add your own tags below (must be lower case)
		switch(string_lower(tag)) {
			case "color":
				// You can add your own color constants below (must be lower case)
				switch(string_lower(value)) {
					case "red":
					case "c_red":
						value = c_red;
						break;
						
					case "green":
					case "c_green":
						value = c_green;
						break;
						
					case "blue":
					case "c_blue":
						value = c_blue;
						break;
						
					case "orange":
					case "c_orange":
						value = c_orange;
						break;
						
					case "aqua":
					case "c_aqua":
						value = c_aqua;
						break;
						
					case "lime":
					case "c_lime":
						value = c_lime;
						break;
						
					case "purple":
					case "c_purple":
						value = c_purple;
						break;
						
					case "fuchsia":
					case "c_fuchsia":
						value = c_fuchsia;
						break;
						
					case "teal":
					case "c_teal":
						value = c_teal;
						break;
						
					case "silver":
					case "c_silver":
						value = c_silver;
						break;
						
					case "olive":
					case "c_olive":
						value = c_olive;
						break;
						
					case "yellow":
					case "c_yellow":
						value = c_yellow;
						break;
						
					case "gray":
					case "c_gray":
						value = c_gray;
						break;
						
					case "ltgray":
					case "c_ltgray":
						value = c_ltgray;
						break;
						
					case "dkgray":
					case "c_dkray":
						value = c_dkgray;
						break;
						
					case "black":
					case "c_black":
						value = c_black;
						break;
						
					case "white":
					case "c_white":
						value = c_white;
						break;
						
					default: // In case none of the constants were used
						
						// if the value starts with a $ or #, assume it's a hex color code
						if(string_char_at(value, 1) == "$" || string_char_at(value, 1) == "#") {
							value = string_copy(value, 2, string_length(value) - 1);
							
							var red = hex_to_dec(string_copy(value, 5, 2));
							var green = hex_to_dec(string_copy(value, 3, 2));
							var blue = hex_to_dec(string_copy(value, 1, 2));
							
							value = make_color_rgb(red, green, blue);
						}
						else value = real(value); // Attempt to convert the color into a number
						break;
				}
				
				ds_list_add(color, value);
				
				break;
				
			case "font":
				if(font_exists(asset_get_index(value)))ds_list_add(font, asset_get_index(value));
				else ds_list_add(font, real(value));
				
				break;
				
			case "effect":
				ds_list_add(effect, value);
				break;
			
			case "shader":
				if(asset_get_index(value))ds_list_add(font, asset_get_index(value));
				else ds_list_add(font, real(value));
				
				break;
		}
	}
	
	var data = gmde_draw_character_prepare(char, index++, color[|ds_list_size(color) - 1], font[|ds_list_size(font) - 1], effect[|ds_list_size(effect) - 1], shader[|ds_list_size(shader) - 1], cdata);
	cdata[0] += data[0];
	cdata[1] += data[1];
	cdata[2] += data[2];
}

shader_reset();
