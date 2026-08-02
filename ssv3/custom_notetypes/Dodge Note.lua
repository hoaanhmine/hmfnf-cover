function onCreatePost()
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Dodge Note' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'SwordNOTE_assets')
            setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0.25)
        end
    end
end

function goodNoteHit(id, dir, type, sus)
    if type == 'Dodge Note' then
        local randomDodges = {'parry1', 'parry2'}
        local chosenAnim = randomDodges[math.random(1, 2)]

        playAnim('boyfriend', chosenAnim, true)
        setProperty('boyfriend.specialAnim', true)
    end
end