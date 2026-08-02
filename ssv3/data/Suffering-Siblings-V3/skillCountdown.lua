-- TRƯỚC KHI BẮT ĐẦU (Khởi tạo các đối tượng)
function onCreate()
    -- 1. Tạo văn bản cho đếm ngược và Skill
    -- makeLuaText(tag, text, width, x, y)
    -- Đặt width là 0 để tự động kích thước theo nội dung, X là 0 để dễ căn giữa sau đó.
    makeLuaText('skillText', '', 0, 0, 300) 
    setTextSize('skillText', 50)             -- Kích thước chữ
    setTextColor('skillText', 'FFFFFF')      -- Màu trắng (FFFFFF)
    setTextBorder('skillText', 3, '000000')   -- Viền đen cho rõ (size, color)
    setTextAlignment('skillText', 'center')  -- Căn giữa nội dung text
    addLuaText('skillText')
    setObjectCamera('skillText', 'hud')      -- Gắn vào camera HUD (để không bị zoom theo stage)
    screenCenter('skillText', 'x')           -- Căn giữa đối tượng text theo chiều ngang màn hình
    setProperty('skillText.visible', false)  -- Ẩn ban đầu

    -- 2. Tạo màn đen cho hiệu ứng tối dần
    -- makeLuaSprite(tag, image, x, y)
    -- Image để trống '' sẽ tạo hình chữ nhật màu
    makeLuaSprite('fadeBack', '', -500, -500)
    makeGraphic('fadeBack', 3000, 2000, '000000') -- Tạo hình chữ nhật đen khổng lồ
    setScrollFactor('fadeBack', 0, 0)         -- Không di chuyển theo camera stage
    -- SỬA: Dùng true để thêm vào phía trước stage group (nhân vật, BG) nhưng vẫn sau HUD (notes)
    addLuaSprite('fadeBack', true) 
    setProperty('fadeBack.alpha', 0)          -- Ban đầu mờ (trong suốt)
end

-- XỬ LÝ THEO NHỊP (Beats)
function onBeatHit()
    local targetCountdownStart = 1247
    local targetCountdownEnd = 1310
    local targetSkillBeat = 1311
    local targetFadeBeat = 1449

    -- 1. Xử lý đếm ngược (Beat 1247 - 1310)
    if curBeat >= targetCountdownStart and curBeat <= targetCountdownEnd then
        -- Hiện văn bản nếu đang ẩn
        if not getProperty('skillText.visible') then
            setProperty('skillText.visible', true)
        end
        -- Tính toán số đếm ngược (đếm về 0)
        local countdownNum = targetCountdownEnd - curBeat
        setTextString('skillText', 'Skill lọ thánh chí tôn: ' .. countdownNum)
    end

    -- 2. Xử lý hiển thị chữ Skill (Beat 1311)
    if curBeat == targetSkillBeat then
        setTextString('skillText', 'Lọ thánh chí tôn!')
        -- Thêm hiệu ứng màu vàng gold (FFD700) cho "thần thánh"
        setProperty('skillText.color', getColorFromHex('FFD700')) 
        
        -- Mờ dần văn bản sau 4 beats để nó không ở trên màn hình mãi
        doTweenAlpha('skillTextFadeOut', 'skillText', 0, (60 / bpm) * 4, 'linear')
    end

    -- 3. Xử lý tối màn hình game (Beat 1449)
    if curBeat == targetFadeBeat then
        -- doTweenAlpha(tag, vars, value, duration, ease)
        -- Duration được tính theo giây. Ở đây mình cho tối dần trong 16 beats.
        local fadeDurationBeats = 16
        local fadeDurationSeconds = (60 / bpm) * fadeDurationBeats
        doTweenAlpha('gameScreenFadeToBlack', 'fadeBack', 1, fadeDurationSeconds, 'linear')
    end
end