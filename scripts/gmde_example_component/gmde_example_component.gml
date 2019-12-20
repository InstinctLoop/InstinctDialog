/// @func gmde_example_component(callback, properties)
/// @arg callback {STRING} The name of the callback to execute
/// @arg properties {DS_MAP} The data structure containing the properties of this component

/*/

Components are for *ADVANCED USERS ONLY*

What they can do:
	Pretty much anything, granted you know how to pull it off.
	
What they were designed to do:
	Modifing the properties of the calling obj_dialog_box.
	- Changing text
	- Moving around pages
	- Changing how the dialog box draws
	- That kind of stuff
	
How they work:
	A component is attached to a dialog box using the `gmde_attach_component` function.
	
	When a component is attached it recieves the "construct" callback.
	
	For every frame a component is attached it recieves the "tick" callback.
	
	When a component is detached from a dialog box (using the `gmde_detach_component` function)
		it recieves the "deconstruct" callback.
		
		
	The construct callback should be used to initialize any data the component may need,
		this data should be stored in the properties map
		the properties map should also contain a "type_name" value that other components may use to
		reference it.
	
	The tick callback can be used for whatever you need it for.
	
	The deconstruct callback should be used to free any resources that you have allocated for this component.
		DO NOT DESTROY THE PROPERTIES MAP, THE PROPERTIES MAP IS AUTOMATICALLY DESTROYED AFTER THE CALLBACK.
	
/*/

var callback = argument0;
var properties = argument1;

switch(callback) {
	case "construct":
		//TODO: Add initialization logic here
		break;
		
	case "tick":
		//TODO: Add tick logic here
		break;
		
	case "deconstruct":
		//TODO: Free your allocated resources here
		break;
}