-- ================= KHAI BÁO FFI (HỆ THỐNG WINDOWS) =================
local ffi = require("ffi")
local user32 = ffi.load("user32")

ffi.cdef([[
    typedef void* HWND;
    typedef int BOOL;
    typedef unsigned char BYTE;
    typedef unsigned long DWORD;
    HWND GetActiveWindow();
    long SetWindowLongA(HWND hWnd, int nIndex, long dwNewLong);
    BOOL SetLayeredWindowAttributes(HWND hwnd, DWORD crKey, BYTE bAlpha, DWORD dwFlags);
]])

local transColorKey = 0x131313 

-- ================= CẤU HÌNH TIMING =================
-- Beat 172: Thu nhỏ & Sóng nhẹ
-- Beat 236: To dần
-- Beat 268: Ẩn game
-- Beat 272: Full màn hình trong suốt + CLONE ORBIT + SÓNG BIỂN (ĐẾN HẾT BÀI)
-- Beat 368: Kết thúc Clone (Nhưng sóng vẫn giữ đến hết)

-- ================= CẤU HÌNH SÓNG BIỂN (SEA WAVE) =================
local seaSpeed = 2.0        -- Tốc độ sóng (càng cao càng nhanh)
local seaAmpX = 30          -- Biên độ lắc ngang của Note
local seaAmpY = 15          -- Biên độ nhấp nhô dọc của Note
local windowWaveAmp = 100   -- Biên độ trôi của Cửa sổ

-- ================= CẤU HÌNH CLONE ORBIT =================
local cloneCount = 8        
local orbitRadX = 600       
local orbitRadY = 150       
local orbitSpeed = 2.0      
local scaleMult = 0.7       
local activeClones = false
local cloneTags = {}

local animData = {
    {prefix = 'hmfnf idle',  name = 'idle',      x = 18, y = 163},
    {prefix = 'hmfnf left',  name = 'singLEFT',  x = 16, y = 164},
    {prefix = 'hmfnf down',  name = 'singDOWN',  x = 20, y = 163},
    {prefix = 'hmfnf up',    name = 'singUP',    x = 22, y = 162},
    {prefix = 'hmfnf right', name = 'singRIGHT', x = 21, y = 164}
}

-- Biến hệ thống
local originalWidth = 1280
local originalHeight = 720
local defaultX = 320
local defaultY = 180
local isSeaMode = false         -- Biến kích hoạt chế độ biển cả
local isTransparentMode = false
local strumDefaultX = {}        -- Lưu vị trí gốc của Note
local strumDefaultY = {}

function onCreate()
    makeLuaSprite('winHelper', '', originalWidth, 0) 
    setProperty('winHelper.y', defaultX)   
    setProperty('winHelper.angle', defaultY)
    setPropertyFromClass('ClientPrefs', 'autoPause', false)
end

function onCreatePost()
    -- Lưu lại vị trí gốc của các mũi tên (Strum Notes) để sau này cộng trừ sóng
    for i = 0, 7 do
        table.insert(strumDefaultX, getPropertyFromGroup('strumLineNotes', i, 'x'))
        table.insert(strumDefaultY, getPropertyFromGroup('strumLineNotes', i, 'y'))
    end
end

function onBeatHit()
    -- ZOOM CAMERA
    if curBeat >= 40 and curBeat < 268 then
        triggerEvent('Add Camera Zoom', 0.03, 0.03)
    end

    -- [PHASE 1] Beat 172: Sóng nhẹ cửa sổ
    if curBeat == 172 then
        doTweenX('tweenW_Small', 'winHelper', 960, 1.5, 'quartOut')
        doTweenY('tweenX_Small', 'winHelper', 480, 1.5, 'quartOut')
        doTweenAngle('tweenY_Small', 'winHelper', 270, 1.5, 'quartOut')
    end

    -- [PHASE 2] Beat 236: Trả về bình thường
    if curBeat == 236 then
        doTweenX('tweenW_Big', 'winHelper', originalWidth, 8, 'linear')
        doTweenY('tweenX_Big', 'winHelper', defaultX, 8, 'linear')
        doTweenAngle('tweenY_Big', 'winHelper', defaultY, 8, 'linear')
    end

    -- [PHASE 3] Beat 268: Ẩn game
    if curBeat == 268 then
        setPropertyFromClass('openfl.Lib', 'application.window.minimized', true)
    end

    -- [PHASE 4] Beat 272: BÙNG NỔ (Trong suốt + Clone + Sóng Biển)
    if curBeat == 272 then
        setupTransparentWindow()
        startCloneOrbit()
        doTweenZoom('camZoomOutClone', 'camGame', 0.6, 2, 'quartOut') 
        
        -- Kích hoạt chế độ Sóng Biển vĩnh viễn
        isSeaMode = true 
    end
    
    -- [PHASE 5] Beat 368: Kết thúc Clone (Nhưng giữ sóng)
    if curBeat == 368 then
        endCloneEffect()
        doTweenZoom('cinematicZoom', 'camGame', 1.1, 8, 'sineInOut')
        setProperty('cameraSpeed', 0.5)
    end
    
    if activeClones and curBeat % 2 == 0 then
        for i, tag in pairs(cloneTags) do
            if getProperty(tag..'.animation.curAnim.finished') then
                objectPlayAnimation(tag, 'idle', true)
            end
        end
    end
