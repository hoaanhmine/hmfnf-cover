function onCreatePost()
    -- [CÁC CODE TRƯỚC ĐÓ CỦA BẠN NHƯ GF/JAKE VISIBLE, CAMERA... GIỮ NGUYÊN]

    -- TẠO MÀN ĐEN CHE BACKGROUND TỪ ĐẦU (Tương tự whitebg của bạn)
    makeLuaSprite('darkBG', '', -1500, -1000)
    setScrollFactor('darkBG', 0, 0)
    makeGraphic('darkBG', 5000, 4000, '000000')
    addLuaSprite('darkBG', false)
    setProperty('darkBG.alpha', 0) -- Ban đầu ẩn đi
    
    -- Đặt màn đen này đằng sau GF (che BG nhưng không che nhân vật)
    setObjectOrder('darkBG', getObjectOrder('gfGroup') - 1)
end

function onEvent(name, value1, value2)
    -- Sự kiện ShadowColor
    if name == 'ShadowColor' then
        
        -- Lấy giá trị Value 2 làm thời gian (nếu để trống thì đổi ngay lập tức trong 0.01s)
        local time = tonumber(value2)
        if time == nil or time <= 0 then time = 0.01 end
        
        if string.lower(value1) == 'on' then
            -- Hiện màn đen che BG
            doTweenAlpha('bgFadeIn', 'darkBG', 1, time, 'linear')
            
            -- Đổi màu nhân vật (BF xám, Dad xanh, GF hồng, Jake vàng)
            -- Lưu ý: Mình để BF là CCCCCC vì nếu để FFFFFF game sẽ hiểu là giữ nguyên màu gốc
            doTweenColor('colorBF', 'boyfriend', 'CCCCCC', time, 'linear')
            doTweenColor('colorDad', 'dad', '00BFFF', time, 'linear')
            doTweenColor('colorGF', 'gf', 'FFB6C1', time, 'linear')
            doTweenColor('colorJake', 'jake', 'FFCC00', time, 'linear')
            
        elseif string.lower(value1) == 'off' then
            -- Ẩn màn đen đi
            doTweenAlpha('bgFadeOut', 'darkBG', 0, time, 'linear')
            
            -- Trả tất cả về màu gốc (FFFFFF)
            doTweenColor('normalBF', 'boyfriend', 'FFFFFF', time, 'linear')
            doTweenColor('normalDad', 'dad', 'FFFFFF', time, 'linear')
            doTweenColor('normalGF', 'gf', 'FFFFFF', time, 'linear')
            doTweenColor('normalJake', 'jake', 'FFFFFF', time, 'linear')
        end
    end
end