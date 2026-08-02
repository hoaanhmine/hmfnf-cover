function onCreatePost()
    addModifier("reverse")
    addModifier("beat")
    addModifier("mini")
    addModifier("tipsy")
    addModifier("tornado")
    addModifier("drunk")
    addModifier("bumpy")
    addModifier("bounce")
    addModifier("confusion")
    addModifier("stealth")
    addModifier("invert")
    addModifier("boost")

    ease("beat", 0, 4, 0.2)
    ease("mini", 0, 30, -0.4)

    repeater(32, 30, "onTipsyWave")

    ease("drunk", 64, 2, 0.2)
    ease("reverse", 80, 2, 1, "quadOut")
    ease("reverse", 96, 8, 0, "quadOut")
    ease("tipsy", 96, 1, 0)
    ease("beat", 128, 2, 0.5)

    -- flicker reverse
    for i = 141, 144 do
        ease("reverse", i, 1, (i % 2 == 1) and 1 or 0, "quadOut")
    end

    ease("drunk", 224, 1, 0.3, "quadOut")
    ease("tornado", 256, 1, 0.3, "quadOut")

    -- thêm biến thể
    ease("confusion", 32, 16, 360, "sineInOut")
    ease("confusion", 48, 16, 0, "sineInOut")

    ease("bumpy", 64, 8, 2, "cubeInOut")
    ease("bumpy", 96, 8, 0, "cubeInOut")

    ease("bounce", 128, 4, 1, "elasticOut")
    ease("bounce", 160, 4, 0, "elasticOut")

    replay(192, function()
        forEachStep(192, 256, 1, function(beat)
            local val = math.sin((beat - 192) * 0.3) * 0.5 + 0.5
            setNow("stealth", val)
        end)
    end)
end

function onTipsyWave()
    ease("tipsy", 32, 1, 0.4)
    ease("tipsy", 33, 1, 0)
end

function forEachStep(start, stop, step, func)
    local i = start
    while i < stop do
        func(i)
        i = i + step
    end
end

function replay(beat, func)
    callback(beat, func)
end