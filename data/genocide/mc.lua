function onCreatePost()

    -- Intro: từ từ hiện ra
    ease("stealth", 0, 0, 1)
    ease("stealth", 0, 4, 0, "sineOut")
    ease("mini", 0, 30, 1.2)
    ease("vibrate", 0, 1, 0.2)
    ease("tipsy", 0, 8, 0.3, "sineInOut")

    -- Đoạn 1: waves nhẹ
    ease("beat", 32, 4, 2)
    ease("wave", 32, 2, 1, "sineInOut")
    ease("mini", 32, 2, 0.1)
    ease("stealth", 32, 0, 0)
    ease("stealth", 44, 4, 0)

    -- Đoạn 2: lên cao trào
    ease("drunk", 48, 4, 0.5, "sineInOut")
    ease("confusion", 48, 8, 180, "sineInOut")
    ease("rotate", 48, 8, 45, "sineInOut")

    ease("confusion", 56, 8, 0, "sineInOut")
    ease("rotate", 56, 8, 0, "sineInOut")

    -- Drop: mạnh mẽ
    ease("tipsy", 64, 4, 1)
    ease("bumpy", 64, 4, 2, "sineInOut")
    ease("sawtooth", 64, 4, 1, "sineInOut")
    ease("boost", 64, 2, 50, "sineInOut")

    ease("bumpy", 80, 4, 0, "sineInOut")
    ease("sawtooth", 80, 4, 0, "sineInOut")
    ease("boost", 80, 2, 0, "sineInOut")

    -- Đoạn 3: xoay + đảo
    ease("reverse", 96, 4, 1, "quadOut")
    ease("drunk", 96, 4, 0.8, "sineInOut")
    ease("tornado", 96, 4, 0.3, "sineInOut")

    -- Đoạn 4: confusion build-up
    ease("confusion", 112, 4, 360, "sineInOut")
    ease("confusion", 116, 4, 0, "sineInOut")
    ease("reverse", 116, 4, 0, "quadIn")

    ease("tipsy", 128, 4, 0)
    ease("bumpy", 128, 4, 1, "sineInOut", 1)
    ease("bumpy", 160, 4, 0, "sineInOut", 1)


    -- Tăng tốc boost
    ease("boost", 224, 2, 20, "sineInOut", 0)
    ease("drugged", 224, 4, 0.5, "sineInOut")
    ease("asymptote", 224, 4, 0.5, "sineInOut")
    ease("boost", 256, 2, 50, "sineInOut", 0)
    ease("drugged", 256, 4, 1, "sineInOut")

    -- Kết thúc
    ease("bounce", 400, 2, 50, "linear", 0)
    ease("beat", 400, 4, 3, "sineInOut")
    ease("confusion", 400, 4, 360, "expoOut")
end