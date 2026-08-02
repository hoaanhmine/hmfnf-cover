-- ================= KHAI BÁO FFI & THƯ VIỆN =================
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

local transColorKey = 0x010101

-- ================= BIẾN HỆ THỐNG =================
local originalWidth = 1280
local originalHeight = 720
local originalX = 0
local originalY = 0

-- Cờ trạng thái
local isWindowMove = false
local isSeaWave = false
local isTransparent = false
local isDadChaos = false
local isCinematicEnd = false 

local strumOrgY = {}

-- Biến cho hiệu ứng Code Scroll
local codeScrollSpeed = 2

function onCreatePost()
    -- 1. Lưu thông số gốc của cửa sổ
    originalWidth = getPropertyFromClass('openfl.Lib', 'application.window.width')
    originalHeight = getPropertyFromClass('openfl.Lib', 'application.window.height')
    originalX = getPropertyFromClass('openfl.Lib', 'application.window.x')
    originalY = getPropertyFromClass('openfl.Lib', 'application.window.y')

    -- 2. Lưu vị trí Y gốc của Note
    for i = 0, 7 do
        strumOrgY[i] = getPropertyFromGroup('strumLineNotes', i, 'y')
    end

    -- 3. Tạo Chroma Background (Màu đen để lọc nền)
    makeLuaSprite('chromaBG', '', -2500, -2500)
    makeGraphic('chromaBG', 5000, 5000, '010101') 
    setScrollFactor('chromaBG', 0, 0)
    setProperty('chromaBG.alpha', 0)
    addLuaSprite('chromaBG', false)
    -- Đặt ngay sau Dad để che stage
    setObjectOrder('chromaBG', getObjectOrder('dadGroup') - 1)

    -- 4. Chuẩn bị Text Code Scroll
    local fileToRead = 'data/' .. songName .. '/manifest-chart.json'
    local content = getTextFromFile(fileToRead)
    
    if content == nil or content == '' then 
        content = getTextFromFile('data/' .. songName .. '/' .. songName .. '-hard.json')
    end
    if content == nil or content == '' then 
        content = "SYSTEM_FAILURE_CRITICAL_ERROR_MANIFEST_DESTRUCTION_INITIATED_0x0001..." 
    end
    
    -- Tạo các dòng text ma trận
    local stringLen = string.len(content)
    local chunkSize = 100
    for i = 1, 10 do 
        local start = math.random(1, math.max(1, stringLen - chunkSize))
        local subText = string.sub(content, start, start + chunkSize)
        
        local tag = 'codeLine_'..i
        makeLuaText(tag, subText, 3000, -1000, math.random(0, 720))
        setTextSize(tag, 18)
        setTextColor(tag, '00FF00') 
        setTextFont(tag, 'vcr.ttf')
        setProperty(tag..'.alpha', 0)
        addLuaText(tag)
    end
end

