local modchartMode = 0 -- 0: Tắt, 1: Thường, 2: CRAZY
local allowCountdown = false
local optionSelected = false
local lerpSpeed = 5 

-- Vị trí nút Crazy
local crazyX = 0; local crazyY = 0; local crazyW = 150; local crazyH = 50

-- Bảng Target
local tX = {}; local tY = {}; local tAng = {}; local tAlpha = {}; local tScaleX = {}; local tScaleY = {}

function onCreate()
    setProperty('defaultCamHUDZoom', 0.75) 
    for i = 0, 7 do
        tX[i]=0; tY[i]=0; tAng[i]=0; tAlpha[i]=1; tScaleX[i]=0.7; tScaleY[i]=0.7
    end
end

function onCreatePost()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)

    makeLuaSprite('blackScreen', '', 0, 0)
    makeGraphic('blackScreen', 1280, 720, '000000')
    setObjectCamera('blackScreen', 'other')
    addLuaSprite('blackScreen', true)

    makeLuaText('optText', 'TÙY CHỌN HEATWAVE\n\n[C] = Chế độ Vũ Trụ (Normal)\n[K] = Tắt Modchart', 1280, 0, 300)
    setTextSize('optText', 35)
    screenCenter('optText', 'xy')
    setObjectCamera('optText', 'other')
    addLuaText('optText')

    crazyX = math.random(50, 1000); crazyY = math.random(50, 600)
    makeLuaText('crazyBtn', 'CRAZY ???', crazyW, crazyX, crazyY)
    setTextSize('crazyBtn', 30)
    setTextColor('crazyBtn', 'FF0000')
    setTextBorder('crazyBtn', 2, 'FFFFFF')
    setObjectCamera('crazyBtn', 'other')
    addLuaText('crazyBtn')
    doTweenAlpha('crazyAlpha', 'crazyBtn', 0.2, 0.5, 'linear')
end

function onTweenCompleted(tag)
    if tag == 'crazyAlpha' then doTweenAlpha('crazyAlpha2', 'crazyBtn', 1, 0.5, 'linear')
    elseif tag == 'crazyAlpha2' then doTweenAlpha('crazyAlpha', 'crazyBtn', 0.2, 0.5, 'linear') end
end

function onStartCountdown()
    if not allowCountdown then return Function_Stop end
    return Function_Continue
end

function onUpdate(elapsed)
    if not allowCountdown and not optionSelected then
        if mouseClicked('left') then
            local mx = getMouseX('other'); local my = getMouseY('other')
            if mx >= crazyX and mx <= crazyX + crazyW + 50 and my >= crazyY and my <= crazyY + crazyH + 20 then
                selectOption(2)
            end
        end
        if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.C') then selectOption(1)
        elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.K') then selectOption(0) end
    end

    if modchartMode == 2 and allowCountdown then
        local hue = (getSongPosition() / 2) % 360 
        setProperty('camHUD.color', HSVtoRGB(hue, 1, 1))
    end
end

function selectOption(mode)
    optionSelected = true
    modchartMode = mode
    local msg = ""; local col = "FFFFFF"
    
    if mode == 1 then msg = "ĐÃ CHỌN: CHẾ ĐỘ VŨ TRỤ"; col = "00FF00"; playSound('confirmMenu')
    elseif mode == 2 then msg = "!!! CẢNH BÁO: HỖN LOẠN !!!"; col = "FF0000"; playSound('thunder_2'); cameraShake('other', 0.05, 0.5)
    else msg = "ĐÃ CHỌN: KHÔNG MODCHART"; col = "FFFFFF"; playSound('cancelMenu') end

    setTextString('optText', msg); setTextColor('optText', col); setTextSize('optText', 50); screenCenter('optText', 'xy')
    removeLuaText('crazyBtn') 
    doTweenAlpha('hideBlack', 'blackScreen', 0, 1.5, 'linear')
    doTweenAlpha('hideText', 'optText', 0, 1.5, 'linear')
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
    allowCountdown = true
    startCountdown()
end

