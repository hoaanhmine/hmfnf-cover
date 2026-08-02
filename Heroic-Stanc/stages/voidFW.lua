local speed = 0.8
local xx = 1300
local yy = 950
local xx2=1700
local yy2=950
local camZoom =0.7
local camZoom2 =0.72
ofs =20
local followchars = false
loop = 0
glitchDrawin = false
local Angle = 2
local timeAngle =0.5
local bordersSize = 90
--Color object
local charColors = {'969494','BFE5BA'}
local houseColors = {'8f8f8f','9ADA91'}
local rockColors = {'bababa','B8D4B5'}
local coolThingColors = {'c4c0c0','C1CEAA'}
function onCreatePost()
setTextFont('scoreTxt','Gumball.ttf')
    setTextColor('scoreTxt','02c0fa')
    setTextFont('botplayTxt','Gumball.ttf')
    setTextColor('botplayTxt','02c0fa')
    setTextFont('timeTxt','Gumball.ttf')

makeLuaSprite("black",'', 0, 0);
makeGraphic("black",2737,1409,'000000')
setObjectCamera("black", 'camOther')
addLuaSprite('black')
    
setProperty('healthBar.visible',false)
setProperty('healthBarBG.visible',false)
setProperty('iconP1.visible',false)
setProperty('iconP2.visible',false)


makeLuaSprite('voidb','images/voidFW/void3/1b',0, -200);
    scaleObject('voidb',1.2,1.2)
    setScrollFactor('voidb',0.6,0.6)
    setProperty('voidb.visible',false)
    addLuaSprite('voidb')
    
  makeLuaSprite('scaryGlitchAhh','images/voidFW/void3/2',0, -200);
    scaleObject('scaryGlitchAhh',1.2,1.2)
    setScrollFactor('scaryGlithAhh',0.6,0.6)
    setProperty('scaryGlitchAhh.visible',false)
    addLuaSprite('scaryGlitchAhh')
    
makeLuaSprite('moreGlitchWaaaButBehindTheRock2','images/voidFW/void3/2b',0, -200);
scaleObject('moreGlitchWaaaButBehindTheRock2',1.2,1.2)
setScrollFactor('moreGlitchWaaaButBehindTheRock2',0.6,0.6)
setProperty('moreGlitchWaaaButBehindTheRock2.visible',false)
addLuaSprite('moreGlitchWaaaButBehindTheRock2')

makeLuaSprite('rock4b','images/voidFW/void3/4',0, -200);
    scaleObject('rock4b',1.2,1.2)
    setScrollFactor('rock4b',0.85,0.85)
    setProperty('rock4b.visible',false)
    addLuaSprite('rock4b')
    
makeLuaSprite('houseb','images/voidFW/void3/3b',0, -200);
    scaleObject('houseb',1.2,1.2)
    setScrollFactor('houseb',0.85,0.85)
    setProperty('houseb.visible',false)
    addLuaSprite('houseb')
    
makeLuaSprite('rockb','images/voidFW/void3/5b',0, -200);
    scaleObject('rockb',1.2,1.2)
    setScrollFactor('rockb',1,1)
    setProperty('rockb.visible',false)
    addLuaSprite('rockb')
    
