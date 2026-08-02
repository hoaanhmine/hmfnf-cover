function onCreate()
if songName == 'Suffering Siblings' then
local xx = 2200
local yy = 1300
local xx2=2150
local yy2=1200
local ofs =20
local Angle = 2
local timeAngle =0.5
end

end

function opponentNoteHit(id,dir,type,sus)
cam = dir
runTimer('Back',0.5)
end

function goodNoteHit(id,dir,type,sus)
cam = dir
runTimer('Back',0.5)
end

function onTimerCompleted(tag)
if tag == 'Back' then
cam = 4
end
end

function onMoveCamera(focus)
    if focus == 'boyfriend' then
    opponent = false
    elseif focus == 'dad' then
    opponent = true
    end
end

function onUpdate()
        if opponent == false then
            setProperty('defaultCamZoom',getProperty('defaultCamZoom'))
            if cam == 0 then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
                doTweenAngle('camGameAngle','camGame',Angle,timeAngle,'linear')
            end
            if cam == 3 then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
                doTweenAngle('camGameAngle','camGame',-Angle,timeAngle,'linear')
            end
            if cam == 2 then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
                doTweenAngle('camGameAngle','camGame',0,timeAngle,'linear')
            end
            if cam == 1 then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
                doTweenAngle('camGameAngle','camGame',0,timeAngle,'linear')
            end
            if cam == 4 then
                triggerEvent('Camera Follow Pos',xx2,yy2)
                doTweenAngle('camGameAngle','camGame',0,timeAngle,'linear')
            end
        else

            setProperty('defaultCamZoom',getProperty('defaultCamZoom'))
            if cam == 0 then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
                doTweenAngle('camGameAngle','camGame',Angle,timeAngle,'linear')
            end
            if cam == 3 then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
                doTweenAngle('camGameAngle','camGame',-Angle,timeAngle,'linear')
            end
            if cam == 2 then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
                doTweenAngle('camGameAngle','camGame',0,timeAngle,'linear')
            end
            if cam == 1 then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
                doTweenAngle('camGameAngle','camGame',0,timeAngle,'linear')
            end
            if cam == 4 then
                triggerEvent('Camera Follow Pos',xx,yy)
                doTweenAngle('camGameAngle','camGame',0,timeAngle,'linear')
            end
        end
end

