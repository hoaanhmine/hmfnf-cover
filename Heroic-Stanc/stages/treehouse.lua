local xx = 2390
local yy = 2500
local xx2=3300
local yy2=2600
local camZoom =1.05
local camZoom2 =1.05
local ofs =25
local followchars = true
local loop = 0
local doThunder = false;
function onCreatePost()
addCharacterToList('finnanimstuff', 'dad');
addCharacterToList('bfcawn', 'bf');
initLuaShader('glowy')
initLuaShader('rain')

makeLuaSprite('rainShader')
setSpriteShader('rainShader','rain')

setProperty('healthBar.visible', false);
setProperty('healthBarBG.visible', false);
setProperty('iconP1.alpha', 0);
setProperty('iconP2.alpha', 0);

setTextFont('scoreTxt','thunderman.ttf')
setTextColor('scoreTxt','4b4652')
setProperty('timeBarBG.color',getColorFromHex('a8a0b3'))
setTextFont('timeTxt','thunderman.ttf')
setTextFont('botplayTxt','thunderman.ttf')
setTextColor('botplayTxt','a8a0b3')
  makeLuaSprite('outside', 'images/treehouse/intro/IMG_8337', 1750, 2000);

makeLuaSprite('idkWhatAreThatThings', 'images/treehouse/intro/Ilustracion_sin_titulo-2', 1750, 2000);

makeLuaSprite('coolGradient', 'images/treehouse/intro/Ilustracion_sin_titulo-3', 1750, 2000);


 ---fin2
makeLuaSprite('backGlitch', 'images/treehouse/reveal/BackGlitch', 1650, 2130);
scaleObject('backGlitch',1.05,1.05)
setProperty('backGlitch.alpha',0)

makeLuaSprite('particles', 'images/treehouse/reveal/Particles', 1650, 2130);
scaleObject('particles',1.05,1.05)
setProperty('particles.alpha',0)

makeLuaSprite('aboveGlitch', 'images/treehouse/reveal/AboveGlitch', 1650, 2130);
scaleObject('aboveGlitch',1.05,1.05)
setProperty('aboveGlitch.alpha',0)

makeLuaSprite('hillStuff', 'images/treehouse/reveal/HillStuff', 1650, 2130);
scaleObject('hillStuff',1.05,1.05)
setProperty('hillStuff.alpha',0)
setScrollFactor('hillStuff',0.65, 0.95);

makeLuaSprite('corruption', 'images/treehouse/reveal/Corruption', 1650, 2130);
scaleObject('corruption',1.05,1.05)
setProperty('corruption.alpha',0)

makeLuaSprite('dangling', 'images/treehouse/reveal/Dangling', 1650, 2130);
scaleObject('dangling',1.05,1.05)
setProperty('dangling.alpha',0)

makeLuaSprite("white","white", 0, 0);
setObjectCamera("white", 'other')

makeLuaSprite("black",'', 0, 0);
makeGraphic("black",1280,720,'000000')
setObjectCamera("black", 'other')

makeLuaSprite("cameraShtuff","images/treehouse/reveal/CameraShtuff", -600, -200);
setObjectCamera("cameraShtuff", 'other')
scaleObject('cameraShtuff',1.7,1.7)

makeLuaSprite("vignette","vignette", 20, -25);
setObjectCamera("vignette", 'other')
scaleObject('vignette',1.2,1.2)
doTweenAlpha("vignetteN","vignette", 0, 0.5, true);

--finn3
makeLuaSprite('bg', 'images/treehouse/back', -700, -500);
setScrollFactor('bg',0.7,0.7)
scaleObject('bg',5,5)

makeAnimatedLuaSprite('thunder', 'images/treehouse/Lighting', 1300, 0);
addAnimationByPrefix('thunder', 'idle', 'LIGHTNING', 24, false);
setScrollFactor('thunder',0.65,0.65)
scaleObject('thunder', 0.8,0.8)
setProperty('thunder.visible',false)

makeLuaSprite('treehouse', 'images/treehouse/tree', -2000, -1600);
scaleObject('treehouse', 10, 10);

makeAnimatedLuaSprite('rain','images/treehouse/Rain',600,1200)
scaleObject('rain',7,7)
setProperty('rain.visible',false)
setProperty('rain.alpha',0.6)
addAnimationByPrefix('rain','idle','rain tho',48,true)
addLuaSprite('rain',true)

