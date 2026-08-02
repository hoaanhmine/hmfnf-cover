-- Tăng tầm nhìn camera của nhân vật đối thủ (dad) cao hơn 50px khi theo dõi
function onMoveCamera(focus)
    if focus == 'dad' then
        setProperty('camFollow.y', getProperty('dad.y') + getProperty('dad.height')/2 - 50)
    end
end

function onUpdate(elapsed)
    -- Không tween liên tục nữa
end

function onStepHit()
    if curStep == 250 then
        -- Hiển thị ảnh cat từ trái qua phải
        makeLuaSprite('catimg', 'catimg', -600, 200)
        setObjectCamera('catimg', 'other')
        scaleObject('catimg', 0.5, 0.5)
        addLuaSprite('catimg', true)
        doTweenX('catMove', 'catimg', 900, 1, 'linear') -- Di chuyển sang phải trong 1 giây
    end
    if curStep == 376 then
        -- Hiển thị ảnh "ao_that_day" từ trái qua phải
        makeLuaSprite('aoThatDaySprite', 'ao_that_day', -600, 200)
        setObjectCamera('aoThatDaySprite', 'other')
        scaleObject('aoThatDaySprite', 0.5, 0.5)
        addLuaSprite('aoThatDaySprite', true)
        doTweenX('aoThatDayMove', 'aoThatDaySprite', 900, 1, 'linear')
    end
    if curStep == 760 then
        -- Hiển thị lại ảnh cat từ trái qua phải
        makeLuaSprite('catimg2', 'catimg', -600, 200)
        setObjectCamera('catimg2', 'other')
        scaleObject('catimg2', 0.5, 0.5)
        addLuaSprite('catimg2', true)
        doTweenX('catMove2', 'catimg2', 900, 1, 'linear')
    end
end

function onTweenCompleted(tag)
    -- Xử lý khi tween ảnh cat xong
    if tag == 'catMove' then
        runTimer('hideCat', 1.2) -- ẩn nhanh hơn
    elseif tag == 'catHide' then
        removeLuaSprite('catimg', true)
    elseif tag == 'aoThatDayMove' then
        runTimer('hideAoThatDay', 1.2)
    elseif tag == 'aoThatDayHide' then
        removeLuaSprite('aoThatDaySprite', true)
    elseif tag == 'catMove2' then
        runTimer('hideCat2', 1.2)
    elseif tag == 'catHide2' then
        removeLuaSprite('catimg2', true)
    end
end

function onTimerCompleted(tag)
    if tag == 'hideCat' then
        doTweenAlpha('catHide', 'catimg', 0, 0.3, 'linear')
    elseif tag == 'hideAoThatDay' then
        doTweenAlpha('aoThatDayHide', 'aoThatDaySprite', 0, 0.3, 'linear')
    elseif tag == 'hideCat2' then
        doTweenAlpha('catHide2', 'catimg2', 0, 0.3, 'linear')
    end
end
