#pragma header

uniform float brightness;
uniform float directions;
uniform float quality;
uniform float size;

void main() {
    vec2 uv = openfl_TextureCoordv.xy;
    float Pi = 6.28318530718;
    vec4 color = texture2D(bitmap, uv);
    vec4 bloom = color;

    if (brightness == 1. && size == 0.) {
        gl_FragColor = color;
        return; // no need for all dat :D
    }

    float maxApply = 0.0;

    for (float d = 0.0; d < Pi; d += Pi / directions) {
        for (float i = 1.0 / quality; i <= 1.0; i += 1.0 / quality) {
            float x_movement = (sin(d) * size * i) / openfl_TextureSize.y;
            float y_movement = (cos(d) * size * i) / openfl_TextureSize.x;
            bloom += texture2D(bitmap, uv + vec2(x_movement, y_movement));
            bloom *= mix(1.0, 1.0 - (i / quality), step(0.0, x_movement) + step(0.0, y_movement));

            maxApply += 1.0; // Increment by 1 for each direction
        }
    }

    float brightnessFactor = 1.0 - (1.0 / maxApply);
    bloom /= maxApply;

    float brightnessApply = brightness;
    if (brightness < 1.5)
        brightnessApply = mix(1.5, 0., abs(1.0-((brightness-1.0)*2.)));

    gl_FragColor = color + ((bloom * brightnessFactor) * brightnessApply);
    // if (uv.x > 0.5) gl_FragColor = vec4(brightnessApply, brightnessApply, brightnessApply, 1.0);
}