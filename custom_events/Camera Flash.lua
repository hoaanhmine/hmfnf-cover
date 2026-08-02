function onEvent(name, value1, value2)
    if name == 'Camera Flash' and songName ~= 'red-demon-o' then
        valueTime = tonumber(split(value2,',')[1]);
        camValue = split(value2,',')[2];
        fade = split(value1,',')[1];
        if fade == 'true' then
            cameraFlash(camValue, '000000', ((crochet / 4) / 1000) * valueTime, true);
        else
            valueColor = split(value1,',')[2];
            cameraFlash(camValue, valueColor, ((crochet / 4) / 1000) * valueTime, true);
        end
    end
end
function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end
