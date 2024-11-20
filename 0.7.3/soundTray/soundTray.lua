local daTrueVol = 0.5

local volKeys = {
    volume_up = {},
    volume_down = {}
}

local upVolSound = ""
local downVolSound = ""
local maxVolSound = ""

local timer = 0

function initSprite(sT, sN) -- spriteTag, spriteName
    makeLuaSprite(sT, "soundTray/"..sN, 0, 0)
    setObjectCamera(sT, "hud")
    scaleObject(sT, 0.6, 0.6, true)
    screenCenter(sT, "x")
    addLuaSprite(sT, true)
end

function initializeTray()
    local dirList = directoryFileList("mods/"..currentModDirectory.."/images/soundTray")
    
    for _, imageName in ipairs(dirList) do
        local spriteName = imageName:gsub("%.png$", "") -- Remove the .png extension
        initSprite(spriteName, spriteName)
        setSpriteShader(spriteName, "squiggleVision")
        setShaderFloat(spriteName, 'amplitude', "0.01")
        setShaderFloat(spriteName, 'frequency', "0.75")
    end
    initSprite("bars_11", "bars_10")
    setProperty("bars_11.alpha", 0.5)
    setSpriteShader("bars_11", "squiggleVision")
    setShaderFloat("bars_11", 'amplitude', "0.01")
    setShaderFloat("bars_11", 'frequency', "0.75")

    setProperty("aVol.y", -getProperty("aVol.height"))
end

function showTray()
    cancelTween("soundTrayTimedOut")
    setProperty("aVol.y", 20)
    runTimer("soundTrayTimeOut", timer * 3)
end

function updateTrayVisuals()
    for i = 1, 11 do
        if i <= 10 then
            setProperty("bars_"..i..".visible", i == math.floor(daTrueVol * 10 + 0.5)) -- i fucking hate floating point percision errors
        end
        setProperty("bars_"..i..".angle", getProperty("aVol.angle"))
        setProperty("bars_"..i..".y", getProperty("aVol.y") + 10)
        setShaderFloat("bars_"..i, 'time', curDecBeat)
    end
    -- setProperty("aVol.angle", 3 * math.sin((curDecBeat / 8) * math.pi))
end

function onCreate()
    callCustomFunc("runShader", {"squiggleVision"})
end

function onCreatePost()
    runHaxeCode("FlxG.game.soundTray.silent = true;")

    upVolSound   = "soundTray/Volup"
    downVolSound = "soundTray/Voldown"
    maxVolSound  = "soundTray/VolMAX"

    timer = (120/curBpm)/playbackRate
    daTrueVol = getPropertyFromClass("flixel.FlxG", "sound.volume")

    for _, k in pairs({'volume_up', 'volume_down'}) do
        local keys = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.'..k, true)
        for _, key in ipairs(keys) do
            local keyName = callMethodFromClass('backend.InputFormatter', 'getKeyName', {key})
            table.insert(volKeys[k], keyName) -- Keys named under their action
        end
    end

    initializeTray() -- feels better if its in its own little func
end

function onUpdate(elapsed)
    local pressedKey = callMethodFromClass('backend.InputFormatter', 'getKeyName', {callMethodFromClass('flixel.FlxG', 'keys.firstJustPressed', {''})})
    runHaxeCode("FlxG.game.soundTray.visible = false;") -- this is dumb but it works sue me

    for action, keys in pairs(volKeys) do
        for _, key in ipairs(keys) do
            if key == pressedKey then
                if action == 'volume_up' then
                    if daTrueVol >= 1 then
                        playSound(maxVolSound)
                    else
                        playSound(upVolSound)
                        daTrueVol = math.min(1, daTrueVol + 0.1)
                        daTrueVol = tonumber(string.format("%.1f", daTrueVol))
                    end
                elseif action == 'volume_down' then
                    if daTrueVol > 0 then
                        playSound(downVolSound)
                        daTrueVol = math.max(0, daTrueVol - 0.1)
                        daTrueVol = tonumber(string.format("%.1f", daTrueVol))
                    else
                        daTrueVol = 0
                    end
                end
                -- debugPrint(daTrueVol)
                showTray()
                break
            end
        end
    end

    setPropertyFromClass("flixel.FlxG", "sound.volume", daTrueVol) -- all this to fix a Psych bug, fml.

    updateTrayVisuals()
end

function onTimerCompleted(t)
    if t == "soundTrayTimeIn" then
        doTweenY("soundTrayTimedOut", "aVol", getProperty("aVol.height"), timer, "quadOut")
    end
    if t == "soundTrayTimeOut" then
        doTweenY("soundTrayTimedOut", "aVol", -getProperty("aVol.height"), timer * 3, "quadOut")
    end
end

function onDestroy()
    runHaxeCode("FlxG.game.soundTray.silent = false;")
end