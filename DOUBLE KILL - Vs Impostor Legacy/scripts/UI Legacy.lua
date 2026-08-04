local Config = {
    timeBarOffsetX = 90,
    timeBarOffsetY = 0,

    timeBarWidth = 390,
    timeBarHeight = 10
}
function onCreatePost()
    setProperty("timeBarBG.visible", false)
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)

    makeLuaText("tempPos", "", 400, 0, 0)
    setObjectCamera("tempPos", "hud")
    setTextSize("tempPos", 14)
    setTextColor("tempPos", "FFFFFF")
    setTextAlignment("tempPos", "left")
    setTextBorder("tempPos", 1, "000000")
    addLuaText("tempPos")

    makeLuaText('songtitle', "", 400, 0, 0)
    setTextFont("songtitle", "vcr-v4.ttf")
    setObjectCamera("songtitle", "hud")
    setTextSize("songtitle", 14)
    setTextColor("songtitle", "FFFFFF")
    setTextAlignment("songtitle", "left")
    setTextBorder("songtitle", 1, "000000")
    addLuaText("songtitle")
    setProperty("songtitle.alpha", 0)
    setTextString("songtitle", string.upper(songName))

    if downscroll then
        setProperty("tempPos.y", screenHeight - 45)
    else
        setProperty("tempPos.y", 20)
    end
    setPropertyFromClass('backend.ClientPrefs', 'data.pauseMusic', 'Breakfast')

    makeLuaSprite('greyGraphic', nil, -550, 185)
    makeGraphic('greyGraphic', 400/1.6, 105, 'FFFFFF')
    setProperty('greyGraphic.alpha', 0.6/2)
    setObjectCamera('greyGraphic', 'other')
    setObjectOrder('greyGraphic', 114513)
    addLuaSprite('greyGraphic', false)
    
    makeLuaText('infoTitle', songName, 1280, -500, 195)
    setTextSize('infoTitle', 20)
    setTextAlignment('infoTitle', 'left')
    setTextFont('infoTitle', 'liberbold.ttf')
    setTextBorder('infoTitle', 1.8, '000000')
    setObjectOrder('infoTitle', 114514)
    setObjectCamera('infoTitle', 'other')
    addLuaText('infoTitle')

    makeLuaText('infoComposer', 'Credits: NOTXMAS BG', 1280, -500, 225)
    setTextSize('infoComposer', 20)
    setTextAlignment('infoComposer', 'left')
    setTextFont('infoComposer', 'liberbold.ttf')
    setTextBorder('infoComposer', 1.8, '000000')
    setObjectOrder('infoComposer', 114514)
    setObjectCamera('infoComposer', 'other')
    addLuaText('infoComposer')

    makeLuaText('infoOptimized', 'Optimized: VGPH Mods', 1280, -500, 255)
    setTextSize('infoOptimized', 20)
    setTextAlignment('infoOptimized', 'left')
    setTextFont('infoOptimized', 'liberbold.ttf')
    setTextBorder('infoOptimized', 1.8, '000000')
    setObjectOrder('infoOptimized', 114514)
    setObjectCamera('infoOptimized', 'other')
    addLuaText('infoOptimized')

makeLuaSprite("v4TimeBarBG", "timeBar", 0, 0)
setObjectCamera("v4TimeBarBG", "hud")
setProperty("v4TimeBarBG.alpha", 0)
addLuaSprite("v4TimeBarBG")

makeLuaSprite("v4TimeBar", "", 0, 0)
makeGraphic("v4TimeBar", Config.timeBarWidth, Config.timeBarHeight, "44d844")
setObjectCamera("v4TimeBar", "hud")
setProperty("v4TimeBar.alpha", 0)
addLuaSprite("v4TimeBar")

setProperty("v4TimeBar.origin.x", 0)
setProperty("v4TimeBar.origin.y", 0)
end
function onGameOverStart()
    local language = getPropertyFromClass('backend.ClientPrefs', 'data.language')
    makeLuaSprite('EnterRes', 'menu/controls/enter', 40, 678) 
    setObjectCamera('EnterRes', 'camOther')
    addLuaSprite('EnterRes', false)
    if language == 'pt-BR' then
    makeLuaText('txtRes', 'Reiniciar', 200, 110, 690)
    setTextSize('txtRes', 20)
    setTextAlignment('txtRes', 'left')
    setObjectCamera('txtRes', 'camOther')
    addLuaText('txtRes')
    else
    makeLuaText('txtRes', 'Restart Song', 200, 110, 690)
    setTextSize('txtRes', 20)
    setTextAlignment('txtRes', 'left')
    setObjectCamera('txtRes', 'camOther')
    addLuaText('txtRes')
    end
    makeLuaSprite('EscBack', 'menu/controls/esc', 265, 678)
    setObjectCamera('EscBack', 'camOther')
    addLuaSprite('EscBack', false)
    if language == 'pt-BR' then
    makeLuaText('txtMenu', 'Menu Principal', 200, 315, 690)
    setTextSize('txtMenu', 20)
    setTextAlignment('txtMenu', 'left')
    setObjectCamera('txtMenu', 'camOther')
    addLuaText('txtMenu')
    else
    makeLuaText('txtMenu', 'Back To Menu', 200, 315, 690)
    setTextSize('txtMenu', 20)
    setTextAlignment('txtMenu', 'left')
    setObjectCamera('txtMenu', 'camOther')
    addLuaText('txtMenu')
    end
