function onEvent(name, value1, value2)
    if name == 'New Change HUD Alpha' then
        paramsNA1 = split(value1,',')[1];
        paramsNA2 = tonumber(split(value1,',')[2]);
        duration = ((crochet / 4) / 1000) * tonumber(split(value1,',')[3]);
        paramsNA4 = split(value2,',')[1];
            if paramsNA4 == 'linear' then
                paramsNA5 = '';
            else
                paramsNA5 = split(value2,',')[2];
            end
        if paramsNA1 == 'false' then
            for i = 0,7 do
                cancelTween('strums'..i);
                setProperty('strumLineNotes.members['..i..'].alpha', paramsNA2);
            end
            setProperty('uiGroup.alpha', paramsNA2);
        else
            for i = 0,7 do
            doTweenAlpha('strums'..i, 'strumLineNotes.members['..i..']', paramsNA2, duration, paramsNA4..paramsNA5);
        end
            doTweenAlpha('uiGroup', 'uiGroup', paramsNA2, duration, paramsNA4..paramsNA5);
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