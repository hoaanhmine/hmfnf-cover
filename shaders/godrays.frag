#pragma header

uniform float range;
uniform float brightness;
uniform float centerX;
uniform float centerY;

vec2 VogelDiskSample(int sampleIndex, int sampleCount, float phi)
{
    float sampleIndexf = float(sampleIndex);
    float sampleCountf = float(sampleCount);
    
    float goldenAngle = 2.39996;

    float r = sqrt((sampleIndexf + 0.5) / sampleCountf);
    float theta = sampleIndexf * goldenAngle + phi;

    return vec2(cos(theta), sin(theta)) * r;
}

void main()
{
    vec2 uv = openfl_TextureCoordv.xy;
    vec4 originalGameColor = flixel_texture2D(bitmap, uv);

    if (brightness <= 0.005){
        gl_FragColor = originalGameColor;
        return;
    }
    
    float blurRadius = 0.1;
    float attenuationSoftness = 0.75;
 
    float rangePerSample = range / 16.0;
    vec2 radialOrigin = vec2(centerX, centerY);
    
    vec4 rayBuffer = vec4(0.0, 0.0, 0.0, 0.0);
    
    for(int softnessSmpIdx = 0; softnessSmpIdx < 4; softnessSmpIdx++)
    {
        vec2 softnessOffset = VogelDiskSample(softnessSmpIdx, 4, 0.0) * blurRadius;
        vec2 uvOffset = softnessOffset + radialOrigin;
        vec2 uvCentered = uv - uvOffset;
        
        for(int radialIdx = 0; radialIdx < 16; radialIdx++)
        {
            float stepSize = float(radialIdx) * rangePerSample;
            vec2 sampleUv = uvCentered * (1.0 + stepSize) + uvOffset;
            rayBuffer += flixel_texture2D(bitmap, sampleUv); 
        }
    }
    
    vec4 radialBlurTarget = rayBuffer / 64.0;
    float bright = dot(radialBlurTarget.rgb, vec3(0.2126, 0.7152, 0.0722));
    radialBlurTarget.rgb *= smoothstep(0.2, 0.7, bright);
    {
        vec2 vecToOrigin = radialOrigin - uv;
        float invSqrFalloff = 1.0 / (dot(vecToOrigin, vecToOrigin) + attenuationSoftness);
        radialBlurTarget *= invSqrFalloff;
    }
    radialBlurTarget *= exp2(1.5);

    vec3 finalRgb = originalGameColor.rgb + (radialBlurTarget.rgb * 0.5);
    finalRgb = clamp(finalRgb, 0.0, 1.0);

    vec4 finalColor = vec4(finalRgb, originalGameColor.a);
    
    gl_FragColor = mix(originalGameColor, finalColor, brightness);
}