end

function onUpdate(elapsed)
    local songPos = getSongPosition() / 1000 -- Lấy thời gian bài hát (giây)

    -- =============================================
    -- 1. LOGIC SÓNG BIỂN (NOTES & WINDOW)
    -- =============================================
    if isSeaMode then
        -- A. CỬA SỔ TRÔI (Window Wave)
        -- Dùng vị trí hiện tại (đã căn giữa) làm gốc
        local winBaseX = getProperty('winHelper.y') 
        local winBaseY = getProperty('winHelper.angle')
        
        -- Công thức số 8 vô cực cho cửa sổ
        local winWaveX = math.cos(songPos * (seaSpeed * 0.5)) * windowWaveAmp
        local winWaveY = math.sin(songPos * (seaSpeed * 0.5)) * (windowWaveAmp / 2)
        
        setPropertyFromClass('openfl.Lib', 'application.window.x', math.floor(winBaseX + winWaveX))
        setPropertyFromClass('openfl.Lib', 'application.window.y', math.floor(winBaseY + winWaveY))

        -- B. NOTES TRÔI (Note Wave)
        for i = 0, 7 do
            -- Tạo độ lệch pha (i * 0.5) để các note uốn lượn như rắn chứ không di chuyển cùng lúc
            local noteOffset = i * 0.3
            
            -- Tính toán vị trí mới
            local moveX = math.sin((songPos * seaSpeed) + noteOffset) * seaAmpX
            local moveY = math.cos((songPos * seaSpeed) + noteOffset) * seaAmpY
            
            -- Áp dụng vào Note (Cộng vào vị trí gốc)
            setPropertyFromGroup('strumLineNotes', i, 'x', strumDefaultX[i+1] + moveX)
            setPropertyFromGroup('strumLineNotes', i, 'y', strumDefaultY[i+1] + moveY)
            
            -- (Tùy chọn) Xoay nhẹ Note
             setPropertyFromGroup('strumLineNotes', i, 'angle', math.sin(songPos * seaSpeed + noteOffset) * 5)
        end
    
    -- Logic cửa sổ cũ (Trước khi vào Sea Mode)
    elseif curBeat >= 172 and curBeat < 236 then 
         -- Logic sóng nhẹ cũ
         local currentW = getProperty('winHelper.x')
         local currentX = getProperty('winHelper.y')
         local currentY = getProperty('winHelper.angle')
         local currentH = math.floor(currentW * (9 / 16))
         
         local waveX = math.cos(songPos * 1.0) * 150
         local waveY = math.sin(songPos * 2.0) * 50
         
         setPropertyFromClass('openfl.Lib', 'application.window.x', math.floor(currentX + waveX))
         setPropertyFromClass('openfl.Lib', 'application.window.y', math.floor(currentY + waveY))
         setPropertyFromClass('openfl.Lib', 'application.window.width', math.floor(currentW))
         setPropertyFromClass('openfl.Lib', 'application.window.height', currentH)
         
    elseif curBeat < 268 then
         -- Logic resize bình thường
         local currentW = getProperty('winHelper.x')
         local currentX = getProperty('winHelper.y')
         local currentY = getProperty('winHelper.angle')
         local currentH = math.floor(currentW * (9 / 16))
         
         setPropertyFromClass('openfl.Lib', 'application.window.x', math.floor(currentX))
         setPropertyFromClass('openfl.Lib', 'application.window.y', math.floor(currentY))
         setPropertyFromClass('openfl.Lib', 'application.window.width', math.floor(currentW))
         setPropertyFromClass('openfl.Lib', 'application.window.height', currentH)
    end

    -- =============================================
    -- 2. LOGIC CLONE ORBIT
    -- =============================================
    if activeClones then
        local centerX = getMidpointX('dad')
        local centerY = getMidpointY('dad')
        
        for i, tag in pairs(cloneTags) do
            local angle = (songPos * orbitSpeed) + (i * (math.pi * 2) / cloneCount)
            local newX = centerX + math.cos(angle) * orbitRadX
            local newY = centerY + math.sin(angle) * orbitRadY
            
            newX = newX - (getProperty(tag..'.width') / 2)
            newY = newY - (getProperty(tag..'.height') / 2) + 100 
            
            setProperty(tag .. '.x', newX)
            setProperty(tag .. '.y', newY)
            
            local depthScale = math.sin(angle) * 0.1 
            scaleObject(tag, scaleMult + depthScale, scaleMult + depthScale)
        end
    end
