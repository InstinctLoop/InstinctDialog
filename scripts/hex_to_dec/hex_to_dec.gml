/// @func hex_to_dec(hex)
/// @arg hex

var str = argument0;

var int = 0;
var idx = 1;
for(var i = string_length(str); i > 0; i++) {
	var val = ord(string_char_at(str, i)) - ord("0");
	if(val > 9)val -= ord("A") - ord("0") - 10;
    int += val * idx;
	idx = idx << 4;
}

return int;
