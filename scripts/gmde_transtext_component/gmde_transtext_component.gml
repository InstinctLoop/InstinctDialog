/// @arg callback {STRING} The name of the callback to execute
/// @arg properties {DS_MAP} The data structure containing the properties of this component

/// NOTE: These should be attached in the order of where they change the string, ascending.

var callback = argument0;
var properties = argument1;

switch(callback) {
	case "construct":
		properties[?"type"] = "TransText";
		properties[?"offset"] = 0;
		
		// The parameters below should be filled in by the tag for this component,
		// see the [transition] tag (inside of gmde_parse_textbox) on how to get the proper values
		// The start of the transition effect
		properties[?"start_pos"] = 1;
		
		// The end of transition effect
		properties[?"end_pos"] = 5;
		
		// Valid strings: [NUMBER][UNIT] where unit can be: (Default unit is Characters)
		// C = Characters
		// T = Ticks
		// M = Minutes
		// S = Seconds
		// MS = Milliseconds
		properties[?"delay"] = "2c"; // Or you can just use a number 2 if your using characters
		properties[?"max_time"] = "500ms";
		properties[?"time"] = 0;
		
		properties[?"from"] = string_copy(displayed_string, 1, 5);
		properties[?"to"] = "Blah!";
		
		properties[?"transition"] = "glitch";
		properties[?"finished"] = false;
		
		properties[?"page"] = page;
		
		break;
		
	case "tick":
		// If the page has changed, detach this component
		if (properties[?"page"] != page) gmde_detach_component(_this_, properties);
	
		// Grab the time and max time
		var max_time = string_lower(properties[?"max_time"]);
		var time = properties[?"time"];
		
		// Determine what type it is and adjust
		if(string_copy(max_time, string_length(max_time) - 2, 2) == "ms")
		{
			time += delta_time / 1000; // delta_time is the time between this step event, and the previous. 
			// It's measured in microseconds
			/// 1 millisecond is 1000 microseconds
		}
		else 
		{
			switch(string_copy(max_time, string_length(max_time) - 2, 2))
			{
				case "m":
					time += delta_time / 1000 / 1000 / 60;
					break;
					
				case "s":
					time += delta_time / 1000 / 1000;
					break;
					
				case "c":
					time += cursor - last_cursor;
					break;
					
				case "t":
					time++;
					break;
			}
		}
		
		// Get real max time, and store the new current time
		max_time = real(string_digits(max_time));
		properties[?"time"] = time;
		
		var mix = time / max_time; // returns value between 0 and 1, where 1 means almost no mixing, and 0 means completely mixed.
		
		if (mix == 0) properties[?"finished"] = true;
		
		// Used to offset the other text transitions in case this transition increases/decreases the strength length
		var updated_offset = properties[?"offset"];
		
		var from = properties[?"from"];
		var to = properties[?"to"];
		
		var start = updated_offset + properties[?"start_pos"];
		var count = properties[?"start_pos"] - properties[?"end_pos"];
		
		// If the transition has already finished...
		if(properties[?"finished"])
		{
			displayed_string = string_delete(displayed_string, start, count);
			displayed_string = string_insert(to, displayed_string, start);
			
			updated_offset += string_length(to) - count;
		}
		
		// Apply the transition
		switch(properties[?"transition"])
		{
			// I won't go in detail here, because there is too much to explain
			// If you have programming knowledge (which you should if your attempting to edit)
			// then you will understand most, if not all of this.
			
			case "glitch":
				
				var length = floor(lerp(string_length(to), string_length(from), mix + (random(0.2) - 0.1) * mix));
				var replacement = "";
				
				for(var i = 0; i < length; i++)
				{
					var rand = irandom(15) * mix;
					if(rand <= 5) 
					{
						if(rand <= 0) 
						{
							replacement += string_char_at(to, i);
						}
						else 
						{
							replacement += chr(irandom_range(32, 127));
						}
					}
					else 
					{
						replacement += string_char_at(from, i);
					}
				}
				
				displayed_string = string_delete(displayed_string, start, count);
				displayed_string = string_insert(replacement, displayed_string, start);
				
				updated_offset += length - count;
				
				break;
			
			case "change":
				
				var length = floor(lerp(string_length(from), string_length(to), mix + (random(0.2) - 0.1) * mix));
				var replacement = string_copy(to, 1, min(string_length(to), length));
				replacement += string_copy(from, min(length, string_length(from)), max(0, string_length(from) - length)); 
				
				displayed_string = string_delete(displayed_string, start, count);
				displayed_string = string_insert(replacement, displayed_string, start);
				
				updated_offset += string_length(replacement) - count;
				
				break;
		}
		
		// This is allowed, because the calling instance should always be the obj_dialogue_box executing the component
		var component_count = ds_list_size(components); 
		
		// Iterate over the other text components, and if they start after this one, then update the offset
		for(var i = 0; i < component_count; i++) 
		{
			var component = components[|i];
			
			if(component[?"type"] == "TransText") // This is why your type name should be unique!!
			{
				if (component[?"start_pos"] > properties[?"start_pos"]) component[?"offset"] = updated_offset;
			}
		}
		
		break;
		
	case "deconstruct":
		ds_list_destroy(properties[?"times"]);
		break;
}