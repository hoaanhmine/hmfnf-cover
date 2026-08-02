isGF = false
function opponentNoteHit(id,noteData,noteType,isSusNote)
if noteType =='GF Sing But Not Visible Note' or noteType =='GF Sing' then
    isGF = true
else
    isGF = false
end
    if not isGF and not isSusNote then
        triggerEvent('glitchCamera','glitchChromatic')
    end
end