makeLuaSprite('gradient', 'gradient', -100, -100);
		setProperty('gradient.alpha',0)
		addLuaSprite('gradient', true);
		scaleObject('gradient',0.6,0.6)
		setObjectCamera('gradient', 'other')

        makeLuaSprite('flash', 'images/treehouse/gradient', 0, 0);
		setProperty('flash.alpha',0)
        setProperty('flash.flipY',true)
		addLuaSprite('flash', false);
		scaleObject('lash',0.6,0.6)
		setObjectCamera('flash', 'camHUD')
		
--Fake finn stage
addLuaSprite('outside', false);
addLuaSprite('idkWhatAreThatThings', false);
addLuaSprite('coolGradient', false);
--Finn corruption glitch
addLuaSprite('backGlitch', false);
addLuaSprite('particles', false);
addLuaSprite('aboveGlitch', false);
addLuaSprite('hillStuff', false);
addLuaSprite('corruption', true);
addLuaSprite('dangling', false);
addLuaSprite('cameraShtuff', true);
addLuaSprite("black");
addLuaSprite("white", true);
--Tree House
addLuaSprite('bg', false);
addLuaSprite('thunder', false);
addLuaSprite('treehouse', false);
addLuaSprite('vignette', true);

makeLuaSprite("blackGame",'', 1550, 1500);
makeGraphic("blackGame",4280,4480,'000000')
setProperty('blackGame.alpha',0)
addLuaSprite("blackGame", true)


setProperty('thunder.alpha',0)
setProperty('treehouse.alpha',0)
setProperty('bg.alpha',0)
setProperty('boyfriend.visible',false)

end


function onStepHit()

if curStep <= 6 then
for i =0,7 do
noteTweenAlpha('Note'..i,i,0,0.01)
end
 for t=0,3 do
    setShaderFloat("opponentStrums.members["..t.."]", "AMT", 0.0)
    end
end

if curStep == 10 then
doTweenAlpha('black','black',0,6)
addCharacterToList('finncawm_reveal', 'dad');
addCharacterToList('finn-sword-sha', 'dad');

end

if curStep == 378 then
doTweenAlpha('HUD','camHUD',0,0.45)
triggerEvent('Set Cam Zoom','1.35','0.5')
end

if curStep == 384 then
doTweenAlpha('HUD','camHUD',1,0.25)
triggerEvent('Set Cam Zoom','1.05','0.2')
 for i=0,3 do
    setShaderFloat("opponentStrums.members["..i.."]", "AMT", 0.2)
    end
end

        if curStep == 608 then
        
            triggerEvent('Change Character', 'dad', 'finnanimstuff')
setProperty('dad.specialAnim', true);
characterPlayAnim('dad', 'lesgo', true);
doTweenAlpha('BG0', 'outside', 0, 0.5, 'linear')
doTweenAlpha('BG1', 'idkWhatAreThatThings', 0, 0.5, 'linear')
doTweenAlpha('BG2', 'coolGradient', 0, 0.5, 'linear')

        end
         
         if curStep == 640 then
         runHaxeCode([[
            var chromToggle = game.createRuntimeShader('ChromaticAbberationHUD');
            var shaderVcr= game.createRuntimeShader('glitchChromatic');
            
            game.camGame.setFilters([new ShaderFilter(shaderVcr),new ShaderFilter(chromToggle)]);
            game.camHUD.setFilters([new ShaderFilter(shaderVcr),new ShaderFilter(chromToggle)]);
            game.getLuaObject('chromToggle').shader = chromToggle;
            game.getLuaObject("temporaryShader1").shader = shaderVcr;
                
            return;
        ]]
    )
         triggerEvent('Change Character', 'dad', 'finncawm_reveal')
        doTweenAlpha('BG0', 'backGlitch', 1, 0.3, 'linear')
