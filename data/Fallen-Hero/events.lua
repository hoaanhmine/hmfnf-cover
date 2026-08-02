bordersSize = 90
chatSize = 80
local angleshit = 1.5;
local anglevar = 1.5;

function onCreatePost()

end

function onEvent(name,value1,value2)
    if name == 'chat' then
        --if string.lower(value1) == 'a8a0b3' then
            cancelTween('Chat Text Alpha')
            screenCenter('Chat Text','XY')
            chatSize = 100
            setProperty('Chat Text.alpha',1)
            doTweenAlpha('Chat Text Alpha','Chat Text',0,0.25,'cubeIn')
        --end
    end
end


function onBeatHit()
    if curBeat == 284 then 
        enable = true
    elseif curBeat == 412 then
        enable = false
        setProperty('camHUD.angle',0)
        doTweenAngle('turn', 'camHUD', 0, stepCrochet*0.008, 'circOut')
        doTweenX('tuin', 'camHUD', 0, crochet*0.004, 'linear')
    end

    if curBeat > 1 and enable then
        if curBeat % 4 == 2 then
            angleshit = anglevar;
            setProperty('camHUD.angle',angleshit*3)
            doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.008, 'circOut')
            doTweenX('tuin', 'camHUD', -angleshit*8, crochet*0.004, 'linear')
            triggerEvent('Add Camera Zoom','0.03','0.06')
        elseif curBeat % 4 == 0 then
            angleshit = -anglevar;
            setProperty('camHUD.angle',angleshit*3)
            doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.008, 'circOut')
            doTweenX('tuin', 'camHUD', -angleshit*8, crochet*0.004, 'linear')
            triggerEvent('Add Camera Zoom','0.03','0.06')
        end
    end
end

function onUpdate(elapsed)
    chatSize = math.lerp(chatSize, 80, boundTo(elapsed * 7, 0, 1));
    setTextSize('Chat Text',chatSize)
    --debugPrint(chatSize)
end

function boundTo(value,min,max)
    return math.max(min,math.min(max,value))
end

function math.lerp(from,to,i)
    return from+(to-from)*i
end