local hereIsMyVar = 0
local timesHurt = 0
local heartBeatVol = 0
local stopEverything = false

function onCreate()
    hereIsMyVar = 2
    makeLuaSprite("healthMarker", null, getProperty("healthBar.x"), getProperty("healthBar.y"))
    makeGraphic("healthMarker", 0, 16, '000000')
    setObjectCamera("healthMarker", 'hud')
    addLuaSprite("healthMarker", true)

    setProperty("healthMarker.alpha", 0)

    setObjectOrder("iconP1", 25)
    setObjectOrder("iconP2", 26)

    local tempFlag = false

    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'racistOuch' then 
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteSkins/temp'); --Change texture
            setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);
            -- setPropertyFromGroup('unspawnNotes', i, 'noteSplashHue', 0); --custom notesplash color, why not
            -- setPropertyFromGroup('unspawnNotes', i, 'noteSplashSat', -20);
            -- setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', 1);
            setPropertyFromGroup('unspawnNotes', i, 'multSpeed', 0.75);
            if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
                setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has penalties
            end
            if songName == "big-dead" then
                if not tempFlag then
                    setPropertyFromGroup('unspawnNotes', i, 'multSpeed', 0.5);
                    tempFlag = true
                end
            end
        end
    end
    precacheSound("heartbeat")
    precacheSound("swing")

    makeLuaSprite("hurtOverlay", "grad", 0, 0)
    setObjectCamera("hurtOverlay", 'hud')
    screenCenter("hurtOverlay", 'xy')
    setProperty("hurtOverlay.alpha", 0)
    addLuaSprite("hurtOverlay", true)
end

function calculateBarPosition(value)
    local endWidth = 620
    local width = endWidth * (1 - value / 2)
    return width
end

function calculateNewMaxHealth(ouchers)
    local newMaxHealth = 2 - 0.25 * ouchers
    return newMaxHealth
end

-- function onEvent(eventName, val1, val2, strumTime)

-- end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    if noteType == "racistOuch" then
        timesHurt = timesHurt + 1
        if timesHurt > 7 then
            setProperty("health", -2)
        end
        setProperty("healthMarker.alpha", 1)

        hereIsMyVar = calculateNewMaxHealth(timesHurt)

        characterPlayAnim('dad', 'attack', true)
        setProperty('dad.specialAnim', true)
        characterPlayAnim('boyfriend', 'hurt', true)
        setProperty('boyfriend.specialAnim', true)

        if getProperty("health") > 0.01 then
            triggerEvent("Add Camera Zoom", 0.5, 0.03)
        end

        playSound("swing", 1, null)

        makeGraphic("healthMarker", calculateBarPosition(hereIsMyVar), 16, '000000')

        setProperty("hurtOverlay.alpha", getProperty("hurtOverlay.alpha") + 0.12)

        heartBeatVol = heartBeatVol + 0.12
    end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    local hulth = getProperty('health')
    hulth = hulth - hulth / (hereIsMyVar * 15)
    setProperty('health', hulth) -- so much hulth
end

function onUpdatePost(elapsed)
    if getProperty('health') > hereIsMyVar then
        setProperty("health", hereIsMyVar)
    end
    if stopEverything then
        setProperty("hurtOverlay.alpha", 0)
    end
end

-- function onKeyPress(key)
--     setProperty("health", 2, false)
-- end

function onSectionHit()
    if not stopEverything then
        playSound("heartbeat", heartBeatVol)
    end
end