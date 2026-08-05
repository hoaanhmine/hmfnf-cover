-- DEMO: Infinite copies + di chuyển
-- Modifier chính: infinite, cull

function onCreatePost()


	ease('drunk', 0, 8, 1, 'sineInOut')
		ease('drunk', 133, 8, 0, 'sineInOut')

    ease("reverse", 196, 2, 1, "cubeOut")
    ease("reverse", 224, 12, 0, "cubeOut")

	ease('beat', 358, 2, 1, 'sineInOut')
	ease('vibrate', 358, 2, 1, 'sineInOut')

for beat = 358, 390, 2 do
    -- Lệnh 1 bắt đầu tại mốc 'beat'
    ease("reverse", beat, 1, 1, "cubeOut")
    
    -- Lệnh 2 bắt đầu SAU lệnh 1 (Ví dụ: trễ 1 beat)
    ease("reverse", beat + 1, 1, 0, "cubeOut")
end

	ease('movex', 368, 1, -300, 'sineInOut')
	ease('movex', 402, 1, -600, 'sineInOut')
	ease('movex', 406, 1, -1200, 'sineInOut')
	ease('movex', 410, 1, -1600, 'sineInOut')
	ease('movex', 414, 1, -1200, 'sineInOut')
	ease('movex', 418, 1, -800, 'sineInOut')
	ease('movex', 422, 1, -600, 'sineInOut')
	ease('movex', 426, 1, -300, 'sineInOut')
	ease('movex', 430, 1, 0, 'sineInOut')
    ease("reverse", 431, 2, 1, "cubeOut")
	ease('drunk', 431, 4, 1, 'sineInOut')
	ease('reverse', 442, 4, 0, 'sineInOut')

	
end

