local shaderName = "adjustColor"

function onCreate()
    shaderCoordFix()

    makeLuaSprite("adjustColor")
    makeGraphic("shaderImage", screenWidth, screenHeight)

    setSpriteShader("shaderImage", "adjustColor")

    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";

        game.initLuaShader(shaderName);

        var shader0 = game.createRuntimeShader(shaderName);
        game.camGame.setFilters([new ShaderFilter(shader0)]);
        game.getLuaObject("adjustColor").shader = shader0;
        game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("adjustColor").shader)]);
        return;
    ]])
end

function onUpdate(elapsed)
    setShaderFloat("adjustColor", "iTime", os.clock())
end

function onEvent(name, value1, value2)
    if name == "blackFlash" then
        local params = {}
        for v in string.gmatch(value1, "[^,]+") do
            table.insert(params, tonumber(v))
        end

        local hue        = params[1] or 0
        local brightness = params[2] or 15
        local saturation = params[3] or -100
        local contrast   = params[4] or 50

        setShaderFloat("adjustColor", "hue", hue)
        setShaderFloat("adjustColor", "brightness", brightness)
        setShaderFloat("adjustColor", "saturation", saturation)
        setShaderFloat("adjustColor", "contrast", contrast)

        local flashSpeed = tonumber(value2)
        if flashSpeed == nil then
            flashSpeed = 1 
        end

        doTweenShader("hueBack",        "adjustColor", "hue",        0, flashSpeed, "linear")
        doTweenShader("brightnessBack", "adjustColor", "brightness", 0, flashSpeed, "linear")
        doTweenShader("saturationBack", "adjustColor", "saturation", -100, flashSpeed, "linear")
        doTweenShader("contrastBack",   "adjustColor", "contrast",   -20, flashSpeed, "linear")
    end
end

function doTweenShader(tag, shaderName, property, targetValue, duration, ease)
    runHaxeCode([[
        var sh = game.getLuaObject("]] .. shaderName .. [[").shader;
        if (sh != null) {
            FlxTween.num(sh.data.]] .. property .. [[.value[0], ]] .. targetValue .. [[, ]] .. duration .. [[,
                {ease: FlxEase.]] .. ease .. [[},
                function(v) {
                    sh.data.]] .. property .. [[.value[0] = v;
                }
            );
        }
    ]])
end

function shaderCoordFix()
    runHaxeCode([[
        resetCamCache = function(?spr) {
            if (spr == null || spr.filters == null) return;
            spr.__cacheBitmap = null;
            spr.__cacheBitmapData = null;
        }

        fixShaderCoordFix = function(?_) {
            resetCamCache(game.camGame.flashSprite);
            resetCamCache(game.camHUD.flashSprite);
            resetCamCache(game.camOther.flashSprite);
        }

        FlxG.signals.gameResized.add(fixShaderCoordFix);
        fixShaderCoordFix();
        return;
    ]])

    local temp = onDestroy
    function onDestroy()
        runHaxeCode([[
            FlxG.signals.gameResized.remove(fixShaderCoordFix);
            return;
        ]])
        if (temp) then temp() end
    end
end