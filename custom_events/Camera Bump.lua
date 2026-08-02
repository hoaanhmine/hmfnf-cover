function onEvent(name, value1, value2)
    if name == 'Camera Bump' then
        setProperty(value2..'.zoom', getProperty(value2..'.zoom') + tonumber(value1));
    end
end