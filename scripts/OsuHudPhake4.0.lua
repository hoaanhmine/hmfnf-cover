-- HealthBar
local locat
local icons = {P1 = {['left'] = true}, P2 = {['right'] = true}}
local health = {['left'] = -230, ['right'] = 920, ['center'] = 364, y = 80}
local equationPart 
local per = 50;

local TxtFont = 'ND.ttf'
local TxtFont2 = 'HARMONI.ttf'

--idk
unhealthrain = false
combomiss = false
Live = true
misss = 1

-------------------------------------------------------------------

function onCountdownStarted()

end


function onCreate()
    if botPlay == true then
        setProperty('denfull.alpha', 1)
    end
end

-------------------------------------------------------------------

function makeCircleTimebar(x,y,size,cam,pixel,type,firstColor)
    makeLuaSprite('circlePointCenter','',x,y)
    makeGraphic('circlePointCenter',pixel,pixel,'ffffff')
    setObjectCamera('circlePointCenter',cam)
    addLuaSprite('circlePointCenter')
    setProperty('circlePointCenter.color',getColorFromHex(firstColor))

    for i = 0,360 do
        makeLuaSprite('circlePoint'..i,'',x+math.cos(i)*size,y+math.sin(i)*size)
        makeGraphic('circlePoint'..i,pixel,pixel,'ffffff')
        setObjectCamera('circlePoint'..i,cam)
        addLuaSprite('circlePoint'..i)
        setProperty('circlePoint'..i..'.color',getColorFromHex(firstColor))
    end

    makeLuaSprite('circlePointNeedle','circleThing',x-(size-1),y-(size-1))
    --makeGraphic('circlePointNeedle',pixel+1,size,'ffffff')
    scaleObject('circlePointNeedle',(0.02*size),(0.02*size))
    setObjectCamera('circlePointNeedle',cam)
    addLuaSprite('circlePointNeedle')
    setProperty('circlePointNeedle.color',getColorFromHex(firstColor))

    if type == 'addNeedle' then
        makeLuaSprite('circlePointNeedle2','circleThing',x-1,y-size)
        makeGraphic('circlePointNeedle2',pixel+2,size,'ffffff')
        setObjectCamera('circlePointNeedle2',cam)
        addLuaSprite('circlePointNeedle2')
        setProperty('circlePointNeedle2.color',getColorFromHex(firstColor))
    end

    initLuaShader('cicrle')
    setSpriteShader('circlePointNeedle','cicrle')
    makeLuaSprite('circleStuff')
    setProperty('circleStuff.angle',360)
end

-------------------------------------------------------------------

function onCreatePost()
-- Make Circle TimeBar/ Tao dong ho OSU pha ke
    makeCircleTimebar(1100,65,15,'camOther',2,'none','FFD96A')

-- Hide Rating and Combo
    setPropertyFromClass('ClientPrefs', 'comboOffset[0]', 9999)
    setProperty('showComboNum', false)
    setProperty('showRating', false)
    
-- Set Y Combo
    comboTextY = 260
    if downscroll then
        comboTextY = 340
end

-- RatingTxt
    makeLuaText('RatingTxt', '', 400, getProperty('scoreTxt.x'), comboTextY)
    setTextSize('RatingTxt', 42)
    setTextBorder('RatingTxt', 3, '000000')
    setTextFont('RatingTxt', TxtFont2)
    setTextAlignment('RatingTxt', 'center')
    addLuaText('RatingTxt')
    screenCenter('RatingTxt', 'x')
    
-- HealthBar
    setObjectOrder('healthBar', getObjectOrder('strumLineNotes') - 1)
    health['left'] = health['left'] + 300
    health['right'] = health['right'] - 295
    scaleObject('healthBar', 0.45, 0.6)
    setProperty('healthBar.angle', 180)
    screenCenter('healthBar', 'x')
    health['center'] = getProperty('healthBar.x') + 5
    setProperty('healthBar.x', 70)
    setProperty('healthBar.y', 50)


    makeLuaText('songTxt','-   '.. songName ..'   -', 1030, 120)
    --makeLuaText('songTxt', '-    ' .. songName .. '     -')
    setTextSize('songTxt', 40)
    setObjectCamera('songTxt', 'other')
    setTextFont('songTxt', 'HARMONI.ttf')
    addLuaText('songTxt')
    setProperty('songTxt.scale.x', 1.25)
    setProperty('songTxt.y',5)
    
-- Hide Score
    setProperty('scoreTxt.alpha', 0)
    setProperty('botPlay.alpha', 0)
    
