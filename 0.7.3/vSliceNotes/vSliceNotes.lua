local activeHolds = {player = {false, false, false, false}, opponent = {false, false, false, false}}

local strums = {"playerStrums", "opponentStrums"} 
local slices = {"holdVslicePlayer", "holdVsliceOppo"}
local tipe = {"player", "opponent"} -- all 3 of these are for easy iteration.

local properties = { -- the math was too fucking complicated. shoutouts 7he
    ["-chip"] = {xOffset = -85, yOffset = -70, scaleFactor = 1.513},
    ["-future"] = {xOffset = -115, yOffset = -80, scaleFactor = 1.656},
    ["-default"] = {xOffset = 5, yOffset = 10, scaleFactor = 1} -- Default case
}

local prop = {} -- placeholder

function getProperties(a) return a == "" and properties["-default"] or properties[a] or properties["-default"] end

function setRgbShader(spr, r, g, b)
    runHaxeCode([[
        import shaders.RGBPalette;
        var rgb = new RGBPalette();
        rgb.r = ]]..r..[[;
        rgb.g = ]]..g..[[;
        rgb.b = ]]..b..[[;

        var spr = game.getLuaObject("]]..spr..[[");
        spr.shader = rgb.shader;
    ]])
end

function createHoldSprites(prefix, strumGroup)
    for i = 0, 3 do
        makeAnimatedLuaSprite(prefix..i, "holdCoverShader", 0, 0)
        addAnimation(prefix..i, "open", {1}, 24, false)
        addAnimation(prefix..i, "idle", {2, 3, 4}, 24, true)
        addAnimation(prefix..i, "close", {6, 7, 8, 9, 10, 11, 12, 13}, 24, false)

        setObjectCamera(prefix..i, "hud")
        setProperty(prefix..i..".alpha", 0)
        setProperty(prefix..i..".visible", false)
        addLuaSprite(prefix..i, true)
    end
end

function onCreatePost()
    prop = getProperties(noteSkinPostfix)
    -- debugPrint(prop)

    for i, slice in ipairs(slices) do
        createHoldSprites(slice, strums[i])
    end

    for i = 0, 3 do
        for j = 1, 2 do
            scaleObject(slices[j]..i, prop.scaleFactor, prop.scaleFactor)
        end
    end
end

function onSongStart()
    setObjectOrder("botplayTxt", getObjectOrder("holdVsliceOppo3") + 1)
end

function onUpdate(e)
    for i = 0, 3 do
        for j = 1, 2 do
            setProperty(slices[j]..i..".x", getPropertyFromGroup(strums[j], i, "x") - getPropertyFromGroup("playerStrums", i, "width") + prop.xOffset)
            setProperty(slices[j]..i..".y", getPropertyFromGroup(strums[j], i, "y") - getPropertyFromGroup("playerStrums", i, "height") + prop.yOffset)
            setProperty(slices[j]..i..".alpha", getPropertyFromGroup(strums[j], i, "alpha"))

            if not activeHolds[tipe[j]][i] and getProperty(slices[j]..i..".animation.curAnim.finished") and getProperty(slices[j]..i..".animation.curAnim.name") == "close" then
                setProperty(slices[j]..i..".visible", false)
            end

            if getPropertyFromGroup(strums[j], i, "animation.name") == "static"
            and getProperty(slices[j]..i..".visible") 
            and getProperty(slices[j]..i..".animation.name") == "idle" then -- sanity check for lag spikes, hopefully this would work?
                setProperty(slices[j]..i..".visible", false)
                activeHolds[tipe[j]][i] = false
            end
        end

        if getPropertyFromGroup("playerStrums", i, "resetAnim") == 0 
        and getPropertyFromGroup("playerStrums", i, "animation.name") == "confirm" 
        and getPropertyFromGroup("playerStrums", i, "animation.finished") then
            callMethod('playerStrums.members['..i..'].playAnim', {'pressed', true})
        end
    end
end

function sustainCheck(isPlayer, id, dir, noteType, isSustainNote)
    if isSustainNote then
        local index = isPlayer and 1 or 2
        setRgbShader(slices[index]..dir,
            getPropertyFromGroup('notes', id, 'rgbShader.r'),
            getPropertyFromGroup('notes', id, 'rgbShader.g'),
            getPropertyFromGroup('notes', id, 'rgbShader.b'))

        if stringEndsWith(getProperty('notes.members['..id..'].animation.curAnim.name'), "end") then
            playAnim(slices[index]..dir, "close", true)
            activeHolds[isPlayer and "player" or "opponent"][dir] = false
        else
            playAnim(slices[index]..dir, "idle", false)
            setProperty(slices[index]..dir..".visible", true)
            activeHolds[isPlayer and "player" or "opponent"][dir] = true
        end
    end
end

function goodNoteHitPre(i, d, t, s)
    sustainCheck(true, i, d, t, s)
end

function opponentNoteHitPre(i, d, t, s)
    sustainCheck(false, i, d, t, s)
end

function onKeyRelease(k)
    if activeHolds.player[k] then
        if getProperty("holdVslicePlayer"..k..".animation.curAnim") ~= "close" then
            setProperty("holdVslicePlayer"..k..".visible", false)
        end
        activeHolds.player[k] = false
    end
end