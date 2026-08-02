function z() setPropertyFromClass('flixel.FlxG', 'camera.target', instanceArg('camFollow'), nil, true) end
function onEvent(n,v1,v2)
if n == 'FocusCamera' then
if v1 == '' then
setProperty('isCameraOnForcedPos', false)
cancelTween('moveCamera')
z()
else
setProperty('isCameraOnForcedPos', true)
cancelTween('moveCamera')
local targetData = stringSplit(v1, ',')
if targetData[1] == '0' or string.lower(targetData[1]) == 'bf' or string.lower(targetData[1]) == 'boyfriend' then

targetX = getMidpointX('boyfriend') - getProperty('boyfriend.cameraPosition[0]') + getProperty('boyfriendCameraOffset[0]') - 100
targetY = getMidpointY('boyfriend') + getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]') - 100
elseif targetData[1] == '1' or string.lower(targetData[1]) == 'dad' or string.lower(targetData[1]) == 'opponent' then
targetX = getMidpointX('dad') + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]') + 150
targetY = getMidpointY('dad') + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]') - 100
elseif targetData[1] == '2' or string.lower(targetData[1]) == 'gf' or string.lower(targetData[1]) == 'girlfriend' then
targetX = getMidpointX('gf') + getProperty('gf.cameraPosition[0]') + getProperty('girlfriendCameraOffset[0]')
targetY = getMidpointY('gf') + getProperty('gf.cameraPosition[1]') + getProperty('girlfriendCameraOffset[1]')
else
targetX = 0
targetY = 0
end
if targetData[2] ~= nil then
targetX = targetX + tonumber(targetData[2])
if targetData[3] ~= nil then
targetY = targetY + tonumber(targetData[3])
end
end
if v2 == '' then
z()
setProperty('camFollow.x', targetX)
setProperty('camFollow.y', targetY)
else
local tweenData = stringSplit(v2, ',')
if tweenData[1] == '0' then
z()
callMethod('camFollow.setPosition', {targetX,targetY})
callMethod('camGame.snapToTarget', {''})
else
setPropertyFromClass('flixel.FlxG', 'camera.target')
callMethod('camFollow.setPosition', {targetX - screenWidth / 2,targetY - screenHeight / 2})
local tweenData = stringSplit(v2, ',')
local duration = stepCrochet * tonumber(tweenData[1]) / 1000
if tweenData[2] == nil then
tweenData[2] = 'linear'
elseif tweenData[2] =='CLASSIC' then
tweenData[2] = 'expoOut'
duration=duration+0.5

elseif tweenData[2] =='INSTANT' then
duration=0.0001
end
startTween('tween_'..'moveCamera', 'camGame.scroll', {x = getProperty('camFollow.x'), y = getProperty('camFollow.y')},duration, {ease = tweenData[2]})
end
end
end
end   
end