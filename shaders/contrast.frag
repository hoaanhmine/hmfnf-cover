#pragma header
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

uniform float desaturationAmount;
const float distortionTime = 1.0;
const float amplitude = 0.0;
const float frequency = 0.0;

void main() {
    vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
    vec2 iResolution = openfl_TextureSize;

    
	vec2 uv = fragCoord.xy / iResolution.xy;
    vec4 desatTexture = texture(bitmap, vec2(openfl_TextureCoordv.x + sin((openfl_TextureCoordv.y * frequency) + distortionTime) * amplitude, openfl_TextureCoordv.y));
    gl_FragColor = vec4(mix(vec3(dot(desatTexture.xyz, vec3(.2126, .7152, .0722))), desatTexture.xyz, desaturationAmount), desatTexture.a);
}