function onEvent(name, value1, value2)
	if name == "Flashing Camera" then
		makeLuaSprite('Flash','',0,0)
		makeGraphic("Flash", 1350, 750, value1) 
		setObjectCamera('Flash','camHUD')
		setProperty('Flash.alpha',0)
		addLuaSprite('Flash')
		runTimer('FlashStart',0.01)
		time = value2
	end
end

function onTimerCompleted(tag)
if tag == 'FlashStart' then
setProperty('Flash.alpha',0.7)
doTweenAlpha('endFlash','Flash',0,time- 0.1,'linear')
end
end
