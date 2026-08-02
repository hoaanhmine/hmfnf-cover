function onCountdownTick(counter)
if counter == 1 then
makeLuaSprite("shadertest")
        makeGraphic("shadertest", screenWidth, screenHeight)
     
initLuaShader("cyclesd")
setSpriteShader('corruption', 'cyclesd');
setShaderFloat('corruption', 'amount', 0)         
                   runHaxeCode([[
            var chromToggle = game.createRuntimeShader('ChromaticAbberationHUD');
            game.getLuaObject('chromToggle').shader = chromToggle;
            game.getLuaObject('shadertest').shader = shaderBlur;
            game.getLuaObject("temporaryShader1").shader = shaderVcr;
                
            return;
        ]]
    )
                   
        end           
      end
glit = 1.4
function onCreatePost()
    initLuaShader("NewGlitch2")
    setSpriteShader("dad", "NewGlitch2")
    setShaderFloat('dad', 'binaryIntensity', 10.0)
    setShaderFloat("dad", "negativity", 0)
end
    
                   
function onBeatHit()
    if curBeat % 1 == 0 then
        setShaderFloat('corruption', 'pixel', math.random(1,5))
        setShaderFloat('dad', 'binaryIntensity', getRandomFloat(-0.3, 0.0))
    end
end

function onUpdate()
end