-- File: custom_events/Unown.lua
local isTyping = false
local wordToType = ""
local currentIdx = 1
local mistakeCount = 0
local wordPool = {"HMFNF", "CON CAC", "HOA DEP TRAI", "DISCORD MESS", "OKE", "HOANOCHROME"}
local alphabet = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}

-- HÀM KIỂM TRA KÝ TỰ BỎ QUA (Khoảng trắng, dấu chấm, phẩy...)
local function isSkippable(char)
    return char == " " or char == "!" or char == "?" or char == "." or char == "," or char == ":"
end

function onEvent(name, value1, value2)
    if name == 'Unown' then
        if isTyping then return end
        
        -- Lấy từ cần gõ
        if value2 ~= nil and value2 ~= "" then
            wordToType = value2
        else
            wordToType = wordPool[getRandomInt(1, #wordPool)]
        end
        
        -- BÍ QUYẾT SỬA LỖI ĐÂY: Ép toàn bộ từ thành CHỮ IN HOA để khớp với mảng alphabet
        wordToType = string.upper(wordToType)
        
        isTyping = true
        currentIdx = 1
        mistakeCount = 0
        
        makeLuaText('unownWord', wordToType, 1280, 0, 250)
        setTextSize('unownWord', 60)
        setTextAlignment('unownWord', 'center')
        setObjectCamera('unownWord', 'other')
        addLuaText('unownWord')
        
        makeLuaText('unownProgress', '', 1280, 0, 330)
        setTextSize('unownProgress', 50)
        setTextAlignment('unownProgress', 'center')
        setTextColor('unownProgress', '00FF00')
        setObjectCamera('unownProgress', 'other')
        addLuaText('unownProgress')
        
        makeLuaText('unownErrors', 'Lỗi: 0/3', 1280, 0, 410)
        setTextSize('unownErrors', 40)
        setTextAlignment('unownErrors', 'center')
        setTextColor('unownErrors', 'FF0000')
        setObjectCamera('unownErrors', 'other')
        addLuaText('unownErrors')
    end
end

-- Chặn phím nhấn note của game
function onKeyPress(key)
    if isTyping then return Function_Stop end
end
function onGhostTap(key)
    if isTyping then return Function_Stop end
end

-- CHẶN NÚT RESET ('R') VÀ CHẾT DO MISS NOTE TRONG LÚC GÕ
function onGameOver()
    if isTyping then
        return Function_Stop 
    end
    return Function_Continue
end

function onUpdatePost(elapsed)
    if isTyping then
        -- VÒNG LẶP TỰ ĐỘNG BỎ QUA DẤU CÁCH VÀ DẤU CÂU
        while currentIdx <= string.len(wordToType) and isSkippable(string.sub(wordToType, currentIdx, currentIdx)) do
            currentIdx = currentIdx + 1
            setTextString('unownProgress', string.sub(wordToType, 1, currentIdx - 1))
        end
        
        -- Kiểm tra xem đã hoàn thành từ chưa sau khi tự động vượt qua
        if currentIdx > string.len(wordToType) then
            finishUnown(true)
            return
        end

        local neededChar = string.sub(wordToType, currentIdx, currentIdx)
        local pressedSomething = false
        local pressedCorrect = false
        
        -- SỬ DỤNG BỘ FIX PHÍM TỪ CODE HYPNO LULLABY BẠN ĐƯA
        local keyFix = {
            D = keyboardJustPressed('D'),
            Y = keyboardJustPressed('Y'),
            H = keyboardJustPressed('H'),
            O = keyboardJustPressed('O')
        }
        
        -- Quét kiểm tra phím bấm gọi trực tiếp vào bộ input của lõi HaxeFlixel
        for i = 1, #alphabet do
            local checkChar = alphabet[i]
            local isPressed = keyFix[checkChar] or getPropertyFromClass("flixel.FlxG", "keys.justPressed." .. checkChar)
            
            if isPressed then
                pressedSomething = true
                if checkChar == neededChar then
                    pressedCorrect = true
                    break -- Ưu tiên nhận phím đúng nếu lỡ tay bấm đè 2 phím cùng lúc
                end
            end
        end
        
        if pressedSomething then
            if pressedCorrect then
                currentIdx = currentIdx + 1
                setTextString('unownProgress', string.sub(wordToType, 1, currentIdx - 1))
                playSound('scrollMenu')
                
                if currentIdx > string.len(wordToType) then
                    finishUnown(true)
                end
            else
                mistakeCount = mistakeCount + 1
                setTextString('unownErrors', 'Lỗi: ' .. mistakeCount .. '/3')
                playSound('cancelMenu')
                cameraShake('camOther', 0.02, 0.2)
                
                if mistakeCount >= 3 then
                    finishUnown(false)
                end
            end
        end
    end
end

function finishUnown(success)
    isTyping = false
    removeLuaText('unownWord', true)
    removeLuaText('unownProgress', true)
    removeLuaText('unownErrors', true)
    
    if not success then
        setProperty('health', -1)
    else
        if getProperty('health') <= 0 then
            setProperty('health', 0.1)
        end
    end
end