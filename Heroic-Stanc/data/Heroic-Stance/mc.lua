-- DEMO: Infinite copies + di chuyển
-- Modifier chính: infinite, cull

function onCreate()
	--------------------
	-- CƠ BẢN: Bật bản sao
	--------------------
	-- infinite = 1: nhân bản nốt vô tận về phía cuộn
	set('infinite', 0, 1)
	-- cull = 0.4: chỉ hiện bản sao trong khoảng 40% màn hình
	set('cull', 0, 0.4)

	--------------------
	-- DI CHUYỂN BẢN SAO
	--------------------
	ease('rotateZ', 0, 16, -720, 'cubeInOut')
	ease('waveyy', 0, 16, 0.8, 'sineInOut')
	ease('drunk', 0, 8, 1, 'sineInOut')
	set('drunkSpeed', 0, 3)
	
	--------------------
	-- TĂNG SỐ LƯỢNG BẢN SAO
	-- cull càng nhỏ → càng nhiều bản sao hiện ra
	--------------------
	ease('cull', 16, 4, 0.15, 'expoOut')

	--------------------
	-- XOAY BẢN SAO THEO NHẠC
	--------------------
	add('angley', 16, 1, 360, 'cubeOut')
	add('angley', 18, 1, -360, 'cubeOut')
	add('angley', 20, 1, 360, 'cubeOut')
	add('angley', 22, 1, -360, 'cubeOut')

	--------------------
	-- TẠO THÊM BẢN SAO VỚI PLAYFIELD
	--------------------
	addPlayfield()
	set('infinite', 24, 1, 1, 1)        -- Playfield 2 cũng infinite
	set('cull', 24, 0.3, 1, 1)
	set('alpha', 24, 0.3, 1, 1)          -- Bản sao mờ hơn
	set('stealthglowgreen', 24, 1, 1, 1) -- Phát sáng xanh
	ease('rotateZ', 24, 16, 720, 'cubeInOut', 1, 1)

	--------------------
	-- EFFECT TỔ HỢP: VŨ ĐIỆU BẢN SAO
	--------------------
	for i = 32, 48, 2 do
		add('waveyy', i, 1, 0.5, 'bounceOut')
		add('waveyx', i, 1, -0.3, 'sineOut')
		add('bumpy', i, 1, 1, 'bounceOut')
		add('rotateZ', i, 1, 45, 'backOut')
	end

	--------------------
	-- KẾT THÚC
	--------------------
	ease('stealth', 48, 8, 0, 'sineInOut')
	ease('cull', 48, 8, 0, 'sineIn')
end
