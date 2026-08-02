twoBeat = false
mid = true
bordersSize = 80
function onStepHit()

if (curStep > 128 and curStep % 4 == 0 and curStep < 381) or (curStep > 760 and curStep % 4 == 0 and curStep < 641) or (curStep > 1839 and curStep % 4 == 0 and curStep < 2089) then-- or (curStep > 1407 and curStep % 4 == 0 and curStep < 1664) or (curStep > 2464 and curStep % 4 == 0 and curStep < 2968) or (curStep > 3104 and curStep % 4 == 0 and curStep < 3348) then
if not twoBeat then
triggerEvent('Add Camera Zoom','0.03','0.06')
twoBeat = true
elseif twoBeat then
triggerEvent('Add Camera Zoom','0.045','0.09')
twoBeat = false
end
end

if (curStep >700 and curStep %2 == 0 and curStep< 720) or (curStep > 1776 and curStep % 2 == 0 and curStep < 1794) then
triggerEvent('Add Camera Zoom','0.03','0.06')
end

--Auto Zoom:)
if (curStep >720 and curStep %1 ==0 and curStep <748) or (curStep >1794 and curStep %1 ==0 and curStep <1821) then
triggerEvent('Add Camera Zoom','0.03','0.06')
end

if (curStep >2080 and curStep< 2336) then
mid = true
end

if curStep == 3294 then
mid = true
elseif curStep == 5375 then
mid = false
end
end

function onBeatHit()
if (curBeat > 252 and curBeat % 2 ==0 and curBeat < 312) or (curBeat > 523 and curBeat % 2 ==0 and curBeat < 585) or (curBeat > 916 and curBeat %1 ==0 and curBeat < 1172) or (curBeat > 1248 and curBeat %1 ==0 and curBeat < 1276) or (curBeat > 1280 and curBeat %1 ==0 and curBeat < 1344)  then
if not twoBeat then
triggerEvent('Add Camera Zoom','0.03','0.06')
twoBeat = true
elseif twoBeat then
triggerEvent('Add Camera Zoom','0.045','0.09')
twoBeat = false
end
end


if (curBeat > 126 and curBeat % 1 == 0 and curBeat < 175) or (curBeat > 316 and curBeat % 1 == 0 and curBeat <344 ) or (curBeat > 428 and curBeat % 1 == 0 and curBeat < 444) or (curBeat > 584 and curBeat % 1 == 0 and curBeat < 613) or (curBeat > 192 and curBeat %1 ==0 and curBeat < 256) or (curBeat > 352 and curBeat %1 ==0 and curBeat < 384) or (curBeat > 624 and curBeat %2 ==0 and curBeat < 658) then
triggerEvent('Add Camera Zoom','0.03','0.06')
end

if (curBeat > 254 and curBeat %2 ==0 and curBeat < 273) or (curBeat > 96 and curBeat %2 ==0 and curBeat < 128) then
triggerEvent('Add Camera Zoom','0.04','0.08')
end
end
