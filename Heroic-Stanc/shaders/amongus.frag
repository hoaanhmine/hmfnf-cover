#pragma header

#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

uniform float FlashIntensity;

void mainImage()
{
float FlashIntensity = FlashIntensity;
vec2 fragCoord = openfl_TextureCoordv*vec2(1920,1080);
vec2 iResolution = vec2(1920,1080);
// vec2 TextureSize = vec2(0.666666666666666/5.,0.666666666666666/5.);
// vec2 fragCoord = openfl_TextureCoordv*TextureSize;
// vec2 iResolution = TextureSize;

vec2 uv = fragCoord.xy/iResolution.xy;

vec4 original = texture(iChannel0,uv)*vec4(0.5,1.,1.,1.);
vec4 colors = texture(iChannel0,uv);
float lll = length(original.rgb);
vec3 custom;
if (lll >= 0.55) {
custom = vec3(colors.r*(5./(FlashIntensity*5.)),colors.g*FlashIntensity,colors.b*FlashIntensity);
} else {
custom = vec3(colors.rgb)*FlashIntensity;
}
vec4 color = vec4(custom,original.a);
fragColor = color;
}