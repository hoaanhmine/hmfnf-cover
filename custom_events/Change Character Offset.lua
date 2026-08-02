function onCreate()
    addHaxeLibrary("FlxTween", "flixel.tweens");
end
function onEvent(name, value1, value2)
    if name == 'Change Character Offset' then
        paramsO6 = split(value2,',')[2];
        if paramsO6 == 'linear' then
            paramsO7 = '';
        else
            paramsO7 = split(value2,',')[3];
        end
        paramsO2 = split(value1,',')[2];
        if paramsO2 == '0' then
            paramsO2 = 'opponent';
        end
        if paramsO2 == '1' then
            paramsO2 = 'boyfriend';
        end
        if paramsO2 == '2' then
            paramsO2 = 'girlfriend';
        end
        paramsO1 = split(value1,',')[1];
        params03 = tonumber(split(value1,',')[3]);
        params04 = tonumber(split(value1,',')[4]);
        params05 = tonumber(split(value2,',')[1]);
        if paramsO1 == 'true' then
            runHaxeCode([[
                var offsetXT:FlxTween;
                var offsetYT:FlxTween;
                for (tween in [offsetXT, offsetYT]){
                    if (tween != null){
                        tween.cancel();
                    }
                    offsetXT = FlxTween.num(]]..paramsO2..[[CameraOffset[0], ]]..paramsO2..[[CameraOffset[0] + (]]..params03..[[), ((Conductor.crochet / 4) / 1000) * (]]..params05..[[), {ease: FlxEase.]]..paramsO6..paramsO7..[[, onUpdate: function(twn:FlxTween){
                        ]]..paramsO2..[[CameraOffset[0] = twn.value;
                        }
                    });
                    offsetYT = FlxTween.num(]]..paramsO2..[[CameraOffset[1], ]]..paramsO2..[[CameraOffset[1] + (]]..params04..[[), ((Conductor.crochet / 4) / 1000) * (]]..params05..[[), {ease: FlxEase.]]..paramsO6..paramsO7..[[, onUpdate: function(twn:FlxTween){
                        ]]..paramsO2..[[CameraOffset[1] = twn.value;
                        }
                    });
                }
            ]]);
        else
            setProperty(paramsO2..'CameraOffset[0]', getProperty(paramsO2..'CameraOffset[0]') + (params03));
            setProperty(paramsO2..'CameraOffset[1]', getProperty(paramsO2..'CameraOffset[1]') + (params04));
        end
    end
end
function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end