-- [[ LOGIC MODCHART CHÍNH ]]
function onUpdatePost(elapsed)
    if modchartMode == 0 then return end
    if not allowCountdown then return end

    local songPos = getSongPosition()
    local beat = (songPos / 1000 * (curBpm / 60))
    local speed = (modchartMode == 2) and 8 or 4 

    calculatePhases(beat)

    -- 1. DI CHUYỂN RECEPTOR
    for i = 0, 7 do
        local isDad = (i < 4)
        local idx = isDad and i or (i-4)
        local strum = isDad and 'opponentStrums' or 'playerStrums'
        
        local defX = isDad and _G['defaultOpponentStrumX'..i] or _G['defaultPlayerStrumX'..idx]
        local defY = isDad and _G['defaultOpponentStrumY'..i] or _G['defaultPlayerStrumY'..idx]
        
        local cX = getPropertyFromGroup(strum, idx, 'x')
        local cY = getPropertyFromGroup(strum, idx, 'y')
        local cAng = getPropertyFromGroup(strum, idx, 'angle')
        local cSx = getPropertyFromGroup(strum, idx, 'scale.x')

        setPropertyFromGroup(strum, idx, 'x', lerp(cX, defX + tX[i], elapsed * speed))
        setPropertyFromGroup(strum, idx, 'y', lerp(cY, defY + tY[i], elapsed * speed))
        setPropertyFromGroup(strum, idx, 'angle', lerp(cAng, tAng[i], elapsed * speed))
        setPropertyFromGroup(strum, idx, 'alpha', tAlpha[i])
        
        -- Scale Effect
        setPropertyFromGroup(strum, idx, 'scale.x', lerp(cSx, tScaleX[i], elapsed * speed))
        setPropertyFromGroup(strum, idx, 'scale.y', lerp(cSx, tScaleY[i], elapsed * speed))
    end

    -- 2. NOTE FIX (CĂN GIỮA + KHỚP DỌC)
    local noteCount = getProperty('notes.length')
    for i = 0, noteCount-1 do
        local data = getPropertyFromGroup('notes', i, 'noteData')
        local isSustain = getPropertyFromGroup('notes', i, 'isSustainNote')
        local mustPress = getPropertyFromGroup('notes', i, 'mustPress')
        
        local strumGroup = mustPress and 'playerStrums' or 'opponentStrums'
        local strumIndex = data 
        
        local receptorX = getPropertyFromGroup(strumGroup, strumIndex, 'x')
        local receptorY = getPropertyFromGroup(strumGroup, strumIndex, 'y')
        local receptorAngle = getPropertyFromGroup(strumGroup, strumIndex, 'angle')
        local receptorWidth = getPropertyFromGroup(strumGroup, strumIndex, 'width')
        local noteWidth = getPropertyFromGroup('notes', i, 'width')
        
        -- A. CĂN GIỮA
        local centerX = receptorX + (receptorWidth / 2) - (noteWidth / 2)
        setPropertyFromGroup('notes', i, 'x', centerX)
        
        -- Crazy Mode: Nốt xoay theo khung (Trừ sustain để đỡ xấu)
        if modchartMode == 2 and not isSustain then
             setPropertyFromGroup('notes', i, 'angle', receptorAngle)
        end
        
        -- B. SCROLL LOGIC
        local isReceptorHigh = (receptorY < 360) 
        local noteTime = getPropertyFromGroup('notes', i, 'strumTime')
        local scrollSpeed = getPropertyFromGroup('notes', i, 'multSpeed') * getProperty('songSpeed')
        local dist = (noteTime - songPos) * (0.45 * scrollSpeed)
        
        if isReceptorHigh then -- UPSCROLL
            setPropertyFromGroup('notes', i, 'y', receptorY + dist)
            if isSustain then 
                setPropertyFromGroup('notes', i, 'flipY', false)
                setPropertyFromGroup('notes', i, 'y', receptorY + dist + (scrollSpeed * 2)) 
            end
        else -- DOWNSCROLL
            setPropertyFromGroup('notes', i, 'y', receptorY - dist)
            if isSustain then 
                setPropertyFromGroup('notes', i, 'flipY', true)
                setPropertyFromGroup('notes', i, 'y', receptorY - dist - (scrollSpeed * 2)) 
            end
        end

        if isSustain then 
            setPropertyFromGroup('notes', i, 'alpha', 0.6) 
            if getPropertyFromGroup('notes', i, 'animation.curAnim.name'):find('holdend') then
                 setPropertyFromGroup('notes', i, 'offset.x', getPropertyFromGroup('notes', i, 'width') / 4) 
            end
        end
    end

    -- 3. HUD LOGIC
    local hudT = 0
    if modchartMode == 1 then
        -- Normal
        if beat >= 96 and beat < 128 then hudT = math.sin(beat*0.5)*5
        elseif beat >= 432 and beat < 496 then hudT = math.sin(beat*0.5)*25 end
    elseif modchartMode == 2 then
        -- CRAZY
        hudT = math.sin(beat * 2) * 15 + math.cos(beat * 15) * 5
        if beat >= 432 and beat < 496 then 
            hudT = math.sin(beat) * 45 
        end
    end
    setProperty('camHUD.angle', lerp(getProperty('camHUD.angle'), hudT, elapsed * speed))
end

