local idleSpeed = 1;
local __curMulti = 0;
local __angleMulti = 0;
local timeIdle = 0;
local idleCameraMovement = false;
local liveCameraIdle = true;
function onEvent(name, value1, value2)
    if name == 'Idle Cam Movement' then
        __curMulti = tonumber(value1);
        __angleMulti = tonumber(value2);
        if value1 == '0' and value2 == '0' then
            idleCameraMovement = false;
        else
            idleCameraMovement = true;
        end
    end
end
function onUpdatePost(elapsed)
    if liveCameraIdle then
    if idleCameraMovement then
        timeIdle = timeIdle + elapsed * idleSpeed;
        setProperty('camFollow.x', getProperty('camFollow.x') + math.sin(timeIdle * (30 / __curMulti)) * __curMulti);
        setProperty('camFollow.y', getProperty('camFollow.y') + (math.sin((timeIdle * (30 / __curMulti)) * 2) / 2) * ( __curMulti * 0.6));
    end
    end
end
function onGameOver()
    liveCameraIdle = false;
end