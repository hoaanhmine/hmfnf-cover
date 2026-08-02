-- galaxyStage.lua
-- Stage Vũ Trụ cho Psych Engine 1.0.4

function onCreate()
    --[[
        THIẾT LẬP TỌA ĐỘ VÀ ZOOM MẶC ĐỊNH
        Bạn có thể điều chỉnh các số này nếu ảnh của bạn bị lệch
    ]]--
    local bgX = -2800
    local bgY = -1300
    
    -- Đặt vị trí mặc định cho bạn nhảy (GF) và đối thủ (Dad)
    -- Nếu không đặt, game sẽ dùng vị trí mặc định (thường là hơi thấp)
    setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-dead-space') -- Ví dụ: đổi xác chết nếu muốn
    setProperty('dad.x', 100)
    setProperty('dad.y', 100)
    setProperty('boyfriend.x', 770)
    setProperty('boyfriend.y', 100)
    setProperty('gf.x', 400)
    setProperty('gf.y', 130)


    
end

-- Biến dùng cho hiệu ứng trôi nổi
local floatTimer = 0

function onUpdate(elapsed)
    --[[
        HIỆU ỨNG ĐỘNG: TRÔI NỔI NHẸ
        Dùng hàm sin (math.sin) để tạo chuyển động lên xuống mượt mà.
    ]]--
    floatTimer = floatTimer + elapsed

    -- Làm cho bệ đứng nhấp nhô nhẹ
    -- Số 5 là biên độ (độ cao nhấp nhô), số 2 là tốc độ
    local platformOffset = math.sin(floatTimer * 2) * 5
    setProperty('thePlatform.y', (bgY + 600) + platformOffset)

    -- Làm cho hành tinh phía sau trôi chậm sang ngang
    -- Mỗi khung hình trừ đi 10 * elapsed pixel
    setProperty('bigGalaxy.x', getProperty('bigGalaxy.x') - (10 * elapsed))
    
    -- Mẹo: Nếu hành tinh trôi ra khỏi màn hình, bạn cần code thêm để nó reset vị trí (loop).
    -- Để đơn giản cho bài này, ta chỉ cho nó trôi chậm thôi.
end