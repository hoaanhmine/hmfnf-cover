local liveBars = true;
function onCreate()
    makeLuaSprite('barUp', nil, -500, 0);
    makeGraphic('barUp', 2280, 2, '000000');
    addLuaSprite('barUp', false);
    setObjectCamera('barUp', 'camHUD');
    setProperty('barUp.y', -10);
    
    makeLuaSprite('barDown', nil, -500, 0);
    makeGraphic('barDown', 2280, 2, '000000');
    addLuaSprite('barDown', false);
    setObjectCamera('barDown', 'camHUD');
end
function onUpdate()
    if liveBars then
        setProperty('barDown.y', screenHeight - getProperty('barDown.height') + 10);
    end
end
function onEvent(name, value1, value2)
    if name == 'Cinematic Bars' then
        paramsB6 = split(value2,',')[3];
        --setObjectCamera('barUp', paramsB6);
        --setObjectCamera('barDown', paramsB6);
        paramsB1 = split(value1,',')[1];
        paramsB2 = tonumber(split(value1,',')[2]);
        if paramsB1 == 'false' then
            cancelTween('barUpY');
            cancelTween('barDownY');
            setProperty('barUp.scale.y', ((screenHeight / 2) * paramsB2 + 0.1));
            setProperty('barDown.scale.y', ((screenHeight / 2) * paramsB2 + 0.1));
        else
            paramsB4 = split(value2,',')[1];
            paramsB3 = tonumber(split(value1,',')[3]);
            if paramsB4 == 'linear' then
                paramsB5 = '';
            else
                paramsB5 = split(value2,',')[2];
            end
            doTweenY('barUpY', 'barUp.scale', ((screenHeight+20)/2) * paramsB2, ((crochet / 4) / 1000) * paramsB3, paramsB4..paramsB5);
            doTweenY('barDownY', 'barDown.scale', ((screenHeight+20)/2) * paramsB2, ((crochet / 4) / 1000) * paramsB3, paramsB4..paramsB5);
        end
    end
end
function onGameOver()
    liveBars = false;
end
function split (inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end