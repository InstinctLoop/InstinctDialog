/// @func gmde_attach_component( obj_dialog_box, component_script )
/// @arg obj_dialog_box {INSTANCE} The dialog box instance to attach to.
/// @arg component_script {SCRIPT} The component script to use.

with(argument0) {
	var props = ds_map_create();
	props[?"__SCRIPT__"] = argument1;
	props[?"__ACTIVE__"] = true;
	ds_list_add(components, props);
	script_execute(argument1, "construct", props);
}