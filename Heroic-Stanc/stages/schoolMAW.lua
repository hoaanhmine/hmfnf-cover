local xx = 700
local yy = 650
local xx2=1400
local yy2=680
local setCamZoom = false
local camZoom =1.15
local camZoom2 =1
local Angle = 1.5
local timeAngle =0.5
ofs =20
ofsGF = 50
ending = false
lauge = false
chanel = 0
goToEnd = false
local bordersSize = 90
local followchars = true
bfTurn = false
function onCreatePost()
initLuaShader('glowy')
setSpriteShader('bloom', 'glowy')   

	makeLuaSprite('background', 'images/schoolMAW/Ilustracion_sin_titulo-1', 0, 0)
	scaleObject('background', 1.3, 1.3)
	setScrollFactor('background', 0.85, 1)
	addLuaSprite('background')
	
	makeLuaSprite('wall', 'images/schoolMAW/Ilustracion_sin_titulo-2', -200, 200)
	scaleObject('wall', 1.1, 1.1)
	setScrollFactor('wall', 1, 1)
	addLuaSprite('wall', true)
	
	runHaxeCode([[
	//PENNY MY BELOVED - schweizer
var penny;
penny = new flixel.FlxSprite();
        penny.x = 800;
        penny.y = 220;
        penny.scale.set(1.3, 1.3);
        penny.frames = retrieveAsset('images/images/schoolMAW/penny', 'atlas');
        penny.animation.addByPrefix('idle', 'idle', 6, true);
        add(penny);
        ]])
	
	makeLuaSprite('light', 'images/schoolMAW/light', -500, 50)
	scaleObject('light', 1, 1)
	setScrollFactor('light', 1, 1)
	addLuaSprite('light', true)
	
	makeLuaSprite('vignette', 'images/schoolMAW/Ilustracion_sin_titulo-3', 0, 0)
	scaleObject('vignette', 1.3, 1.3)
	setScrollFactor('vignette', 1, 1)
	addLuaSprite('vignette', true)
	
	makeLuaSprite('vignette2', 'images/schoolMAW/188_sin_titulo11_20230523094718', 0, 0)
	scaleObject('vignette2', 1.3, 1.3)
	setScrollFactor('vignette2', 1, 1)
	addLuaSprite('vignette2', true)
	
	makeAnimatedLuaSprite('topgoop', 'school/topgoop', 0, 100);
   addAnimationByPrefix('topgoop','idle','gooey0',24, true);
   scaleObject('topgoop', 1, 1);
   setProperty('topgoop.alpha', 1)
   addLuaSprite('topgoop', true);
   
   makeAnimatedLuaSprite('secondtopgoop', 'school/secondtopgoop', 1500, -100);
   addAnimationByPrefix('secondtopgoop','idle','gooey0',24, true);
   scaleObject('secondtopgoop', 1.7, 1.7);
   setScrollFactor('secondtopgoop', 0.685, 1);
   setProperty('secondtopgoop.alpha', 1)
   addLuaSprite('secondtopgoop', true);
   
   makeAnimatedLuaSprite('sinkgoop', 'school/sinkgoop', 586, 505);
   addAnimationByPrefix('sinkgoop','idle','gooey0',24, true);
   setScrollFactor('sinkgoop', 0.85, 1);
   scaleObject('sinkgoop', 2.0, 2.0);
   addLuaSprite('sinkgoop', false);

   makeAnimatedLuaSprite('droplet2', 'school/droplet2', 400, 760);
   addAnimationByPrefix('droplet2','idle','gooey0',24, true);
   setScrollFactor('droplet2', 0.85, 1);
   scaleObject('droplet2', 2.0, 2.0);
   addLuaSprite('droplet2', false);

   makeAnimatedLuaSprite('droplet', 'school/droplet', 870, 250);
   addAnimationByPrefix('droplet','idle','gooey0',24, true);
   setScrollFactor('droplet', 0.85, 1);
   scaleObject('droplet', 2.0, 2.0);
   addLuaSprite('droplet', false);
   
   makeAnimatedLuaSprite('penny', 'images/schoolMAW/penny', 700, 120);
   addAnimationByPrefix('penny','idle','idle',10, true);
   scaleObject('penny', 1.3, 1.3);
   setProperty('penny.alpha', 1)
   setScrollFactor('penny', 0.85, 1);
   addLuaSprite('penny');
   
	makeLuaSprite('blackOther',nil, 0, 0);
makeGraphic('blackOther',1280,720,'000000')
setProperty('blackOther.alpha',1)
setObjectCamera('blackOther', 'other')
addLuaSprite('blackOther')

