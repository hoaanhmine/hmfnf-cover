glit = 1.4

function onCountdownTick(counter)
    if counter == 1 then
        makeLuaSprite("shadertest")
        makeGraphic("shadertest", screenWidth, screenHeight)
         
        initLuaShader("cyclesd")
        setSpriteShader('corruption', 'cyclesd')
        setShaderFloat('corruption', 'amount', 0)         
        
        runHaxeCode([[
            var shaderVcr = game.createRuntimeShader('glitchChromatic');                
            return;
        ]])
    end           
end

function onCreatePost()
    -- Chỉ khởi tạo (preload) shader từ đầu để không bị lag khi gọi ở beat 400
    initLuaShader("NewGlitch2") 
end

function onBeatHit()
    -- 1. Shader của 'corruption' vẫn update ngẫu nhiên theo mỗi beat ngay từ đầu game
    if curBeat % 1 == 0 then
        setShaderFloat('corruption', 'pixel', math.random(5,10))
    end

    -- 2. Ngay tại đúng beat 400, áp dụng shader vào dad
    if curBeat == 423 then
        setSpriteShader("dad", "NewGlitch2")
        setShaderFloat("dad", "negativity", 0)
    end

    if curBeat >= 423 then
        if curBeat % 1 == 0 then
            setShaderFloat('dad', 'binaryIntensity', getRandomFloat(0.8, -0.9))
        end
    end
end

function onUpdate(elapsed)
    -- Hàm này để trống hoặc thêm code update mỗi frame tùy ý bạn
end

function onEvent(eventName, value1, value2)
    -- Kiểm tra nếu event được kích hoạt là Change Character
    if eventName == 'Change Character' then
        
        -- value1 trong event này thường là 'dad' (hoặc '1') đại diện cho đối thủ
        if value1 == 'dad' or value1 == '1' then
            
            -- Nếu sự kiện này xảy ra sau beat 423, ốp lại shader cho nhân vật mới
            if curBeat >= 423 then
                setSpriteShader("dad", "NewGlitch2")
                setShaderFloat("dad", "negativity", 0)
            end
            
        end
    end
end