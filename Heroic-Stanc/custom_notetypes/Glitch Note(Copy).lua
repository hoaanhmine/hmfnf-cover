function opponentNoteHit(id, noteData, noteType, isSustainNote)
if noteType == 'Glitch Note' then
cameraShake('camGame',0.03,0.1)
for strumLieNotes = 0,7 do
        
       if getPropertyFromGroup('strumLineNotes',strumLieNotes,'angle') > getPropertyFromGroup('strumLineNotes',strumLieNotes,'angle')-3 and getPropertyFromGroup('strumLineNotes',strumLieNotes,'angle') < getPropertyFromGroup('strumLineNotes',strumLieNotes,'angle') +3 then
        noteTweenAngle('glitchNoteAngle'..strumLieNotes, strumLieNotes,getPropertyFromGroup('strumLineNotes',strumLieNotes,'angle') + math.random(-1,1),0.1,'quadInOut')
        
      elseif getPropertyFromGroup('strumLineNotes',strumLieNotes,'angle') < getPropertyFromGroup('strumLineNotes',strumLieNotes,'angle') -3 then
        noteTweenAngle('glitchNoteAngle'..strumLieNotes, strumLieNotes,getPropertyFromGroup('strumLineNotes',strumLieNotes,'angle') + math.random(0,1),0.1,'quadInOut')
        
        elseif getPropertyFromGroup('strumLineNotes',strumLieNotes,'angle') > getPropertyFromGroup('strumLineNotes',strumLieNotes,'angle') +3 then
       noteTweenAngle('glitchNoteAngle'..strumLieNotes, strumLieNotes,getPropertyFromGroup('strumLineNotes',strumLieNotes,'angle') + math.random(-1,0),0.1,'quadInOut')
        end 
        
        
     if getPropertyFromGroup('strumLineNotes',strumLieNotes,'x') > getPropertyFromGroup('strumLineNotes',strumLieNotes,'x')-10 and getPropertyFromGroup('strumLineNotes',strumLieNotes,'x') < getPropertyFromGroup('strumLineNotes',strumLieNotes,'x')+10 then
     noteTweenX('glitchNoteX'..strumLieNotes, strumLieNotes,getPropertyFromGroup('strumLineNotes',strumLieNotes,'x') + math.random(-10,10),0.1,'quadInOut')
        
      elseif getPropertyFromGroup('strumLineNotes',strumLieNotes,'x') < getPropertyFromGroup('strumLineNotes',strumLieNotes,'x') -10 then
        noteTweenX('glitchNoteX'..strumLieNotes, strumLieNotes,getPropertyFromGroup('strumLineNotes',strumLieNotes,'x') + math.random(0,10),0.1,'quadInOut')
        
        elseif getPropertyFromGroup('strumLineNotes',strumLieNotes,'x') > getPropertyFromGroup('strumLineNotes',strumLieNotes,'x') +10 then
       noteTweenX('glitchNoteX'..strumLieNotes, strumLieNotes,getPropertyFromGroup('strumLineNotes',strumLieNotes,'x') + math.random(-10,0),0.1,'quadInOut')
        end
        
        if getPropertyFromGroup('strumLineNotes',strumLieNotes,'y') > getPropertyFromGroup('strumLineNotes',strumLieNotes,'y') -10 and getPropertyFromGroup('strumLineNotes',strumLieNotes,'y') < getPropertyFromGroup('strumLineNotes',strumLieNotes,'x') +10 then
    noteTweenY('glitchNoteY'..strumLieNotes, strumLieNotes,getPropertyFromGroup('strumLineNotes',strumLieNotes,'y') + math.random(-10,10),0.1,'quadInOut')
        
       elseif getPropertyFromGroup('strumLineNotes',strumLieNotes,'y') < getPropertyFromGroup('strumLineNotes',strumLieNotes,'y') -10 then
      noteTweenY('glitchNoteY'..strumLieNotes, strumLieNotes,getPropertyFromGroup('strumLineNotes',strumLieNotes,'y') + math.random(0,10),0.1,'quadInOut')
        
    elseif getPropertyFromGroup('strumLineNotes',strumLieNotes,'y') > getPropertyFromGroup('strumLineNotes',strumLieNotes,'y') +10 then
    noteTweenY('glitchNoteY'..strumLieNotes, strumLieNotes,getPropertyFromGroup('strumLineNotes',strumLieNotes,'y') + math.random(-10,0),0.1,'quadInOut')
     end        
    end
end
end