makeLuaSprite("blackGame",'', 0, 0);
makeGraphic("blackGame",3213,1660,'000000')
setProperty('blackGame.alpha',0)
setObjectCamera("blackGame", 'camGame')
addLuaSprite('blackGame',true)

makeLuaSprite('cinematicBorder1',nil,0,-90)
        makeLuaSprite('cinematicBorder2',nil,0,screenHeight - bordersSize+ 90)
        for borders = 1,2 do
            makeGraphic('cinematicBorder'..borders,screenWidth+2,bordersSize,'000000')
            setObjectCamera('cinematicBorder'..borders,'camHUD')
            addLuaSprite('cinematicBorder'..borders,false)
            end
            
            makeLuaSprite('ch1', 'images/schoolMAW/channels/chn1', 100, 150)
	scaleObject('ch1', 1, 1)
	setScrollFactor('ch1', 1, 1)
	setProperty('ch1.alpha',0)
	addLuaSprite('ch1')
	
	makeLuaSprite('ch2', 'images/schoolMAW/channels/chn2', 125, -20)
	scaleObject('ch2', 1, 1)
	setScrollFactor('ch2', 1, 1)
	setProperty('ch2.alpha',0)
	addLuaSprite('ch2')
	
	makeLuaSprite('ch3', 'images/schoolMAW/channels/chn3', 100, 150)
	scaleObject('ch3', 1, 1)
	setScrollFactor('ch3', 1, 1)
	setProperty('ch3.alpha',0)
	addLuaSprite('ch3')
	
            
            makeAnimatedLuaSprite('void','images/void/void',-80, -200);
    addAnimationByPrefix('void','idle','idle',24,true)
    scaleObject('void',1.7,1.7)
    setScrollFactor('void',0.4,0.4)
    setProperty('void.alpha',0)
    addLuaSprite('void')
    
    makeLuaSprite('rock3','images/voidFW/Ilustracion_sin_titulo-6',0, -200);
    scaleObject('rock3',2.5,2.5)
    setScrollFactor('rock3',0.9,0.9)
    setProperty('rock3.alpha',0)
    addLuaSprite('rock3')
    
    makeLuaSprite('rock4','images/voidFW/Ilustracion_sin_titulo-7',0, -200);
    scaleObject('rock4',2.5,2.5)
    setScrollFactor('rock4',0.85,0.85)
    setProperty('rock4.alpha',0)
    addLuaSprite('rock4')
    
    makeLuaSprite('house','images/voidFW/Ilustracion_sin_titulo-3',0, -200);
    scaleObject('house',2.5,2.5)
    setScrollFactor('house',0.85,0.85)
    addLuaSprite('house')
    setProperty('house.alpha',0)
    
    makeLuaSprite('rock','images/voidFW/Ilustracion_sin_titulo-4',0, -200);
    scaleObject('rock',2.5,2.5)
    setScrollFactor('rock',1,1)
    addLuaSprite('rock')
    setProperty('rock.alpha',0)
    
    makeLuaSprite('rock2','images/voidFW/Ilustracion_sin_titulo-5',0, -200);
    scaleObject('rock2',2.5,2.5)
    setScrollFactor('rock2',1.1,1.1)
    addLuaSprite('rock2')
setProperty('rock2.alpha',0)

    makeLuaSprite('wtf','images/voidFW/Ilustracion_sin_titulo-8',0, -200);
    scaleObject('wtf',2.5,2.5)
    setScrollFactor('wtf',1,1)
    addLuaSprite('wtf')
    setProperty('wtf.alpha',0)
    
    makeLuaText('chanelNumber', '', 400, 20, 50)
	addLuaText('chanelNumber')
	setTextSize('chanelNumber', 60)
	setTextColor('chanelNumber','00ff00')
	setObjectCamera('chanelNumber','camHUD')
	setTextFont('chanelNumber', 'vcr.ttf')
	
    setTextFont('scoreTxt','Gumball.ttf')
    setTextColor('scoreTxt','02c0fa')
    setTextFont('botplayTxt','Gumball.ttf')
    setTextColor('botplayTxt','02c0fa')
    setTextFont('timeTxt','Gumball.ttf')
    setProperty('defaultCamZoom',2)
    
    initLuaShader("cyclesd")
setSpriteShader('droplet', 'cyclesd');
setSpriteShader('droplet2', 'cyclesd');
setSpriteShader('sinkgoop', 'cyclesd');
setSpriteShader('topgoop', 'cyclesd');
setSpriteShader('secondtopgoop', 'cyclesd');
setShaderFloat('droplet', 'pixel', 10)
setShaderFloat('droplet2', 'pixel', 10)
setShaderFloat('sinkgoop', 'pixel', 10)
setShaderFloat('topgoop', 'pixel', 10)
setShaderFloat('secondtopgoop', 'pixel', 10)
end

