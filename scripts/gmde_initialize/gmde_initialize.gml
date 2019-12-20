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

// The Text to Display When No Text is Provided
global.gmde_default_text = "[color:red]Error!![/color]";

#endregion

#region Display

// [x, y] or (array[0] = x, array[1] = y)
global.gmde_gui_size = [256, 192]; 



#endregion