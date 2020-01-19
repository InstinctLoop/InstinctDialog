current_page = pages[|page];

if(cursor < string_length(current_page)) {
	cursor_timer += cursor_speed;
	
	while(cursor_timer >= 1 || gmde_control_check("skip", gmde_c_state.press)) {
		cursor_timer--;
		cursor++;
		gmde_parse_textbox();
		if(cursor >= string_length(current_page))cursor_timer = 0;
	}
}

for(var i = 0; i < ds_list_size(components); i++) {
	var component = components[|i];
	script_execute(component[?"__SCRIPT__"], "tick", component);
}