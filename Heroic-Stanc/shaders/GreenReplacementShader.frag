#pragma header
#define iChannel0 bitmap
#define iChannel1 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

const float threshold = 0.5;
const float padding = 0.05;

uniform float arrayR;
uniform float arrayG;
uniform float arrayB;

void main(){
    vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
    vec2 iResolution = openfl_TextureSize;
  
	vec2 uv = fragCoord.xy / iResolution.xy;

    vec3 replacementColour = vec3(arrayR,arrayG,arrayB);

    vec4 greenScreen = vec4(0.0,1.0,0.0,1.0);
    vec3 color = texture(iChannel0, uv).rgb;
    float alpha = texture(iChannel0, uv).a;
    
    vec3 diff = color .xyz - greenScreen.xyz;
    float fac = smoothstep(threshold - padding, threshold + padding, dot(diff,diff));

    color = mix(color, replacementColour, 1. -fac);
    gl_FragColor = vec4(color.rgb * alpha, alpha);

}