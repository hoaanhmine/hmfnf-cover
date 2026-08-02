local shootName = {
	{'shootLEFT'},
	{'shootDOWN'},
	{'shootUP'},
	{'shootRIGHT'},
	}

	function onCreatePost()
		for i = 0,getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes',i,'noteType') == 'Attack Note' then
				setPropertyFromGroup('unspawnNotes',i,'texture','opponentNote/butlet')
				setPropertyFromGroup('unspawnNotes',i,'offsetX',getPropertyFromGroup('unspawnNotes',i,'offsetX') - 60)
				setPropertyFromGroup('unspawnNotes',i,'offsetY',getPropertyFromGroup('unspawnNotes',i,'offsetY') - 60)
				--setPropertyFromGroup('unspawnNotes',i,'noteSplashTexture','opponentNote/butlet')
				setPropertyFromGroup('unspawnNotes',i,'scale.x',0.6)
				setPropertyFromGroup('unspawnNotes',i,'scale.y',0.6)
				
				--setPropertyFromGroup('unspawnNotes',i,'missHealth',0.25)
			end
		end

		for j=0,getProperty('grpNoteSplashes.length') - 1 do
			setPropertyFromGroup('grpNoteSplashes',j,'noteSplashTexture','opponentNote/butlet')
		end
	end
	
function goodNoteHit(id,dir,type,sus)
if type == 'Attack Note' then
		characterPlayAnim('boyfriend',shootName[dir+ 1][1] , true)
		setProperty('boyfriend.specialAnim', true);
	end
	end