end
function onSongStart()
    start = true

    doTweenAlpha("barBG", "v4TimeBarBG", 1, 0.5, "circOut")
    doTweenAlpha("barFill", "v4TimeBar", 1, 0.5, "circOut")
    doTweenAlpha("barTxt", "tempPos", 1, 0.5, "circOut")
    doTweenAlpha("songTitle", "songtitle", 1, 0.5, "circOut")

    doTweenX('greyX', 'greyGraphic', 0, 1, 'smootherStepOut')
    doTweenX('TitleX', 'infoTitle', 15, 1, 'smootherStepOut')
    doTweenX('infoX', 'infoComposer', 15, 1, 'smootherStepOut')
    doTweenX('optimizeX', 'infoOptimized', 15, 1, 'smootherStepOut')
    runTimer('adiosCreditos', 5)
end
function onUpdate(elapsed)
    if start then
        setProperty("v4TimeBar.visible", true)

        local percent = getSongPosition() / songLength
        percent = math.min(math.max(percent, 0), 1)

        setProperty("v4TimeBar.scale.x", percent)
    end
end
function onTimerCompleted(tag)
    if tag == 'adiosCreditos' then
        doTweenX('greyX', 'greyGraphic', -550, 1, 'smootherStepOut')
        doTweenX('TitleX', 'infoTitle', -550, 1, 'smootherStepOut')
        doTweenX('infoX', 'infoComposer', -550, 1, 'smootherStepOut')
        doTweenX('optimizeX', 'infoOptimized', -550, 1, 'smootherStepOut')
        runTimer('borrenlosss', 2)
    elseif tag == 'borrenlosss' then
        removeLuaSprite('greyGraphic', true)
        removeLuaText('infoTitle', true)
        removeLuaText('infoComposer', true)
        removeLuaText('infoOptimized', true)
    end
end
function onUpdatePost()
    local currentScore = getProperty('songScore') or 0
    local currentMisses = getProperty('songMisses') or 0
    local currentHits = getProperty('songHits') or 0
    local rawRating = getProperty('ratingPercent') or 0
    local acc = math.floor(rawRating * 10000) / 100

    if currentScore ~= oldScore or currentMisses ~= oldMisses or acc ~= oldAcc then
        local accDisplay = 'N/A'
        local rankDisplay = getRank(acc, currentMisses, currentHits)

        if currentHits > 0 or currentMisses > 0 then
            accDisplay = string.format("%.2f%%", acc)
        end

setProperty("v4TimeBarBG.x", getProperty("tempPos.x") + Config.timeBarOffsetX)

if downscroll then
    setProperty("v4TimeBarBG.y", getProperty("tempPos.y") + 10)
else
    setProperty("v4TimeBarBG.y", getProperty("tempPos.y") + 0)
end

setProperty("v4TimeBar.x", getProperty("v4TimeBarBG.x") + 3)
setProperty("v4TimeBar.y", getProperty("v4TimeBarBG.y") + 5)

local baseX = getProperty("v4TimeBar.x")
local baseY = getProperty("v4TimeBar.y")

-- center-ish offset
setProperty("songtitle.x", baseX + 10)
setProperty("songtitle.y", baseY - 5)

    local language = getPropertyFromClass('backend.ClientPrefs', 'data.language')
    if language == 'pt-BR' then
        setTextString('scoreTxt', 'Pontos: ' .. formatNumber(currentScore) .. ' | Erros: ' .. currentMisses .. ' | Média: ' .. accDisplay .. ' | Nota: ' .. rankDisplay)
    else
        setTextString('scoreTxt', 'Score: ' .. formatNumber(currentScore) .. ' | Misses: ' .. currentMisses .. ' | Accuracy: ' .. accDisplay .. ' | Rank: ' .. rankDisplay)
    end

        oldScore = currentScore
        oldMisses = currentMisses
        oldAcc = acc
    end
    local rgb = getProperty('dad.healthColorArray')
    if rgb and not songName == 'Double Kill' then
        local hexColor = string.format('%02x%02x%02x', rgb[1], rgb[2], rgb[3])
        setTextColor('scoreTxt', hexColor)
    end
end
function formatNumber(amount)
    local formatted = tostring(amount)
    while true do
        local k
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end
function getRank(acc, misses, hits)
    if hits == 0 and misses == 0 then return 'N/A' end
    if misses == 0 and acc >= 98.0 then return 'P' end
    if misses == 0 and acc >= 90.0 then return 'S' end
    if acc >= 80.0 then return 'A' end
    if acc >= 70.0 then return 'B' end
    if acc >= 60.0 then return 'C' end
    if acc >= 50.0 then return 'D' end
    if acc >= 40.0 then return 'E' end
    return 'F'
end