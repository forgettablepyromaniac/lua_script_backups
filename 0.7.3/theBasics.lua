local areWePaused = false -- i dont know why this isnt a built in variable but whatever
local idleAfterPause = false

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

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    runTimer('goIdle', (75/curBpm)/playbackRate)
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

function onPause()
    areWePaused = true
end

function onResume()
    if idleAfterPause then
        characterPlayAnim('boyfriend', 'idle', true)
    end
    areWePaused = false
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "goIdle" then
        if not areWePaused then
            characterPlayAnim('boyfriend', 'idle', true)
        else
            idleAfterPause = true
        end
    end
end

function onCreate()
    setProperty('showCombo', false)
    setProperty("showComboNum", false)
end

function onUpdate(elapsed)
    local combo = getProperty('combo')

    if combo > 10 then
        setProperty("showComboNum", true)
        if (combo == 19 or combo == 49 or combo == 149 or combo == 249 or (combo + 1) % 100 == 0) then
            setProperty('showCombo', true)
        else
            setProperty('showCombo', false)
        end
    else
        setProperty('showCombo', false)
        setProperty("showComboNum", false)
    end
end