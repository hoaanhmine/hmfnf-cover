local DEFAULT_ZOOM = 1
local DEFAULT_DURATION = 1
local DEFAULT_MODE = 'direct'
local DEFAULT_EASE = 'linear'
local coiso = 'Stage Zoom'
function tweenCameraZoom(zoom, duration, direct, ease, mode)
local stageZoom = callMethodFromClass('backend.StageData', 'getStageFile', {curStage}).defaultZoom+0.3
local targetZoom = tonumber(zoom) * (direct and getProperty('defaultCamZoom') or stageZoom)
if duration == 0 then
setProperty('defaultCamZoom', targetZoom)
setProperty('camGame.zoom', targetZoom)
else
if mode == 'Stage Zoom' then
startTween('zoomEventTween', 'game', {defaultCamZoom = targetZoom}, (stepCrochet / 1000) * duration, {ease = tostring(ease)})
end
end
coiso = tostring(mode)
end

function onEvent(n, v1, v2)
if n == 'ZoomCamera' then
local splitV1 = stringSplit(v1, ',')
tweenCameraZoom(
(splitV1[1] == nil and DEFAULT_ZOOM or splitV1[1]),
(splitV1[2] == nil and DEFAULT_DURATION or splitV1[2] / 2),
false,
(splitV1[3] == nil and DEFAULT_EASE or splitV1[3]),
coiso
);
end
end