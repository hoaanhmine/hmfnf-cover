offsetX = 0;
offset = 20;
function opponentNoteHit(id,data,type,sus)
    if mustHitSection == false then
        if data == 0 then
            offsetX = -offset;
        end

        if data == 1 then
            offsetX = 0;
        end

        if data == 2 then
            offsetX = 0;
        end
        
        if data == 3 then
            offsetX = offset;
        end
        --runTimer('back',0.3 * getProperty('playbackRate') * (getPropertyFromClass('backend.Conductor', 'bpm')/ 180))
    end
end


function goodNoteHit(id,data,type,sus)
    if mustHitSection == true then
        if data == 0 then
            offsetX = -offset;
        end

        if data == 1 then
            offsetX = 0;
        end

        if data == 2 then
            offsetX = 0;
        end

        if data == 3 then
            offsetX = offset;
        end
        --runTimer('back',1 * getProperty('playbackRate') * (getPropertyFromClass('backend.Conductor', 'bpm')/ 180))
    end
end
el = 0
speed = 0

function onUpdate(elapsed)
    speed = getPropertyFromClass('backend.Conductor','bpm')/120;
    el = elapsed
    runHaxeCode([[
    var angleLerp = FlxMath.bound(FlxMath.bound(]]..el..[[ * 2.4 / 0.4, 0, 1) * ]]..speed..[[ * cameraSpeed * playbackRate,0,1);
    game.camGame.angle = FlxMath.lerp(game.camGame.angle,0 + ]]..offsetX..[[ / 30, angleLerp);
    ]])
end

--function onTimerCompleted(tag)
  --  if tag == 'back' then
    --    offsetX = 0
  --  end
--end
