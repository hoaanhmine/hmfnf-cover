local xx = 700
local yy = 650
local xx2=1400
local yy2=680
local camZoom =1.15
local camZoom2 =1.05
local Angle = 2
local timeAngle =0.5
ofs =20
local bordersSize = 90
local followchars = false
bfTurn = false
function onCreatePost()
runTimer('fix',2.8)
	initLuaShader('glowy')
setSpriteShader('bloom', 'glowy')   

	makeLuaSprite('background', 'images/schoolMAW/Ilustracion_sin_titulo-1', 100, 0)
	scaleObject('background', 1.3, 1.3)
	setScrollFactor('background', 0.85, 1)
	addLuaSprite('background')
	
	makeLuaSprite('wall', 'images/schoolMAW/Ilustracion_sin_titulo-2', -200, 200)
	scaleObject('wall', 1.1, 1.1)
	setScrollFactor('wall', 1, 1)
	addLuaSprite('wall', true)
	
	
	makeLuaSprite('light', 'images/schoolMAW/light', -400, 50)
	scaleObject('light', 1, 1)
	setScrollFactor('light', 1, 1)
	addLuaSprite('light', true)
	
	makeLuaSprite('vignette', 'images/schoolMAW/Ilustracion_sin_titulo-3', -400, 0)
	scaleObject('vignette', 1.8, 1.3)
	setScrollFactor('vignette', 1, 1)
	addLuaSprite('vignette', true)
	
	makeLuaSprite('vignette2', 'images/schoolMAW/188_sin_titulo11_20230523094718', -400, 0)
	scaleObject('vignette2', 1.8, 1.3)
	setScrollFactor('vignette2', 1, 1)
	addLuaSprite('vignette2', true)
	
	makeAnimatedLuaSprite('topgoop', 'school/topgoop', 0, 100);
   addAnimationByPrefix('topgoop','idle','gooey0',24, true);
   scaleObject('topgoop', 1, 1);
   setProperty('topgoop.alpha', 0)
   addLuaSprite('topgoop', true);
   
   makeAnimatedLuaSprite('secondtopgoop', 'school/secondtopgoop', 1500, -100);
   addAnimationByPrefix('secondtopgoop','idle','gooey0',24, true);
   scaleObject('secondtopgoop', 1.7, 1.7);
   setScrollFactor('secondtopgoop', 0.685, 1);
   setProperty('secondtopgoop.alpha', 0)
   addLuaSprite('secondtopgoop', true);
   
   makeAnimatedLuaSprite('sinkgoop', 'school/sinkgoop', 686, 505);
   addAnimationByPrefix('sinkgoop','idle','gooey0',24, true);
   setScrollFactor('sinkgoop', 0.85, 1);
   setProperty('sinkgoop.alpha', 0)
   scaleObject('sinkgoop', 2.0, 2.0);
   addLuaSprite('sinkgoop', false);

   makeAnimatedLuaSprite('droplet2', 'school/droplet2', 400, 760);
   addAnimationByPrefix('droplet2','idle','gooey0',24, true);
   setScrollFactor('droplet2', 0.85, 1);
   setProperty('droplet2.alpha', 0)
   scaleObject('droplet2', 2.0, 2.0);
   addLuaSprite('droplet2', false);

   makeAnimatedLuaSprite('droplet', 'school/droplet', 870, 250);
   addAnimationByPrefix('droplet','idle','gooey0',24, true);
   setScrollFactor('droplet', 0.85, 1);
   setProperty('droplet.alpha', 0)
   scaleObject('droplet', 2.0, 2.0);
   addLuaSprite('droplet', false);
   
   makeAnimatedLuaSprite('penny', 'images/schoolMAW/penny', 700, 120);
   addAnimationByPrefix('penny','idle','idle',10, true);
   scaleObject('penny', 1.3, 1.3);
   setProperty('penny.alpha', 0)
   setScrollFactor('penny', 0.85, 1);
   addLuaSprite('penny');
   
	makeLuaSprite('blackOther',nil, 0, 0);
makeGraphic('blackOther',1280,720,'000000')
setProperty('blackOther.alpha',0)
setObjectCamera('blackOther', 'other')
addLuaSprite('blackOther')

makeLuaSprite('LightsOut', 'images/school/Darkness', -250, -300)
	scaleObject('LightsOut', 2, 2)
	setProperty('LightsOut.alpha', 0)
	addLuaSprite('LightsOut', true)
	
makeLuaSprite("blackGame",'', 0, 0);
makeGraphic("blackGame",3213,1660,'000000')
setProperty('blackGame.alpha',0)
setObjectCamera("blackGame", 'camGame')
addLuaSprite('blackGame')
makeLuaSprite('cinematicBorder1',nil,0,-90)
        makeLuaSprite('cinematicBorder2',nil,0,screenHeight - bordersSize + 90)
        for borders = 1,2 do
            makeGraphic('cinematicBorder'..borders,screenWidth+2,bordersSize,'000000')
            setObjectCamera('cinematicBorder'..borders,'camHUD')
            addLuaSprite('cinematicBorder'..borders,false)
            end
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

function onTweenCompleted(tag)

end

function onTimerCompleted(tag)

end

function onSongStart()
    tam = 'dad'
    moveCamera(tam)
    followchars = true
end
function onUpdate()
        if getProperty('dad.curCharacter') == 'gumball' then
                    setProperty('dad.x',250)
                    setProperty('dad.y',450)
        else
                setProperty('dad.x',300)
                    setProperty('dad.y',550)
              end
              
              if followchars == true then
        if mustHitSection == false then
          --  setProperty('defaultCamZoom',camZoom)
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
if bfTurn == true then
          tam = 'boyfriend'
          moveCamera(tam)
          bfTurn = false
          end
           -- setProperty('defaultCamZoom',camZoom2)
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
