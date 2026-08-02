function onCreate()
    precacheImage('dep')
end

local depCount = 0

function opponentNoteHit(id, direction, noteType, isSustainNote)
    -- Trừ máu mỗi khi đối thủ hát, nhưng không trừ hết
    local curHealth = getProperty('health')
    if curHealth > 0.2 then -- chỉ trừ khi còn trên 0.2 máu
        setProperty('health', curHealth - 0.02)
    end
    -- Lấy vị trí của đối thủ (dad) và BF
    local dadX = getProperty('dad.x') + getProperty('dad.width')/2
    local dadY = getProperty('dad.y') + getProperty('dad.height')/2 - 300 -- cao hơn 1 tý
    local bfX = getProperty('boyfriend.x') + getProperty('boyfriend.width')/2-100
    local bfY = getProperty('boyfriend.y') + getProperty('boyfriend.height')/2 - 200

    depCount = depCount + 1
    local depTag = 'dep' .. depCount

    makeLuaSprite(depTag, 'dep', dadX, dadY)
    scaleObject(depTag, 0.1667, 0.1667) -- nhỏ hơn 3 lần
    addLuaSprite(depTag, true)

    doTweenX(depTag..'TweenX', depTag, bfX, 0.3, 'linear')
    doTweenY(depTag..'TweenY', depTag, bfY, 0.3, 'linear')
end

function onTweenCompleted(tag)
    -- Kiểm tra nếu tag là Tween của dép
    if string.find(tag, 'dep') and (string.find(tag, 'TweenX') or string.find(tag, 'TweenY')) then
        local depTag = string.gsub(tag, 'Tween[X|Y].*', '')
        removeLuaSprite(depTag, true)
    end
end