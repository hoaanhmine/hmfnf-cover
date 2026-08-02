local changeTexture = false;
local textureP = false;
function onCreate()
    luaDebugMode = true;
    if songName == 'cornered' or songName == 'thermal-shock' or songName == 'redscreen' then
        normalTexture = 'cornered';
    elseif songName == 'avulsion' then
        normalTexture = 'avulsion';
    elseif songName == 'broken-reality' then
        normalTexture = 'br';
    elseif songName == 'the-uprising' then
        normalTexture = 'uprising';
    elseif songName == 'you-are' then
        normalTexture = 'youare';
    elseif songName == 'haunted' then
        normalTexture = 'haunted';
    elseif songName == 'Overthrone' or songName == 'red-demon-o' then
        normalTexture = 'dustfell';
    elseif songName == 'psychopath' then
        normalTexture = 'notes_psychopath';
    elseif songName == 'Bargain' or songName == 'YOLO' or songName == 'Uncreate' then
        normalTexture = 'bargain';
    elseif songName == 'vindication' then
        normalTexture = 'vin_notes';
    else
        normalTexture = 'default';
    end
end
function onEvent(name, value1, value2)
    if name == 'Change Strum Skin' then
        textureS = split(value1,',')[1];
        if textureS == normalTexture then
            changeTexture = false;
        else
            noteSkin = (textureS);
            changeTexture = true;
        end
        pixel = split(value1,',')[2];
        if pixel == 'true' then
            textureP = true;
        else
            textureP = false;
        end
        for i = 0, 7 do
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'game/notes/'..(textureS));
            if textureP == true then
                scaleObject('strumLineNotes.members['..i..']', 6, 6);
                setPropertyFromGroup('strumLineNotes', i, 'antialiasing', false);
            else
                setPropertyFromGroup('strumLineNotes', i, 'scale.x', 0.65);
                setPropertyFromGroup('strumLineNotes', i, 'scale.y', 0.65);
                setPropertyFromGroup('strumLineNotes', i, 'antialiasing', true);
            end
        end
        for i = 0, getProperty('notes.length')-1 do
            setPropertyFromGroup('notes', i, 'texture', 'game/notes/'..(textureS));
            if textureP == true then
                scaleObject('notes.members['..i..']', 6, 6);
                setPropertyFromGroup('notes', i, 'antialiasing', false);
            else
                setPropertyFromGroup('notes', i, 'scale.x', 0.65);
                if not getPropertyFromGroup('notes', i, 'isSustainNote') then
                    setPropertyFromGroup('notes', i, 'scale.y', 0.65);
                end
                setPropertyFromGroup('notes', i, 'antialiasing', true);
            end
        end
    end
end
function onSpawnNote(membersIndex, noteData, noteType, isSustainNote)
    if changeTexture then
        if noteType == '' or noteType == 'Alt Animation' or noteType == 'No Animation' or noteType == 'GF Sing' then
            setPropertyFromGroup('notes', membersIndex, 'texture', 'game/notes/'..noteSkin);
            if textureP == true then
                scaleObject('notes.members['..membersIndex..']', 6, 6);
                setPropertyFromGroup('notes', membersIndex, 'antialiasing', false);
            else
                setPropertyFromGroup('notes', membersIndex, 'scale.x', 0.65);
                if not getPropertyFromGroup('notes', membersIndex, 'isSustainNote') then
                    setPropertyFromGroup('notes', membersIndex, 'scale.y', 0.65);
                end
                setPropertyFromGroup('notes', membersIndex, 'antialiasing', true);
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