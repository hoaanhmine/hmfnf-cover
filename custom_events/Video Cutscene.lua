local videoBool = false;
function onCreatePost()
    if version <= '1.0' then
        if buildTarget == 'android' then
            addHaxeLibrary('VideoHandler','hxcodec');
        else
            addHaxeLibrary('FlxVideo','hxcodec.flixel');
        end
        addHaxeLibrary('Event','openfl.events');
    end
end
function onEvent(name,value1,value2)
    if name == "Video Cutscene" then
        if version <= '1.0' then
            makeLuaSprite('videoSprite',nil, 0, 0);
            makeGraphic('videoSprite', 1280, 720, '000000');
            setObjectCamera('videoSprite','camHUD');
            setObjectOrder('videoSprite', getObjectOrder('noteGroup') - 1);
            addLuaSprite('videoSprite');
            if buildTarget == 'android' then
                runHaxeCode([[
                    var video:VideoHandler = new VideoHandler();
                    video.playVideo(Paths.video("]]..(value1)..[["));
                    video.visible = false;
                    video.alpha = 0.001;
                    setVar('video',video);
                    FlxG.stage.removeEventListener('enterFrame', video.update);
                    game.getLuaObject('videoSprite').loadGraphic(video.bitmapData);
                    return;
                ]]);
            else
                runHaxeCode([[
                    var video = new FlxVideo();
                    video.play(Paths.video("]]..(value1)..[["));
                    video.alpha = 0.001;
                    setVar('video',video);
                    return;
                ]]);
            end
            videoBool = true;
            runTimer('destroy', tonumber(value2));
        else
            startVideo((value1), false, true, false, false);
            callMethod('videoCutscene.play');
            setObjectCamera('videoCutscene', 'camHUD');
            setObjectOrder('videoCutscene', getObjectOrder('noteGroup') - 1);
        end
    end
end
function onTimerCompleted(tag)
    if tag == 'destroy' then
        videoBool = false;
        if buildTarget == 'android' then
            runHaxeCode([[
                var sprite = game.getLuaObject('videoSprite');
                sprite.kill();
                sprite.destroy();
                game.modchartSprites.remove('videoSprite');
            ]]);
        else
            runHaxeCode([[
                var sprite = game.getLuaObject('videoSprite');
                sprite.kill();
                sprite.destroy();
                game.modchartSprites.remove('videoSprite');
                var video = getVar('video');
                video.dispose();
            ]]);
        end
    end
end
function onUpdate()
    if version <= '1.0' then
        if videoBool then
            widthV = getProperty('videoSprite.width');
            heightV = getProperty('videoSprite.height');
            scaleVX = 1280 / widthV;
            scaleVY = 720 / heightV;
            setProperty('videoSprite.scale.x', scaleVX);
            setProperty('videoSprite.scale.y', scaleVY);
            screenCenter('videoSprite', 'xy');
            runHaxeCode([[
                var video = getVar('video');
                if(video != null && video.bitmapData != null){
                    game.getLuaObject('videoSprite').loadGraphic(video.bitmapData);
                    return;
                }
            ]]);
        end
    end
end
function onPause()
    if version <= '1.0' then
        if videoBool then
            runHaxeCode([[
                var video = getVar('video');
                if(game.paused)video.pause();
                return;
            ]]);
        end
    else
        if getProperty('videoCutscene') == nil then return end
        callMethod('videoCutscene.pause');
    end
end
function onResume()
    if version <= '1.0' then
        if videoBool then
            runHaxeCode([[
                var video = getVar('video');
                video.resume();
            ]]);
        end
    else
        if getProperty('videoCutscene') == nil then return end
        callMethod('videoCutscene.resume');
    end
end
function onEndSong()
    if version <= '1.0' then
        if videoBool then
            videoBool = false;
            runHaxeCode([[
                var video = getVar('video');
                if(game.paused)video.pause();
                return;
            ]]);
        end
    else
        if getProperty('videoCutscene') == nil then return end
        callMethod('videoCutscene.pause');
    end
end
function onGameOver()
    if version <= '1.0' then
        if videoBool then
            videoBool = false;
            runHaxeCode([[
                var video = getVar('video');
                if(game.paused)video.pause();
                return;
            ]]);
        end
    else
        if getProperty('videoCutscene') == nil then return end
        callMethod('videoCutscene.pause');
    end
end
function onDestroy()
    if version <= '1.0' then
        if videoBool then
            videoBool = false;
            runHaxeCode([[
                var video = getVar('video');
                if(game.paused)video.pause();
                return;
            ]]);
        end
    else
        if getProperty('videoCutscene') == nil then return end
        callMethod('videoCutscene.pause');
    end
end