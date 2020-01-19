//
// An Example Text Shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// These uniforms *MUST* be present in the shader, used or not, as they are set to by the text draw script.
uniform float u_Time;           // Milliseconds sense game start.
uniform vec2  u_Position;       // The xy position of the top-left corner of the current character
uniform vec2  u_FontSize;       // The fonts size in Pixels.
uniform vec2  u_TextureSize;    // The texture size in Pixels.
uniform vec4  u_MouseXYLR;      // The mouses X and Y coordinates and if LMB or RMB is pressed.
uniform int   u_CharacterIndex; // The index (in the displayed string) of the current character being drawn.
uniform int   u_Character;      // The Unicode Character Code for the current character being draw.

void main()
{
	vec2 newTexcoord = v_vTexcoord + vec2(cos(v_vTexcoord.y + u_Time * 0.005) / u_FontSize.x / u_TextureSize.x, 0.);
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, newTexcoord );
}
