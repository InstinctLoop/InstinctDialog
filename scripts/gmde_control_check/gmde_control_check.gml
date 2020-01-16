/// @func gmde_control_check( control, enum_gmde_c_state )
/// @arg control The control to check for
/// @arg enum_gmde_c_state The state to check for

enum gmde_c_state {
	press, hold, release, up, 
	
	_E
}

var control = argument0, state = argument1;
var pass = false;

var control = "gmde_{0}_" + control;

var testfor = ["keyboard", "mouse", "gamepad"];

for(var i = 0; i < array_length_1d(testfor); i++) {
	var testing = testfor[i];
	
	var ctrl = string_replace(control, "{0}", testing);
	
	if(variable_global_exists(ctrl)) {
		ctrl = variable_global_get(ctrl);
		
		switch(testing) {
			case "keyboard":
				for(var j = 0; j < array_length_1d(ctrl); j++) {
					switch(state) {
						case gmde_c_state.press:
							pass |= keyboard_check_pressed(ctrl[j]);
							break;
						case gmde_c_state.hold:
							pass |= keyboard_check(ctrl[j]);
							break;
						case gmde_c_state.release:
							pass |= keyboard_check_released(ctrl[j]);
							break;
						case gmde_c_state.up:
							pass |= !keyboard_check_pressed(ctrl[j]) && !keyboard_check(ctrl[j]) && !keyboard_check_released(ctrl[j]);
							break;
					}
				}
				break;
				
			case "mouse":
				for(var j = 0; j < array_length_1d(ctrl); j++) {
					switch(state) {
						case gmde_c_state.press:
							pass |= mouse_check_button_pressed(ctrl[j]);
							break;
						case gmde_c_state.hold:
							pass |= mouse_check_button(ctrl[j]);
							break;
						case gmde_c_state.release:
							pass |= mouse_check_button_released(ctrl[j]);
							break;
						case gmde_c_state.up:
							pass |= !mouse_check_button_pressed(ctrl[j]) && !mouse_check_button(ctrl[j]) && !mouse_check_button_released(ctrl[j]);
							break;
					}
				}
				break;
				
			case "gamepad":
				for(var j = 0; j < array_length_1d(ctrl); j++) {
					switch(state) {
						case gmde_c_state.press:
							pass |= gamepad_button_check_pressed(global.gmde_gamepad_index, ctrl[j]);
							break;
						case gmde_c_state.hold:
							pass |= gamepad_button_check(global.gmde_gamepad_index, ctrl[j]);
							break;
						case gmde_c_state.release:
							pass |= gamepad_button_check_released(global.gmde_gamepad_index, ctrl[j]);
							break;
						case gmde_c_state.up:
							pass |= !gamepad_button_check_pressed(global.gmde_gamepad_index, ctrl[j]) && !gamepad_button_check(global.gmde_gamepad_index, ctrl[j]) && !gamepad_button_check_released(global.gmde_gamepad_index, ctrl[j]);
							break;
					}
				}
				break;
		}
	}
}


return pass;
