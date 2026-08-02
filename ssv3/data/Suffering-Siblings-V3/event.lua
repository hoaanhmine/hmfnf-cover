local isCamForced = false
local originalGfX = 0
local originalJakeX = 0

function onCreatePost()
    
    setProperty('gf.visible', false)
    
end

function onBeatHit()
    if curBeat == 256 then
        setProperty('gf.visible', true)
        setProperty('jake.visible', true) -- Nhớ đổi thành 'dad' nếu Jake là đối thủ chính
    end

    if curBeat == 1044 then
        for i = 0, 3 do
            noteTweenAlpha('hideOpStrum'..i, i, 0, 0.5, 'linear') 
        end
    end

    if curBeat == 1176 then
        -- Lưu lại vị trí đứng gốc của 2 người
        originalGfX = getProperty('gf.x')
        originalJakeX = getProperty('jake.x')
        
        -- Dùng doTweenX để kéo họ trượt mạnh sang bên phải (cộng thêm 2500 pixel)
        -- Số '2' là thời gian chạy (2 giây). Bạn có thể chỉnh cho nhanh hoặc chậm hơn.
        doTweenX('gfRunAway', 'gf', originalGfX + 2500, 4, 'quadInOut')
        doTweenX('jakeRunAway', 'jake', originalJakeX + 2500, 4, 'quadInOut')
    end
    
    -- === GF VÀ JAKE QUAY VỀ Ở BEAT 1340 ===
    if curBeat == 1340 then
        -- Trượt họ trở lại chính xác vị trí đã lưu ở trên
        doTweenX('gfReturn', 'gf', originalGfX, 2, 'quadInOut')
        doTweenX('jakeReturn', 'jake', originalJakeX, 2, 'quadInOut')
    end

    local inRange = false
    
    if (curBeat >= 0 and curBeat <= 28) or 
       (curBeat >= 400 and curBeat <= 527) or 
       (curBeat >= 656 and curBeat <= 687) or 
       (curBeat >= 916 and curBeat <= 979) or 
       (curBeat >= 1044 and curBeat <= 1344) then
        inRange = true
    end

    if inRange and not isCamForced then
        -- Khóa góc máy
        triggerEvent('Camera Follow Pos', '2000', '1300')
        isCamForced = true
        
        -- Trượt 2 dải đen vào màn hình trong 1 giây (hiệu ứng 'quadOut' làm chậm dần khi dừng)
        doTweenY('cineTopIn', 'cineBarTop', 0, -50, 'quadOut')
        doTweenY('cineBotIn', 'cineBarBot', 720 - 100, 1, 'quadOut') -- 720 là chiều cao màn hình, 150 là độ dày dải đen
        
    elseif not inRange and isCamForced then
        -- Nhả góc máy
        triggerEvent('Camera Follow Pos', '', '')
        isCamForced = false
        
        -- Trượt 2 dải đen ra khỏi màn hình trong 1 giây
        doTweenY('cineTopOut', 'cineBarTop', -150, 1, 'quadInOut')
        doTweenY('cineBotOut', 'cineBarBot', 720, 1, 'quadInOut')
    end
end

function onCreate()
    makeLuaSprite('blackScreenFade', '', -500, -500)
    makeGraphic('blackScreenFade', 3000, 2000, '000000') 
    setScrollFactor('blackScreenFade', 0, 0)
    
    -- Đặt 'other' để che mọi thứ, hoặc 'game' nếu muốn giữ lại UI/Mũi tên
    setObjectCamera('blackScreenFade', 'other') 
    
    setProperty('blackScreenFade.alpha', 1) -- Bắt đầu bằng màn đen đặc
    addLuaSprite('blackScreenFade', true)

    makeLuaSprite('cineBarTop', '', -10, -150)
    makeGraphic('cineBarTop', 1300, 150, '000000')
    setObjectCamera('cineBarTop', 'hud') -- Gắn vào HUD để mũi tên vẫn nằm đè lên trên
    addLuaSprite('cineBarTop', true)

    -- Dải đen phía dưới (ẩn ở tọa độ Y = 720, mép dưới màn hình)
    makeLuaSprite('cineBarBot', '', -10, 720)
    makeGraphic('cineBarBot', 1300, 150, '000000')
    setObjectCamera('cineBarBot', 'hud')
    addLuaSprite('cineBarBot', true)
end

function onSongStart()
    -- Tính thời gian từ lúc bắt đầu đến đúng beat 32
    local timeToFade = (60 / curBpm) * 32
    
    -- Dùng 'quadInOut' để màn hình bắt đầu sáng lên thật chậm và mượt
    doTweenAlpha('fadeInScreen', 'blackScreenFade', 0, timeToFade, 'quadInOut')
end

function onTweenCompleted(tag)
    if tag == 'fadeInScreen' then
        removeLuaSprite('blackScreenFade', true)
    end
end
