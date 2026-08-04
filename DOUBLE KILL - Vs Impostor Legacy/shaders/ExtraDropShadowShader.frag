#pragma header

uniform float threshold;
uniform float strength;

void main() {
    vec2 uv = openfl_TextureCoordv;
    vec4 texColor = flixel_texture2D(bitmap, uv);
    
    mat4 colorMat = mat4(
         0.3,  0.5, -0.2,  0.0,
        -0.25, 0.1,  0.05, 0.0,
         0.4,  0.25, 0.6,  0.0,
         0.0,  0.0,  0.0,  1.0
    );
    vec4 offsetColor = vec4(-50.0/255.0, 10.0/255.0, -92.0/255.0, 0.0);
    vec4 baseColor = (texColor * colorMat) + offsetColor;
    baseColor.a = texColor.a;

    vec2 shadowOffset1 = vec2(10.0, 14.0) / openfl_TextureSize;
    vec2 shadowOffset2 = vec2(96.0, 24.0) / openfl_TextureSize;
    
    float alphaShadow1 = flixel_texture2D(bitmap, uv - shadowOffset1).a;
    float alphaShadow2 = flixel_texture2D(bitmap, uv - shadowOffset2).a;
    
    float rimEffect = smoothstep(threshold, threshold + 0.1, (1.0 - texColor.a) * alphaShadow1);
    vec3 rimColor = vec3(0.5, 0.8, 1.0) * strength;

    vec4 finalColor = baseColor;
    
    if (texColor.a > 0.0) {
        finalColor.rgb = mix(finalColor.rgb, rimColor, rimEffect * 0.4);
    } else {
        float shadowAlpha = max(alphaShadow1 * 0.3, alphaShadow2 * 0.15);
        finalColor = vec4(0.0, 0.0, 0.0, shadowAlpha);
    }

    gl_FragColor = finalColor * texColor.a;
}