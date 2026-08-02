local singName = {
	{'singLEFT-alt'},
	{'singDOWN-alt'},
	{'singUP-alt'},
	{'singRIGHT-alt'},
	}

	function onCreatePost()
		for i = 0,getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes',i,'noteType') == 'GlitchAltSing' then
				setPropertyFromGroup('unspawnNotes',i,'texture','GlitchNOTE_assets')
				--setPropertyFromGroup('unspawnNotes',i,'offsetX',getPropertyFromGroup('unspawnNotes',i,'offsetX') - 40)
				--setPropertyFromGroup('unspawnNotes',i,'scale.x',1.15)
				--setPropertyFromGroup('unspawnNotes',i,'scale.y',1.15)
				--setPropertyFromGroup('unspawnNotes',i,'missHealth',0.25)
			end
		end
	end

function opponentNoteHit(id,dir,type,sus)
if type == 'GlitchAltSing' then
		characterPlayAnim('dad',singName[dir+ 1][1] , true)
		setProperty('dad.specialAnim', true);
	end
	end