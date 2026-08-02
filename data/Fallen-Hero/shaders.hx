game.initLuaShader('Glitchy');
game.initLuaShader('ChromaticAbberationHUD');

var rainShader;
var rainShaderStartIntensity:Float = 0;
var rainShaderEndIntensity:Float = 0;

var GlitchyShader = game.createRuntimeShader('Glitchy');

var creditsText = "SONG BY:\nIamDaDogeDaFuture ft. Requiem Zero\n \nCODE, CHART, IDEA:\n NTH208\n Cover: HMFNF";

function onCreatePost(){
    game.getLuaObject('songname').shader = GlitchyShader;
    GlitchyShader.setFloat('AMT',0.0);
    GlitchyShader.setFloat('SPEED',0.3);
    
}

function setupRainShader(){

    if (ClientPrefs.data.shaders){
        game.initLuaShader('rain');
        rainShader = game.createRuntimeShader('rain');

        rainShader.setFloat('uScale', FlxG.height/144);
        rainShader.setFloat('uTime', 1.0);
        rainShader.setFloat('uIntensity', 0.5);
        rainShader.setFloat('uPuddleY', 0.0);
        rainShader.setFloat('uPuddleScaleY', 0.0);
        rainShader.setInt('numLights', 0);
        rainShader.setFloatArray('uScreenResolution', [FlxG.width, FlxG.height]);
        rainShader.setFloatArray('uCameraBounds', [game.camGame.viewLeft, game.camGame.viewTop, game.camGame.viewRight, game.camGame.viewBottom]);
		
        //debugPrint(camera.viewLeft);
        rainShaderStartIntensity = 0.0;
        rainShaderEndIntensity = 0.5;
		
        FlxTween.num(rainShaderStartIntensity, rainShaderEndIntensity, 60, {ease:FlxEase.linear, onUpdate:(rain)->rainShader.setFloat('uIntensity', rain.value)});
		//rainShader.intensity = rainShaderStartIntensity;
		game.camGame.filters.push(new ShaderFilter(rainShader));
    }
}

var el:Float = 0;
function onUpdate(elapsed){
    el += elapsed;
    GlitchyShader.setFloat('iTime',el);
    if (rainShader != null){
        rainShader.setFloat('uTime', el);
    }
}

var tweenCamOther:FlxTween;
function onEvent(name, value1, value2){
    if (name == 'Trigger Scripts'){
        if (value1 == 'intro'){
            if (value2 == 'songtext start glitch'){
                FlxTween.num(0,0.5,1,{ease:FlxEase.cubeIn, onUpdate: (tw)-> GlitchyShader.setFloat('AMT',tw.value)});
                tweenCamOther = FlxTween.tween(game.camOther, {angle: -90}, 1, {ease:FlxEase.cubeIn});
                FlxTween.tween(game.camOther, {zoom:1.5}, 1, {ease:FlxEase.cubeIn});
            }    

            if (value2 == 'songtext end glitch'){
                FlxTween.num(0.5,0,0.6,{ease:FlxEase.cubeOut, onUpdate: (tw)-> GlitchyShader.setFloat('AMT',tw.value)});
                tweenCamOther.cancel();
                game.camOther.angle = -270;
                tweenCamOther = FlxTween.tween(game.camOther, {angle: -360}, 1, {ease:FlxEase.cubeOut});
                FlxTween.tween(game.camOther, {zoom:1}, 1, {ease:FlxEase.cubeOut});
                game.getLuaObject('songname').size = 40;
                game.getLuaObject('songname').text = creditsText;
            }
        }

        if (value1 == 'treehouse'){
            if (value2 == 'white other fade out'){
                setupRainShader();
            }
        }
    }
}