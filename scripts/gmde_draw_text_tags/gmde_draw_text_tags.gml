/// @func gmde_draw_text_tags(x, y, string)

var color = ds_list_create(), font = ds_list_create(), effect = ds_list_create(), shader = ds_list_create();

ds_list_add(color,  global.gmde_default_color);
ds_list_add(font,   global.gmde_default_font);
ds_list_add(effect, global.gmde_default_effect);
ds_list_add(shader, global.gmde_default_shader);

var str = argument0;
var strlen = string_length(str);

var ignore = false;

for(var i = 0; i < strlen; i++) {
	var char = string_char_at(str, i);
	
	if(ignore) {
		
	}
	
	if(char == global.gmde_tag_open_character) {
		
	}
}

shader_reset();
