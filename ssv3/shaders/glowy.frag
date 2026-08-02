    //SHADERTOY PORT FIX
    #pragma header
    #define iChannel0 bitmap
    #define texture texture2D
    #define fragColor gl_FragColor
    #define mainImage main

    void mainImage()
    {
       #pragma body

       vec2 uv = openfl_TextureCoordv.xy;
       vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
       vec2 iResolution = openfl_TextureSize;
       float iTime = 0.0;
       float Size = 0.0;
       const float blurSize = 1.0 / 512.0;
       const float intensity = 0.85;


       vec4 sum = vec4(0.0);
       vec2 texcoord = fragCoord.xy/iResolution.xy;
       int j;
       int i;
    
       sum += texture2D(iChannel0, vec2(texcoord.x - 4.0*blurSize, texcoord.y)) * 0.05;
       sum += texture2D(iChannel0, vec2(texcoord.x - 3.0*blurSize, texcoord.y)) * 0.09;
       sum += texture2D(iChannel0, vec2(texcoord.x - 2.0*blurSize, texcoord.y)) * 0.12;
       sum += texture2D(iChannel0, vec2(texcoord.x - blurSize, texcoord.y)) * 0.15;
       sum += texture2D(iChannel0, vec2(texcoord.x, texcoord.y)) * 0.16;
       sum += texture2D(iChannel0, vec2(texcoord.x + blurSize, texcoord.y)) * 0.15;
       sum += texture2D(iChannel0, vec2(texcoord.x + 2.0*blurSize, texcoord.y)) * 0.12;
       sum += texture2D(iChannel0, vec2(texcoord.x + 3.0*blurSize, texcoord.y)) * 0.09;
       sum += texture2D(iChannel0, vec2(texcoord.x + 4.0*blurSize, texcoord.y)) * 0.05;
        
       sum += texture2D(iChannel0, vec2(texcoord.x, texcoord.y - 4.0*blurSize)) * 0.05;
       sum += texture2D(iChannel0, vec2(texcoord.x, texcoord.y - 3.0*blurSize)) * 0.09;
       sum += texture2D(iChannel0, vec2(texcoord.x, texcoord.y - 2.0*blurSize)) * 0.12;
       sum += texture2D(iChannel0, vec2(texcoord.x, texcoord.y - blurSize)) * 0.15;
       sum += texture2D(iChannel0, vec2(texcoord.x, texcoord.y)) * 0.16;
       sum += texture2D(iChannel0, vec2(texcoord.x, texcoord.y + blurSize)) * 0.15;
       sum += texture2D(iChannel0, vec2(texcoord.x, texcoord.y + 2.0*blurSize)) * 0.12;
       sum += texture2D(iChannel0, vec2(texcoord.x, texcoord.y + 3.0*blurSize)) * 0.09;
       sum += texture2D(iChannel0, vec2(texcoord.x, texcoord.y + 4.0*blurSize)) * 0.05;
    
       fragColor = sum*intensity + texture(iChannel0, texcoord); 
    }