local xx = 1650
local yy = 1080
local xx2=2220
local yy2=1200
local ofs = 30
local Angle = 2
local timeAngle =0.5
local followchars = true

function onCreate()

makeLuaSprite("whiteOther",'', 0, 0);
makeGraphic("whiteOther",2480,1420,'FFFFFF')
setProperty('whiteOther.alpha',0)
setObjectCamera("whiteOther", 'camOther')
addLuaSprite('whiteOther')

makeLuaSprite("blackOther",'', 0, 0);
makeGraphic("blackOther",2480,1420,'000000')
setProperty('blackOther.alpha',0)
setObjectCamera("blackOther", 'camOther')
addLuaSprite('blackOther')

makeLuaSprite("whiteOther",'', 0, 0);
makeGraphic("whiteOther",2480,1420,'FFFFFF')
setProperty('whiteOther.alpha',0)
setObjectCamera("whiteOther", 'camOther')
addLuaSprite('whiteOther')

makeLuaSprite('bg','images/lab/bg',720,450)
scaleObject('bg',1.5,1.5)
addLuaSprite('bg',false)

makeLuaSprite('dark','images/lab/dark',500,440)
scaleObject('dark',1.8,1.8)
setProperty('dark.alpha',0.9)
addLuaSprite('dark',true)

makeLuaSprite('light','images/lab/light',500,440)
setProperty('light.alpha',0.8)
scaleObject('light',1.8,1.8)
addLuaSprite('light',true)
flickerTween = true

--Treehouse

makeLuaSprite('sky','images/treehouse/background',-500,-600)
setProperty('sky.alpha',1)
scaleObject('sky',5,5)
setProperty('sky.alpha',1)
addLuaSprite('sky')

makeLuaSprite('treehouse','images/treehouse/treehouse',-500,-600)
setProperty('treehouse.alpha',1)
scaleObject('treehouse',5,5)
addLuaSprite('treehouse')

makeLuaSprite('flash', 'images/treehouse/gradient', 0, 0);
setProperty('flash.alpha',0)
setProperty('flash.flipY',true)
addLuaSprite('flash', false);
scaleObject('lash',0.6,0.6)
setObjectCamera('flash', 'camHUD')

makeLuaSprite('skyNight','images/treehouse/back',-500,-600)
scaleObject('skyNight',1.25,1.25111)
setProperty('skyNight.alpha',0)
addLuaSprite('skyNight')

makeAnimatedLuaSprite('thunder', 'images/treehouse/Lighting', 500, -1000);
addAnimationByPrefix('thunder', 'idle', 'LIGHTNING', 24, false);
setScrollFactor('thunder',0.65,0.65)
scaleObject('thunder', 0.8,0.8)
setProperty('thunder.visible',false)
addLuaSprite('thunder')

makeLuaSprite('treehouseNight','images/treehouse/tree',-500,-600)
setProperty('treehouseNight.alpha',0)
scaleObject('treehouseNight',1.25,1.25111)
addLuaSprite('treehouseNight')

makeAnimatedLuaSprite('rain','images/treehouse/Rain',-250,-500)
scaleObject('rain',8,8)
setProperty('rain.visible',true)
setProperty('rain.alpha',0)
addAnimationByPrefix('rain','idle','rain tho',48,true)
addLuaSprite('rain',true)


makeLuaSprite('buld','images/lab/bulb',590,260)
scaleObject('buld',1.3,1.3)
addLuaSprite('buld',true)

makeLuaSprite("blackGame",'', -520, -750);
makeGraphic("blackGame",3213,1660,'000000')
scaleObject('blackGame',5,5)
setProperty('blackGame.alpha',0)
setObjectCamera("blackGame", 'camGame')
addLuaSprite('blackGame',true)

makeLuaSprite("whiteGame",'', 720, 450);
makeGraphic("whiteGame",3213,1660,'ffffff')
setProperty('whiteGame.alpha',0)
setObjectCamera("whiteGame", 'camGame')
addLuaSprite('whiteGame')
setObjectOrder('whiteGame',50)

doTweenAlpha('lightAlpha','light',math.random(2,8)/10,0.25,'linear')

setProperty('bg.alpha',0)
setProperty('dark.visible',false)
setProperty('light.visible',false)
setProperty('buld.visible',false)
end

time = 0
function onCreatePost()
    runTimer('time',0.01,0)
    setTextFont('scoreTxt','thunderman.ttf')
    setProperty('timeBarBG.color',getColorFromHex('a8a0b3'))
    setTextFont('timeTxt','thunderman.ttf')
    setTextFont('botplayTxt','thunderman.ttf')
    setTextColor('botplayTxt','a8a0b3')

    xx = xx - 300
    yy = yy + 200
    xx2 = xx2 + 200
    yy2 = yy2 + 200
end

function onTimerCompleted(tag)
    if tag == 'time' then
        time = time + 10
    end
end

function onUpdatePost(elapsed) 

	setProperty('light.angle',math.sin((getPropertyFromClass('backend.Conductor','songPosition')/ 1000) * ((getPropertyFromClass('backend.Conductor', 'bpm') / 60) * 1.0)) * 5); 
    setProperty('light.x',500 + math.sin((getPropertyFromClass('backend.Conductor','songPosition')/ 1000) * ((getPropertyFromClass('backend.Conductor', 'bpm') / 60) * 1.0)) * - 180);                                                                                                              
	setProperty('dark.angle',getProperty('light.angle'));
    setProperty('dark.x',500 + math.sin((getPropertyFromClass('backend.Conductor','songPosition')/ 1000) * ((getPropertyFromClass('backend.Conductor', 'bpm') / 60) * 1.0)) * - 180);                                           
	setProperty('buld.angle', getProperty('light.angle'));
    setProperty('buld.x',160 + math.sin((getPropertyFromClass('backend.Conductor','songPosition')/ 1000) * ((getPropertyFromClass('backend.Conductor', 'bpm') / 60) * 1.0)) * - 160); 
        
    --debugPrint(time)
	end
	
	function onTweenCompleted(tag)
	if tag == 'lightAlpha' then
	doTweenAlpha('lightAlpha2','light',0.6,0.5,'bounceInOut')
	end
	
	if tag == 'lightAlpha2' then
	doTweenAlpha('lightAlpha','light',0.4,0.5,'bounceInOut')
	end
	end
	
    function onEvent(name,value1,value2)

        if name == '' then
            if value1 == 'treehouseAppear' then
                if value2 == 'prepare' then
                    xx = xx - 300
                    yy = yy + 200
                    xx2 = xx2 + 200
                    yy2 = yy2 + 200
                end
            end

            if value1 == 'animFinn' then
                if value2 == 'hide' then
                    xx = xx + 300
                    yy = yy - 200
                    xx2 = xx2 - 200
                    yy2 = yy2 - 200
                end
            end
        end
    end

	function onUpdate()


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
            
            if getProperty('jake.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('jake.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('jake.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('jake.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
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
            if getProperty('gf.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('gf.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('gf.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('gf.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
end
