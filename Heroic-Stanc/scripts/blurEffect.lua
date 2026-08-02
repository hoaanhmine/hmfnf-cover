function onCreatePost()
    initLuaShader('blur')
    makeLuaSprite('blurShader')
    setSpriteShader('blurShader','blur')
    runHaxeCode([[
        var blur = game.createRuntimeShader('blur');
        FlxG.game.setFilters([new ShaderFilter(blur)]);
        game.getLuaObject('blurShader').shader = blur;
    ]])

    setShaderFloat('blurShader','cx', 0.4)
    setShaderFloat('blurShader','cy', 0.5)
    setShaderFloat('blurShader','blurWidth',0.0)
    --setProperty('camGame.x',20)
end

function onUpdate()
    setShaderFloat('blurShader','blurWidth',getProperty('blurShader.x'))
end

function onEvent(n,v1,v2)
    if n == 'Effect Blur' then
        -- v1 is blur
        -- v2 is time
        setProperty('blurShader.x',v1)
        doTweenX('blurShaderDown','blurShader',0,v2,'linear')
    end
end