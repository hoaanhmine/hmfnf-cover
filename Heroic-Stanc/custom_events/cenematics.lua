bordersSize = 360

function onCreate()
    makeLuaSprite('cinematicBorder1',nil,-100,0)
    makeLuaSprite('cinematicBorder2',nil,-100,screenHeight - bordersSize)
    for borders = 1,2 do
        makeGraphic('cinematicBorder'..borders,screenWidth + 200,bordersSize,'000000')
        setObjectCamera('cinematicBorder'..borders,'camHUD')
        addLuaSprite('cinematicBorder'..borders,false)
        
    end
    
    setProperty('cinematicBorder1.y',-bordersSize)
    setProperty('cinematicBorder2.y',screenHeight)
end

function onEvent(name,value1,value2)
    if name == 'cenematics' then
        doTweenY('cenematic1Y','cinematicBorder1',-bordersSize + value1, value2, 'cubeInOut')
        doTweenY('cenematic2Y','cinematicBorder2',screenHeight - value1, value2, 'cubeInOut')
    end
end