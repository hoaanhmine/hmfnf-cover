function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Both Char Sing' then
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties

			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.046'); --Default value is: 0.0475, health lost on miss
			--setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
            --setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);

			--if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
            --    setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
		end
	end
end

local singName = {
	{'singLEFT'},
	{'singDOWN'},
	{'singUP'},
	{'singRIGHT'},
	}
	
	
	
function onCreate()

      for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Both BF Sing' then
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.046'); --Default value is: 0.0475, health lost on miss
			--setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
            --setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);

			--if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
            --    setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			--end
		end
	end
end

function goodNoteHit(id,dir,type,sus)
	if type == 'Both Char Sing' then
		characterPlayAnim('gf',singName[dir+1][1] , true)
		setProperty('gf.holdTimer', 0)
	end
end
	
function noteMiss(id,data,type,sus)
	if type == 'Both Char Sing' then 
		characterPlayAnim('gf',singName[data+1][1]..'miss', true)
		setProperty('gf.holdTimer', 0)
	end
end