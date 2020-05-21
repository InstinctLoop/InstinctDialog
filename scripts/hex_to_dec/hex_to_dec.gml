/// @func hex_to_dec(hex)
/// @arg hex

// The hex string to parse
var str = argument0;

var int = 0; // A variable to store our number
var idx = 1; // This multiplier of the digit

// For every character in the string (in reverse order)
for(var i = string_length(str); i > 0; i--) {
	
	// Grab the character's ascii decimal and subtract the ascii decimal of the number '0'
	var val = ord(string_char_at(str, i)) - ord("0");
	
	// If the value is still greator than 9, subtract the decimal for ('A' - '0' - 10)
	if(val > 9)val -= ord("A") - ord("0") - 10;
    
	// Add the value multiplied by the our multiplier
	int += val * idx;
	
	// Bitshift the multiplier by half a byte
	idx = idx << 4;
}

// Return the result
return int;
