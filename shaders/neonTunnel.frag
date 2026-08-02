#pragma header
uniform float iTime;

// Code được chuyển đổi từ Shadertoy: https://www.shadertoy.com/view/dtcfWn
void main() {
    // Lấy tọa độ và kích thước từ Psych Engine
    vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
    vec2 iResolution = openfl_TextureSize;

    // Bắt đầu code gốc của Shadertoy
    vec2 p = (fragCoord.xy * 2.0 - iResolution.xy) / min(iResolution.x, iResolution.y);
    vec3 col = vec3(0.0);
    
    // Tốc độ animation (bạn có thể thay đổi số 0.5 để nhanh/chậm hơn)
    float t = iTime * 0.5;
    
    for(float i = 0.0; i < 10.0; i++){
        float s = sin(t + i * 0.5) * 0.5;
        float c = cos(t + i * 0.5) * 0.5;
        mat2 m = mat2(c, -s, s, c);
        p *= m;
        float d = abs(length(p) - 0.5 * i) - 0.02;
        float k = 0.02 / d;
        col += vec3(k * (0.5 + 0.5 * sin(i)), k * (0.5 + 0.5 * cos(i)), k);
    }
    
    // Xuất màu ra màn hình
    gl_FragColor = vec4(col, 1.0);
}