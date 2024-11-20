local isGirlfriend = false
local fuckDownscrollUsers = false
local fuckMiddlescrollUsers = false

function healthDrain(health)
    local baselineDamage = getPropertyFromGroup('notes', 0, 'missHealth') or 0.0475
    local damage = math.min(baselineDamage * health, 0.03) -- damage tapers based on current health
    local returnHp = health - damage
    returnHp = math.max(0.005, health - damage) -- failsafe, i don't want to kill the player with this, and floats are weird.
    return returnHp -- at this point, health movements are not perceptible anyway.
end

function forceBounce()
    if not isGirlfriend then
        characterPlayAnim('boyfriend', 'idle'..getProperty("boyfriend.idleSuffix"), true)
    else
        if curStep % 2 == 0 then
            characterPlayAnim('boyfriend', 'danceLeft', true)
        else
            characterPlayAnim('boyfriend', 'danceRight', true)
        end
    end
end

function goodNoteHit(i, d, t, s)
    runTimer('goIdle', (80/curBpm)/playbackRate)

    local combo = getProperty('combo')
    if combo == 19 or combo == 49 or combo == 149 or combo == 249 or (combo + 1) % 100 == 0 then -- this looks stupid but it works
        setProperty('showCombo', true)
    else
        setProperty('showCombo', false)
    end
end

function opponentNoteHit(i, d, t, s)
    if not guitarHeroSustains or (guitarHeroSustains and not s) then
        setProperty('health', healthDrain(getProperty('health')))
    end
end


function onCreate()
    setProperty('showCombo', false)
end

function onCountdownStarted()
    setProperty('camZooming', true)
    if getProperty('boyfriend.animation.curAnim.name') == "idle"..getProperty("boyfriend.idleSuffix") then
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

    if buildTarget == 'android' then -- because fuck mobile ports, get a pc.
        os.exit()
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

function onTimerCompleted(t, l, r)
    if t == "goIdle" then
        if not isPaused then
            if not isGirlfriend then
                if getProperty('boyfriend.animation.curAnim.name') ~= "idle"..getProperty("boyfriend.idleSuffix") then
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