makeLuaSprite('rock2b','images/voidFW/void3/11',0, -200);
    scaleObject('rock2b',1.2,1.2)
    setScrollFactor('rock2b',1,1)
    setProperty('rock2b.visible',false)
    addLuaSprite('rock2b')
	
	makeLuaSprite('rock3b','images/voidFW/void3/11',0, -200);
    scaleObject('rock3b',1.2,1.2)
    setScrollFactor('rock3b',0.9,0.9)
    setProperty('rock3b.visible',false)
    addLuaSprite('rock3b')

    makeLuaSprite('wtfb','images/voidFW/void3/6',0, -200);
    scaleObject('wtfb',1.2,1.2)
    setScrollFactor('wtfb',1,1)
    setProperty('wtfb.visible',false)
    addLuaSprite('wtfb')
    
    makeLuaSprite('moreGlitchWaaa','images/voidFW/void3/2b',0, 210);
    scaleObject('moreGlitchWaaa',1.2,1.2)
    setScrollFactor('moreGlitchWaaa',1.1,1.1)
    setProperty('moreGlitchWaaa.visible',false)
    addLuaSprite('moreGlitchWaaa',true)
    


    makeAnimatedLuaSprite('void','images/void/void',-80, -200);
    addAnimationByPrefix('void','idle','idle',24,true)
    scaleObject('void',1.7,1.7)
    setScrollFactor('void',0.4,0.4)
    addLuaSprite('void')
    
    
    makeLuaSprite('rock3','images/voidFW/Ilustracion_sin_titulo-6',0, -200);
    scaleObject('rock3',2.5,2.5)
    setScrollFactor('rock3',0.9,0.9)
    addLuaSprite('rock3')
    
    makeLuaSprite('house','images/voidFW/Ilustracion_sin_titulo-3',0, -200);
    scaleObject('house',2.5,2.5)
    setScrollFactor('house',0.85,0.85)
    addLuaSprite('house')
    
    makeLuaSprite('moreGlitchWaaaButBehindTheRock','images/voidFW/void3/2b',0, -200);
scaleObject('moreGlitchWaaaButBehindTheRock',1.2,1.2)
setScrollFactor('moreGlitchWaaaButBehindTheRock',0.6,0.6)
setProperty('moreGlitchWaaaButBehindTheRock.visible',true)
addLuaSprite('moreGlitchWaaaButBehindTheRock')
   
    
    makeLuaSprite('rock','images/voidFW/Ilustracion_sin_titulo-4',0, -200);
    scaleObject('rock',2.5,2.5)
    setScrollFactor('rock',1,1)
    addLuaSprite('rock')
    
    makeLuaSprite('rock2','images/voidFW/Ilustracion_sin_titulo-5',0, -200);
    scaleObject('rock2',2.5,2.5)
    setScrollFactor('rock2',1.1,1.1)
    addLuaSprite('rock2')
	
    
        makeLuaSprite('rock4','images/voidFW/Ilustracion_sin_titulo-7',0, -200);
    scaleObject('rock4',2.5,2.5)
    setScrollFactor('rock4',0.85,0.85)
    addLuaSprite('rock4')
    
    makeLuaSprite('wtf','images/voidFW/Ilustracion_sin_titulo-8',0, -200);
    scaleObject('wtf',2.5,2.5)
    setScrollFactor('wtf',1,1)
    addLuaSprite('wtf')
    
    makeLuaSprite('scaryGlitch','images/voidFW/Ilustracion_sin_titulo-9',200, 100);
    scaleObject('scaryGlitch',2.2,2.2)
    setScrollFactor('scaryGlitch',1,1)
    addLuaSprite('scaryGlitch')
    
    initLuaShader("cyclesd")
setSpriteShader('scaryGlitch', 'cyclesd');
setSpriteShader('moreGlitchWaaaButBehindTheRock', 'cyclesd');
setSpriteShader('moreGlitchWaaaButBehindTheRock2', 'cyclesd');
setSpriteShader('moreGlitchWaaa', 'cyclesd');
setSpriteShader('scaryGlitchAhh', 'cyclesd');
 --   }

makeAnimatedLuaSprite('glitch','images/voidFW/gumballglitchbg',0, -200);
addAnimatedByPrefix('spin', 'spin', 24,true)
    scaleObject('glitch',2.5,2.5)
    setScrollFactor('glitch',1,1)
    addLuaSprite('glitch')
    
    makeLuaSprite('gradient', 'gradient', 0, 0);
		setProperty('gradient.alpha',0)
		addLuaSprite('gradient', true);
		scaleObject('gradient',0.5,0.5)
		setObjectCamera('gradient', 'other')
		
        runTimer('repeat',0.1 * getProperty('playbackRate') / (getPropertyFromClass('backend.Conductor', 'bpm')/ 90),0) 
            
        setProperty('void.color',getColorFromHex('DBDBDB'))
        setProperty('house.color',getColorFromHex(houseColors[1]))
        setProperty('rock.color',getColorFromHex(rockColors[1]))
        setProperty('rock2.color',getColorFromHex(rockColors[1]))
        setProperty('rock3.color',getColorFromHex(rockColors[1]))
        setProperty('rock4.color',getColorFromHex(rockColors[1]))
        setProperty('wtf.color',getColorFromHex(coolThingColors[1]))
	end

    function onEvent(n,v1,v2)
        if n == 'Change Character' then
            setProperty('boyfriend.color',getColorFromHex('a8a4a4'))
            setProperty('dad.color',getColorFromHex('a8a4a4'))
        end
    end

 function onTweenCompleted(tag)
 if tag == 'housebX' then
