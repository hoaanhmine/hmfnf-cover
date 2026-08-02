local character = 'dad';
local nameAnim = '';
local changeAnims = false;
local singName = {
    'singLEFT',
    'singDOWN',
    'singUP',
    'singRIGHT'
};
function onEvent(name, value1, value2)
    if name == 'Change Char Anim Suffix' then
        changeAnims = true;
        character = (value1);
        if character == '0' then
            character = 'dad';
        end
        if character == '1' then
            character = 'bf';
        end
        if character == '2' then
            character = 'gf';
        end
        nameAnim = (value2);
        if nameAnim == '' then
            changeAnims = false;
        end
        triggerEvent('Alt Idle Animation', 'Dad', nameAnim);
    end end
function opponentNoteHit(id, noteData, noteType, isSustainNote)
    if changeAnims then
        anim = singName[noteData + 1] .. nameAnim;
        playAnim(character, anim, true, false, 1);
    end
end