function moveCamera(focus)
	if focus == 'boyfriend' then
            setProperty('defaultCamZoom',0.9);
	elseif focus == 'dad' then
            setProperty('defaultCamZoom',1.2);
	end
end

function onBeatHit()
if curBeat <5 then
doTweenAlpha('blackOtherFirst','blackOther',0,8,'linear')
triggerEvent('Set Cam Zoom','1.1','8')
setProperty('gf.visible',false)
triggerEvent('VisibleIcon','no','yes')
end

if curBeat == 64 then
doTweenY('1Y','cinematicBorder1',-90,0.8,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize+ 90 ,0.8,'linear')
end

if curBeat == 128 then
doTweenY('1Y','cinematicBorder1',0,0.7,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize ,0.7,'linear')
triggerEvent('Apple Filter','off','')
makeLuaSprite("white",'', 0, 0);
makeGraphic("white",2737,1409,'FFFFFF')
setObjectCamera("white", 'camGame')
addLuaSprite('white')
cameraFlash('camGame','ffffff',1)

setProperty('boyfriend.color',getColorFromHex('000000'))
setProperty('dad.color',getColorFromHex('000000'))

end

if curBeat == 252 then
doTweenY('1Y','cinematicBorder1',-90,0.7,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize+ 90 ,0.7,'linear')


end

if curBeat == 256 then
setProperty('boyfriend.color',getColorFromHex('ffffff'))
setProperty('dad.color',getColorFromHex('ffffff'))
triggerEvent('Apple Filter','on','')
setProperty('white.visible',false)
setProperty('blackOther.alpha',1)
doTweenAlpha('BlackOther','blackOther',0,5,'linear')
doTweenY('1Y','cinematicBorder1',0,3.5,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize ,3.5,'linear')
end

if curBeat == 272 then
doTweenY('1Y','cinematicBorder1',-90,0.7,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize+ 90 ,0.7,'linear')
end

if curBeat == 319 then
doTweenY('1Y','cinematicBorder1',0,0.5,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize ,0.5,'linear')
lauge = true
runTimer('endLauge',2)
end

if curBeat == 359 then
setCamZoom = false
end

if curBeat == 388 then
triggerEvent('Apple Filter','off','')
setProperty('camGame.visible',false)
setProperty('white.visible',true)
setProperty('boyfriend.color',getColorFromHex('000000'))
setProperty('dad.color',getColorFromHex('000000'))
setProperty('gf.color',getColorFromHex('000000'))
setProperty('boyfriend.alpha',0.3)
setProperty('gf.visible',true)
setCamZoom = true
triggerEvent('VisibleIcon','yes','yes')
end
if curBeat == 392 then
setProperty('camGame.visible',true)
end

if curBeat == 456 then
cameraFlash('camGame','ffffff',1)
setProperty('white.visible',false)
triggerEvent('Apple Filter','on','')
setProperty('boyfriend.color',getColorFromHex('ffffff'))
setProperty('dad.color',getColorFromHex('ffffff'))
setProperty('gf.color',getColorFromHex('ffffff'))
end

if curBeat == 520 then
cameraFlash('camGame','ffffff',1)
triggerEvent('Apple Filter','off','')
setProperty('white.visible',true)
setProperty('dad.color',getColorFromHex('000000'))
setProperty('gf.color',getColorFromHex('000000'))
setProperty('boyfriend.alpha',0)
doTweenY('1Y','cinematicBorder1',0,1.5,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize ,1.5,'linear')
end

if curBeat == 536 then
cameraFlash('camGame','ffffff',1)
triggerEvent('Apple Filter','off','')
setProperty('white.visible',false)
setProperty('dad.color',getColorFromHex('ffffff'))
setProperty('gf.color',getColorFromHex('ffffff'))
doTweenY('1Y','cinematicBorder1',-90,0.5,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize+ 90 ,0.5,'linear')
end

if curBeat == 600 then
setProperty('camGame.alpha',0)
doTweenAlpha('camGame','camGame',1,5,'linear')
triggerEvent('Set Cam Zoom','1.8','0.1')
triggerEvent('Set Cam Zoom','0.8','5')
end
end


function onTweenCompleted(tag)
if tag =='blackOtherFirst' then
setCamZoom = true
end
end

function onTimerCompleted(tag)
if tag == 'endLauge' then
lauge =false
end

if tag =='resetCam' then
setProperty('cameraSpeed',1)
end
end

