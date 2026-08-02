offset = 240
function onCreatePost()
	runHaxeCode([[
		for (strum in opponentStrums)
		{
			strum.cameras = [camGame];
			strum.scrollFactor.set(1,1);
		}

		for (note in unspawnNotes)
		{
			if (!note.mustPress)
			{
				note.cameras = [camGame];
				note.scrollFactor.set(1,1);
			}
		};
	]])
end

function onSongStart()
	runTimer('start',0.5)
end

function onUpdate()
	--PLAYER
	setObjectOrder('playerSplashPurpleEnd',getObjectOrder('noteGroup')+1)
	setObjectOrder('playerSplashBlueEnd',getObjectOrder('noteGroup')+1)
	setObjectOrder('playerSplashGreenEnd',getObjectOrder('noteGroup')+1)
	setObjectOrder('playerSplashRedEnd',getObjectOrder('noteGroup')+1)
	setObjectOrder('playerSplashPurpleHold',getObjectOrder('noteGroup')+1)
	setObjectOrder('playerSplashBlueHold',getObjectOrder('noteGroup')+1)
	setObjectOrder('playerSplashGreenHold',getObjectOrder('noteGroup')+1)
	setObjectOrder('playerSplashRedHold',getObjectOrder('noteGroup')+1)
	--OPPONENT
	setObjectOrder('opponentSplashPurpleHold',getObjectOrder('noteGroup')+1)
	setObjectOrder('opponentSplashBlueHold',getObjectOrder('noteGroup')+1)
	setObjectOrder('opponentSplashGreenHold',getObjectOrder('noteGroup')+1)
	setObjectOrder('opponentSplashRedHold',getObjectOrder('noteGroup')+1)

	--debugPrint(getPropertyFromGroup('strumLineNotes','4','x'))
end

function onUpdatePost()
end

function onTimerCompleted(tag)
	if tag == 'start' then
		for i =0,3 do
			setPropertyFromGroup('strumLineNotes',i,'x',740 + i*offset)
			if downscroll then
				setPropertyFromGroup('strumLineNotes',i,'y',1180)
			else
				setPropertyFromGroup('strumLineNotes',i,'y',520)
			end
			setPropertyFromGroup('strumLineNotes',i,'scale.x',0.8)
			setPropertyFromGroup('strumLineNotes',i,'scale.y',0.8)
			setPropertyFromGroup('strumLineNotes',i,'alpha',0.5)
			setObjectOrder('noteGroup',getObjectOrder('mirrorBroken'))
		end

		for i = 0,getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes',i,'mustPress') then else
				setPropertyFromGroup('unspawnNotes',i,'scale.x',0.8)
				setPropertyFromGroup('unspawnNotes',i,'scale.y',0.8)
				if getPropertyFromGroup('unspawnNotes',i,'isSustainNote') then
					setPropertyFromGroup('unspawnNotes',i,'scale.y',2)
				end
			end
		end

		setObjectOrder('bars',getObjectOrder('noteGroup')-1)
		setObjectOrder('videoSprite',getObjectOrder('bars')-1)
		setObjectOrder('blackScreen',getObjectOrder('bars')-1)
		--[[for i = 0,getProperty('notes.length') do
			if getPropertyFromGroup('notes',i,'isSustainNote')  then
				setPropertyFromGroup('notes',i,'scale.y',4)
			end
		end]]
	end
end
