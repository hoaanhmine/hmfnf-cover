-- File: custom_events/Jumpscare.lua
function onEvent(name, value1, value2)
    if name == 'Jumpscare' then
        local jumpType = value1
        local duration = tonumber(value2)
        
        -- Nếu không nhập thời gian, set mặc định là 0.25 giây
        if duration == nil or duration <= 0 then 
            duration = 0.25 
        end
        
        -- Xử lý độ mờ của ảnh (Gold = mờ, GoldAlt = đậm hơn)
        local alphaVal = 0.4
        if jumpType == 'GoldAlt' then
            alphaVal = 0.8
        end
        
        -- Tạo và hiển thị ảnh
        makeLuaSprite('jumpCat', 'catimg', 0, 0)
        setObjectCamera('jumpCat', 'other') -- Hiển thị đè lên toàn bộ UI
        scaleObject('jumpCat', 1280 / getProperty('jumpCat.width'), 720 / getProperty('jumpCat.height')) -- Phóng to full màn hình
        screenCenter('jumpCat')
        setProperty('jumpCat.alpha', alphaVal)
        addLuaSprite('jumpCat', true)
        
        -- Phát âm thanh
        playSound('scarecat', 1)
        
        -- Chạy timer để xóa ảnh
        runTimer('removeJump', duration)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'removeJump' then
        removeLuaSprite('jumpCat', true)
    end
end