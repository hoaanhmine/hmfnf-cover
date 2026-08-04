-- Configuration
local globalScale = 0.6

local maxDigits = 4
local idleTime = 1.0
local fadeDuration = 0.5

local ratingScaleDefault = 0.7 * globalScale
local ratingScalePulse = 0.8 * globalScale
local comboScale = 0.5 * globalScale

local fadeTimer = 0
local isFading = false

local baseX = 0
local baseYRating = 0
local baseYCombo = 0

function onCreate()
    makeLuaSprite('customRating', 'sick', 0, 0)
    setObjectCamera('customRating', 'hud')
    setProperty('customRating.scale.x', ratingScaleDefault)
    setProperty('customRating.scale.y', ratingScaleDefault)
    setProperty('customRating.alpha', 0)
    addLuaSprite('customRating', true)

    for i = 1, maxDigits do
        makeLuaSprite('customCombo'..i, 'num0', 0, 0)
        setObjectCamera('customCombo'..i, 'hud')
        setProperty('customCombo'..i..'.scale.x', comboScale)
        setProperty('customCombo'..i..'.scale.y', comboScale)
        setProperty('customCombo'..i..'.alpha', 0) 
        addLuaSprite('customCombo'..i, true)
    end
end

function onCreatePost()
    setProperty('showRating', false)
    setProperty('showComboNum', false)

    if middlescroll then
        baseX = screenWidth * 0.75 
    else
        baseX = screenWidth * 0.5 
    end
    
    if downscroll then
        baseYRating = screenHeight * 0.80
    else
        baseYRating = screenHeight * 0.08 
    end
    
    baseYCombo = baseYRating + (100 * globalScale)
    
    setProperty('customRating.y', baseYRating)
    for i = 1, maxDigits do
        setProperty('customCombo'..i..'.y', baseYCombo)
    end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if not isSustainNote then
    
        local rating = getPropertyFromGroup('notes', id, 'rating')
        if rating == '' or rating == nil then rating = 'sick' end
        local combo = getProperty('combo')

        loadGraphic('customRating', rating)
        setProperty('customRating.alpha', 1)
        
        updateHitbox('customRating')
        setProperty('customRating.x', baseX - (getProperty('customRating.width') / 2))
        
        setProperty('customRating.scale.x', ratingScalePulse)
        setProperty('customRating.scale.y', ratingScalePulse)
        doTweenX('rateScaleX', 'customRating.scale', ratingScaleDefault, 0.2, 'cubeOut')
        doTweenY('rateScaleY', 'customRating.scale', ratingScaleDefault, 0.2, 'cubeOut')

        local comboStr = tostring(combo)
        

        while string.len(comboStr) < 3 do
            comboStr = '0' .. comboStr
        end
        
        local length = string.len(comboStr)
        
        local spacing = 86 * comboScale 
        local totalWidth = spacing * length
        local startX = baseX - (totalWidth / 2) 
        
        for i = 1, maxDigits do
            if i <= length then
                local digit = string.sub(comboStr, i, i)
                loadGraphic('customCombo'..i, 'num'..digit)
                setProperty('customCombo'..i..'.alpha', 1)
                
                updateHitbox('customCombo'..i)
                local digitCenterX = startX + ((i - 1) * spacing) + (spacing / 2)
                setProperty('customCombo'..i..'.x', digitCenterX - (getProperty('customCombo'..i..'.width') / 2))
            else
                setProperty('customCombo'..i..'.alpha', 0)
            end
        end

        fadeTimer = idleTime
        isFading = false
        cancelTween('fadeRating')
        for i = 1, maxDigits do
            cancelTween('fadeCombo'..i)
        end
    end
end

function noteMiss(id, noteData, noteType, isSustainNote)
    -- Optional miss logic
end

function onUpdate(elapsed)
    if fadeTimer > 0 then
        fadeTimer = fadeTimer - elapsed
        if fadeTimer <= 0 and not isFading then
            isFading = true
            
            doTweenAlpha('fadeRating', 'customRating', 0, fadeDuration, 'linear')
            for i = 1, maxDigits do
                doTweenAlpha('fadeCombo'..i, 'customCombo'..i, 0, fadeDuration, 'linear')
            end
        end
    end
end