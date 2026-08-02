dadGlitchIntensity = 1000.0
dadGlitchNegativity = 0

extraCharGlitchIntensity = 0
bfCharGlitchIntensity = 0

local extraChar = {}

function onSongStart()
    if shaderEnabled then
        initLuaShader("NewGlitch2")

        setSpriteShader("dad", "NewGlitch2")
        setShaderFloat("dad", "negativity", 0.0)    
        setShaderFloat('dad', 'binaryIntensity', 1000.0)

        setSpriteShader("boyfriend", "NewGlitch2")
        setShaderFloat("boyfriend", "negativity", 0.0)    
        setShaderFloat('boyfriend', 'binaryIntensity', 1000.0)

        makeLuaSprite('distortShader')
        setSpriteShader('distortShader','NewGlitch2')
        setShaderFloat("distortShader", "negativity", 0.0)    
        setShaderFloat('distortShader', 'binaryIntensity', 1000.0)
    end
end

function opponentNoteHit(id, derection, noteType, isSustainNote)
    if noteType == 'Glitch Note' then
        glitchCharacters('dad', false, isSustainNote)
    end
end

function addCharacterGlitch(name)
    table.insert(extraChar, name)

    setSpriteShader(name, "NewGlitch2")
    setShaderFloat(name, "negativity", 0.0)    
    setShaderFloat(name, 'binaryIntensity', 1000.0)
end

function glitchCharacters(curCharacter, isExtraCharacter, isSustainNote)
    if shadersEnabled then
        if curCharacter == 'boyfriend' then
            setSpriteShader("boyfriend", "NewGlitch2")
            bfGlitchIntensity = getRandomFloat(-0.6,-0.4)

            runTimer('distortShaderTimeBF',0.08 + getRandomFloat(0.06,0.08))
            setShaderFloat('boyfriend','binaryIntensity', bfGlitchIntensity)


            if math.random(1,2) == 1 then
                setShaderFloat('boyfriend','negativity',2)
            else
                setShaderFloat('boyfriend','negativity',-10)
            end

            runTimer('negativityShaderTimeBF',0.05 + getRandomFloat(0.04,0.06))
        end

        if curCharacter == 'dad' then
            setSpriteShader("dad", "NewGlitch2")

            if isSustainNote then
                dadGlitchIntensity = -0.5 
            else
                dadGlitchIntensity = getRandomFloat(-0.6,-0.4)
            end

            runTimer('distortShaderTime',0.08 + getRandomFloat(0.06,0.08))
            setShaderFloat('dad','binaryIntensity', dadGlitchIntensity)

            dadGlitchNegativity = (getRandomBool(50) and 2 or -10)
            setShaderFloat('dad','negativity',dadGlitchNegativity)
            

            runTimer('negativityShaderTime',0.05 + getRandomFloat(0.04,0.06))
        end

        if isExtraCharacter then
            setSpriteShader(curCharacter, "NewGlitch2")

            if isSustainNote then
                extraCharGlitchIntensity = -0.5 
            else
                extraCharGlitchIntensity = getRandomFloat(-0.6,-0.4)
            end

            runTimer('distortShaderTime'..curCharacter, 0.08 + getRandomFloat(0.04,0.06))
            setShaderFloat(curCharacter,'binaryIntensity', extraCharGlitchIntensity)

            if math.random(1,2) == 1 then
                setShaderFloat(curCharacter,'negativity', 2)
            else
                setShaderFloat(curCharacter,'negativity', -10)
            end

            runTimer('negativityShaderTime'..curCharacter, 0.05 + getRandomFloat(0.04,0.06))
        end
    end
end


function onEvent(n,v1,v2)
    if n == 'Play Animation' then
        local tagBF = v1
        if --[[getProperty("boyfriend.curCharacter") == 'bfsword' and]] string.sub(tagBF,string.len(tagBF)-3,string.len(tagBF)) == 'miss' then
            glitchCharacters('boyfriend')
        end
    end
end

function onUpdate()
    setVar('dadGlitchIntensity', dadGlitchIntensity)
    setVar('dadGlitchNegativity', dadGlitchNegativity)
end

function noteMiss(id,data,type,sus)
    if type == 'Dodge Note' then
        glitchCharacters('boyfriend')
    end
end

function onTimerCompleted(tag)
    if tag == 'negativityShaderTime' then
        dadGlitchNegativity = 0
        setShaderFloat("dad", "negativity", dadGlitchNegativity)  
    end

    if tag == 'distortShaderTime' then
        dadGlitchIntensity = 1000
        setShaderFloat('dad', 'binaryIntensity', dadGlitchIntensity)
    end

    if tag == 'negativityShaderTimeBF' then
        setShaderFloat("boyfriend", "negativity", 0)  
    end

    if tag == 'distortShaderTimeBF' then
        setShaderFloat('boyfriend', 'binaryIntensity', 1000.0)
    end

    for i = 1,#extraChar do
        if tag == 'negativityShaderTime'..extraChar[i] then
            setShaderFloat(extraChar[i], "negativity", 0)  
        end

        if tag == 'distortShaderTime'..extraChar[i] then
            setShaderFloat(extraChar[i], 'binaryIntensity', 1000.0)
        end
    end
end
    
