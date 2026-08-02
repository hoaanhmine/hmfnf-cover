local isActive = false
local currentSequence = {} 
local progressIndex = 1
local timeLeft = 0
local maxTime = 0

-- [[ BIẾN MỚI: ĐẾM LỖI ]]
local currentMisses = 0
local maxAllowedMisses = 3 -- Sai quá 3 lần là thua

-- [[ CẤU HÌNH ]]
local noteSpacing = 110    -- Khoảng cách giữa các nốt
local noteScale = 0.65     -- Kích thước nốt

function onCreate()
    -- Random Seed
    math.randomseed(os.time() + os.clock() * 10000)
    math.random(); math.random(); math.random()

    precacheImage('NOTE_assets')
    debugPrint('Audition Handler Loaded (3 Strikes Mode)!')
end

function onEvent(name, value1, value2)
    if name == 'Audition Mode' then
        local noteCount = tonumber(value1)
        local durationBeats = tonumber(value2)

        if noteCount == nil or noteCount < 1 then noteCount = 6 end
        if durationBeats == nil or durationBeats < 1 then durationBeats = 4 end

        startAudition(noteCount, durationBeats)
    end
end

function startAudition(count, beats)
    if isActive then return end
    
    isActive = true
    progressIndex = 1
    currentSequence = {}
    currentMisses = 0 -- Reset số lần sai
    
    local durationSec = (stepCrochet * (beats * 4)) / 1000
    maxTime = durationSec
    timeLeft = durationSec

    -- Tính vị trí bắt đầu
    local startX = (1280 - (count * noteSpacing)) / 2 + (noteSpacing / 2)

    for i = 1, count do
        -- Random hướng: 0=Left, 1=Down, 2=Up, 3=Right
        local dir = math.random(0, 3)
        table.insert(currentSequence, dir)
        
        local tag = 'audNote_' .. i
        
        makeAnimatedLuaSprite(tag, 'NOTE_assets', startX + (i-1)*noteSpacing, 300)
        
        if dir == 0 then
            addAnimationByPrefix(tag, 'static', 'purple0', 24, true)
            addAnimationByPrefix(tag, 'confirm', 'left confirm', 24, false)
        elseif dir == 1 then
            addAnimationByPrefix(tag, 'static', 'blue0', 24, true)
            addAnimationByPrefix(tag, 'confirm', 'down confirm', 24, false)
        elseif dir == 2 then
            addAnimationByPrefix(tag, 'static', 'green0', 24, true)
            addAnimationByPrefix(tag, 'confirm', 'up confirm', 24, false)
        elseif dir == 3 then
            addAnimationByPrefix(tag, 'static', 'red0', 24, true)
            addAnimationByPrefix(tag, 'confirm', 'right confirm', 24, false)
        end
        
        scaleObject(tag, noteScale, noteScale)
        objectPlayAnimation(tag, 'static', true)
        setObjectCamera(tag, 'other')
        addLuaSprite(tag, true)
    end

    -- Thanh thời gian
    makeLuaSprite('audTimerBG', '', 0, 420)
    makeGraphic('audTimerBG', 600, 15, '000000')
    screenCenter('audTimerBG', 'x')
    setObjectCamera('audTimerBG', 'other')
    addLuaSprite('audTimerBG', true)

    makeLuaSprite('audTimer', '', 0, 420)
    makeGraphic('audTimer', 600, 15, '00FF00')
    screenCenter('audTimer', 'x')
    setObjectCamera('audTimer', 'other')
    addLuaSprite('audTimer', true)

    -- Hiển thị bộ đếm lỗi
    makeLuaText('missCounter', 'LỖI: 0/'..maxAllowedMisses, 1280, 0, 500)
    setTextSize('missCounter', 40)
    setTextColor('missCounter', 'FFFFFF')
    setObjectCamera('missCounter', 'other')
    screenCenter('missCounter', 'x')
    addLuaText('missCounter')

    playSound('scrollMenu', 1)
end