end

-- ================= CÁC HÀM HỖ TRỢ =================
function startCloneOrbit()
    activeClones = true
    local dadImage = getProperty('dad.imageFile')
    local isDadFlipped = getProperty('dad.flipX')
    cloneTags = {}
    for i = 1, cloneCount do
        local tag = 'dadCloneOrb_' .. i
        makeAnimatedLuaSprite(tag, dadImage, 0, 0)
        for _, anim in pairs(animData) do
            addAnimationByPrefix(tag, anim.name, anim.prefix, 24, false)
            addOffset(tag, anim.name, anim.x, anim.y)
        end
        scaleObject(tag, scaleMult, scaleMult)
        setProperty(tag .. '.flipX', isDadFlipped)
        addLuaSprite(tag, false) 
        table.insert(cloneTags, tag)
        objectPlayAnimation(tag, 'idle', true)
    end
end

function endCloneEffect()
    activeClones = false
    for i, tag in pairs(cloneTags) do
        doTweenAlpha('fadeClone'..tag, tag, 0, 1, 'linear')
    end
    runTimer('cleanupClones', 1.1)
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'cleanupClones' then
        for i, tag in pairs(cloneTags) do removeLuaSprite(tag, true) end
        cloneTags = {}
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
        for i, tag in pairs(cloneTags) do objectPlayAnimation(tag, animName, true) end
    end
end

function setupTransparentWindow()
    setPropertyFromClass('openfl.Lib', 'application.window.minimized', false)
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', true)
    
    local screenW = getPropertyFromClass('openfl.Lib', 'application.window.display.currentMode.width')
    local safeWidth = screenW - 100
    local safeHeight = math.floor(safeWidth * (9 / 16))
    local centerX = math.floor((screenW - safeWidth) / 2)
    local screenH = getPropertyFromClass('openfl.Lib', 'application.window.display.currentMode.height')
    local centerY = math.floor((screenH - safeHeight) / 2)

    -- Cập nhật winHelper để logic sóng biển dùng làm mốc
    setProperty('winHelper.y', centerX)
    setProperty('winHelper.angle', centerY)

    setPropertyFromClass('openfl.Lib', 'application.window.x', centerX)
    setPropertyFromClass('openfl.Lib', 'application.window.y', centerY)
    setPropertyFromClass('openfl.Lib', 'application.window.width', safeWidth)
    setPropertyFromClass('openfl.Lib', 'application.window.height', safeHeight)
    
    activateTransparentMode()
end

function activateTransparentMode()
    isTransparentMode = true
    local hwnd = ffi.C.GetActiveWindow()
    ffi.C.SetWindowLongA(hwnd, -20, 0x00080000)
    ffi.C.SetLayeredWindowAttributes(hwnd, transColorKey, 0, 0x00000001)

    makeLuaSprite('chromaKeyBG', '', -2500, -2500)
    makeGraphic('chromaKeyBG', 8000, 8000, '131313') 
    setScrollFactor('chromaKeyBG', 0, 0)
    addLuaSprite('chromaKeyBG', false) 
    
    setProperty('healthBar.visible', false)
    setProperty('healthBarBG.visible', false)
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)
end

function onDestroy() resetWindow() end
function onGameOver() resetWindow() end

function resetWindow()
    if isTransparentMode then
        local hwnd = ffi.C.GetActiveWindow()
        ffi.C.SetWindowLongA(hwnd, -20, 0x00000000)
    end
    setPropertyFromClass('openfl.Lib', 'application.window.minimized', false)
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', false)
    setPropertyFromClass('openfl.Lib', 'application.window.width', originalWidth)
    setPropertyFromClass('openfl.Lib', 'application.window.height', originalHeight)
    setPropertyFromClass('openfl.Lib', 'application.window.x', defaultX)
    setPropertyFromClass('openfl.Lib', 'application.window.y', defaultY)
    setProperty('healthBar.visible', true)
    setProperty('scoreTxt.visible', true)
end