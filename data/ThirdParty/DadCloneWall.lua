-- ================= CẤU HÌNH CƠ BẢN =================
local startBeat = 108
local endBeat = 171
local rowCount = 3
local clonesPerRow = 4
local scrollSpeed = 200
local scaleMult = 0.6     -- Giữ nguyên hoặc chỉnh nhỏ hơn nếu thấy hình to quá
local wallCamZoom = 0.5

-- ================= CẤU HÌNH OFFSET TỪ FILE JSON =================
-- Tôi đã điền chính xác số liệu từ file JSON bạn gửi vào đây
local animData = {
    {prefix = 'hmfnf idle',  name = 'idle',      x = 18, y = 163},
    {prefix = 'hmfnf left',  name = 'singLEFT',  x = 16, y = 164},
    {prefix = 'hmfnf down',  name = 'singDOWN',  x = 20, y = 163},
    {prefix = 'hmfnf up',    name = 'singUP',    x = 22, y = 162},
    {prefix = 'hmfnf right', name = 'singRIGHT', x = 21, y = 164}
}
-- ================================================================

local activeClones = false
local cloneTags = {}
local dadImage = ''
local originalZoom = 0

function onCreatePost()
    -- Lấy tên ảnh từ nhân vật Dad
    dadImage = getProperty('dad.imageFile')
    originalZoom = getProperty('defaultCamZoom')
end

function onBeatHit()
    if curBeat == startBeat then
        startCloneEffect()
    end
    if curBeat == endBeat then
        endCloneEffect()
    end
    
    -- Clone nhảy Idle theo nhịp
    if activeClones and curBeat % 2 == 0 then
        for i, tag in pairs(cloneTags) do
            -- Chỉ idle khi animation hát đã kết thúc
            if getProperty(tag..'.animation.curAnim.finished') then
                objectPlayAnimation(tag, 'idle', true)
            end
        end
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if activeClones then
        local animName = ''
        if direction == 0 then animName = 'singLEFT'
        elseif direction == 1 then animName = 'singDOWN'
        elseif direction == 2 then animName = 'singUP'
        elseif direction == 3 then animName = 'singRIGHT'
        end
        
        for i, tag in pairs(cloneTags) do
            objectPlayAnimation(tag, animName, true)
        end
    end
end

function startCloneEffect()
    activeClones = true
    
    -- Xử lý Camera
    doTweenZoom('wallZoom', 'camGame', wallCamZoom, 1, 'quadOut')
    setProperty('isCameraOnForcedPos', true)
    setProperty('camFollow.x', 640)
    setProperty('camFollow.y', 360)
    
    setProperty('dad.visible', false) 

    local screenHeight = 720
    local rowHeight = screenHeight / rowCount
    -- Kiểm tra xem Dad gốc có bị lật hình không (từ JSON flip_x)
    local isDadFlipped = getProperty('dad.flipX')

    for row = 0, rowCount - 1 do
        for col = 0, clonesPerRow - 1 do
            local tag = 'dadClone_' .. row .. '_' .. col
            
            makeAnimatedLuaSprite(tag, dadImage, 0, 0)
            
            -- >>> THÊM ANIMATION VÀ OFFSET CHUẨN TỪ JSON <<<
            for _, anim in pairs(animData) do
                -- Thêm Animation
                addAnimationByPrefix(tag, anim.name, anim.prefix, 24, false)
                -- Thêm Offset (QUAN TRỌNG: Giúp hình không bị lệch)
                addOffset(tag, anim.name, anim.x, anim.y)
            end
            
            -- Cài đặt thuộc tính
            scaleObject(tag, scaleMult, scaleMult)
            setProperty(tag .. '.flipX', isDadFlipped) -- Lật hình giống hệt Dad gốc
            
            -- Tính toán vị trí
            local startX = (screenWidth / clonesPerRow) * col
            local startY = (row * rowHeight) + (rowHeight/2) - (getProperty(tag..'.height')/2)
            
            setProperty(tag .. '.x', startX)
            setProperty(tag .. '.y', startY)
            
            addLuaSprite(tag, false)
            table.insert(cloneTags, tag)
            
            objectPlayAnimation(tag, 'idle', true)
        end
    end
end

function onUpdate(elapsed)
    if activeClones then
        for i, tag in pairs(cloneTags) do
            local parts = stringSplit(tag, '_')
            local currentRow = tonumber(parts[2])
            local moveX = 0
            
            -- Hàng chẵn sang phải, lẻ sang trái
            if currentRow % 2 == 0 then moveX = scrollSpeed * elapsed
            else moveX = -(scrollSpeed * elapsed) end
            
            setProperty(tag .. '.x', getProperty(tag .. '.x') + moveX)
            
            -- Loop vô tận
            local currentX = getProperty(tag .. '.x')
            -- Tính chiều rộng thực tế sau khi scale để loop mượt hơn
            local spriteWidth = getProperty(tag .. '.frameWidth') * scaleMult 
            
            if currentX > screenWidth + 100 then 
                setProperty(tag .. '.x', -spriteWidth)
            elseif currentX < -spriteWidth - 100 then 
                setProperty(tag .. '.x', screenWidth) 
            end
        end
    end
end

function endCloneEffect()
    activeClones = false
    for i, tag in pairs(cloneTags) do removeLuaSprite(tag, true) end
    cloneTags = {}
    
    doTweenZoom('wallZoomReturn', 'camGame', originalZoom, 0.5, 'quadOut')
    setProperty('isCameraOnForcedPos', false)
    setProperty('dad.visible', true)
end

function stringSplit(str, sep)
    if sep == nil then sep = "%s" end
    local t={}
    for str in string.gmatch(str, "([^"..sep.."]+)") do table.insert(t, str) end
    return t
end