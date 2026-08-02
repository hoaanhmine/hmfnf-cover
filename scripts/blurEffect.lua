function onCreatePost()
    makeLuaSprite('godraysShader')
    if shadersEnabled then
        initLuaShader('godrays')
        setSpriteShader('godraysShader','godrays')
        runHaxeCode([[
            var godraysShader = game.createRuntimeShader('godrays');
            FlxG.game.setFilters([new ShaderFilter(godraysShader)]);
            game.getLuaObject('godraysShader').shader = godraysShader;
        ]])

        setShaderFloat('godraysShader','range', -0.1)
        setShaderFloat('godraysShader','brightness', 0.0)
    --setProperty('camGame.x',20)
    end
end

cx = 0.4
cy = 0.4

cxNew = 0.4
cyNew = 0.4

function onStepHit()
    cxNew = 0.4 + getRandomFloat(-0.15, 0.15)
    cyNew = 0.4 + getRandomFloat(-0.15, 0.15)
end

function onUpdate(elapsed)
    cx = math.lerp(cx, cxNew, math.bound(elapsed * 6, 0, 1));
    cy = math.lerp(cy, cyNew, math.bound(elapsed * 6, 0, 1));
    
    setShaderFloat('godraysShader','centerX', cx)
    setShaderFloat('godraysShader','centerY', cy)
    setShaderFloat('godraysShader','brightness', getProperty('godraysShader.x'))
end

function onEvent(n,v1,v2)
    if n == 'Flash Rays' then
        -- v1 is brightness
        -- v2 is duration
        setProperty('godraysShader.x',v1)
        doTweenX('godraysShaderDown','godraysShader',0,v2,'linear')
    end
end

function math.bound(value,min,max)
    return math.max(min,math.min(max,value))
end

function math.lerp(from,to,i)
    return from+(to-from)*i
end