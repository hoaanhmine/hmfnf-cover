anim = false
local followchars = true
xx = 1420
yy = 1000
xx2 = 1640
yy2 = 1420
ofs = 30
camZoomLock = false
shit = {}
function onCreatePost()
    --for i =0,3 do
    --    setObjectCamera('opponentStrums.members['..i..']','camGame');
        --setScrollFactor('opponentStrums.members['..i..'].scrollFactor.y',1);
    --end

    makeAnimatedLuaSprite('anim1','characters/Anim1',getProperty('dad.x'),getProperty('dad.y'))
    addAnimationByPrefix('anim1','idle','HSLookalikeDialogue',30,false)
    scaleObject('anim1',2.41,2.41)
    setProperty('anim1.offset.x',-190)
    setProperty('anim1.offset.y',-95)
    setProperty('anim1.visible',false)
    setObjectOrder('anim1',getObjectOrder('dad'))
    addLuaSprite('anim1')

    makeAnimatedLuaSprite('anim2','characters/Anim2',getProperty('dad.x'),getProperty('dad.y'))
    addAnimationByPrefix('anim2','idle','HSLookalikeDialogue',30,false)
    scaleObject('anim2',2.41,2.41)
    setProperty('anim2.offset.x',-190)
    setProperty('anim2.offset.y',-95)
    setProperty('anim2.visible',false)
    setObjectOrder('anim2',getObjectOrder('dad'))
    addLuaSprite('anim2')

    makeLuaText('lyrics','',1280,0,0)
    --setTxtFormat('lyrics',"Times New Roman.ttf", 48, 'cfa92d', 'CENTER', '000000',2, 'camHUD', 'X');
    setTextFont('lyrics',"Times New Roman.ttf")
    setTextSize('lyrics',48)
    setTextColor('lyrics','cfa92d')
    setTextAlignment('lyrics','CENTER')
    setTextBorder('lyrics',2,"000000")
    setObjectCamera('lyrics',"camHUD")
    screenCenter('lyrics',"X")
    setProperty('lyrics.y',screenHeight - getProperty('lyrics.height'));
    addLuaText('lyrics');

    makeLuaText('vietsub','',1280,0,0)
    --setTxtFormat('vietsub',"Times New Roman.ttf", 48, 'cfa92d', 'CENTER', '000000',2, 'camHUD', 'X');
    setTextFont('vietsub',"Times New Roman.ttf")
    setTextSize('vietsub',48)
    setTextColor('vietsub','cfa92d')
    setTextAlignment('vietsub','CENTER')
    setTextBorder('vietsub',2,"000000")
    setObjectCamera('vietsub',"camHUD")
    screenCenter('vietsub',"X")
    setProperty('vietsub.y', getProperty('lyrics.height')/2);
    addLuaText('vietsub');

end

function setTxtFormat(tag, font, size, color, alignment, borderColor, borderColorSize, camObject, screenCenter)
    
end