function onUpdate(elapsed)
    local songPos = getSongPosition() / 1000
    
    -- 1. WINDOW MOVE
    if isWindowMove then
        local moveX = math.sin(songPos * 1.5) * 200
        local moveY = math.cos(songPos * 2.5) * 100
        setPropertyFromClass('openfl.Lib', 'application.window.x', originalX + moveX)
        setPropertyFromClass('openfl.Lib', 'application.window.y', originalY + moveY)
    end

    -- 2. SEA WAVE (Đoạn giữa bài)
    if isSeaWave then
        local speed = 2.0
        local amplitude = 30
        for i = 0, 7 do
            local offset = i * 0.3
            local wave = math.sin((songPos * speed) + offset) * amplitude
            setPropertyFromGroup('strumLineNotes', i, 'y', strumOrgY[i] + wave)
        end
    end

    -- 3. DAD CHAOS (Đoạn 528 - Trước khi kết thúc)
    if isDadChaos and not isCinematicEnd then
        local dadX = getProperty('dad.x')
        local dadY = getProperty('dad.y')
        local dadW = getProperty('dad.width')
        for i = 0, 3 do
            local targetX = dadX + (dadW / 2) - 220 + (i * 110)
            local targetY = dadY - 50
            setPropertyFromGroup('strumLineNotes', i, 'x', targetX)
            setPropertyFromGroup('strumLineNotes', i, 'y', targetY)
        end
    end

    -- 4. CINEMATIC END (Beat 704+)
    if isCinematicEnd then
        -- A. DAD NOTES (0-3): Bay quanh Dad (Orbit)
        -- Tọa độ được tính theo World Space vì note đã chuyển sang camGame
        local dadMidX = getMidpointX('dad')
        local dadMidY = getMidpointY('dad')
        local radius = 350 -- Bán kính xoay rộng hơn chút
        local speed = 1.5
        
        for i = 0, 3 do
            local angle = (songPos * speed) + (i * (math.pi / 2))
            -- Tính toán quỹ đạo
            local orbX = dadMidX + math.cos(angle) * radius - 50
            local orbY = dadMidY + math.sin(angle) * (radius * 0.6) -- Hình elip dẹt
            
            setPropertyFromGroup('strumLineNotes', i, 'x', orbX)
            setPropertyFromGroup('strumLineNotes', i, 'y', orbY)
            -- Xoay mũi tên
            setPropertyFromGroup('strumLineNotes', i, 'angle', (angle * 180 / math.pi) - 90)
        end

        -- B. BF NOTES (4-7): Ở giữa + Lượn sóng nhẹ
        -- Tọa độ tính theo HUD Space (Mặc định)
        local center = 1280 / 2
        local gap = 110
        local bfBaseX = {
            center - (gap * 2) + 20, -- Note 4
            center - gap + 20,       -- Note 5
            center + 20,             -- Note 6
            center + gap + 20        -- Note 7
        }
        
        for i = 4, 7 do
            local idx = i - 3
            -- Chỉ lắc lư nhẹ, không bay lung tung
            local swayX = math.cos(songPos * 1.0 + (i * 0.2)) * 20 
            local waveY = math.sin(songPos * 1.5 + (i * 0.2)) * 20
            
            setPropertyFromGroup('strumLineNotes', i, 'x', bfBaseX[idx] + swayX)
            setPropertyFromGroup('strumLineNotes', i, 'y', strumOrgY[i] + waveY)
            setPropertyFromGroup('strumLineNotes', i, 'angle', 0) -- Giữ thẳng
        end

        -- C. CODE SCROLL
        for i = 1, 10 do
            local tag = 'codeLine_'..i
            setProperty(tag..'.x', getProperty(tag..'.x') - (codeScrollSpeed * (i/2)))
            if getProperty(tag..'.x') < -2000 then
                setProperty(tag..'.x', 1500)
                setProperty(tag..'.y', math.random(0, 720))
            end
        end
    end
end

function onBeatHit()
    -- Beat 176 - 303: Nhỏ cửa sổ
    if curBeat == 176 then
        isWindowMove = true
        setPropertyFromClass('openfl.Lib', 'application.window.width', originalWidth * 0.85)
        setPropertyFromClass('openfl.Lib', 'application.window.height', originalHeight * 0.85)
    end
    if curBeat == 303 then
        isWindowMove = false
        resetWindowSize()
    end

    -- Beat 304 - 399: Zoom Beat
    if curBeat >= 304 and curBeat < 399 and curBeat % 2 == 0 then
        setPropertyFromClass('openfl.Lib', 'application.window.width', originalWidth * 1.02)
        setPropertyFromClass('openfl.Lib', 'application.window.height', originalHeight * 1.02)
        setPropertyFromClass('openfl.Lib', 'application.window.x', originalX - 10)
        runTimer('winZoomBack', 0.2)
    end

    -- Beat 400 - 463: Sóng biển
    if curBeat == 400 then
        isSeaWave = true
        isWindowMove = true
    end
    if curBeat == 463 then
        isSeaWave = false
        isWindowMove = false
        resetWindowSize()
        for i = 0, 7 do noteTweenY('resetY'..i, i, strumOrgY[i], 0.5, 'elasticOut') end
    end

    -- Beat 464: TRANSFORM
    if curBeat == 464 then
        activeTransparentMode()
    end

    -- Beat 528: CHAOS START
    if curBeat == 528 then
        isDadChaos = true
        dadRandomMove()
        setProperty('defaultCamZoom', 0.6)
        doTweenZoom('chaosZoom', 'camGame', 0.6, 2, 'quartOut')
        
        -- Note BF ra giữa
        local center = 1280 / 2
        local gap = 110
        noteTweenX('bfL', 4, center - (gap*2) + 20, 1, 'expoOut')
        noteTweenX('bfD', 5, center - gap + 20, 1, 'expoOut')
        noteTweenX('bfU', 6, center + 20, 1, 'expoOut')
        noteTweenX('bfR', 7, center + gap + 20, 1, 'expoOut')
    end

    -- Beat 688: HUD ZOOM FAR
    if curBeat == 688 then
        doTweenZoom('hudZoomFar', 'camHUD', 0.6, 4, 'quadInOut')
    end

    -- Beat 704: CINEMATIC END (KÍCH HOẠT HAXE LAYER)
    if curBeat == 704 then
        isCinematicEnd = true
        isDadChaos = false 
        isWindowMove = true
        
        -- Hiện Code Matrix
        for i = 1, 10 do
            setProperty('codeLine_'..i..'.alpha', 0.6)
            setProperty('codeLine_'..i..'.x', math.random(0, 1280))
        end
        
        doTweenZoom('finalZoom', 'camGame', 0.5, 4, 'sineInOut')
        doTweenZoom('hudZoomBack', 'camHUD', 1, 2, 'elasticOut')

        -- *** KỸ THUẬT QUAN TRỌNG ***
        -- Sử dụng Haxe để:
        -- 1. Đưa note Dad (0-3) sang camGame (để bay theo thế giới thực)
        -- 2. Đưa note BF (4-7) về camHUD (để dễ chơi)
        -- 3. Xếp lại lớp vẽ (Draw Order) để StrumNotes nằm SAU Dad
        runHaxeCode([[
            // Tìm vị trí của DadGroup
            var index = game.members.indexOf(game.dadGroup);
            
            // Di chuyển nhóm Note xuống dưới DadGroup để nó bị Dad che (nằm sau)
            if (index != -1) {
                game.remove(game.strumLineNotes);
                game.insert(index, game.strumLineNotes);
            }

            // Note Dad (0-3): Chuyển sang Camera Game
            for (i in 0...4) {
                var note = game.strumLineNotes.members[i];
                note.camera = game.camGame; 
                note.scrollFactor.set(1, 1);
            }
            
            // Note BF (4-7): Giữ nguyên Camera HUD
            for (i in 4...8) {
                var note = game.strumLineNotes.members[i];
                note.camera = game.camHUD;
                note.scrollFactor.set(0, 0);
            }
        ]])
    end