-- Osu Score
    makeLuaText('OsuScore', '0', 1030, 244)
    setTextAlignment('OsuScore', 'right')
    setTextBorder('OsuScore', 0)
    setTextFont('OsuScore',TxtFont)
    setTextSize('OsuScore', 45)
    addLuaText('OsuScore')
    setObjectCamera('OsuScore','other')
    setTextBorder('OsuScore', 3, '000000')

-- Osu Misses
    makeLuaText('OsuMisses', '0', 1030, 243)
    setTextAlignment('OsuMisses', 'right')
    setTextBorder('OsuMisses', 0)
    setTextFont('OsuMisses',TxtFont)
    setTextSize('OsuMisses', 35)
    addLuaText('OsuMisses')
    setObjectCamera('OsuMisses','other')
    setProperty('OsuMisses.y', 69)
    setTextBorder('OsuMisses', 3, '000000')
    setProperty('OsuMisses.scale.x', 1)

--Osu Accuracy  
    makeLuaText('OsuAccuracy', '0', 1030, 243)
    setTextAlignment('OsuAccuracy', 'right')
    setTextBorder('OsuAccuracy', 0)
    setTextFont('OsuAccuracy',TxtFont)
    setTextSize('OsuAccuracy', 35)
    addLuaText('OsuAccuracy')
    setObjectCamera('OsuAccuracy','other')
    setProperty('OsuAccuracy.y', 38)
    --setProperty('OsuAccuracy.x', 0)
    setTextBorder('OsuAccuracy', 3, '000000')
    --setProperty('OsuAccuracy.scale.x', 1.35)
    
--Osu Combo
    makeLuaText('OsuCombo', '0', 1030, 243)
    setTextAlignment('OsuCombo', 'left')
    setTextBorder('OsuCombo', 0)
    setTextFont('OsuCombo',TxtFont)
    setTextSize('OsuCombo', 45)
    addLuaText('OsuCombo')
    setObjectCamera('OsuCombo','other')
    setProperty('OsuCombo.x', 5)
    setProperty('OsuCombo.y',675)
    setTextBorder('OsuCombo', 3, '000000')
    setProperty('OsuCombo.scale.x', 1)
    
    
    makeLuaText('MissTxt', 'Trượt', 1030, 120)
    setTextBorder('MissTxt', 0)
    setTextFont('MissTxt',TxtFont2)
    setTextSize('MissTxt', 45)
    addLuaText('MissTxt')
    setObjectCamera('MissTxt','other')
    setProperty('MissTxt.y',comboTextY)
    setTextBorder('MissTxt', 3, 'FF0D00')
    setProperty('MissTxt.alpha', 0)
    setProperty('MissTxt.angle', 0)
    setProperty('MissTxt.scale.x', 1)
    setProperty('MissTxt.scale.y', 1)	
    
    makeLuaSprite('coolflash','coolflash',0,0);
    setObjectCamera('coolflash','hud');
    scaleObject('coolflash',0.8, 0.8)
    setScrollFactor('coolflash',0,0);
    setProperty('coolflash.alpha', 0);
    addLuaSprite('coolflash',true)
    

end

-------------------------------------------------------------------

function onCountdownTick(counter)
    if counter == 1 then
        doTweenAngle('circleStuffAngle','circleStuff',0,(crochet / 1000 / playbackRate)*5,'cubeInOut')
    end
end

startSong = false
function onSongStart()
    startSong = true
end

-------------------------------------------------------------------

function onUpdatePost()	
    if not startSong then
        setShaderFloat('circlePointNeedle','percent',getProperty('circleStuff.angle')/360)
    end

    if startSong then
        setShaderFloat('circlePointNeedle','percent',getPropertyFromClass('backend.Conductor', 'songPosition') / getProperty('songLength'))
    end

--Health Rain to % curStep
    health = getProperty('health')
    if curStep % 2 == 0 and getProperty('health') > 0.075 then
   setProperty('health', health-  0.000);
end

--combomiss
    if combo >= 50 then
        combomiss = true
    elseif combo == 0 and combomiss == true then
        playSound('cuoi', 1.5, 1)
        combomiss = false
end

    if combo < 50 then
        setProperty('coolflash.alpha', 0);
end

-- coolflash
    if combo >= 200 and curBeat % 1 == 0 then 
        doTweenAlpha('coolflash', 'coolflash', 1, 0.5, 'linear');
end
    if combo >= 200 and curBeat % 2 == 0 then
        doTweenAlpha('coolflash', 'coolflash', 0, 0.5, 'linear'); 
end
        