function onSongStart()
doTweenY('1Y','cinematicBorder1',0,3.5,'linear')
doTweenY('2Y','cinematicBorder2',screenHeight - bordersSize ,3.5,'linear')
end

function onEvent(event, value1, value2)
     if event == 'Apple Filter' then
             if value1 == 'off' then
                setProperty('wall.alpha', 0.0001)
                setProperty('vignette2.alpha', 0.0001)
                setProperty('vignette.alpha', 0.0001)
                setProperty('light.alpha', 0.0001)
                setProperty('secondtopgoop.alpha',0.0001)
                setProperty('topgoop.alpha',0.0001)
                setProperty('penny.alpha',0.0001)
                runHaxeCode([[
            var chromToggle = game.createRuntimeShader('ChromaticAbberationHUD');
            var shaderVcr= game.createRuntimeShader('glitchChromatic');
            var bloom2= game.createRuntimeShader('glowy');
            
            game.camGame.setFilters([new ShaderFilter(shaderVcr),new ShaderFilter(chromToggle),new ShaderFilter(bloom2)]);
            game.getLuaObject('chromToggle').shader = chromToggle;
            game.getLuaObject("temporaryShader1").shader = shaderVcr;
            game.getLuaObject("bloom").shader = bloom2;
                
        ]]
    )
             elseif value1 == 'on' then
                setProperty('secondtopgoop.alpha',1)
                setProperty('topgoop.alpha',1)
                setProperty('wall.alpha', 1)
                setProperty('vignette2.alpha', 1)
                setProperty('vignette.alpha', 1)
                setProperty('light.alpha', 1)
                setProperty('penny.alpha',1)
                runHaxeCode([[
            var chromToggle = game.createRuntimeShader('ChromaticAbberationHUD');
            var shaderVcr= game.createRuntimeShader('glitchChromatic');
            
            game.camGame.setFilters([new ShaderFilter(shaderVcr),new ShaderFilter(chromToggle)]);
            game.camHUD.setFilters([new ShaderFilter(shaderVcr),new ShaderFilter(chromToggle)]);
            game.getLuaObject('chromToggle').shader = chromToggle;
            game.getLuaObject("temporaryShader1").shader = shaderVcr;
                
        ]]
    )
            end
        end
    end
    
    function onStepHit()
        if curStep == 2144 then
            followchars = false
            triggerEvent('VisibleIcon','yes','no')
            oldMemori =true
                setProperty('wall.visible', false)
                setProperty('vignette2.visible',false)
                setProperty('vignette.visible',false)
                setProperty('background.visible', false)
                setProperty('light.visible',false)
                setProperty('ch1.alpha',1)
                setProperty('gf.y', 720)
                setProperty('boyfriend.alpha',0)
                chanel = 1
            end
            
        if curStep == 2176 then
                setProperty('ch1.visible', false)
                setProperty('ch2.alpha',1)
                chanel = 2
                end
                
        if curStep == 2208 then
            
                setProperty('ch2.visible',false)
                setProperty('ch3.alpha',1)
                chanel = 3
            end
            
        if curStep == 2272 then
            
                setProperty('ch3.visible',false)
                setProperty('ch1.visible', true)
                chanel = 1
            end
        if curStep == 2304 then
            
                setProperty('ch1.visible',false)
                setProperty('ch2.visible', true)
                chanel = 2
            end
            
        if curStep == 2336 then
            
                setProperty('ch2.visible',false)
                setProperty('ch3.visible', true)
                chanel = 3
            end
            
        if curStep == 2400 then
            
                setProperty('ch3.visible', false)
                setProperty('ch1.visible',true)
                chanel = 1
            end
            
        if curStep == 2432 then
            
                setProperty('ch1.visible',false)
                setProperty('ch2.visible', true)
                chanel = 2
            end
            
        if curStep == 2464 then
           
                setProperty('ch2.visible',false)
               setProperty('ch3.visible',true)
               chanel = 3
            end
            
        if curStep == 2528 then
            
                setProperty('ch3.visible',false)
                setProperty('ch1.visible', true)
                chanel = 1
            end
            
        if curStep == 2560 then
            
                setProperty('ch1.visible', false)
                setProperty('ch2.visible', true)
                chanel = 2
            end
            
        if curStep == 2592 then
            
                setProperty('ch2.visible',false)
                setProperty('ch3.visible',true)
                chanel = 3
            end
            
        if curStep == 2604 then
            
                setProperty('ch3.visible',false)
                setProperty('ch1.visible', true)
                chanel = 1
            end
            
        if curStep == 2624 then
            
                setProperty('ch1.visible', false)
                setProperty('ch2.visible', true)
                chanel = 2
            end
            
        if curStep == 2632 then
            
                setProperty('ch2.visible', false)
                setProperty('ch3.visible', true)
                chanel = 3
            end
            
        if curStep == 2640 then
           
                setProperty('ch3.visible', false)
                setProperty('ch1.visible', true)
                chanel = 1
            end
            
        if curStep == 2648 then
            
                setProperty('ch1.visible', false)
                setProperty('ch2.visible', true)
                chanel = 2
            end
            
        if curStep == 2656 then                
                xx2=1450
                yy2=750
                goToEnd = true    
                setProperty('ch2.visible', false)
                setProperty('ch3.visible', true)
                chanel = 3
            end
            
        if curStep == 2688 then
            ending = true
           goToEnd = false
          xx = 1100
          yy = 1000
          xx2=1550
          yy2=990
          camZoom = 0.7
          camZoom2 = 0.7
          followchars = true              
          setCamZoom = true
          triggerEvent('VisibleIcon','yes','yes')
                setProperty('void.alpha',1);
                setProperty('rock4.alpha',1);
                setProperty('rock3.alpha',1);
                setProperty('rock2.alpha',1);
                setProperty('house.alpha',1);
                setProperty('rock.alpha',1);
                setProperty('wtf.alpha',1);
                setProperty('glitch.alpha',1);
                setProperty('gf.x', 1670)
                setProperty('gf.y', 900)
                setProperty('boyfriend.x', 1800)
                setProperty('boyfriend.y', 950)
                setProperty('boyfriend.alpha',1)
                chanel = 4
                setProperty('blackGame.alpha',0.2)
            end
            
    end
    
    function onUpdatePost(elapsed)
