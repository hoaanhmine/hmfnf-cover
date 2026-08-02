function onEvent(name, value1, value2)
    if name == 'Camera Speed' then
        setProperty('cameraSpeed', tonumber(value1) * 20);
        --setProperty('camGame.followLerp', tonumber(value1));
    end
end