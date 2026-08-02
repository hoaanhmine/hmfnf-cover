function onEvent(name, value1, value2)
    if name == 'Change HUD Alpha' then
        paramsA1 = split(value1,',')[1];
        paramsA2 = tonumber(split(value1,',')[2]);
        if paramsA1 == 'false' then
            for i = 0,7 do
                cancelTween('strums'..i);
                setProperty('strumLineNotes.members['..i..'].alpha', paramsA2);
            end
            setProperty('uiGroup.alpha', paramsA2);
        else
            paramsA5 = split(value2,',')[1];
            if paramsA5 == 'linear' then
                paramsA4 = '';
            else
                paramsA4 = split(value2,',')[2];
            end
            paramsA3 = tonumber(split(value1,',')[3]);
            for i = 0,7 do
            doTweenAlpha('strums'..i, 'strumLineNotes.members['..i..']', paramsA2, ((crochet / 4) / 1000) * paramsA3, paramsA5..paramsA4);
        end
            doTweenAlpha('uiGroup', 'uiGroup', paramsA2, ((crochet / 4) / 1000) * paramsA3, paramsA5..paramsA4);
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