doTweenAlpha('BG1', 'aboveGlitch', 1, 0.6, 'linear')
doTweenAlpha('BG2', 'hillShit', 1, 0.9, 'linear')
doTweenAlpha('BG3', 'particles', 1, 1.5, 'linear')
doTweenAlpha('BG4', 'dangling', 1, 1.8, 'linear')
doTweenAlpha('BG5', 'corruption', 1, 3, 'linear')
doTweenAlpha('BG6', 'gradient', 0.6, 1.2, 'linear')
end

        if curStep == 896 then
            
            camZoom = 0.35;
            camZoom2 = 0.5
            
            setProperty('backGlitch.alpha',0)
            setProperty('aboveGlitch.alpha',0)
            setProperty('hillShit.alpha',0)
            setProperty('particles.alpha',0)
            setProperty('dangling.alpha',0)
            setProperty('corruption.alpha',0)
            setProperty('bg.alpha',1)
            setProperty('thunder.visible',true)
            setProperty('rain.visible',true)
            setProperty('treehouse.alpha',1)
            
            triggerEvent('Change Character', 'dad', 'finn-sword-sha')
            setProperty('boyfriend.color', getColorFromHex('5253a2'))
            xx = 2480
            yy = 2400
            setProperty('boyfriend.visible',true)
        end
        
        if curStep == 1535 then
        setProperty('boyfriend.visible',false)
            setProperty('outside.alpha',1)
            setProperty('outside2.alpha',1)
            setProperty('coolGradient.alpha',1)
            setProperty('idkWhatAreThatThings.alpha',1)
            triggerEvent('Change Character', 'dad', 'finncawm_start_new')
            setProperty('thunder.visible',false)
            setProperty('rain.visible',false)
            setProperty('treehouse.alpha',0)
            setProperty('bg.alpha', 0)
            doThunder = false;
            camZoom = 1.05;
            camZoom2 = 1.05
            xx = 2390
            yy = 2500
        end
        
        if curStep == 1536 then
            camZoom = 1.15;
            addCharacterToList('finncawn', 'dad');
            end
          
        if curStep == 1648 then
        camZoom = 1;
            camZoom2 = 0.85
            setProperty('outside.alpha',0)
            setProperty('outside2.alpha',0)
            setProperty('coolGradient.alpha', 0)
            setProperty('idkWhatAreThatThings.alpha',0)
            triggerEvent('Change Character', 'dad', 'finncawm_reveal')
           
            setProperty('backGlitch.alpha',1)
            setProperty('aboveGlitch.alpha',1)
            setProperty('hillShit.alpha',1)
            setProperty('particles.alpha',1)
            setProperty('dangling.alpha',1)
            setProperty('corruption.alpha',1)
            
        end
  
        if curStep == 1664 then
           camZoom = 0.35;
            camZoom2 = 0.5
            xx = 2480
            yy = 2400
            setProperty('boyfriend.visible',true)
            triggerEvent('Change Character', 'dad', 'finn-sword-sha')
            setProperty('backGlitch.alpha',0)
            setProperty('aboveGlitch.alpha',0)
            setProperty('hillShit.alpha',0)
            setProperty('particles.alpha',0)
            setProperty('dangling.alpha',0)
            setProperty('corruption.alpha',0)
            setProperty('boyfriend.color', getColorFromHex('5253a2'))
            setProperty('thunder.visible',true)
            setProperty('rain.visible',true)
            setProperty('treehouse.alpha',1)
            setProperty('bg.alpha',1)
            doThunder = true;
        end        
        end
    

function onBeatHit()
    if curBeat % 12 == 0 then
        setProperty('thunder.alpha',1)
        setProperty('thunder.offset.x',math.random(-1000,1000))
        setProperty('thunder.offset.y',math.random(-1000,0))
        setProperty('thunder.flipX',getRandomBool(50))
        playAnim('thunder','idle',false);
        runTimer('thunderEnd',0.5)
        if getProperty('thunder.visible') == true then
            playSound('ray',10)

            scaleObject('flash',308,2.5)
            setProperty('flash.alpha',1)
            setProperty('flash.y',-100)
            doTweenAlpha('fadeOut','flash',0,1.2)
            doTweenY('endFlash','flash.scale',0,1.2,'easyType')
            doTweenY('up','flash',-400,0.8,'easyType')
        end
        
    end
    
    if curBeat == 444 then
    doTweenAlpha('blackEnd','black',1,1.2,'linear')
    for i = 0,7 do
    noteTweenAlpha('Note'..i,i,0,1.2,'linear')
    end
    end
    
  if curBeat == 32 then
  for i =0,3 do
  noteTweenAlpha(i,i,5,0.01)
end
end

  if curBeat == 46 then
  for i =4,7 do
  noteTweenAlpha(i,i,1,0.3)
end
end

if curBeat == 157 then
cameraFlash('camGame','ffffff',0.5)
end

if curBeat ==212 then
doTweenAlpha('blackFirst','blackGame',1,4,'linear')
end

if curBeat == 543 then
for tween =4,7 do
noteTweenAlpha('noteAlpha'..tween,tween,0,0.1,'linear')
end
end

if curBeat == 608 then
setProperty('black.alpha',1)
end
end

function onTweenCompleted(tag)
if tag =='blackFirst' then
cameraFlash('camGame','ffffff',1)
setProperty('blackGame.alpha',0)
end

if tag =='blackEnd' then
cameraFlash('camGame','ffffff',1)
setProperty('rain.visible',false)
setProperty('black.alpha',0)
            setProperty('treehouse.alpha',0)    
            setProperty('bg.alpha',0)
            setProperty('thunder.visible',false)  
