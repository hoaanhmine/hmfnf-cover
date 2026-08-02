-- === CẤU HÌNH VỊ TRÍ ===
local startY = 1500      -- Vị trí xuất phát thấp
local targetY = -200     -- Độ cao trung bình khi bay (nên thấp hơn chút để cam dễ nhìn)
local centerX = 400      -- Tâm màn hình (X)
local flySpeed = 1.5     -- Tốc độ trôi nổi

-- === BIẾN HỆ THỐNG ===
local isFlying = false

function onCreate()
    -- 1. Setup GF
    setProperty('gf.y', startY)
    setProperty('gf.x', centerX)
    
    -- 2. Màn hình đen (Overlay)
    makeLuaSprite('blackOverlay', '', 0, 0)
    makeGraphic('blackOverlay', 1280, 720, '000000')
    setObjectCamera('blackOverlay', 'other')
    setProperty('blackOverlay.alpha', 0)
    addLuaSprite('blackOverlay', true)
end

function onBeatHit()
    -- [[ GIAI ĐOẠN 1: GF ĐI LÊN & CHUYỂN CẢNH ]]
    if curBeat == 256 then
        local duration = (60 / curBpm) * 43
        
        -- GF bay lên vị trí chờ
        doTweenY('gfRiseUp', 'gf', targetY, duration, 'sineInOut')
        doTweenX('gfMoveCenter', 'gf', centerX, duration, 'sineInOut')
        
        -- Hiệu ứng ánh sáng
        setProperty('blackOverlay.alpha', 1) 
        doTweenAlpha('lightUpEffect', 'blackOverlay', 0, duration, 'linear')
        
        -- Ẩn Dad đi
        doTweenAlpha('dadVanish', 'dad', 0, 0.5, 'linear')
    end

    -- [[ GIAI ĐOẠN 2: BẮT ĐẦU TRÔI NỔI (SPACE FLOAT) ]]
    if curBeat == 304 then
        isFlying = true
        cancelTween('gfRiseUp')
        cancelTween('gfMoveCenter')
    end

    -- [[ GIAI ĐOẠN 3: KẾT THÚC (Beat 555) ]]
    if curBeat == 555 then
        isFlying = false
        
        -- Reset Camera về mặc định
        triggerEvent('Camera Follow Pos', '', '') 
        
        -- GF biến mất, Dad hiện lại
        doTweenAlpha('gfFadeOut', 'gf', 0, 2, 'linear')
        doTweenAlpha('dadComeBack', 'dad', 1, 2, 'linear')
        
        -- Trả GF về vị trí thẳng đứng (hết nghiêng)
        doTweenAngle('gfResetAng', 'gf', 0, 2, 'sineInOut')
    end
end

function onUpdate(elapsed)
    if isFlying then
        -- [[ 1. LOGIC BAY TỰ NHIÊN (ZERO GRAVITY) ]]
        -- Dùng songPosition để chuyển động mượt theo thời gian thực
        local time = getSongPosition() / 1000 * flySpeed
        
        -- Công thức tạo quỹ đạo "số 8 méo" hoặc lơ lửng ngẫu nhiên:
        -- Kết hợp 2 sóng Sin/Cos với tần số khác nhau để không bị lặp lại đơn điệu
        local driftX = math.sin(time) * 300 + math.cos(time * 0.5) * 150
        local driftY = math.cos(time * 0.8) * 200 + math.sin(time * 0.4) * 100
        
        setProperty('gf.x', centerX + driftX)
        setProperty('gf.y', targetY + driftY)
        
        -- Thêm hiệu ứng xoay nhẹ (Tilt) như đang mất trọng lực
        -- Nghiêng từ -5 đến 5 độ
        local tilt = math.sin(time * 0.5) * 5 
        setProperty('gf.angle', tilt)

        -- [[ 2. LOGIC CAMERA THÔNG MINH ]]
        -- Kiểm tra xem đang đến lượt ai (mustHitSection = true là BF, false là Opponent)
        if not mustHitSection then
            -- Nếu là lượt của GF/Dad: Ép cam đi theo GF đang bay
            local camX = getProperty('gf.x') + getProperty('gf.width') / 2
            local camY = getProperty('gf.y') + getProperty('gf.height') / 2 - 100 -- Trừ 100 để nhìn rõ mặt hơn
            
            triggerEvent('Camera Follow Pos', camX, camY)
        else
            -- Nếu là lượt của BF: Thả cam ra để nó tự về BF
            triggerEvent('Camera Follow Pos', '', '')
        end
    end
end