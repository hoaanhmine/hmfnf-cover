function onEvent(name, value1, value2)
    if name == "Reactor Beep" then
        local fadeTime = tonumber(value1) or 0.25
        triggerReactorBeep(fadeTime)
    end
end

function triggerReactorBeep(fadeTime)
    makeLuaSprite("reactorOverlay", "", 0, 0)
    makeGraphic("reactorOverlay", screenWidth, screenHeight, "FF0000")
    setObjectCamera("reactorOverlay", "camOther")
    setProperty("reactorOverlay.alpha", 0)
    -- setBlendMode("reactorOverlay", "add")
    addLuaSprite("reactorOverlay", true)

    setProperty("reactorOverlay.alpha", 0.2)
    doTweenAlpha("reactorFade", "reactorOverlay", 0, fadeTime, "linear")

    runTimer("cleanupReactor", fadeTime + 0.1, 1)
end

function onTimerCompleted(tag)
    if tag == "cleanupReactor" then
        removeLuaSprite("reactorOverlay", true)
    end
end