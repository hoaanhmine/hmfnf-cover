local bothSing = false
local twoSing = false
local isBfGhost = false
local mandoSing = false
local ext = 'stages/airship/double-kill/'
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 2000;
local yy = 1050;
local xx2 = 2300;
local yy2 = 1050;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;

function onCreate()
    makeLuaSprite('bg', ext .. 'cargo', 0, 0)
    scaleObject('bg', 2, 2)
    setScrollFactor('bg', 1, 1)
    setProperty('bg.antialiasing', true)
    setProperty('bg.active', false)
    addLuaSprite('bg', false)
    
    makeLuaSprite('cargoDark', '', -1000, -1000)
    makeGraphic('cargoDark', screenWidth * 3, screenHeight * 3, '000000')
    setScrollFactor('cargoDark', 0, 0)
    setProperty('cargoDark.antialiasing', true)
    setProperty('cargoDark.alpha', 0.001)
    addLuaSprite('cargoDark', false)

    makeLuaSprite('blackHUD', '', 0, 0)
    makeGraphic('blackHUD', 1280, 720, '000000')
    setObjectCamera('blackHUD', 'hud')
    setProperty('blackHUD.alpha', 0)
    addLuaSprite('blackHUD', true)
end

function onCreatePost()
    makeLuaSprite('mainoverlayDK', ext .. 'newoverlay1', 1000, 350)
    scaleObject('mainoverlayDK', 1.8, 1.6)
    setProperty('mainoverlayDK.alpha', 0.51)
    setBlendMode('mainoverlayDK', 'subtract')
    addLuaSprite('mainoverlayDK', true)
    
    makeLuaSprite('lightoverlayDK', ext .. 'newoverlay2', 1000, 350)
    scaleObject('lightoverlayDK', 1.8, 1.6)
    setProperty('lightoverlayDK.alpha', 0.60)
    setBlendMode('lightoverlayDK', 'add')
    addLuaSprite('lightoverlayDK', true)
end

function onSongStart()
doTweenAlpha('fadeGame', 'camGame', 0.4, 1, 'sineInOut')
end

function onEvent(eventName, value1, value2)
    if eventName == 'Legacy' then
        if value1 == 'black' then
            setProperty('camCurTarget', getProperty('gf'))
        elseif value1 == 'not black' then
            setProperty('camCurTarget', nil)
        end
        
    elseif eventName == 'Opponent Two' then
        twoSing = (tonumber(value1) == 1)
        if not bothSing then 
            refreshDoubleKillIcon() 
        end
        
    elseif eventName == 'Both Opponents' then
        bothSing = (tonumber(value1) == 1)
        
        local iconName = 'white'
        if bothSing then
            iconName = 'double-kill'
        elseif twoSing then
            iconName = 'black'
        end
        
        runHaxeCode([[
            game.iconP2.changeIcon(']]..iconName..[[');
        ]])
    end
end

function refreshDoubleKillIcon()
    local dadColor = getProperty('dad.healthColorArray')
    local gfColor = getProperty('gf.healthColorArray')
    local bfColor = getProperty('boyfriend.healthColorArray')
    
    local targetColor = twoSing and gfColor or dadColor
    
    local hexColor = string.format('%02x%02x%02x', targetColor[1], targetColor[2], targetColor[3])
    setProperty('scoreTxt.color', getColorFromHex(hexColor))
    
    local dadHex = string.format('%02x%02x%02x', targetColor[1], targetColor[2], targetColor[3])
    local bfHex = string.format('%02x%02x%02x', bfColor[1], bfColor[2], bfColor[3])
    setHealthBarColors(dadHex, bfHex)
    
    local iconName = twoSing and 'black' or 'white'
    runHaxeCode([[
        game.iconP2.changeIcon(']]..iconName..[[');
    ]])
end