setProperty('houseb.x',-2400)
doTweenX('housebX','houseb',2400,4/speed,'linear')
end

if tag == 'rock4bX' then
setProperty('rock4b.x',-2400)
doTweenX('rock4bX','rock4b',2500,3/speed,'linear')
end
  
 end

function onUpdatePost(elapsed)
if math.random(1,4) == 1 then
setProperty('void.alpha',0)
else
setProperty('void.alpha',1)
end

if curStep >= 0 and curStep < 999999999999 then
setProperty('house.angle',9 * math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / (1500/speed) ))
        setProperty('rock.angle',3* math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / (1700/speed) ))
        setProperty('wtf.angle',4.5 * math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / (3000/speed)))
        setProperty('rock2.angle',2 * math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / (2500/speed)))
  setProperty('rock3.angle',360 * math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / (20000/(speed*1.5)) ))
  setProperty('rock4.angle',6* math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / (5000/speed)))
  setProperty('wtf.y', -200 + math.sin((getPropertyFromClass('backend.Conductor', 'songPosition') / (3000/speed)) * ((getPropertyFromClass('backend.Conductor', 'bpm')/ 60) * 1.0)) * 60)
  setProperty('camGame.y', math.sin((getPropertyFromClass('backend.Conductor', 'songPosition') / (4000/(speed*0.5))) * ((getPropertyFromClass('backend.Conductor', 'bpm')/ 60) * 1.0)) * 20)
  
  setProperty('houseb.angle',8 * math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / (1500/speed) ))
        setProperty('rockb.angle',3* math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / (1700/speed) ))
        setProperty('wtfb.angle',4.5 * math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / (3000/speed)))
        setProperty('rock2b.angle',2 * math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / (2500/speed)))
  setProperty('rock3b.angle',360 * math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / (20000/(speed*1.5)) ))
  setProperty('rock4b.angle',6* math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / (5000/speed)))
  setProperty('wtfb.y', -200 + math.sin((getPropertyFromClass('backend.Conductor', 'songPosition') / (3000/speed)) * ((getPropertyFromClass('backend.Conductor', 'bpm')/ 60) * 1.0)) * 60)
  end
  if curStep <515 then
  setProperty('boyfriend.angle',0)
  setProperty('dad.angle',0)
  setProperty('gf.angle',0)
  else 
  setProperty('boyfriend.y', 920 + math.sin((getPropertyFromClass('backend.Conductor', 'songPosition') / (1700/speed)) ) *20)
--  setProperty('gf.y', 870 + math.sin((getPropertyFromClass('Conductor', 'songPosition') / (1700/speed)) )*20)
  setProperty('dad.y', 770 + math.sin((getPropertyFromClass('backend.Conductor', 'songPosition') / (1700/speed)) )* -20)
  setProperty('boyfriend.x', 1800 + math.sin((getPropertyFromClass('backend.Conductor', 'songPosition') / (1700/speed)) ) * -20)
--  setProperty('gf.x', 1670 + math.sin((getPropertyFromClass('Conductor', 'songPosition') / (1700/speed)) )* -20)
  setProperty('dad.x', 900 + math.sin((getPropertyFromClass('backend.Conductor', 'songPosition') / (1700/speed)) )* -20)
  setProperty('boyfriend.angle',getProperty('rock.angle'))
  setProperty('dad.angle',getProperty('rock.aggle'))
  setProperty('gf.angle',getProperty('rock.angle'))
  end
end

function onSongStart()
makeLuaSprite("white",'', 0, 100);
makeGraphic("white",2737,1409,'FFFFFF')
setObjectCamera("white", 'camGame')
addLuaSprite('white')

