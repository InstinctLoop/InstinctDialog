/// @arg obj_dialog_box
/// @arg component

var dialog_box = argument0;
var component = argument1;

with(dialog_box) {
	script_execute(component["__SCRIPT__"], "deconstruct", component);
	ds_list_delete(components, ds_list_find_index(components, component));
	ds_map_destroy(component);
}