--Hide BF, DAD, GF - Set Icon
    if combo >= 0 and Live == false then
    setProperty('boyfriend.alpha', 0)
    setProperty('dad.alpha', 0)
    setProperty('gf.alpha', 0)
end
    
    if combo >= 0 then
    setProperty('timeBarBG.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('iconP1.x', -25) 
    setProperty('iconP1.y', -25) 
    scaleObject('iconP1', 0.8, 0.8)
    setProperty('iconP1.flipX', true)
    setProperty('iconP2.y', 12350)	
end

--OsuScore
    score = getProperty('songScore')
    setProperty('OsuScore.text','0000000'..tostring(score))

--OsuMisses
    misses = getProperty('songMisses')
    setProperty('OsuMisses.text',tostring(misses))
    
--OsuAccuracy
    setProperty('OsuAccuracy.text', round((getProperty('ratingPercent')*100),2) .. '%')

--OsuCombo
    setProperty('OsuCombo.text',getProperty('combo')..'X')
    
    
    if misses == misss then
        misss = misss + 1
        cancelTween('RatingTxtAlphaTween')
        cancelTween('ratingScaleTweenAngle')
        cancelTween('ratingScaleTweenX')
        cancelTween('ratingPosTweenY')
        cancelTween('ratingScaleTweenY')
        setProperty('RatingTxt.angle', -5)
        setProperty('RatingTxt.alpha', 0)
        setProperty('MissTxt.alpha', 1)
        setProperty('MissTxt.scale.x', 1.45)
        setProperty('MissTxt.scale.y', 1.45)	
        doTweenAngle('ratingScaleTweenAngle', 'RatingTxt', -10, 0.7, 'linear')
        doTweenX('missScaleTweenX', 'MissTxt.scale', 0.7, 0.7, 'expoOut');
        doTweenY('missScaleTweenY', 'MissTxt.scale', 0.7, 0.7, 'expoOut');
    end
    doTweenAlpha('missTxtAlphaTween', 'MissTxt', 0, 0.1, 'linear')
   

--Fix OsuScore
    if     score >=     -999 and score <=     -100 then
        setProperty('OsuScore.text',  '0000'.. tostring(score))
    elseif score >=      -99 and score <=      -10 then
        setProperty('OsuScore.text', '00000'.. tostring(score))
    elseif score >=        0 and score <=        0 then
        setProperty('OsuScore.text','0000000'.. tostring(score))
    elseif score >=       10 and score <=       99 then
        setProperty('OsuScore.text','000000'.. tostring(score))
    elseif score >=      100 and score <=      999 then
        setProperty('OsuScore.text', '00000'.. tostring(score))
    elseif score >=     1000 and score <=     9999 then
        setProperty('OsuScore.text',  '0000'.. tostring(score))
    elseif score >=    10000 and score <=    99999 then
        setProperty('OsuScore.text',   '000'.. tostring(score))
    elseif score >=   100000 and score <=   999999 then
        setProperty('OsuScore.text',    '00'.. tostring(score))
    elseif score >=  1000000 and score <=  9999999 then
        setProperty('OsuScore.text',     '0'.. tostring(score))
    elseif score >= 10000000 and score <= 99999999 then
        setProperty('OsuScore.text',      ''.. tostring(score))
        end
    end


-------------------------------------------------------------------

function round(x, n)
  n = math.pow(10, n or 0)
  x = x * n
  if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
  return x / n
end

-------------------------------------------------------------------

function math.lerp(a, b, t)
    return (b - a) * t + a
end


function noteMiss()
    
end

-------------------------------------------------------------------

function goodNoteHit(id, direction, noteType, isSustainNote)
    
--OsuRating
	local rawNoteRating = getPropertyFromGroup('notes', id, 'rating')
	local noteRating = rawNoteRating
	unhealthrain = true
	

	if not isSustainNote then
        if rawNoteRating == 'sick' and combo < 50 then
			noteRating = "Sick"
			setTextBorder('RatingTxt', 3, '00AC99')
			
			
		elseif rawNoteRating == 'sick' and combo >= 50 and combo < 200 then
			noteRating = "Perfect"
			setTextBorder('RatingTxt', 3, '00AC99')
			
			
		elseif rawNoteRating == 'sick' and combo > 200 and combo < 300 then
			noteRating = "So cool"
			setTextBorder('RatingTxt', 3, '00AC99')
			
		
		elseif rawNoteRating == 'sick' and combo > 300 and combo < 400 then
			noteRating = "NICEEE"
			setTextBorder('RatingTxt', 3, '00AC99')
			
			
		elseif rawNoteRating == 'sick' and combo > 400 and combo < 500 then
			noteRating = "You cook!"
			setTextBorder('RatingTxt', 3, '00AC99')
			
			
		elseif rawNoteRating == 'sick' and combo > 500 then
			noteRating = "SEGGG!!"
			setTextBorder('RatingTxt', 3, '00DDFF')
			
			
		elseif rawNoteRating == 'good' then
			noteRating = "good!!"
			setTextBorder('RatingTxt', 3, '55AA00')
			
			
		elseif rawNoteRating == 'bad' then
			noteRating = "bad!!"
			setTextBorder('RatingTxt', 3, '820100')
			
			
		elseif rawNoteRating == 'shit' then
			noteRating = "SHIT"
			setTextBorder('RatingTxt', 3, '303030')
			
		end
	end
	
	if not isSustainNote then
		cancelTween('RatingTxtAlphaTween')
		cancelTween('ratingScaleTweenAngle')
		cancelTween('ratingScaleTweenX')
		cancelTween('ratingPosTweenY')
		cancelTween('ratingScaleTweenY')
		setProperty('RatingTxt.y', comboTextY)
		setProperty('RatingTxt.alpha', 1)
		setProperty('RatingTxt.angle', 0)
		setProperty('RatingTxt.scale.x', 1)
		setProperty('RatingTxt.scale.y', 1)	
		setTextString('RatingTxt',noteRating)
		setProperty('MissTxt.alpha', 0)
		
		
		
		if unique_rating_animations then
			if noteRating == "Sick!!" then
				setProperty('RatingTxt.angle', -5)
				setProperty('RatingTxt.scale.x', 1.8)
				setProperty('RatingTxt.scale.y', 1.8)	
				doTweenX('ratingScaleTweenX', 'RatingTxt.scale', 1, 0.7, 'expoOut');
				doTweenY('ratingScaleTweenY', 'RatingTxt.scale', 1, 0.7, 'expoOut');
				doTweenAngle('ratingScaleTweenAngle', 'RatingTxt', 5, 0.7, 'linear')
			elseif noteRating == "Good!" then
				setProperty('RatingTxt.scale.x', 1.6)
				setProperty('RatingTxt.scale.y', 1.6)	
				doTweenX('ratingScaleTweenX', 'RatingTxt.scale', 1, 0.7, 'expoOut');
				doTweenY('ratingScaleTweenY', 'RatingTxt.scale', 1, 0.7, 'expoOut');
			elseif noteRating == "Bad" then
				setProperty('RatingTxt.scale.x', 1.3)
				setProperty('RatingTxt.scale.y', 1.3)	
				doTweenX('ratingScaleTweenX', 'RatingTxt.scale', 1, 0.7, 'expoOut');
				doTweenY('ratingScaleTweenY', 'RatingTxt.scale', 1, 0.7, 'expoOut');
				doTweenAngle('ratingScaleTweenAngle', 'RatingTxt', -10, 0.7, 'linear')
			elseif noteRating == "Shit" then
				setProperty('RatingTxt.scale.x', 1.0)
				setProperty('RatingTxt.scale.y', 1.0)	
				doTweenX('ratingScaleTweenX', 'RatingTxt.scale', 1, 0.7, 'expoOut');
				doTweenY('ratingScaleTweenY', 'RatingTxt.scale', 1, 0.7, 'expoOut');
				doTweenY('ratingPosTweenY', 'RatingTxt', comboTextY + 25, 0.7, 'linear');
				doTweenAngle('ratingScaleTweenAngle', 'RatingTxt', -20, 0.7, 'linear')
			end
		else
			setProperty('RatingTxt.scale.x', 1.6)
			setProperty('RatingTxt.scale.y', 1.6)	
			doTweenX('scaleTweenX', 'RatingTxt.scale', 1, 0.7, 'expoOut');
			doTweenY('scaleTweenY', 'RatingTxt.scale', 1, 0.7, 'expoOut');
		end	
		doTweenAlpha('RatingTxtAlphaTween', 'RatingTxt', 0, 0.5, 'linear')
		
	end
end

-------------------------------------------------------------------

function onTweenCompleted(tag)
    if tag == 'circleStuffAngle' then
        doTweenColor('circlePointCenterColor','circlePointCenter','ffffff',0.5)
        doTweenColor('circlePointNeedleColor','circlePointNeedle','ffffff',0.5)
        doTweenColor('circlePointNeedle2Color','circlePointNeedle2','ffffff',0.5)
        for i = 0,360 do
            doTweenColor('circlePoint'..i..'Color','circlePoint'..i,'ffffff',0.5)
        end
    end
end
