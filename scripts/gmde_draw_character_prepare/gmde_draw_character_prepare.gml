/// @arg char
/// @arg index
/// @arg color
/// @arg font
/// @arg effect
/// @arg shader
/// @arg cdata

var char = argument0, index = argument1, color = argument2, font = argument3, effect = argument4, shader = argument5, cdata = argument6;

if(shader_current() != shader) {
	shader_set(shader);
}

var uni_time = shader_get_uniform(shader, "u_Time");
var uni_position = shader_get_uniform(shader, "u_Position");
var uni_fontsize = shader_get_uniform(shader, "u_FontSize");
var uni_texturesize = shader_get_uniform(shader, "u_TextureSize");
var uni_mouse = shader_get_uniform(shader, "u_MouseXYLR");
var uni_index = shader_get_uniform(shader, "u_CharacterIndex");
var uni_char = shader_get_uniform(shader, "u_Character");
	
shader_set_uniform_f(uni_time, current_time);

shader_set_uniform_f(uni_position, cdata[CDATA_X], cdata[CDATA_Y]);

var dpix = display_get_dpi_x();
var dpiy = display_get_dpi_y();
var fontsize = font_get_size(font);

var font_size_x = fontsize / 72 * dpix;
var font_size_y = fontsize / 72 * dpiy;
	
shader_set_uniform_f(uni_fontsize, font_size_x, font_size_y);

if(!surface_exists(global.gmde_char_surface)) {
	global.gmde_char_surface = surface_create(font_size_x, font_size_y);
}
else if(surface_get_width(global.gmde_char_surface) != font_size_x || surface_get_height(global.gmde_char_surface) != font_size_y) {
	global.gmde_char_surface = surface_create(font_size_x, font_size_y);
}

var texture = font_get_texture(font);
	
shader_set_uniform_f(uni_texturesize, texture_get_width(texture), texture_get_height(texture));
	
var mousex = mouse_x, mousey = mouse_y;
var camera = camera_get_active();
	
if(event_type == ev_gui) {
	mousex = (mousex - camera_get_view_x(camera)) * (display_get_gui_width() / camera_get_view_width(camera));
	mousey = (mousey - camera_get_view_y(camera)) * (display_get_gui_height() / camera_get_view_height(camera));
}
	
var lmb, rmb;
lmb = mouse_check_button_pressed(mb_left);
lmb += (mouse_check_button(mb_left) - lmb) * 2;
lmb += mouse_check_button_released(mb_left) * 3;
	
rmb = mouse_check_button_pressed(mb_right);
rmb += (mouse_check_button(mb_right) - rmb) * 2;
rmb += mouse_check_button_released(mb_right) * 3;
	
shader_set_uniform_f(uni_mouse, mousex, mousey, lmb, rmb);

shader_set_uniform_f(uni_index, index);

shader_set_uniform_f(uni_char, ord(char));

draw_set_font(font);
draw_set_color(color);

return gmde_draw_character(char, index, color, font, effect, shader, cdata);