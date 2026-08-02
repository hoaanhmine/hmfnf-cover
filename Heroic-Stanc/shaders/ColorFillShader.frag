#pragma header;
#define iChannel0 bitmap
#define iChannel1 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

uniform float fade;
uniform float arrayR;
uniform float arrayG;
uniform float arrayB;

void main()
{
    vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
    vec2 iResolution = openfl_TextureSize;
  
	vec2 uv = fragCoord.xy / iResolution.xy;

    vec4 normal_map = flixel_texture2D(bitmap,openfl_TextureCoordv);
    vec3 fill = vec3(arrayR,arrayG,arrayB);
    normal_map.rgb = mix(fill,normal_map.rgb,fade);
    normal_map *= normal_map.a;
    gl_FragColor = normal_map;
}