doThunder = false
            triggerEvent('Change Character', 'dad', 'finncawn')
triggerEvent('Change Character', 'bf', 'bfcawn')
ending = true
setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
setProperty('boyfriend.x',2700) 
            setProperty('boyfriend.y',1200) 
            setProperty('dad.y',3000) 
            doTweenY('dad','dad',2250,3,'cubeOut')
            setProperty('boyfriend.angle',180)
            doTweenY('bf','boyfriend',1850,3,'cubeOut')
            setProperty('gradient.alpha',0)

            runHaxeCode([[
            var chromToggle = game.createRuntimeShader('ChromaticAbberationHUD');
            var shaderVcr= game.createRuntimeShader('glitchChromatic');
            var bloom2= game.createRuntimeShader('glowy');
            
            game.camGame.setFilters([new ShaderFilter(shaderVcr),new ShaderFilter(chromToggle),new ShaderFilter(bloom2)]);
            game.getLuaObject('chromToggle').shader = chromToggle;
            game.getLuaObject("temporaryShader1").shader = shaderVcr;
            game.getLuaObject("bloom2").shader = bloom2;
                
        ]]
    )
            
            for tween=4,7 do
		--setPropertyFromGroup('playerStrums',tween,'x',getPropertyFromGroup('playerStrums',tween,'x')-700)
		--setPropertyFromGroup('playerStrums',tween,'y',getPropertyFromGroup('playerStrums',tween,'y')-700)
		  noteTweenAlpha('noteAlpha'..tween,tween,1,0.5,'linear')
		if not middlescroll and not downscroll then
		  noteTweenX('noteX'..tween,tween,getPropertyFromGroup('playerStrums',tween-4,'x')-650,4.5,'cubeOut')
end
end
            end
            end
            
            
            function onTimerCompleted(tag)
            if tag=='thunderEnd' then
            doTweenAlpha('thunderAlpha','thunder',0,0.15,'linear')
            end
            end
         
            function onUpdate()
            setTextColor('scoreTxt','4b4652')
            if ending == true then
            triggerEvent('Camera Follow Pos',2600,2200)
            setProperty('defaultCamZoom',0.9)  
            followchars = false
            i = i+ 1
            
            end
           if i == 1 then
            setProperty('dad.y',2400)
            setProperty('boyfriend.y',1200)        
            end

           
if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',camZoom)
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
                doTweenAngle('camGameAngle','camGame',2,0.5,'linear')
                doTweenAngle('backGlitchAngle','backGlitch',-2,0.5,'linear')
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
                doTweenAngle('camGameAngle','camGame',-2,0.5,'linear')
                doTweenAngle('backGlitchAngle','backGlitch',2,0.5,'linear')
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
                doTweenAngle('camGameAngle','camGame',0,0.5,'linear')
                doTweenAngle('backGlitchAngle','backGlitch',0,0.5,'linear')
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
                doTweenAngle('camGameAngle','camGame',0,0.5,'linear')
                doTweenAngle('backGlitchAngle','backGlitch',0,0.5,'linear')
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
                doTweenAngle('camGameAngle','camGame',2,0.5,'linear')
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
                doTweenAngle('camGameAngle','camGame',-2,0.5,'linear')
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
                doTweenAngle('camGameAngle','camGame',0,0.5,'linear')
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
                doTweenAngle('camGameAngle','camGame',0,0.5,'linear')
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
            doTweenAngle('camGameAngle','camGame',0,0.5,'linear')
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
            doTweenAngle('camGameAngle','camGame',0,0.5,'linear')
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

            setProperty('defaultCamZoom',camZoom2)
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
                doTweenAngle('camGameAngle','camGame',1.2,0.5,'linear')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
                doTweenAngle('camGameAngle','camGame',-1.2,0.5,'linear')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
                doTweenAngle('camGameAngle','camGame',0,0.5,'linear')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
                doTweenAngle('camGameAngle','camGame',0,0.5,'linear')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
                doTweenAngle('camGameAngle','camGame',0,0.5,'linear')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
            doTweenAngle('camGameAngle','camGame',0,0.5,'linear')
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
end

function opponentNoteHit(id,data,type,sus)
if type =='GF Sing' then
setProperty('gf.alpha',0.5)
doTweenAlpha('gfAlpha','gf',0,0.5)
end
end

function onUpdatePost()
setTextColor('scoreTxt','4b4652')
if curStep < 384 then
            for t=0,3 do
    setShaderFloat('opponentStrums.members['..t..']', 'binaryIntensity', 1000)
    end
end
end