makeLuaSprite("blackGame",'', 0, 100);
makeGraphic("blackGame",2737,1409,'000000')
setObjectCamera("blackGame", 'camGame')
addLuaSprite('blackGame',true)
setProperty('blackGame.alpha',0)

setProperty('boyfriend.color',getColorFromHex('000000'))
setProperty('dad.color',getColorFromHex('000000'))
end

function onBeatHit()
if curBeat  <3 then
makeLuaSprite('cinematicBorder1',nil,0,-90)
        makeLuaSprite('cinematicBorder2',nil,0,screenHeight - bordersSize + 90)
        for borders = 1,2 do
            makeGraphic('cinematicBorder'..borders,screenWidth+2,bordersSize,'000000')
            setObjectCamera('cinematicBorder'..borders,'camHUD')
            addLuaSprite('cinematicBorder'..borders,false)
            end
            
doTweenAlpha('black','black',0,8)
doTweenY('1Y','cinematicBorder1',0,6,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize ,6,'linear')
end

if curBeat == 494 then
doTweenY('1Y','cinematicBorder1',-90,1,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize+ 90,1,'linear')
end

if (curBeat >361 and curBeat % 1 == 0 and curBeat < 428) or (curBeat >498 and curBeat % 1 == 0 and curBeat < 597) then
triggerEvent('Add Camera Zoom',0.03,0.06)
end

                   if curBeat % 1 == 0 then
setShaderFloat('scaryGlitch', 'pixel', math.random(6,15))
setShaderFloat('moreGlitchWaaaButBehindTheRock', 'pixel', math.random(15,25))
setShaderFloat('moreGlitchWaaaButBehindTheRock2', 'pixel', math.random(15,30))
setShaderFloat('moreGlitchWaaa', 'pixel', math.random(5,10))
setShaderFloat('scaryGlitchAhh', 'pixel', math.random(8,20))
end
end

function onStepHit()

if curStep <= 7 then
for i =0,7 do
noteTweenAlpha('Note'..i,i,0,0.01)
end
end

if curStep == 245 then
noteTweenAlpha('NoteAlpha0','0',1,0.001)
noteTweenAlpha('NoteAlpha4','4',1,0.001)
end

if curStep == 247 then
noteTweenAlpha('NoteAlpha0','1',1,0.001)
noteTweenAlpha('NoteAlpha4','5',1,0.001)
end

if curStep == 251 then
noteTweenAlpha('NoteAlpha0','2',1,0.001)
noteTweenAlpha('NoteAlpha4','6',1,0.001)
end

if curStep == 253 then
noteTweenAlpha('NoteAlpha0','3',1,0.001)
noteTweenAlpha('NoteAlpha4','7',1,0.001)
end

if curStep == 255 then
doTweenY('1Y','cinematicBorder1',-90,1,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize+ 90 ,1,'linear')
followchars = true
end

if curStep >= 515 and curStep <= 518 then
setProperty('white.visible',false)
setProperty('boyfriend.color',getColorFromHex('a8a4a4'))
setProperty('dad.color',getColorFromHex('a8a4a4'))
--setProperty('blackGame.alpha',0.2)
end

if curStep == 774 then
doTweenY('1Y','cinematicBorder1',0,0.3,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize ,0.3,'linear')
end

if curStep == 904 then
doTweenY('1Y','cinematicBorder1',-90,1,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize+ 90 ,1,'linear')
cameraFlash('camGame','ffffff',1)
end

if (curStep % 4 == 0 and curStep > 515 and curStep < 776 ) or (curStep % 4 == 0 and curStep >900 and curStep <1176 )then 
triggerEvent('Add Camera Zoom',0.025,0.05)
end

  if curStep == 1435 then
  --Change BG--
      removeLuaSprite('void',false);
      removeLuaSprite('wtf',false)
      removeLuaSprite('rock',false)
      removeLuaSprite('rock2',false)
      removeLuaSprite('rock3',false)
      removeLuaSprite('rock4',false)
      removeLuaSprite('house',false)
      removeLuaSprite('moreGlitchWaaaButBehindTheRock',false)

      setProperty('voidb.visible',true)
      setProperty('rockb.visible',true)
      setProperty('rock2b.visible',true)
      setProperty('rock3b.visible',true)
      setProperty('rock4b.visible',true)
      setProperty('houseb.visible',true)
      setProperty('wtfb.visible',true)
      setProperty('scaryGlitchAhh.visible',true)
      setProperty('moreGlitchWaaa.visible',true)
      setProperty('moreGlitchWaaaButBehindTheRock2.visible',true)
      setProperty('gradient.alpha',0.6)
      
      doTweenY('1Y','cinematicBorder1',0,1,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize ,1,'linear')
      doTweenX('housebX','houseb',2000,4,'linear')
