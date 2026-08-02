local angleshit = 1;
local anglevar = 1;
function opponentNoteHit(id, direction, noteType, isSustainNote)
	if difficulty == 2 then
		if curBeat < 1 then
			if curBeat > 240 then
				cameraShake('cam', '0.015', '0.1')
			end
		end
	end
end

function onEvent(name,value1,value2)
if name == 'screen shake left right' then
if value1 == 'Enable' then
ena = true
 end
 if value1 == 'Disable' then
 ena = false
end
beat= value2
end
end

function onBeatHit()
    if curBeat > 1 and ena then
        if curBeat % 2 == 0 then
            angleshit = anglevar;
        else
            angleshit = -anglevar;
        end
        setProperty('camHUD.angle',angleshit*3)
        doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.002, 'circOut')
        doTweenX('tuin', 'camHUD', -angleshit*8, crochet*0.001, 'linear')
    elseif curBeat > 1 and not ena then
if curBeat % 2== 0 then
            angleshit = anglevar;
        else
            angleshit = -anglevar;
        end
        setProperty('camHUD.angle',angleshit*0)
        doTweenAngle('turn', 'camHUD', 0, stepCrochet*0.002, 'circOut')
        doTweenX('tuin', 'camHUD', 0, crochet*0.001, 'linear')
end
end