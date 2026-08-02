resetOffset = false
function onSongStart()
     noteX0 = getPropertyFromGroup('strumLineNotes','0','x')
     noteX1 = getPropertyFromGroup('strumLineNotes','1','x')
     noteX2 = getPropertyFromGroup('strumLineNotes','2','x')
     noteX3 = getPropertyFromGroup('strumLineNotes','3','x')
     noteX4 = getPropertyFromGroup('strumLineNotes','4','x')
     noteX5 = getPropertyFromGroup('strumLineNotes','5','x')
     noteX6 = getPropertyFromGroup('strumLineNotes','6','x')
     noteX7 = getPropertyFromGroup('strumLineNotes','7','x')
     
     
     noteY0 = getPropertyFromGroup('strumLineNotes','0','y')
     noteY1 = getPropertyFromGroup('strumLineNotes','1','y')
     noteY2 = getPropertyFromGroup('strumLineNotes','2','y')
     noteY3 = getPropertyFromGroup('strumLineNotes','3','y')
     noteY4 = getPropertyFromGroup('strumLineNotes','4','y')
     noteY5 = getPropertyFromGroup('strumLineNotes','5','y')
     noteY6 = getPropertyFromGroup('strumLineNotes','6','y')
     noteY7 = getPropertyFromGroup('strumLineNotes','7','y')
end

function onStepHit()
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
if noteType == 'Glitch Note' then
cameraShake('camGame',0.01,0.1)
cameraShake('camHUD',0.01,0.1)

end
end