doTweenX('rock4bX','rock4b',2500,3,'linear')
        glitchDrawin = true
        speed = 0.8
        --glitch arrow player
for i =0,3 do
setSpriteShader('playerStrums.members['..i..']', 'NewGlitch2')  
end   
end

if curStep == 1710 then
doTweenY('1Y','cinematicBorder1',-90,0.5,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize+ 90 ,0.5,'linear')
cameraFlash('camGame','ffffff',1)
end

if curStep == 1843 then
doTweenY('1Y','cinematicBorder1',0,0.35,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize ,0.35,'linear')
end

if curStep == 2394 then
setProperty('camGame.visible',false)
for i = 0,7 do
noteTweenAlpha('Note'..i,i,0,0.01,'linear')
runTimer('EndSong',24)
setProperty('black.alpha',1)
cameraFlash('camOther','ffffff',1)
end
end

if curStep == 2634 then
setProperty('camGame.visible',false)
doTweenAlpha('black','black',0,0.2)
for number= 0,3 do
noteTweenAlpha('Note'..number,number,0.3,0.5,'linear')
end
end

if glitchDrawin then
for j =0,3 do
    random = getRandomFloat(4,6)
          setShaderFloat('playerStrums.members['..j..']', 'binaryIntensity', random)
    end
end
end

function onUpdate()

  if curStep < 256 then
     triggerEvent('Camera Follow Pos',1500,950)
end 
if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',getProperty('defaultCamZoom'))
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

            setProperty('defaultCamZoom',getProperty('defaultCamZoom'))
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
end

function updateNote()
    speed = speed + 0.002

    if glitchDrawin then
        for i =0,3 do
            setShaderFloat("playerStrums.members["..i.."]", "negativity", 0.0)
        end

        if speedUpGlitch0 then
            setShaderFloat('playerStrums.members[0]', 'binaryIntensity', math.random(4,6))
        end
    
        if speedUpGlitch1 then
            setShaderFloat('playerStrums.members[1]', 'binaryIntensity', math.random(4,6))
        end
    
        if speedUpGlitch2 then
            setShaderFloat('playerStrums.members[2]', 'binaryIntensity', math.random(4,6))
        end
    
        if speedUpGlitch3 then
            setShaderFloat('playerStrums.members[3]', 'binaryIntensity', math.random(4,6))
        end
    end
end

function goodNoteHit(id,data,type,sus)
    if data == 0 then
    speedUpGlitch0 = true
    runTimer('outSpeed0',0.15)
    end
    
    if data == 1 then
    speedUpGlitch1 = true
    runTimer('outSpeed1',0.15)
    end
    
    if data == 2 then
    speedUpGlitch2 = true
    runTimer('outSpeed2',0.15)
    end
    
    if data == 3 then
    speedUpGlitch3 = true
    runTimer('outSpeed3',0.15)
    end
    end
    
    function onTimerCompleted(tag)
    if tag== 'outSpeed0' then
    speedUpGlitch0 = false
    end
    
    if tag== 'outSpeed1' then
    speedUpGlitch1 = false
    end
    
    if tag== 'outSpeed2' then
    speedUpGlitch2 = false
    end
    
    if tag== 'outSpeed3' then
    speedUpGlitch3 = false
    end

    if tag == 'repeat' then
        updateNote()
        runTimer('repeat',0.1 * getProperty('playbackRate') / (getPropertyFromClass('backend.Conductor', 'bpm')/ 90),0)       
      end
    
    if tag =='EndSong' then
setProperty('black.alpha',1)
cameraFlash('camOther', 'ffffff', 1)
end
    end
    