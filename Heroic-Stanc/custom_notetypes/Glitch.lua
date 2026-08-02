function onCreatePost()
    for i = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',i,'noteType') == 'Glitch' then
            setPropertyFromGroup('unspawnNotes',i,'texture','GlitchNOTE_assets')
            --setPropertyFromGroup('unspawnNotes',i,'noteSplashTexture','GlitchnoteSplashes')
            setPropertyFromGroup('unspawnNotes',i,'hitHealth',-0.25)
            setPropertyFromGroup('unspawnNotes',i,'missHealth',0)

            if getPropertyFromGroup('unspawnNotes',i,'mustPress') then
                setPropertyFromGroup('unspawnNotes',i,'ignoreNote', true)
            end
        end
    end
end

function goodNoteHit(id,data,type,sus)
    if type == 'Glitch' then
        playSound('glitchhit',2)
    end
end