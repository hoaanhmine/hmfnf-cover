--SCRIPT BY NTH208
chromAmount = 0.2 --default = 0.65
chromatic = 0.001
percent = 50
enabled = false
activated = false
zoomChromatic = true
glitchChromatic = true
notGF = false

glitchShaderIntensity = 0
chromaticShaderIntensity = 0
lerpGlitchChromatic = 7.0
glitchyAmount = 0
uTimeFloat = 0

function onCreatePost()
    --if shadersEnabled then
    initLuaShader('ChromaticAbberationHUD')


    runHaxeCode([[
            var chromToggle = game.createRuntimeShader('ChromaticAbberationHUD'); 
            setVar('chromToggle', chromToggle);

            game.camGame.setFilters([new ShaderFilter(chromToggle)]);
            game.camHUD.setFilters([new ShaderFilter(chromToggle)]);
    ]])
    --end
end

function onSectionHit()
    if zoomChromatic then
        chromBeat()
    end
end

function onEvent(name,value1,value2)
    if name =='Add Camera Zoom' then
        if zoomChromatic then
            chromBeat() 
        end
    end

    if value1 == 'Change Lerp Glitch' then
        lerpGlitchChromatic = tonumber(value2);
    end
end


function chromBeat()
    if zoomChromatic then
        chromaticShaderIntensity = chromAmount
    end
end

function resetShaderGlitch()
    runHaxeCode([[
            var chromToggle = getVar('chromToggle'); 

            game.camGame.setFilters([new ShaderFilter(chromToggle)]);
            game.camHUD.setFilters([new ShaderFilter(chromToggle)]);
    ]])
end

function ChromaticAbberationSetting(isZoomChromatic,amount)
    zoomChromatic = isZoomChromatic

    if not zoomChromatic then
        chromaticShaderIntensity = (amount ~= nil and amount or 0)
    end
end


function onUpdate(elapsed)
    uTimeFloat = uTimeFloat + elapsed
    glitchShaderIntensity = math.lerp(glitchShaderIntensity, 0, math.bound(elapsed * lerpGlitchChromatic, 0, 1));
    glitchyAmount = math.lerp(glitchyAmount, 0, math.bound(elapsed * 5, 0, 1));
    if zoomChromatic then
        chromaticShaderIntensity = math.lerp(chromaticShaderIntensity, 0, math.bound(elapsed * 6, 0, 1));
    end

    runHaxeCode([[
        var chromToggle = getVar('chromToggle');

        chromToggle.setFloat('amount', ]]..chromaticShaderIntensity..[[);
    ]])
end

function math.bound(value,min,max)
    return math.max(min,math.min(max,value))
end

function math.lerp(from,to,i)
    return from+(to-from)*i
end
