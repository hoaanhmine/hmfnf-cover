--scripts by NTH208
speedUpGlitch0 = false
speedUpGlitch1 = false
speedUpGlitch2 = false
speedUpGlitch3 = false
function onCreatePost()
  initLuaShader("NewGlitch2")

for i=0,3 do
  setSpriteShader('opponentStrums.members['..i..']', 'NewGlitch2')
end       
 runTimer('repeat',0.1 * getProperty('playbackRate') / (getPropertyFromClass('backend.Conductor', 'bpm')/ 100),0)       
  for i = 0,getProperty('unspawnNotes.length')-1 do
    if getPropertyFromGroup('unspawnNotes',i,'gfNote') then
      if not getPropertyFromGroup('unspawnNotes',i,'mustPress') then
        setPropertyFromGroup('unspawnNotes', i, 'visible', false)
      end
    end
  end
end
        
function onSongStart()
  for i = 0,3 do
    noteTweenAlpha('note'..i,i,1,0.0001,'linear')
  end
end
         
function updateNote()
    --Speed Glitch
    if speedUpGlitch0 then
      setShaderFloat('opponentStrums.members[0]', 'binaryIntensity', getRandomFloat(4,6))
    else
      setShaderFloat("opponentStrums.members[0]", "negativity", 0.0)
    end
    
    if speedUpGlitch1 then
      setShaderFloat('opponentStrums.members[1]', 'binaryIntensity', getRandomFloat(4,6))
    else
      setShaderFloat("opponentStrums.members[1]", "negativity", 0.0)
    end
    
    if speedUpGlitch2 then
      setShaderFloat('opponentStrums.members[2]', 'binaryIntensity', getRandomFloat(4,6))
    else
      setShaderFloat("opponentStrums.members[2]", "negativity", 0.0)
    end
    
    if speedUpGlitch3 then
      setShaderFloat('opponentStrums.members[3]', 'binaryIntensity', getRandomFloat(4,6))
    else
      setShaderFloat("opponentStrums.members[3]", "negativity", 0.0)
    end
    
end
    negativityNote0 = 0
    negativityNote1 = 0
    negativityNote2 = 0
    negativityNote3 = 0
  function opponentNoteHit(id,data,type,sus)
    if type == 'GF Sing But Not Visible Note' or type == 'GF Sing' then
    else
    if data == 0 then
      speedUpGlitch0 = true
      runTimer('outSpeed0',0.15)

      if not sus then
        negativityNote0 = math.random(0,5)
        if negativityNote0 == 0 then
          setShaderFloat('opponentStrums.members['..data..']', 'negativity', 10)
        end
      end

      if (type == 'Glitch Note' or type == 'Second Char Glitch') and not sus then
        if math.random(0,1) == 0 then
          setShaderFloat('opponentStrums.members['..data..']', 'negativity', 10)
        end
      end
    end
    
    if data == 1 then
      speedUpGlitch1 = true
      runTimer('outSpeed1',0.15)

      if not sus then
        negativityNote1 = math.random(0,5)
        if negativityNote1 == 0 then
          setShaderFloat('opponentStrums.members['..data..']', 'negativity', 10)
        end
      end

      if (type == 'Glitch Note' or type == 'Second Char Glitch') and not sus then
        if math.random(0,1) == 0 then
          setShaderFloat('opponentStrums.members['..data..']', 'negativity', 10)
        end
      end
    end
    
    if data == 2 then
      speedUpGlitch2 = true
      runTimer('outSpeed2',0.15)

      if not sus then
        negativityNote2 = math.random(0,5)
        if negativityNote2 == 0 then
          setShaderFloat('opponentStrums.members['..data..']', 'negativity', 10)
        end
      end

      if (type == 'Glitch Note' or type == 'Second Char Glitch') and not sus then
        if math.random(0,1) == 0 then
          setShaderFloat('opponentStrums.members['..data..']', 'negativity', 10)
        end
      end
    end
    
    if data == 3 then
      speedUpGlitch3 = true
      runTimer('outSpeed3',0.15)

      if not sus then
        negativityNote3 = math.random(0,5)
        if negativityNote3 == 0 then
          setShaderFloat('opponentStrums.members['..data..']', 'negativity', 10)
        end
      end

      if (type == 'Glitch Note' or type == 'Second Char Glitch') and not sus then
        if math.random(0,1) == 0 then
          setShaderFloat('opponentStrums.members['..data..']', 'negativity', 10)
        end
      end
    end
  end

    if getPropertyFromGroup('notes',id,'gfNote') or type == 'GF Sing But Not Visible Note' then
      runHaxeCode('game.opponentStrums.members['..data..'].playAnim(\'static\', true);');
    end
    end
    
    function onTimerCompleted(tag)
    if tag== 'outSpeed0' then
    speedUpGlitch0 = false
    end
    
    if tag== 'outSpeed1' then
    speedUpGlitch1 = false
    end
    
    if tag== 'outSpeed2' then
    speedUpGlitch2 = false
    end
    
    if tag== 'outSpeed3' then
    speedUpGlitch3 = false
    end

    if tag == 'repeat' then
      updateNote()
      runTimer('repeat',0.1 * getProperty('playbackRate') / (getPropertyFromClass('backend.Conductor', 'bpm')/ 90),0)       
    end
    end
    
    function onStepHit()
    
    for i=0,3 do
      random = getRandomFloat(4,6)
      setShaderFloat('opponentStrums.members['..i..']', 'binaryIntensity', random)
--setSpriteShader('playerStrums.members['..i..']', 'NewGlitch2')  
end   
 end
 