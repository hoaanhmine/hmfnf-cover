function onCreate()

    makeAnimatedLuaSprite('myFireEffect', 'Firehud', 0.5, 0)
    addAnimationByPrefix('myFireEffect', 'burn', 'hud firehud', 24, true)
    setObjectCamera('myFireEffect', 'hud')
    scaleObject('myFireEffect', 1.4 , 1.4)
    addLuaSprite('myFireEffect', true) -- Firehud nằm trên cùng (HUD)
    objectPlayAnimation('myFireEffect', 'burn', true)
makeLuaSprite('bg','stage/sannha',0,0)
addLuaSprite('bg',false)
scaleObject('bg',  1.3, 1.3);
end