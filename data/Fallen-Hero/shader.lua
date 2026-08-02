function onCountdownTick(counter)
if counter == 1 then
makeLuaSprite("shadertest")
        makeGraphic("shadertest", screenWidth, screenHeight)
     
initLuaShader("cyclesd")
setSpriteShader('corruption', 'cyclesd');
setShaderFloat('corruption', 'amount', 0)         
                   runHaxeCode([[
            var shaderVcr = game.createRuntimeShader('glitchChromatic');                
            return;
        ]]
    )
                   
        end           
      end
glit = 1.4
function onCreatePost()
    initLuaShader("NewGlitch2")
    setSpriteShader("dad", "NewGlitch2")
    setShaderFloat('dad', 'binaryIntensity', 1000.0)
    setShaderFloat("dad", "negativity", 0)
end
    
                   
function onBeatHit()
    if curBeat % 1 == 0 then
        setShaderFloat('corruption', 'pixel', math.random(5,10))
        setShaderFloat('dad', 'binaryIntensity', getRandomFloat(0.8, -0.9))
    end
end

function onUpdate()
end