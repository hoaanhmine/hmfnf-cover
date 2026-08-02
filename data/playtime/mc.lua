function onCreatePost()

    -- Intro: build-up nhẹ
    ease("tipsy", 0, 8, 0.3, "sineInOut")
    ease("drunk", 0, 16, 0.2, "sineInOut")
    ease("confusion", 0, 32, 90, "sineInOut")

    -- Đoạn 1 (36-68)
    ease("beat", 36, 1, 1, "cubeOut")
    ease("bounce", 68, 4, 1, "cubeOut")
    ease("vibrate", 36, 4, 0.3, "sineInOut")
    ease("vibrate", 68, 4, 0, "sineInOut")

    -- Đoạn 2 (100-164)
    ease("bounce", 100, 1, 0, "cubeOut")
    ease("reverse", 100, 4, 1, "cubeOut")

    ease("fieldRotateZ", 100, 4, 15, "sineInOut")
    ease("fieldRotateZ", 120, 4, -15, "sineInOut")
    ease("fieldRotateZ", 132, 2, 0, "sineInOut")

    ease("reverse", 132, 10, 0, "cubeOut")
    ease("boost", 132, 1, 1, "cubeOut")
    ease("beat", 132, 2, 2, "cubeOut")

    ease("bumpy", 132, 8, 1, "sineInOut")
    ease("bumpy", 140, 8, 0, "sineInOut")

    ease("beat", 164, 1, 2, "cubeOut")
    ease("boost", 164, 1, 0, "cubeOut")
    ease("bounce", 164, 2, 1, "cubeOut")

    -- Đoạn 3 (164-228): sneak + hidden transition
    ease("dark", 164, 2, 1, "cubeOut")
    ease("stealth", 164, 1, 0.5, "cubeOut")
    ease("stealth", 180, 4, 0, "sineOut")

    ease("dark", 194, 2, 0, "cubeOut")
    ease("bounce", 194, 2, 0, "cubeOut")
    ease("beat", 194, 1, 0, "cubeOut")

    -- Spiral + inverted section
    ease("invert", 200, 4, 1, "sineInOut")
    ease("infinite", 200, 4, 0.5, "sineInOut")
    ease("infinite", 220, 4, 0, "sineInOut")
    ease("invert", 220, 4, 0, "sineInOut")

    -- Đoạn 4 (228-292): ẩn rồi bùng nổ
    ease("hidden", 228, 12, 1, "cubeOut")
    ease("beat", 228, 1, 1, "cubeOut")

    ease("reverse", 256, 10, 1, "cubeOut")
    ease("bounce", 260, 1, 1, "cubeOut")

    ease("confusion", 260, 8, 360, "expoIn")
    ease("confusion", 268, 4, 0, "sineOut")

    ease("reverse", 272, 2, 0, "cubeOut")
    ease("bounce", 292, 1, 0, "cubeOut")

    -- Đoạn 5 (292-356): sóng dồn
    ease("bumpy", 292, 1, 2, "cubeOut")
    ease("tornado", 292, 8, 0.4, "sineInOut")
    ease("tornado", 310, 8, 0, "sineInOut")

    ease("sawtooth", 324, 1, 1, "cubeOut")
    ease("hidden", 324, 12, 0, "cubeOut")
    ease("tipsy", 324, 1, 1, "cubeOut")

    ease("radionic", 324, 4, 1, "sineInOut")
    ease("radionic", 340, 4, 0, "sineInOut")

    -- Đoạn 6 (356-372): shaky build-up
    ease("reverse", 356, 1, 1, "cubeOut")
    ease("vibrate", 356, 8, 0.5, "sineInOut")
    ease("asymptote", 356, 8, 0.6, "sineInOut")

    -- Drop cuối
    ease("reverse", 372, 10, 0, "cubeOut")
    ease("fieldRotateZ", 372, 1, 25, "expoOut")
    ease("fieldRotateZ", 374, 1, -25, "expoOut")
    ease("fieldRotateZ", 376, 1, 15, "expoOut")
    ease("fieldRotateZ", 378, 1, 0, "sineOut")

    -- Outro: fadeout
    ease("stealth", 380, 6, 1, "sineInOut")
    ease("tipsy", 380, 4, 0)
end