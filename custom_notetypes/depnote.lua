function noteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'depnote' then
		playSound('tiengdep', 1.0)
	end
end
local Poison = 0;
function onUpdate()
    setProperty('health', getProperty('health') - Poison); 
end

function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'depnote' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'depnote');
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0');
			setPropertyFromGroup('unspawnNotes', i, 'missHealth','0');
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);
	
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then 
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); 
			end
		end
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'depnote' then
		playSound('tiengdep', 2.0);
		Poison = Poison + 0.0015;
		if Poison == 0.0015 then
			runTimer('PoisonTime', 5 , 10);
	end
end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'PoisonTime' then
			Poison = 0;
		end
	end