local eccoCounterEvent = 0;
local eccoCounter = 0;
local ecco_color = 'FFFFFF';
function onCreatePost()
    ecco_scale = getProperty('dad.scale.x');
end
function onEvent(name, value1, value2)
    if name == 'Character Ecco' then
        characterEcco = tonumber(split(value1,',')[1]);
        if characterEcco == 0 then
            characterEcco = 'dad';
        elseif characterEcco == 1 then
            characterEcco = 'boyfriend';
        elseif characterEcco == 2 then
            characterEcco = 'gf';
        end
        ecco_color = split(value1,',')[2];
        ecco_anchor = tonumber(split(value2,',')[3]);
        eccoCounterEvent = eccoCounterEvent + 1;
        numerTA = tonumber(split(value1,',')[3]);
        numerAE = tonumber(split(value2,',')[1]);
        numerSE = tonumber(split(value2,',')[2]);
        runTimer('ecco'..eccoCounterEvent, 0.2, 2);
    end
end
function onTimerCompleted(tag, loops, loopsLeft)
    for i = 0, eccoCounterEvent do
        if tag == 'ecco'..i then
            setupEccoDraw(characterEcco);
        end
    end
end
function onTweenCompleted(tag)
    for i = 0, eccoCounter do
        if tag == 'GhostA'..i then
        removeLuaSprite('Ghost'..i, true);
        end
    end
end
function setupEccoDraw(character)
    eccoCounter = eccoCounter + 1;
    makeAnimatedLuaSprite('Ghost'..eccoCounter, getProperty(character..'.imageFile'), getProperty(character..'.x'), getProperty(character..'.y'));
    setProperty('Ghost'..eccoCounter..'.scale.x', getProperty(character..'.scale.x'));
    setProperty('Ghost'..eccoCounter..'.scale.y', getProperty(character..'.scale.y'));
    addAnimationByPrefix('Ghost'..eccoCounter, 'idle', getProperty(character..'.animation.frameName'), 1, false);
    addLuaSprite('Ghost'..eccoCounter, false);
    setProperty('Ghost'..eccoCounter..'.flipX', getProperty(character..'.flipX'));
    setProperty('Ghost'..eccoCounter..'.offset.x', getProperty(character..'.offset.x'));
    setProperty('Ghost'..eccoCounter..'.offset.y', getProperty(character..'.offset.y'));
    setProperty('Ghost'..eccoCounter..'.color', getColorFromHex(ecco_color));
    setProperty('Ghost'..eccoCounter..'.alpha', numerAE);
    setObjectOrder('Ghost'..eccoCounter, getObjectOrder(character..'Group') - 1);
    doTweenX('Ghost'..eccoCounter..'scaleX', 'Ghost'..eccoCounter..'.scale', numerSE, (stepCrochet / 1000) * numerTA, 'circOut');
    doTweenY('Ghost'..eccoCounter..'scaleY', 'Ghost'..eccoCounter..'.scale', numerSE, (stepCrochet / 1000) * numerTA, 'circOut');
    doTweenAlpha('GhostA'..eccoCounter, 'Ghost'..eccoCounter, 0, ((stepCrochet / 1000) * numerTA) * 0.4, 'quad');
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