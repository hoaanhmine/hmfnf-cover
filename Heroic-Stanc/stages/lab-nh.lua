
function onCreate()
    makeLuaSprite('place','images/lab-nh/bgnoherofull',-600,-300);
    addLuaSprite('place');

    makeLuaSprite('placeog','images/lab-nh/place',-600,-300);
    addLuaSprite('placeog');
end

function onStepHit()

    if (curStep == 464) then
        setProperty('place.visible',false);
        setProperty('placeog.visible',true);
    end

    if (curStep == 592) then
        setProperty('placeog.visible',false);
        setProperty('place.visible',true);
    end
end