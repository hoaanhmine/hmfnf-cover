local xOffset = 0;
local yOffset = 0;
local font = "8bit-jve";
local size = 32;
local textSpaceMovementMult = 1;
local showHistory = true;
local counterText = 0;
local colorT = 'FFFFFF';
local colorTB = '000000';
function onEvent(name, value1, value2)
    if name == 'Lyrics' then
        paramsL1 = split(value1,',')[1];
        if paramsL1 == 'Add Text' then
            paramsL2 = split(value1,',')[2];
            addText(paramsL2);
        end
        if paramsL1 == 'Force remove all text' then
            killText();
        end
        if paramsL1 == 'Set Color' then
            colorT = split(value2,',')[1];
            if not showHistory then
                setTextColor('text'..counterText, colorT);
            end
        end
        if paramsL1 == 'Set Border Color' then
            colorTB = split(value2,',')[1];
        end
        if paramsL1 == 'Set Font' then
            font = split(value1,',')[2];
        end
        if paramsL1 == 'Set Size' then
            size = split(value1,',')[2];
        end
        if paramsL1 == 'Enable text history (On Off)' then
            paramsL4 = split(value2,',')[2];
            if paramsL4 == 'true' then
                showHistory = true;
            else
                showHistory = false;
            end
        end
        if paramsL1 == 'Center' then
            yOffset = -200;
        end
        if paramsL1 == 'Cutscene' then
            yOffset = 90;
        end
        if paramsL1 == 'Ultra remove' then
            killTextULTRA();
        end
    end
end
function addText(setText)
    if showHistory == true then
        counterText = counterText + 1;
        makeLuaText('text'..counterText, setText, 1280, 0, 500);
        setTextBorder('text'..counterText, 2, colorTB);
        setTextAlignment('text'..counterText, 'Center');
        setTextSize('text'..counterText, size);
        setTextFont("text"..counterText, font..'.ttf');
        setTextColor('text'..counterText, colorT);
        setObjectOrder('text'..counterText, 99);
        setObjectCamera('text'..counterText, 'camOther');
        addLuaText('text'..counterText);
        setProperty('text'..counterText..'.x', getProperty('text'..counterText..'.x') + (xOffset));
        setProperty('text'..counterText..'.y', getProperty('text'..counterText..'.y') + (yOffset));
        if not downscroll then
            spaceToMove = size;
        else
            spaceToMove = -1 * size;
        end
        spaceToMove = spaceToMove * textSpaceMovementMult;
        for i = counterText - 2, counterText - 1 do
            if luaTextExists('text'..i) then
                doTweenY('text'..i, 'text'..i, getProperty('text'..i..'.y') - (spaceToMove), 0.3, 'cubeOut');
                doTweenAlpha('textA'..i, 'text'..i, getProperty('text'..i..'.alpha') - 0.7, 0.3, 'cubeOut');
            end
        end
    else
        if luaTextExists('text'..counterText) then
            setTextString('text'..counterText, setText);
        else
            makeLuaText('text'..counterText, setText, 1280, 0, 500);
            setTextBorder('text'..counterText, 2, colorTB);
            setTextAlignment('text'..counterText, 'Center');
            setTextSize('text'..counterText, size);
            setTextFont('text'..counterText, font..'.ttf');
            setTextColor('text'..counterText, colorT);
            setObjectOrder('text'..counterText, 99);
            setObjectCamera('text'..counterText, 'camOther');
            addLuaText('text'..counterText);
            setProperty('text'..counterText..'.x', getProperty('text'..counterText..'.x') + (xOffset));
            setProperty('text'..counterText..'.y', getProperty('text'..counterText..'.y') + (yOffset));
        end
    end
end
function killText()
    for i = 0, counterText do
        if luaTextExists('text'..i) then
            doTweenAlpha('textAK'..i, 'text'..i, 0, 0.3, 'cubeOut');
        end
    end
end
function killTextULTRA()
    for e = 0, counterText do
        if luaTextExists('text'..e) then
            removeLuaText('text'..e);
        end
    end
end
function onTweenCompleted(tag)
    for e = 0, counterText do
        if tag == 'textAK'..e then
            if luaTextExists('text'..e) then
                removeLuaText('text'..e);
            end
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