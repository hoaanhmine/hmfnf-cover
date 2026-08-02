#pragma header
uniform float negativity;

#define iChannel0 bitmap
#define iChannel1 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

void main() {

#pragma body
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
    
vec2 uv = fragCoord.xy / iResolution.xy;
    vec4 mierdaColor = texture(iChannel0, uv);

    fragColor = mix(mierdaColor, vec4(1.0 - mierdaColor.r, 1.0 - mierdaColor.g, 1.0 - mierdaColor.b, mierdaColor.a) * mierdaColor.a, negativity);
}