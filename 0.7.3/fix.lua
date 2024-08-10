local isGirlfriend = false

function healthDrain(health)
    local extraDamage = (health / 4) * 0.075
    if extraDamage > 0.03 then
        extraDamage = 0.03
    end
    local totalDamagePercent = 0.01 + extraDamage
    local damage = health * totalDamagePercent
    health = health - damage
    return health
end

function forceBounce()
    if not isGirlfriend then
        characterPlayAnim('boyfriend', 'idle', true)
    else
        if curStep % 2 == 0 then
            characterPlayAnim('boyfriend', 'danceLeft', true)
        else
            characterPlayAnim('boyfriend', 'danceRight', true)
        end
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    runTimer('goIdle', (80/curBpm)/playbackRate)
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if guitarHeroSustains then
        if not isSustainNote then
            setProperty('health', healthDrain(getProperty('health', health)))
        end
    else
        setProperty('health', healthDrain(getProperty('health', health)))
    end
end

function onCreate()
    setProperty('showCombo', false)
end

function onCountdownStarted()
    setProperty('camZooming', true)
    if getProperty('boyfriend.animation.curAnim.name') == "idle" then
        isGirlfriend = false
    else
        isGirlfriend = true
    end
end

originalZoom = 0.9
originalSpeed = 1

function onCreatePost()
    originalZoom = getProperty('camGame.zoom')
    originalSpeed = getProperty("cameraSpeed")
end

function onUpdate(elapsed)
    local combo = getProperty('combo')
    if combo > 10 and (combo == 19 or combo == 49 or combo == 149 or combo == 249 or (combo + 1) % 100 == 0) then
        setProperty('showCombo', true)
    else
        setProperty('showCombo', false)
    end
end

isPaused = false
shouldBounce = false

function onPause()
    isPaused = true
end

function onResume()
    isPaused = false
    if shouldBounce then
        forceBounce()
        shouldBounce = false
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "goIdle" then
        if not isPaused then
            if not isGirlfriend then
                if getProperty('boyfriend.animation.curAnim.name') ~= "idle" then
                    forceBounce()
                end
            else
                if getProperty('boyfriend.animation.curAnim.name') ~= "danceLeft" and getProperty('boyfriend.animation.curAnim.name') ~= "danceRight" then
                    forceBounce()
                end
            end
        else
            shouldBounce = true
        end
    end
end

function onGameOver()
    setProperty('camGame.zoom', originalZoom)
    setProperty('cameraSpeed', originalSpeed)
end

function onSongStart()
    triggerEvent("Add Camera Zoom", 0.015, 0.03)
end