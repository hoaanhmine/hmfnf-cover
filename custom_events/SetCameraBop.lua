local rate = 4
local intensity = 0
function onBeatHit()
if curBeat % rate == 0 then
setProperty('camGame.zoom',getProperty('camGame.zoom')+0.015*intensity)
setProperty('camHUD.zoom',getProperty('camHUD.zoom')+0.03*intensity)
end
end

function onEvent(n,v1,v2)
if n == 'SetCameraBop' then
rate = tonumber(v1)
intensity = tonumber(v2)
end
end