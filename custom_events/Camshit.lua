function onEvent(name,value1,value2)
if name == 'Camshit' then
  
	if value1 == 'bf' then
    setProperty('camFollowPos.x',2200)
    setProperty('camFollowPos.y',1100)
    setProperty('camFollow.x',2200)
    setProperty('camFollow.y',1100)

    setProperty('isCameraOnForcedPos',true)
  end		

	if value1 == 'dad' then
  setProperty('camFollowPos.x',1700)
  setProperty('camFollowPos.y',1100)
  setProperty('camFollow.x',1700)
  setProperty('camFollow.y',1100)

  setProperty('isCameraOnForcedPos',true)

  end	

	if value1 == 'gf' then
    setProperty('camFollowPos.x',1000)
    setProperty('camFollowPos.y',900)
    setProperty('camFollow.x',1900)
    setProperty('camFollow.y',1000)

    setProperty('isCameraOnForcedPos',true)
  end	

    if value1 == 'Camjerk' then
      setProperty('defaultCamZoom',value2)
      setProperty('camGame.zoom',value2)
end
   end 
end
