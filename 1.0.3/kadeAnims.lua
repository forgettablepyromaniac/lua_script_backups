defaultTimer = 30 -- if you want it to take longer to return to idle, increase this. typically a multiple of 30.
bpmPlaceholder = 150 -- gets updated accordingly, only update kadeTimer when nessecary.

-- every multiple of 200 that the bpm hits, it'll multiply default timer by 2x to keep it looking decent for higher bpms.
function getMult(n)
    return math.floor(n/200) + 1
end

function updateKadeTimer()
    bpmPlaceholder = curBpm
    kadeTimer = defaultTimer * getMult(curBpm)
end

shouldBounceBoyfriend = false
shouldBounceDad = false
shouldBounceGF = false

function onCreatePost()
    triggerEvent("z-setSpeed", 6.2, 6.2) -- if you're not using z-Zoom.lua, comment this line and uncomment the line below.
    -- setProperty("camZoomingDecay", 2)
    updateKadeTimer()
end

function onSectionHit() -- allows for bpm changes to work with kadeAnims
    if bpmPlaceholder ~= curBpm then
        updateKadeTimer()
        debugPrint(curBpm.." "..bpmPlaceholder)
    end
end

function opponentNoteHitPre(i,d,t,s)
    if s then
        setPropertyFromGroup('notes', i, 'noAnimation', true)
        setProperty('dad.holdTimer', 0)
    end
end

function opponentNoteHit(i,d,t,s)
    char = getPropertyFromGroup('notes', i, 'gfNote') and 'gf' or 'dad'
    runTimer('goIdle-'..char, (kadeTimer/curBpm)/playbackRate)
end

function goodNoteHitPre(i,d,t,s)
    if s then
        char = getPropertyFromGroup('notes', i, 'gfNote') and 'gf' or 'boyfriend'
        setPropertyFromGroup('notes', i, 'noAnimation', true)
        setProperty(char..'.holdTimer', 0)
    end
end

function goodNoteHit(i,d,t,s)
    char = getPropertyFromGroup('notes', i, 'gfNote') and 'gf' or 'boyfriend'
    runTimer('goIdle-'..char, (kadeTimer/curBpm)/playbackRate) -- i hate the timer method but it works the best.
end

function onPause()
    isPaused = true
end

function onResume()
    isPaused = false
    local charMap = { "boyfriend", "gf", "dad" }

    for _, key in ipairs(charMap) do
        local bounceFlag = "shouldBounce" .. key:gsub("^%l", string.upper)
        if _G[bounceFlag] then
            characterDance(key == "boyfriend" and "bf" or key)
            _G[bounceFlag] = false
        end
    end
end


function onTimerCompleted(t, l, r)
    if not stringStartsWith(t, "goIdle-") then return end
    local charMap = {
        boyfriend = "bf",
        gf = "gf",
        dad = "dad"
    }

    for key, char in pairs(charMap) do
        if stringEndsWith(t, key) then
            if not isPaused then
                if not getProperty(key .. ".specialAnim") then
                    characterDance(char)
                end
            else
                _G["shouldBounce" .. key:gsub("^%l", string.upper)] = true
            end
            break
        end
    end
end