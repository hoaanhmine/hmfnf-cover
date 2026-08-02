function onCreate()
    makeLuaSprite('screenCoverer', nil, -1000, -1000);
    makeGraphic('screenCoverer', screenWidth* 4, screenHeight * 4, '000000');
    setScrollFactor('screenCoverer', 0, 0);
    addLuaSprite('screenCoverer', false);
    setProperty('screenCoverer.alpha', 0);
end
function onEvent(name, value1, value2)
    if name == 'Screen Coverer' then
        paramsSC8 = split(value2,',')[4];
        paramsSC7 = split(value2,',')[3];
        setObjectCamera('screenCoverer', paramsSC7);
        if paramsSC7 == 'camGame' then
            if paramsSC8 == 'front' then
                setObjectOrder('screenCoverer', getObjectOrder('gfGroup')-1);
            else
                setObjectOrder('screenCoverer', getObjectOrder('boyfriendGroup'));
            end
        elseif paramsSC7 == 'camHUD' then
            if paramsSC8 == 'front' then
                --if version >= '1.0' then
                    --setObjectOrder('screenCoverer', getObjectOrder('noteGroup') + 1);
                --else
                    setObjectOrder('screenCoverer', getObjectOrder('uiGroup') + 1);
                --end
            else
                setObjectOrder('screenCoverer', getObjectOrder('noteGroup') - 2);
            end
        end
        paramsSC1 = split(value1,',')[1];
        paramsSC3 = tonumber(split(value1,',')[3]);
        if paramsSC1 == 'false' then
            cancelTween('screenCoverer');
            setProperty('screenCoverer.alpha', paramsSC3);
        else
            paramsSC5 = split(value2,',')[1];
            if paramsSC5 == 'linear' then
                paramsSC6 = '';
            else
                paramsSC6 = split(value2,',')[2];
            end
            paramsSC4= tonumber(split(value1,',')[4]);
            doTweenAlpha('screenCoverer', 'screenCoverer', paramsSC3, ((crochet / 4) / 1000) * paramsSC4, paramsSC5..paramsSC6);
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