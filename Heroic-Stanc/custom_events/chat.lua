function onCreatePost()
makeLuaText('Chat Text','',1800,-350,500)
		setTextAlignment('Chat Text','center')
		addLuaText('Chat Text',true)
		setTextSize('Chat Text',60)
		setObjectCamera('Chat Text','camOther')
		if getProperty('dad.curCharacter') == 'gumball' then
			setTextFont('Chat Text','Gumball.ttf')
		elseif string.sub(getProperty('dad.curCharacter'),1,4) == 'finn' then
			setTextFont('Chat Text','Thunderman.ttf')
		end

		setObjectOrder('Chat Text',50)
		end

function onEvent(name,value1,value2)
	if name == 'chat' then
		setProperty('Chat Text.alpha',1)
		if value2 ~= '' then
			setTextString('Chat Text',value2)
			
			if string.len(value1) == 6 then
				setTextColor('Chat Text',value1)
			end
		end

		if string.len(value1) == 6 then
			setTextColor('Chat Text',value1)
		end

		if string.len(value1) > 6 and string.sub(value1,7,7) == ',' and string.sub(value1,14,14) == ',' then
			setTextColor('Chat Text',string.sub(value1,1,6))
			doTweenColor('Chat Text Color','Chat Text',string.sub(value1,8,13),tonumber(string.sub(value1,15,string.len(value1))),'cubeIn')
		end

		
	end
end