function opponentNoteHitPre(id, noteData, noteType, isSustainNote)
    if noteType == 'Opponent 2 Sing' then
        setPropertyFromGroup('notes', id, 'gfNote', true)
        
    elseif bothSing or noteType == 'Both Opponents Sing' then
        local anims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
        local animToPlay = anims[noteData + 1]
        
        characterPlayAnim('dad', animToPlay, true)
        characterPlayAnim('gf', animToPlay, true)
        
        setPropertyFromGroup('notes', id, 'noAnimation', true)
        
    elseif twoSing then
        setPropertyFromGroup('notes', id, 'gfNote', true)
    end
end

function onUpdate()
    	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.8)
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' or getProperty('gf.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('gf.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('gf.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('gf.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' or getProperty('gf.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('gf.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' or getProperty('gf.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' or getProperty('gf.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
        else

            setProperty('defaultCamZoom',0.8)
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    if curBeat >= 4 then
        setProperty('camGame.alpha', 1)
        setProperty('cargoDarkFG.alpha', 0)
        setProperty('camHUD.visible', true)
   end
    if curBeat >= 276 and curBeat < 277 then
        xx = 2100;
        xx2 = 2100;
   end
    if curBeat == 277 then
        xx = 2000;
        xx2 = 2300;
   end
    if curBeat >= 288 and curBeat < 292 then
        xx = 2100;
        xx2 = 2100;
   end
    if curBeat == 292 then
        xx = 2000;
        xx2 = 2300;
   end
    if curBeat >= 356 and curBeat < 420 then
		setProperty('defaultCamZoom',1.1)
        xx2 = 2750;
        yy2 = 1150;  
	end
    if curBeat == 420 then
		setProperty('defaultCamZoom',0.8)
        xx2 = 2300;
        yy2 = 1050;
	end
    if curBeat >= 552 and curBeat < 556 then
		setProperty('defaultCamZoom',1.2)
        xx = 1650;
        yy = 1180;  
	end
    if curBeat == 556 then
        xx = 2000;
        yy = 1050;  
        xx2 = 2650;
        yy2 = 1050;  
	end
    if curBeat >= 620 and curBeat < 652 then
		setProperty('defaultCamZoom',0.7)
        xx = 2100;
        yy = 950;  
        xx2 = 2100;
        yy2 = 950;  
   end
    if curBeat == 652 then
		setProperty('defaultCamZoom',0.8)
        xx = 2000;
        yy = 1050;  
        xx2 = 2650;
        yy2 = 1050;  
	end
    if curBeat == 853 then
        xx2 = 2300;
        yy2 = 1050;
   end
    if curBeat == 916 then
        doTweenZoom('camGameZoom', 'camGame', 0.65, 9.55, 'sineInOut')
        doTweenAlpha('endingOverlay', 'defeatDKoverlay', 1, 9.55, 'sineInOut')
   end
    if curBeat >= 948 then
		setProperty('defaultCamZoom',0.65)
        xx = 2200;
        xx2 = 2200;
   end
    if curStep == 3408 then
        setProperty('blackHUD.alpha', 1)
        doTweenAlpha('cargo', 'cargo', 0, 0.1, 'linear')
        doTweenAlpha('white', 'dad', 0, 0.1, 'linear')
        doTweenAlpha('lightoverlayDK', 'lightoverlayDK', 0, 0.1, 'linear')
        doTweenAlpha('defeatDKoverlay', 'defeatDKoverlay', 0.1, 0.1, 'linear')
        doTweenAlpha('cargoDarkFG', 'cargoDarkFG', 1, 0.1, 'linear')
        doTweenAlpha('cargoDark', 'cargoDark', 1, 0.1, 'linear')
        doTweenAlpha('readyKillDarkFade', 'cargoDarkFG', 0, 2.75, 'linear')
        setProperty('healthBar.alpha', 0)
        setProperty('healthBarBG.alpha', 0)
        setProperty('iconP1.alpha', 0)
        setProperty('iconP2.alpha', 0)
   end
    if curStep == 3409 then
        doTweenAlpha('fadeBlack', 'blackHUD', 0, 3, 'sineInOut')
   end
end