local cargoDarkFG
local cargoDarken = false
local cargoAirsip
local showDlowDK = false
local defeatDKoverlay
local testMode = false
local hasBfSkin = false
local charTag = 'yellowGhost'
local offsetX = 350
local offsetY = -100
local isPlayer = false

function onCreatePost()
    if not hasBfSkin then 
        addCharacterToList('hoacamkiem', 0) 
    end
    
    makeLuaSprite('cargoAirsip', 'stages/airship/double-kill/airshipFlashback', 1750, 800)
    setProperty('cargoAirsip.antialiasing', true)
    setScrollFactor('cargoAirsip', 1, 1)
    scaleObject('cargoAirsip', 1.3, 1.3)
    setProperty('cargoAirsip.alpha', 0.001)
    addLuaSprite('cargoAirsip', false)
    
    setProperty('camHUD.visible', false)
    setProperty('camGame.alpha', 0)
    
    makeGraphic('cargoDarkFG', screenWidth * 2, screenHeight * 2, '000000')
    setProperty('cargoDarkFG.x', -640)
    setProperty('cargoDarkFG.y', -360)
    setScrollFactor('cargoDarkFG', 0, 0)
    
    makeLuaSprite('defeatDKoverlay', 'stages/void/iluminao omaga', 700, 300)
    setBlendMode('defeatDKoverlay', 'add')
    setProperty('defeatDKoverlay.alpha', 0.001)
    scaleObject('defeatDKoverlay', 11.5, 11.5)
    addLuaSprite('defeatDKoverlay', true)

    addLuaSprite('cargoDarkFG', true)

    if testMode then 
        setProperty('cargoDarkFG.alpha', 0) 
    end

    local bfX = getProperty('boyfriend.x')
    local bfY = getProperty('boyfriend.y')
    
    makeAnimatedLuaSprite(charTag, 'characters/' .. charTag, bfX + offsetX, bfY + offsetY)

    addAnimationByPrefix(charTag, 'idle', 'idle', 24, true)
    addAnimationByPrefix(charTag, 'singLEFT', 'left', 24, true)
    addAnimationByPrefix(charTag, 'singDOWN', 'down', 24, true)
    addAnimationByPrefix(charTag, 'singUP', 'up', 24, true)
    addAnimationByPrefix(charTag, 'singRIGHT', 'right', 24, true)

    setProperty(charTag .. '.flipX', isPlayer)
    setObjectOrder(charTag, getObjectOrder('boyfriendGroup') - 1)
    setProperty(charTag .. '.alpha', 0)

    playAnim(charTag, 'idle', true)
    addLuaSprite(charTag, false)
end

function onUpdate(elapsed)
    if getSongPosition() >= 0 and getSongPosition() < 1200 then
        setProperty('cargoDarkFG.alpha', getProperty('cargoDarkFG.alpha') - (elapsed / 5))
        
        local currentZoom = getProperty('camGame.zoom')
        local targetZoom = 1
        local ratio = math.min(elapsed * 3, 1)
        setProperty('camGame.zoom', currentZoom + (targetZoom - currentZoom) * ratio)
    end
    
    if cargoDarken then
        local ratio = math.min(elapsed * 1.4, 1)
        
        setProperty('cargoDark.alpha', getProperty('cargoDark.alpha') + (1 - getProperty('cargoDark.alpha')) * ratio)
        setProperty('dad.alpha', getProperty('dad.alpha') + (0.001 - getProperty('dad.alpha')) * ratio)
        setProperty('gf.alpha', getProperty('gf.alpha') + (0.001 - getProperty('gf.alpha')) * ratio)
        setProperty('mainoverlayDK.alpha', getProperty('mainoverlayDK.alpha') + (0.001 - getProperty('mainoverlayDK.alpha')) * ratio)
        setProperty('lightoverlayDK.alpha', getProperty('lightoverlayDK.alpha') + (0.001 - getProperty('lightoverlayDK.alpha')) * ratio)
    end
    
    if showDlowDK then
        local ratio = math.min(elapsed * 0.1, 1)
        setProperty('cargoAirsip.alpha', getProperty('cargoAirsip.alpha') + (0.45 - getProperty('cargoAirsip.alpha')) * ratio)
    end

    if getProperty(charTag .. '.animation.curAnim.name') == 'idle' and getProperty(charTag .. '.animation.curAnim.finished') then
        characterDance(charTag)
    end
    if curBeat >= 552 and curBeat < 556 then
    setProperty(charTag .. '.alpha', 1)
    elseif curStep == 3408 then
    setProperty(charTag .. '.alpha', 0)
    end
end

function onEvent(eventName, value1, value2)
    if eventName == 'flash' then
        setProperty('cargoDarkFG.alpha', 0)
        setProperty('camHUD.visible', true)
        
    elseif eventName == 'Legacy' then

        if value1 == 'darken' then
            cargoDarken = true
            cameraFlash('game', '000000', 0.55)

        elseif value1 == 'airship' then
            showDlowDK = true

        elseif value1 == 'brighten' then
            showDlowDK = false
            cargoDarken = false
            setProperty('cargoAirsip.alpha', 0.001)
            setProperty('cargoDark.alpha', 0.001)
            setProperty('dad.alpha', 1)
            setProperty('gf.alpha', 1)
            setProperty('lightoverlayDK.alpha', 1)
            setProperty('mainoverlayDK.alpha', 1)

        elseif value1 == 'readykill' then
            if not hasBfSkin then 
                triggerEvent('Change Character', '0', 'hoacamkiem') 
                defeatness()
            end

        elseif value1 == 'kill' then
            cameraFlash('camOther', 'FF0000', 2.75)
            setProperty('gf.visible', false)
            setProperty('boyfriend.visible', false)
            removeLuaSprite('defeatDKoverlay', true)
            setProperty('camHUD.alpha', 0)
        end
    end
end

function defeatness()
    local shadersEnabled = getPropertyFromClass('backend.ClientPrefs', 'shaders') or getPropertyFromClass('ClientPrefs', 'shaders')
    if not shadersEnabled then return end

    local hasBfSkin = getProperty('hasBfSkin')
    local isBacklit = getProperty('boyfriend.backlit')

    if hasBfSkin and not isBacklit then
        initLuaShader(shaderName)
        setSpriteShader('boyfriend', shaderName)
        setProperty('boyfriend.useRenderTexture', true)
        
        setShaderFloat('boyfriend', 'threshold', 0.1)
        setShaderFloat('boyfriend', 'strength', 0.85)
    end
end
function goodNoteHit(id, noteData, noteType, isSustainNote)
playCharSing(noteData)
end
function onBeatHit()
    if curBeat % 2 == 0 and not string.startswith(getProperty(charTag .. '.animation.curAnim.name'), 'sing') then
        characterDance(charTag)
    end
end
function playCharSing(direction)
    local anims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
    playAnim(charTag, anims[direction + 1], true)
    setProperty(charTag .. '.holdTimer', 0)
end