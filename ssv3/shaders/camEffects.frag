// |[RED ABERRATION FRAGMENT FOR GLSL ES 2.0(ver 100 for Android)]| //
// [FIXED FORMAT]
#pragma header

#define mainImage main
#define iChannel0 bitmap
#define fragColor gl_FragColor
#define texture texture2D // flixel_texture2D smh not working, yea freak that glsl

uniform float distort;

vec2 pincushionDistortion(in vec2 uv, float strength) {
	vec2 st = uv - 0.5;
    float uvA = atan(st.x, st.y);
    float uvD = dot(st, st);
    return 0.5 + vec2(sin(uvA), cos(uvA)) * sqrt(uvD) * (1.0 - strength * uvD);
}

void mainImage() {
    float rChannel = texture(iChannel0, pincushionDistortion(openfl_TextureCoordv, 0.3 * distort)).r;
    float gChannel = texture(iChannel0, pincushionDistortion(openfl_TextureCoordv, 0.15 * distort)).g;
    float bChannel = texture(iChannel0, pincushionDistortion(openfl_TextureCoordv, 0.075 * distort)).b;
    fragColor = vec4(rChannel, gChannel, bChannel, 1.0);
}