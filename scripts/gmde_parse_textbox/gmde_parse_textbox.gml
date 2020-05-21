/// @func gmde_parse_textbox()

if(exiting || waiting)return 0;

var char = string_char_at(pages[|page], cursor);

if(char == global.gmde_tag_open_character) {
	var tag = "", val = "", i = 0, swch = false;
	
	while(string_char_at(pages[|page], cursor + i) != global.gmde_tag_close_character && cursor + i <= string_length(pages[|page])) {
		if(!swch) {
			if(string_char_at(pages[|page], cursor + i) == global.gmde_tag_value_separator) {
				swch = true;
			}
			else tag += string_char_at(pages[|page], cursor + i);
		}
		else {
			val += string_char_at(pages[|page], cursor + i);
		}
	}
	
	if(string_char_at(pages[|page], cursor + i) == global.gmde_tag_close_character) 
	{
		// You can add your own tags below!
		switch(tag) {
			case "color":
			case "effect":
			case "shader":
			case "font":
			case "/color":
			case "/effect":
			case "/shader":
			case "/font":
			
				// These tags are reserved. And are used in the drawing scripts
			
				break;
		
			case "wait":
				waiting = true;
				wait_arg = real(val);
				break;
		
			case "pause":
				cursor_timer = -real(val);
				break;
			
			case "end":
				exiting = true;
				instance_destroy();
				break;
		
			case "script":
			
				var map = json_decode(string_replace_all(val, "''", "\""));
			
				if(is_undefined(map[?"args"])) script_execute(map[?"script"]);
				else script_execute(map[?"script"], map[?"args"]);
			
				break;
			
			case "portraits":
			
				break;
		
			case "nameplates":
			
				break;
		
			case "background":
		
				break;
			
			case "glitch":
				var props = gmde_attach_component(_this_, gmde_transtext_component);
				
				break;
			
			// Put your own tags below
		}
	}
}