local colors = {'Purple','Blue','Green','Red'}
local path = 'sustainHold'

local offsetX = -36
local offsetY = -60

-- HOLD SPRITES
function createSprite(color, suffix)
    local spr = 'hold'..color..suffix

    makeAnimatedLuaSprite(spr, path, 210, 90)
    addAnimationByPrefix(spr, 'loop', 'hold splash loop', 24, true)
    addAnimationByPrefix(spr, 'end', 'hold splash end', 24, false)

    addLuaSprite(spr, true)
    setObjectCamera(spr, 'hud')
    scaleObject(spr, 0.8, 0.8)

    setProperty(spr..'.visible', false)
end

function onCountdownStarted()
    for i, color in pairs(colors) do
        createSprite(color, 'BF')
        createSprite(color, 'DAD')

        local bfStrum = i + 3
        local dadStrum = i - 1

        -- RGB Shaders
        runHaxeCode([[
            var sprBF = game.getLuaObject('hold]]..color..[[BF');
            var strumBF = game.strumLineNotes.members[]]..bfStrum..[[];
            if (sprBF != null && strumBF != null && strumBF.rgbShader != null) {
                try { sprBF.shader = strumBF.rgbShader.parent.shader; } 
                catch(e:Dynamic) { sprBF.shader = strumBF.rgbShader.shader; }
            }

            var sprDAD = game.getLuaObject('hold]]..color..[[DAD');
            var strumDAD = game.strumLineNotes.members[]]..dadStrum..[[];
            if (sprDAD != null && strumDAD != null && strumDAD.rgbShader != null) {
                try { sprDAD.shader = strumDAD.rgbShader.parent.shader; } 
                catch(e:Dynamic) { sprDAD.shader = strumDAD.rgbShader.shader; }
            }
        ]])
    end
end

function onUpdatePost()
    for i, color in pairs(colors) do
        for _, suffix in pairs({'BF','DAD'}) do
            local spr = 'hold'..color..suffix

            local strumIndex = (suffix == 'BF') and (i + 3) or (i - 1)

            local posx = getProperty('strumLineNotes.members['..strumIndex..'].x')
            local posy = getProperty('strumLineNotes.members['..strumIndex..'].y')

            setProperty(spr..'.x', posx + offsetX)
            setProperty(spr..'.y', posy + offsetY)
            setPropertyFromGroup('noteSplashes', i, 'alpha', 1)
            setProperty(spr..'.alpha', 1)

            if getProperty(spr..'.animation.name') == 'end' and getProperty(spr..'.animation.finished') then
                setProperty(spr..'.visible', false)
                playAnim(spr, 'loop', true)
            end

            if getProperty(spr..'.animation.name') == 'end' then
                setProperty(spr..'.visible', true)
            end
        end
    end
end

function noteHit(opponent, i, direction, isSustain)
    if not isSustain then return end

    local spr = 'hold'..colors[direction + 1]..(opponent and 'DAD' or 'BF')
    local anim = getPropertyFromGroup('notes', i, 'animation.name')
    local isEnd = stringEndsWith(anim, 'end')

    setProperty(spr..'.visible', not (opponent and isEnd))

    if not opponent then
        playAnim(spr, isEnd and 'end' or 'loop', true)
    end
end

function goodNoteHit(i, d, _, s)
    noteHit(false, i, d, s)
end

function opponentNoteHit(i, d, _, s)
    noteHit(true, i, d, s)
end

-- HIDE ON RELEASE
function onKeyRelease(n)
    setProperty('hold'..colors[n+1]..'BF.visible', false)
end

function onResume()
    for i = 1, #colors do
        setProperty('hold'..colors[i]..'BF.visible', false)
    end
end

function onSpawnNote(id, noteData, noteType, isSustainNote)
    if isSustainNote then
         setPropertyFromGroup('notes', id, 'alpha', 1)
         setPropertyFromGroup('notes', id, 'multAlpha', 1)
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
    setProperty('hold'..colors[direction+1]..'BF.visible', false)
end