if curStep >= 0 and curStep < 999999999999 then
        setProperty('house.angle',4 * math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / 2500 ))
        setProperty('wtf.angle',3.5 * math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / 3000))
        setProperty('rock2.angle',2 * math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / 2500 ))
  setProperty('rock3.angle',360 * math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / 25000 ))
  setProperty('rock4.angle',360 * math.sin(getPropertyFromClass('backend.Conductor', 'songPosition') / 30000 ))
  end
  if curStep == 99999999999999999 then
        setProperty('house.angle',0)
        setProperty('wtf.angle',0)
  setProperty('rock3.angle',0)
  setProperty('rock2.angle',0)
  setProperty('rock4.angle',0)
    end
end

function onUpdate()
        if getProperty('dad.curCharacter') == 'gumball' and not ending then
                    setProperty('dad.x',250)
                    setProperty('dad.y',450)
        else
                setProperty('dad.x',300)
                    setProperty('dad.y',550)
              end
              
              if followchars == true then
        if mustHitSection == false then
        if bfTurn == false then
          tam = 'dad'
          moveCamera(tam)
          bfTurn = true
          end
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
            if bfTurn == false then
          tam = 'boyfriend'
          moveCamera(tam)
          bfTurn = false
          end
--BOYFRIEND CAM
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
--DRAWIN CAM
            if getProperty('gf.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs-ofsGF,yy2)
            end
            if getProperty('gf.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs-ofsGF,yy2)
            end
            if getProperty('gf.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2-ofsGF,yy2-ofs)
            end
            if getProperty('gf.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2-ofsGF,yy2+ofs)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    
    if lauge then
    triggerEvent('Camera Follow Pos',xx,yy)
    end
    
    if ending then
    setProperty('dad.x', 900)
    setProperty('dad.y', 740)
                end
                
    if oldMemori and not ending and not goToEnd then
    setProperty('defaultCamZoom',0.8)
              triggerEvent('Camera Follow Pos', '900', '720');
              elseif goToEnd then
              triggerEvent('Camera Follow Pos', '1400', '720');
              end
              
              if chanel == 4 then
              setTextString('chanelNumber','AV')              
              elseif chanel == 1  then
              setTextString('chanelNumber','CH 06')     
              if (curBeat <=599 or curBeat >= 615) then         
              setProperty('defaultCamZoom',0.8)
              runTimer('ressetCam',0.05)
              end
              elseif chanel == 2 then
              setTextString('chanelNumber','CH 02')
              if (curBeat <=599 or curBeat >= 615) then
              setProperty('defaultCamZoom',1)
              runTimer('ressetCam',0.05)
              end
              elseif chanel == 3 then
              setTextString('chanelNumber','CH 03')    
              if (curBeat <=599 or curBeat >= 615) then     
              setProperty('defaultCamZoom',0.8)
              runTimer('ressetCam',0.05)
              end
              end
end
