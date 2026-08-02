local dodgeName = {
	{'dodgeLEFT'},
	{'dodgeDOWN'},
	{'dodgeUP'},
	{'dodgeRIGHT'},
	}

	function onCreatePost()
		for i = 0,getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes',i,'noteType') == 'Dodge Note' then
				setPropertyFromGroup('unspawnNotes',i,'texture','SwordNOTE_assets')
				--setPropertyFromGroup('unspawnNotes',i,'texture','opponentNote/sword_assets')--It  looksgreat but when put in gameplay it so hard to see
				--setPropertyFromGroup('unspawnNotes',i,'offsetX',getPropertyFromGroup('unspawnNotes',i,'offsetX') - 40)
				--setPropertyFromGroup('unspawnNotes',i,'scale.x',1.15)
				--setPropertyFromGroup('unspawnNotes',i,'scale.y',1.15)
				setPropertyFromGroup('unspawnNotes',i,'missHealth',0.25)
			end
		end
	end

function goodNoteHit(id,dir,type,sus)
if type == 'Dodge Note' then
		characterPlayAnim('boyfriend',dodgeName[dir+ 1][1] , true)
		setProperty('boyfriend.specialAnim', true);
	end
	end