end

function onStepHit()
    if curStep == 1856 or curStep == 1858 or curStep == 1860 or curStep == 1862 then
        cameraShake('hud', 0.01, 0.1)
        cameraFlash('hud', '000000', 0.1)
    end
end

function onTimerCompleted(tag)
    if tag == 'winZoomBack' then
        setPropertyFromClass('openfl.Lib', 'application.window.width', originalWidth)
        setPropertyFromClass('openfl.Lib', 'application.window.height', originalHeight)
        setPropertyFromClass('openfl.Lib', 'application.window.x', originalX)
    end
    if tag == 'dadMoveLoop' and isDadChaos and not isCinematicEnd then
        dadRandomMove()
    end
end

function dadRandomMove()
    if not isDadChaos or isCinematicEnd then return end
    local rX = math.random(200, 1500)
    local rY = math.random(200, 800)
    local time = math.random(5, 12) / 10
    doTweenX('dadX', 'dad', rX, time, 'quadInOut')
    doTweenY('dadY', 'dad', rY, time, 'quadInOut')
    runTimer('dadMoveLoop', time)
end

function resetWindowSize()
    setPropertyFromClass('openfl.Lib', 'application.window.width', originalWidth)
    setPropertyFromClass('openfl.Lib', 'application.window.height', originalHeight)
    setPropertyFromClass('openfl.Lib', 'application.window.x', originalX)
    setPropertyFromClass('openfl.Lib', 'application.window.y', originalY)
end

-- ================= HÀM XỬ LÝ TRONG SUỐT =================

function activeTransparentMode()
    if isTransparent then return end
    isTransparent = true
    
    setProperty('bg.visible', false) 
    setProperty('chromaBG.alpha', 1)
    
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', true)
    setPropertyFromClass('openfl.Lib', 'application.window.x', originalX)
    setPropertyFromClass('openfl.Lib', 'application.window.y', originalY)
    setPropertyFromClass('openfl.Lib', 'application.window.width', originalWidth)
    setPropertyFromClass('openfl.Lib', 'application.window.height', originalHeight)
    
    local hwnd = ffi.C.GetActiveWindow()
    ffi.C.SetWindowLongA(hwnd, -20, 0x00080000)
    ffi.C.SetLayeredWindowAttributes(hwnd, transColorKey, 0, 0x00000001)
end

function disableTransparentMode()
    if not isTransparent then return end
    isTransparent = false
    
    local hwnd = ffi.C.GetActiveWindow()
    ffi.C.SetWindowLongA(hwnd, -20, 0x00000000)
    
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', false)
    resetWindowSize()
    
    setProperty('chromaBG.alpha', 0)
    setProperty('bg.visible', true)
end

function onDestroy() disableTransparentMode() end
function onGameOver() disableTransparentMode() end