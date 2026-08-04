//Fix by NTH208
var chromFreq:Int = 4; //default = 2
var chromAmount:Float = 0.2; //default = 0.65
var chromatic:Float = 0.001;
var enabled:Bool = false;
var activated:Bool = false;
var angelEnable:Bool = false;

game.initLuaShader('ChromaticAbberationHUD');
game.initLuaShader("amongus");
game.initLuaShader('glitchChromatic');
game.initLuaShader('angel');
game.initLuaShader('chromeVcr');
game.initLuaShader('soo weird');

var oldTV = game.createRuntimeShader('old tv');
var chromVcr = game.createRuntimeShader('chromeVcr');
var pibbyFNF = game.createRuntimeShader('glitchChromatic');
var chromToggle = game.createRuntimeShader('ChromaticAbberationHUD');
var black = game.createRuntimeShader('amongus');
var angel = game.createRuntimeShader('angel');
var weird = game.createRuntimeShader('soo weird');

var glitchShaderIntensity:Float;
var chromaticShaderIntensity:Float;
var uTimeFloat:Float;
var stronkLerp:Float;

function onCreatePost(){   
    setVar('black',black); 
    setVar('stronkLerp',stronkLerp);
  
    game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromToggle),new ShaderFilter(black), new ShaderFilter(chromVcr)]);
    game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromToggle),new ShaderFilter(black),new ShaderFilter(angel), new ShaderFilter(chromVcr)]);
    black.setFloat('FlashIntensity',1);
}

function onBeatHit(){
    if (curBeat % chromFreq == 0){
        chromBeat();
    }

}

var blue:FlxTween;
var red:FlxTween;
var green:FlxTween;

function onEvent(name,v1,v2){
    if (name == ''){
        if (v1 == 'angelEnable'){
            angelEnable = true;
        }

        if (v1 == 'angelDisable'){
            angelEnable = false;
        }

        if (v1 == 'reloadOldShader'){
            game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromToggle),new ShaderFilter(black)]);
            game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromToggle),new ShaderFilter(black),new ShaderFilter(angel)]);
        }

        if (v1 == 'countdown'){
            if (v2 == 'treehouseChange') {
                FlxTween.num(-0.01,0.01,1,{type: FlxTween.PINGPONG, ease:FlxEase.quadInOut, startDelay: 0, loopDelay: 0.3, onUpdate: (rx:FlxTween)->oldTV.setFloat('redX',rx.value)});
                FlxTween.num(0.01,-0.01,1,{type: FlxTween.PINGPONG, ease:FlxEase.quadInOut, startDelay: 0.1, loopDelay: 0.2, onUpdate: (ry:FlxTween)->oldTV.setFloat('redY',ry.value)});
                FlxTween.num(-0.01,0.01,1,{type: FlxTween.PINGPONG, ease:FlxEase.quadInOut, startDelay: 0.2, loopDelay: 0.1, onUpdate: (bx:FlxTween)->oldTV.setFloat('blueX',bx.value)});
                FlxTween.num(0.01,-0.01,1,{type: FlxTween.PINGPONG, ease:FlxEase.quadInOut, startDelay: 0.3, loopDelay: 0.0, onUpdate: (by:FlxTween)->oldTV.setFloat('blueY',by.value)});

                game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromToggle),new ShaderFilter(black),new ShaderFilter(oldTV),new ShaderFilter(weird)]);
                game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromToggle),new ShaderFilter(black),new ShaderFilter(angel),new ShaderFilter(oldTV),new ShaderFilter(weird)]);
            }

            if (v2 == 'finish'){
                game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromToggle),new ShaderFilter(black)]);
                game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromToggle),new ShaderFilter(black),new ShaderFilter(angel)]);
            }
        }
    }

    if (name == 'Add Camera Zoom'){
        chromBeat();

        if (angelEnable){
            stronkLerp = 0.225;
        }
    }

    if (name == 'Zoom Chrom'){
        chromaticShaderIntensity = Std.parseFloat(v1);
    }


    if (name == 'change amount chrom'){
        chromAmount = Std.parseFloat(v1);
    }

    if (name == 'glitchCamera'){
        if (v1 == 'glitchChromatic'){
            if (FlxG.random.int(0,1) == 0){
                glitchShaderIntensity = FlxG.random.float(0.2,0.7);
            }
        }
    }
}


function chromBeat(){
    chromaticShaderIntensity = chromAmount;
}

function onUpdate(elapsed){
    glitchShaderIntensity = FlxMath.lerp(glitchShaderIntensity, 0, FlxMath.bound(elapsed * 7, 0, 1));
    chromaticShaderIntensity = FlxMath.lerp(chromaticShaderIntensity, 0, FlxMath.bound(elapsed * 6, 0, 1));
    stronkLerp = FlxMath.lerp(0, stronkLerp, FlxMath.bound(1 - (elapsed * 9 * game.playbackRate), 0, 1));

    chromToggle.setFloat('amount',chromaticShaderIntensity);
    pibbyFNF.setFloat('glitchMultiply',glitchShaderIntensity);
    uTimeFloat += elapsed;
    weird.setFloat('iTime',uTimeFloat);
    pibbyFNF.setFloat('uTime',uTimeFloat);
    oldTV.setFloat('iTime',uTimeFloat);
    angel.setFloat('time', uTimeFloat);
    angel.setFloat('stronk', stronkLerp);
    angel.setFloatArray('pixel', [1, 1]);
}