function onUpdate(elapsed)
    if isActive then
        timeLeft = timeLeft - elapsed
        local pct = timeLeft / maxTime
        if pct < 0 then pct = 0 end
        scaleObject('audTimer', pct, 1)

        -- Hết giờ -> Thua
        if timeLeft <= 0 then
            finishAudition(false)
            return
        end

        if progressIndex <= #currentSequence then
            local expected = currentSequence[progressIndex]
            
            -- Kiểm tra xem người chơi bấm nút gì
            local input = -1
            if keyJustPressed('left') then input = 0 end
            if keyJustPressed('down') then input = 1 end
            if keyJustPressed('up') then input = 2 end
            if keyJustPressed('right') then input = 3 end

            -- Nếu có bấm nút
            if input > -1 then
                if input == expected then
                    -- [[ BẤM ĐÚNG ]]
                    local tag = 'audNote_' .. progressIndex
                    objectPlayAnimation(tag, 'confirm', true)
                    doTweenAlpha('fadeNote'..progressIndex, tag, 0.4, 0.2, 'linear')

                    playSound('scrollMenu', 0.6)
                    progressIndex = progressIndex + 1

                    -- Hoàn thành chuỗi
                    if progressIndex > #currentSequence then
                        finishAudition(true)
                    end
                else
                    -- [[ BẤM SAI ]]
                    currentMisses = currentMisses + 1
                    playSound('missnote1', 1) -- Âm thanh Miss
                    
                    -- Rung màn hình nhẹ
                    cameraShake('other', 0.01, 0.1)
                    
                    -- Cập nhật chữ
                    setTextString('missCounter', 'LỖI: '..currentMisses..'/'..maxAllowedMisses)
                    setTextColor('missCounter', 'FF0000') -- Đổi màu đỏ cảnh báo
                    
                    -- Hiện thông báo trôi lên
                    local missTag = 'missPop'..currentMisses
                    makeLuaText(missTag, 'SAI!', 200, 0, 0)
                    setTextSize(missTag, 50)
                    setTextColor(missTag, 'FF0000')
                    setObjectCamera(missTag, 'other')
                    -- Canh vị trí chữ "SAI" ngay trên đầu nốt đang bấm
                    local noteX = getProperty('audNote_'..progressIndex..'.x')
                    local noteY = getProperty('audNote_'..progressIndex..'.y')
                    setProperty(missTag..'.x', noteX + 10)
                    setProperty(missTag..'.y', noteY - 50)
                    addLuaText(missTag)
                    doTweenY(missTag..'Move', missTag, noteY - 100, 0.5, 'linear')
                    doTweenAlpha(missTag..'Fade', missTag, 0, 0.5, 'linear')

                    -- Kiểm tra thua cuộc
                    if currentMisses >= maxAllowedMisses then
                        finishAudition(false)
                    end
                end
            end
        end
    end
end

function finishAudition(win)
    isActive = false
    
    -- Xóa hình ảnh nốt
    for i = 1, 20 do
        removeLuaSprite('audNote_'..i, true)
    end
    -- Xóa UI
    removeLuaSprite('audTimer', true)
    removeLuaSprite('audTimerBG', true)
    removeLuaText('missCounter', true)

    if win then
        -- [[ TRƯỜNG HỢP THẮNG ]] --
        playSound('confirmMenu', 1)
        setProperty('songScore', getProperty('songScore') + 5000)
        
        characterPlayAnim('boyfriend', 'hey', true)
        setProperty('boyfriend.specialAnim', true)
        
        makeLuaText('audResult', 'Tuyệt!', 1280, 0, 300)
        setTextSize('audResult', 80)
        setTextColor('audResult', '00FF00')
        setTextBorder('audResult', 4, '000000')
        setObjectCamera('audResult', 'other')
        screenCenter('audResult', 'x')
        addLuaText('audResult')
        doTweenAlpha('hideRes', 'audResult', 0, 1, 'linear')
    else
        -- [[ TRƯỜNG HỢP THUA ]] --
        playSound('missnote1', 1)
        
        -- Nếu thua do hết giờ hay do bấm sai quá nhiều đều chết
        setProperty('health', -1) 
        
        makeLuaText('audResult', 'THẤT BẠI!', 1280, 0, 300)
        setTextSize('audResult', 80)
        setTextColor('audResult', 'FF0000')
        setTextBorder('audResult', 4, '000000')
        setObjectCamera('audResult', 'other')
        screenCenter('audResult', 'x')
        addLuaText('audResult')
    end
end