#pragma header
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main 
#define VHSRES vec2(320.0,240.0)

void mainImage() {
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
  vec2 uv = fragCoord.xy / iResolution.xy / iResolution.xy * VHSRES;
  fragColor = texture( iChannel0, uv );
}