-- [[ LOGIC 15 PHASE - SPACE THEMED ]]
function calculatePhases(beat)
    -- Reset (Mặc định)
    for i=0,7 do tX[i]=0; tY[i]=0; tAng[i]=0; tAlpha[i]=1; tScaleX[i]=0.7; tScaleY[i]=0.7 end

    local chaosX = math.sin(beat * 2) * 300 + math.cos(beat * 5) * 100
    local chaosY = math.cos(beat * 3) * 200 + math.sin(beat * 7) * 100
    local chaosAng = beat * 200

    -- [[ PHASE 1: ZERO GRAVITY (0-32) ]]
    if beat >= 0 and beat < 32 then
        for i=0,7 do 
            if modchartMode==1 then 
                tY[i] = math.sin(beat*0.5 + i)*20 
                tX[i] = math.cos(beat*0.2 + i)*20
            else 
                tX[i] = chaosX * (i%2==0 and 1 or -1)
                tY[i] = chaosY
                tAng[i] = chaosAng
            end 
        end

    -- [[ PHASE 2: ORBIT (32-64) ]]
    elseif beat >= 32 and beat < 64 then
        for i=0,7 do 
            if modchartMode==1 then 
                tX[i] = math.sin(beat + i*0.5) * 50
                tY[i] = math.cos(beat + i*0.5) * 30
            else 
                tX[i] = math.sin(beat*4 + i)*400 
                tY[i] = math.cos(beat*5 + i)*300
                tAng[i] = beat * 360
            end 
        end

    -- [[ PHASE 3: METEOR SHOWER (64-96) ]]
    elseif beat >= 64 and beat < 96 then
        for i=0,7 do 
            if modchartMode==1 then 
                tX[i] = (beat*50 + i*50) % 200 - 100
                tY[i] = (beat*50 + i*50) % 200 - 100
            else 
                if beat % 2 < 1 then tX[i] = 600 else tX[i] = -600 end
                tY[i] = math.random(-200, 200)
                tAng[i] = math.random(0, 360)
            end 
        end

    -- [[ PHASE 4: GALAXY SPIRAL (96-128) ]]
    elseif beat >= 96 and beat < 128 then
        for i=0,7 do 
            if modchartMode==1 then 
                tX[i] = math.cos(beat*0.5 + i)*80
                tAng[i] = i * 15 + math.sin(beat)*10
            else 
                tX[i] = math.sin(beat*10)*500
                tScaleX[i] = 1 + math.sin(beat*10)
                tScaleY[i] = 1 + math.cos(beat*10)
            end 
        end

    -- [[ PHASE 5: INFINITY SWAP (128-160) ]]
    elseif beat >= 128 and beat < 160 then
        local speed = beat * 0.5 
        local swapProgress = (1 - math.cos(speed)) / 2 
        local spinAngle = swapProgress * 360 

        for i = 0, 7 do 
            local isDad = (i < 4)
            local direction = isDad and 1 or -1 
            tX[i] = swapProgress * 640 * direction
            tY[i] = math.sin(speed) * 100 
            
            if modchartMode == 1 then
                tAng[i] = spinAngle * direction
            else
                tAng[i] = (spinAngle * direction) + math.sin(beat * 4) * 30
                tScaleX[i] = 0.8 + math.sin(speed) * 0.4
                tScaleY[i] = 0.8 + math.sin(speed) * 0.4
            end 
        end

    -- [[ PHASE 6: STABILIZE WAVE (160-192) ]]
    -- FIX: Reset Angle và Scale để tránh lỗi visual sau Swap
    elseif beat >= 160 and beat < 192 then
        for i=0,7 do 
            tAng[i] = 0 
            tScaleX[i] = 0.7; tScaleY[i] = 0.7
            
            if modchartMode == 1 then
                tX[i] = math.sin(beat + i) * 30
                tY[i] = math.cos(beat * 2 + i) * 10
            else
                local direction = (i % 2 == 0) and -1 or 1
                tX[i] = math.sin(beat * 2) * 40 * direction
                tY[i] = math.cos(beat * 2 + i) * 30
            end 
        end

    -- [[ PHASE 7: NEBULA WAVES (224-256) ]]
    elseif beat >= 224 and beat < 256 then
        for i=0,7 do 
            if modchartMode==1 then tY[i]=math.sin(beat + i*0.5)*40
            else tY[i]=math.tan(beat + i)*100; tAng[i]=math.random(-180,180) end
        end

    -- [[ PHASE 8: BINARY STAR (256-304) ]]
    elseif beat >= 256 and beat < 304 then
        for i=0,7 do 
            local radius = 100
            if modchartMode==1 then 
                tX[i] = math.cos(beat)*radius
                tY[i] = math.sin(beat)*radius
            else 
                tX[i] = math.cos(beat*5)*300 + math.random(-50,50)
                tY[i] = math.sin(beat*5)*300 + math.random(-50,50)
                tAng[i] = beat*500
            end 
        end

    -- [[ PHASE 9: PRE-ELEVATOR (304-368) ]]
    elseif beat >= 304 and beat < 368 then
        local j=math.abs(math.sin(beat*math.pi))
        for i=0,7 do 
            if modchartMode==1 then tY[i]=-j*30 
            else tY[i]=math.random(-300, 300); tX[i]=math.random(-300, 300) end 
        end

    -- [[ PHASE 10: ELEVATOR (368-400) ]]
    elseif beat >= 368 and beat < 400 then 
        local downscroll = getPropertyFromClass('ClientPrefs', 'downScroll')
        local wave = downscroll and math.cos(beat*0.5) or -math.cos(beat*0.5)
        local targetAbsY = 360 + wave * 280
        for i=0,7 do
            local isDad = i < 4
            local idx = isDad and i or (i-4)
            local defY = isDad and _G['defaultOpponentStrumY'..i] or _G['defaultPlayerStrumY'..idx]
            tY[i] = targetAbsY - defY 
            if modchartMode==2 then 
                tAng[i]=beat*360 
                tScaleX[i] = 0.5 + math.abs(math.sin(beat*2))
            end
        end

    -- [[ PHASE 11: JITTER / HYPER SPEED (400-432) ]]
    elseif beat >= 400 and beat < 432 then
        for i=0,7 do 
            if modchartMode==1 then 
                tX[i]=math.sin(beat*20+i)*10; tY[i]=math.cos(beat*25+i)*10 
            else 
                tX[i]=math.random(-50,50); tY[i]=math.random(-50,50); tAng[i]=math.random(-90,90) 
            end 
        end

    -- [[ PHASE 12: SUPERNOVA (432-496) ]]
    elseif beat >= 432 and beat < 496 then
        for i=0,7 do 
            if modchartMode==1 then 
                tX[i]=math.cos(beat*2+i)*80; tY[i]=math.sin(beat*2+i)*80; tAng[i]=beat*100 
            else 
                tX[i]=math.cos(beat*10+i)*400
                tY[i]=math.sin(beat*10+i)*300
                tAng[i]=beat*1000
                tScaleX[i]=1.5
                tScaleY[i]=1.5
            end 
        end

    -- [[ PHASE 13: AUDITION (496-603) ]]
    elseif beat >= 496 and beat < 603 then
        local f=50
        for i=0,7 do 
            if modchartMode==1 then tX[i]=(i<4)and f or -f 
            else 
                tX[i]=(i<4)and f or -f
                tY[i]=math.sin(beat*10)*5 
            end 
        end

    -- [[ PHASE 14: DYING STAR (603-635) ]]
    elseif beat >= 603 and beat < 635 then
        for i=0,7 do 
            if modchartMode==1 then tY[i]=math.sin(beat*0.5)*30+50; tAng[i]=math.cos(beat*0.5+i)*15 
            else tY[i]=math.sin(beat)*100; tAng[i]=beat*100 end
        end

    -- [[ PHASE 15: DRIFT AWAY (635+) ]]
    elseif beat >= 635 then
        local d=(beat-635)*2
        for i=0,7 do 
            if modchartMode==1 then 
                tX[i]=math.cos(i)*d*5; tY[i]=math.sin(i)*d*5; tAlpha[i]=1-(d*0.01) 
            else 
                tX[i]=math.cos(i)*d*20; tY[i]=math.sin(i)*d*20; tAng[i]=d*100; tAlpha[i]=1-(d*0.05) 
            end 
        end
    end
end

function lerp(a, b, t) return a + (b - a) * math.max(0, math.min(1, t)) end

function HSVtoRGB(h, s, v)
    local c=v*s; local x=c*(1-math.abs((h/60)%2-1)); local m=v-c; local r,g,b=0,0,0
    if h<60 then r,g,b=c,x,0 elseif h<120 then r,g,b=x,c,0 elseif h<180 then r,g,b=0,c,x elseif h<240 then r,g,b=0,x,c elseif h<300 then r,g,b=x,0,c else r,g,b=c,0,x end
    return getColorFromHex(string.format("%02X%02X%02X",(r+m)*255,(g+m)*255,(b+m)*255))
end

function onBeatHit()
    if modchartMode > 0 then
        if curBeat >= 432 and curBeat < 496 and curBeat % 2 == 0 then triggerEvent('Add Camera Zoom', (modchartMode==2 and '0.1' or '0.05'), '0.08') end
        if modchartMode == 2 and curBeat % 4 == 0 and curBeat > 64 then cameraFlash('hud', 'FF0000', 0.2) end
    end
end