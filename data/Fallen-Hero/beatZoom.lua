
function onStepHit() 
    if curStep >= 2160 and curStep % 2 == 0 and curStep <=  2174 then
        triggerEvent('Add Camera Zoom','0.03','0.06')
    end
end

angle = 1

function onBeatHit()
    if (curBeat >= 112 and curBeat <= 174) then
        if curBeat % 2 ~= 0 then
            triggerEvent('Add Camera Zoom', 0.03, 0.06)
        else
            triggerEvent('Add Camera Zoom', -0.03, -0.06)
        end
    end

    if (curBeat >= 174 and curBeat <= 240) or (curBeat >= 348 and curBeat <= 408) or
    (curBeat >= 482 and curBeat <= 544) or (curBeat >= 868 and curBeat <= 900) or 
    (curBeat >= 904 and curBeat <= 1004) then
        if curBeat % 4 == 2 then
            triggerEvent('Add Camera Zoom', 0.03, 0.06)
        elseif curBeat % 4 == 0 then
            triggerEvent('Add Camera Zoom', -0.03, -0.06)
        end
    end

    if (curBeat >= 408 and curBeat <= 472) or (curBeat >= 736 and curBeat <= 860) then
        if curBeat % 2 == 0 then
            triggerEvent('Add Camera Zoom', 0.03, 0.06)
        end
    end

    if curBeat >= 768 and curBeat <= 798 then
        if curBeat % 4 == 2 then
            angle = angle * -1
            cancelTween('camHUDAngle')
            setProperty('camHUD.angle', 15 * angle)
            doTweenAngle('camHUDAngle', 'camHUD', 0, 0.5, 'cubeOut')
        end
    end

    if (curBeat >= 544 and curBeat <= 606) then
        if curBeat % 1 == 0 then
            triggerEvent('Add Camera Zoom', 0.03, 0.06)
        end
    end

    if (curBeat >= 284 and curBeat <= 348) then
        if curBeat % 2 == 0 then
            triggerEvent('Add Camera Zoom', 0, 0.06)
        end
    end
end