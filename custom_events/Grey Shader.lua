function onCreatePost()
    initLuaShader('contrast')
end

function onEvent(name, value1, value2)
    if name == 'Grey Shader' then
        if luaSpriteExists('Grey Shader') ~= true then
            makeLuaSprite('Grey Shader', '', 1)
            setSpriteShader('Grey Shader', 'contrast')
        end

        runHaxeCode([[
            var contrast = game.createRuntimeShader('contrast');
            FlxG.game.setFilters([new ShaderFilter(contrast)]);
            game.getLuaObject('Grey Shader').shader = contrast;
        ]])

        doTweenX('Grey Shader Amount', 'Grey Shader', tonumber(value1), tonumber(value2), 'linear')
    end
end

function onUpdate(elapsed)
    if luaSpriteExists('Grey Shader') == true then
        setShaderFloat('Grey Shader', 'desaturationAmount', getProperty('Grey Shader.x'))
    end
end

function onDestroy()
    runHaxeCode([[
        FlxG.game.setFilters([]);
    ]])
end