function onEvent(eventName, value1, value2)
    if eventName == '' then
        if (value1 == 'zoomin') then
            setProperty('defaultCamZoom',getProperty('defaultCamZoom') + value2/5)
        end
        if (value1 == 'hurt') then
            if (getProperty('health') > 0.5) then
                setProperty('health',getProperty('health')-0.05);
            end
        end
        if value1 == 'setZoom' then
            camZoomLock = true;
            triggerEvent('Add Camera Zoom','','');
            setProperty('defaultCamZoom',value2)
            runHaxeCode([[
                FlxG.camera.zoom = ]]..value2..[[
                ]])
        end
        if (value1 == 'removeLock') then
            camZoomLock = false;
        end
    end

    if (eventName == "ill make") then
            if value1 == 'hud in' then 
                for i = 4,7 do               
                    noteTweenAlpha('note'..i,i,1,1.5,'quadOut')
                end
            end


            if value1 == 'anim' then
                setProperty('vocals.volume', 1);
                setProperty('dad.visible', false);
                setProperty('anim1.visible',true)
                playAnim('anim1','idle',false)
                anim = true
            end

            if value1 == 'black' then
                doTweenAlpha('blackScreenAlpha','blackScreen',1, 1.125,'quadOut');
                runHaxeCode([[
                FlxTween.num(0.6, 1.125, 0.75, {ease: FlxEase.backIn, onUpdate: (s)->{
                    game.defaultCamZoom = s.value;
                    }
                });
                    ]])
            end

            if value1 == 'pre' then
                shit = {"scoreTxt", "timeBar","timeTxt","bar"}
                for s = 1,#shit do
                    doTweenAlpha(shit[s]..'Alpha',shit[s], 0, 2, "quadIn");
                    --FlxTween.num(0, 1, 2, thenease: FlxEase.quadIn, onUpdate: function(shit2:FlxTween)then
                        --modManager.setValue("alpha", shit2.value, 0);
                    --}, onComplete: Void->modManager.setValue("alpha", 1, 0)});
                end

                for i = 4,7 do
                    noteTweenAlpha(i..'Alpha',i, 0, 2, "quadIn");
                end
        
                camZoomLock = true;
                setProperty('defaultCamZoom', 0.5);
            end
                
                
            if value1 == 'die' then
                setProperty('blackScreen.alpha',1);
                runTimer('end',1)
            end

            if value1 == 'txt' then
                setTextString('lyrics',value2);
                screenCenter('lyrics', 'X');

                if value2 == "I'LL MAKE" then
                    setTextString('vietsub','TAO SẼ')
                elseif value2 == "YOU SAY" then
                    setTextString('vietsub','LÀM MÀY NÓI')
                elseif value2 == "HOW PROUD" then
                    setTextString('vietsub','RẰNG TAO')
                elseif value2 == "YOU" then
                    setTextString('vietsub','RẤT')
                elseif value2 == "YOU ARE" then
                    setTextString('vietsub','RẤT ĐÁNG')
                elseif value2 == "YOU ARE OF" then
                    setTextString('vietsub','RẤT ĐÁNG TỰ')
                elseif value2 == "YOU ARE OF ME" then
                    setTextString('vietsub','RẤT ĐÁNG TỰ HÀO')
                elseif value2 == "SO STAY" then
                    setTextString('vietsub','NÊN HÃY')
                elseif value2 == "AWAKE" then
                    setTextString('vietsub','TỈNH TÁO')
                elseif value2 == "JUST" then
                    setTextString('vietsub','THẬT')
                elseif value2 == "LONG" then
                    setTextString('vietsub','LÂU')
                elseif value2 == "ENOUGH TO SEE" then
                    setTextString('vietsub','ĐỂ THẤY CON ĐƯỜNG')
                elseif value2 == "MY" then
                    setTextString('vietsub','CỦA')  
                elseif value2 == "MY WAY" then
                    setTextString('vietsub','CỦA TAO') 
                elseif value2 == "" then
                    setTextString('vietsub','') 
                end
            end

            if value1 == 'break mirror' then
                setProperty('whiteMirror.alpha',1)
                doTweenAlpha('whiteMirrorAlpha','whiteMirror',0,1.75,'quadOut')
                setProperty('mirrorBroken.visible',true)
                
                cameraShake('camHUD',0.01, 0.25);
                cameraShake('camGame',0.01, 0.25);
                playSound('mirror_break',1);
                
            end

            if value1 == 'vid' then
                camZoomLock = false
            end
        
    end

    if eventName == 'Change Character' then
        if value1 == 'dad' then
            if value2 == 'bf-lookalike' then
                yy = 1220
            end

            if value2 == 'evilLookaLike' then
                yy = 1000
            end
        end
    end
end

function onUpdate()
    if getProperty('anim1.animation.curAnim.name') == 'idle' and getProperty('anim1.animation.curAnim.finished') == true and anim == true then
        playAnim('anim2','idle',false)
        setProperty('anim2.visible',true)
        setProperty('anim1.visible',false)
    end

    if followchars == true then
        if mustHitSection == false then
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
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN-alt' then
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
    setProperty('isCameraOnForcedPos',false)
end

function onMoveCamera(turn)
    if turn == 'dad' and camZoomLock == false then
        setProperty('defaultCamZoom',0.6)
    elseif turn == 'boyfriend' and camZoomLock == false then
        setProperty('defaultCamZoom',0.5)
    end
    --debugPrint(turn)
end

function onTimerCompleted(tag)
    if tag == 'end' then
        --doTweenAlpha('blackOtherAlpha','blackOther',1,2,'quadOut')
        for i =4,7 do
            noteTweenAlpha('note'..i,i,0,4,'quadIn')
        end
    end
end