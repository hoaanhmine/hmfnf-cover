function onEvent(eventName, value1, value2)
    if eventName == 'flash' then
        cameraFlash('camHUD', 'FFFFFF', 0.5, true)
    end
end