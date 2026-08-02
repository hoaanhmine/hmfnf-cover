function onEvent(n, value1, value2)
    if n == 'Change Scroll Speed' then
        local params = stringSplit(value1, ',')
        local useTween = params[1] == 'true'
        local finalScroll = tonumber(params[2])
        local multiplyCurrent = params[6] == 'true'
        
        if multiplyCurrent then
            finalScroll = finalScroll * getProperty('songSpeed')
        end

        local steps = tonumber(params[3])
        local easeType = params[4] or 'linear'
        local easeDir = params[5] or ''
        local ease = easeType .. (easeType == 'linear' and '' or easeDir)

        local duration = ((crochet/ 4) / 1000) * steps
        startTween('scrollSpeedTween', 'game', {songSpeed = finalScroll}, duration, {ease = ease})
    end
end