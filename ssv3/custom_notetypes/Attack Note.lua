function onCreate()
    makeAnimatedLuaSprite('attackSlash', 'slash/slash', 0, 0)
    addAnimationByPrefix('attackSlash', 'slashAnim', 'slash slash', 24, false)
    addLuaSprite('attackSlash', true)
    
    -- Đổi màu sprite sang màu xanh da trời (Mã Hex: 00FFFF - Cyan)
    setProperty('attackSlash.color', getColorFromHex('00FFFF'))
    
    setProperty('attackSlash.visible', false)
end

function onCreatePost()
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Attack Note' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'opponentNote/butlet')
            setPropertyFromGroup('unspawnNotes', i, 'offsetX', getPropertyFromGroup('unspawnNotes', i, 'offsetX') - 60)
            setPropertyFromGroup('unspawnNotes', i, 'offsetY', getPropertyFromGroup('unspawnNotes', i, 'offsetY') - 60)
            --setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'opponentNote/butlet')
            setPropertyFromGroup('unspawnNotes', i, 'scale.x', 0.6)
            setPropertyFromGroup('unspawnNotes', i, 'scale.y', 0.6)
            --setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0.25)
        end
    end

    for j = 0, getProperty('grpNoteSplashes.length') - 1 do
        setPropertyFromGroup('grpNoteSplashes', j, 'noteSplashTexture', 'opponentNote/butlet')
    end
end
    
function goodNoteHit(id, dir, type, sus)
    if type == 'Attack Note' then
        -- Phát animation cho boyfriend
        playAnim('boyfriend', 'attack', true)
        setProperty('boyfriend.specialAnim', true)
        
        -- === HIỆU ỨNG SLASH ===
        -- Mình đã đổi thành trừ 50 (-50) để nó dịch sang trái. 
        -- Nếu vẫn chưa chuẩn, bạn cứ giảm số này xuống thêm nhé (ví dụ: -100).
        local slashX = getProperty('dad.x') - 250
        local slashY = getProperty('dad.y') - 100
        
        setProperty('attackSlash.x', slashX)
        setProperty('attackSlash.y', slashY)
        
        -- Xoay ảnh ngẫu nhiên từ 0 đến 360 độ để tạo cảm giác chém nhiều góc khác nhau
        local randomAngle = math.random(0, 360)
        setProperty('attackSlash.angle', randomAngle)
        
        -- Hiện sprite và chạy animation chém
        setProperty('attackSlash.visible', true)
        playAnim('attackSlash', 'slashAnim', true)
        
        -- Hẹn giờ ẩn hiệu ứng
        runTimer('hideSlash', 0.3)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'hideSlash' then
        -- Ẩn hiệu ứng đi sau khi chém xong
        setProperty('attackSlash.visible', false)
    end
end