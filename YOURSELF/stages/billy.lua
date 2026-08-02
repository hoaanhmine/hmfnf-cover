local bg = {"Silly_floor","Silly_idk_1","Silly_idk_2"}

function onCreate()
    setProperty("skipCountdown",true)
end

function onCreatePost()

    makeLuaSprite('mirror','bg/silly_mirror',0,0)
    --setObjectCamera('mirror','camHUD')
    addLuaSprite('mirror')

    makeLuaSprite('mirrorBroken','bg/broken_mirror',0,0)
    setProperty('mirrorBroken.visible',false)
    addLuaSprite('mirrorBroken')

    makeLuaSprite('whiteMirror',nil,getProperty('mirror.x'),getProperty('mirror.y'))
    makeGraphic('whiteMirror',getProperty('mirror.width'),getProperty('mirror.height'),'ffffff')
    setProperty('whiteMirror.alpha',0)
    addLuaSprite('whiteMirror')

    makeLuaSprite('vig','vignette',0,0)
    setObjectCamera('vig','camHUD')
    addLuaSprite('vig')

    makeLuaSprite('bars','bars',0,0)
    setObjectCamera('bars','camHUD')
    addLuaSprite('bars')

    for i = 1,#bg do
        makeAnimatedLuaSprite('bg'..i,'bg/bgAssets',0,0)
        addAnimationByPrefix('bg'..i,bg[i],bg[i],1,false)
        addLuaSprite('bg'..i)
    end

    makeLuaSprite('blackScreen','')
    makeGraphic('blackScreen',1300,740,'000000')
    setObjectCamera('blackScreen','camHUD')
    setProperty('blackScreen.alpha',0)
    --screenCenter('blackScreen','XY')
    addLuaSprite('blackScreen')

    --makeLuaSprite('blackOther','')
    --makeGraphic('blackOther',1300,740,'000000')
    --setObjectCamera('blackOther','camOther')
    --setProperty('blackOther.alpha',0)
    --screenCenter('blackOther','XY')
    --addLuaSprite('blackOther')
end

function onStepHit()
    if curStep == 128 then
        cameraFlash('camHUD','000000',1)
        triggerEvent('Add Camera Zoom',0.2,0.1)
    end
end