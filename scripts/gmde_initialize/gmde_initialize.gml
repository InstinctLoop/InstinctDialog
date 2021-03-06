/// @func gmde_initialize()
/*/

GameMaker Dialog Engine Initialize

This script is called when the first launches, (You should not need to call this script directly)
It provides some defaults and general properties for the engine.

The comments will explain what each thing does.


/*/

// Call this script at game launch
gml_pragma("global", "gmde_initialize();");

#region Defaults
// The Default Font to Use
global.gmde_default_font = 0;

// The Default Color to Use
global.gmde_default_color = c_white;

// The Default Effect to Use
global.gmde_default_effect = "normal";

// The Default Text Shader to Use
global.gmde_default_shader = sh_gmde_passthrough;

#endregion

#region Controls

// You can add controls for the mouse or gamepad by create variables with the same names
// as below but replace "keyboard" with "mouse" or "gamepad" 
// for example "global.gmde_mouse_confirm = mb_left"

// To have multiple controls just add a new index into the array.

global.gmde_keyboard_confirm[0]  = vk_space;
global.gmde_keyboard_continue[0] = vk_space;
global.gmde_keyboard_skip[0]     = vk_shift;
global.gmde_keyboard_back[0]     = vk_shift;
global.gmde_keyboard_left[0]     = vk_left;
global.gmde_keyboard_right[0]    = vk_right;
global.gmde_keyboard_up[0]       = vk_up;
global.gmde_keyboard_down[0]     = vk_down;

global.gmde_gamepad_index = 0; // Set this to the gamepad index either during runtime (by code) or in this script.

#endregion

#region Display

// [x, y] or (gmde_gui_size[0] = x, gmde_gui_size[1] = y)
global.gmde_gui_size = [256, 192]; 



#endregion

#region Conventional

// The character that represents the opening of a tag
global.gmde_tag_open_character = "[";   // Must be one character

// The character that represents the closing of a tag
global.gmde_tag_close_character = "]";  // Must be one character

// The character that represents the end of the tag name and beginning of it's value
global.gmde_tag_value_separator = ":";  // Must be one character

// The character that escapes a tag
global.gmde_tag_escape_character = "/"; // Must be one character

// The character that represents a new line
global.gmde_new_line_character = "\n";  // Must be one character

// The character that represents the end of a region tag (Ex: [color:red]Hello, World![/color])
//                                                       (                         this^      )
global.gmde_tag_region_end_character = "/"; // Must be one character

#endregion

#region INTERNAL

global.gmde_char_surface = surface_create(16, 16);

#endregion

#macro _this_ id