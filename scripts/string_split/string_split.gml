/// @func string_split(string, separator)
/// @arg string        The string to split.
/// @arg separator     The character to split the string at.
/// @desc Splits a string at the provided separator into an array

// Grab the arguments
var str = argument0;
var sep = argument1;

// Create the array
var arr;

// Temporary variable that holds the current index of the array
var i = 0;

while(string_pos(str, sep) > 0) { // While there is another seperator in the string
	
	arr[i++] = string_copy(str, 1, string_pos(str, sep) - 1);                   // Copy the string up to the separator into the array
	str = string_delete(str, 1, string_pos(str, sep) + string_length(sep) - 1); // Delete the part we copied and the current separator from the string
}

arr[i++] = str; // Copy the final part of the string into the array

return arr;     // Return the array