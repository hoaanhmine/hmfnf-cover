local originalZoom = 0

function onCreatePost()
    originalZoom = getProperty('defaultCamZoom')
end

function onEvent(name, value1, value2)
    if name == 'Extra Cam Zoom' then
        if value1 ~= '' then
            local zoomChange = tonumber(value1) or 0
            setProperty('defaultCamZoom', originalZoom + zoomChange)
        else
            setProperty('defaultCamZoom', originalZoom)
        end
    end
end
