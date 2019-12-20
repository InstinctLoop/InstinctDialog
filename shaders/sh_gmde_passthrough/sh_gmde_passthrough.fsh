//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// These uniforms *MUST* be present in the shader, used or not, as they are set to by the text's draw script.
uniform float u_Time;           // Milliseconds sense game start.
uniform float u_FontSize;       // The fonts size in Pixels.
uniform vec2  u_TextureSize;    // The texture size in Pixels.
uniform vec4  u_MouseXYLR;      // The mouses X and Y coordinates and if LMB or RMB is pressed.
uniform int   u_CharacterIndex; // The index (in the displayed string) of the current character being drawn.
uniform int   u_Character;      // The Unicode Character Code for the current character being draw.

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
