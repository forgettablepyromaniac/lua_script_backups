local allSongsInfoPath = "data/allSongsInfo.txt"

local isItReal = false
local creditsInfo = {
    songName = "",
    creddz = "",
    songNameColor = "",
    creddzColor = "",
    boxColor = "",
    whenTween = 0
}
local bpmTweener = 0
local parts = { -- intentionally left blank

}

function findSongInfo(allSongsContent, currentFolderName)
    local foundSection = false
    local currentFolderNameLower = string.lower(currentFolderName)

    for line in string.gmatch(allSongsContent, "[^\r\n]+") do
        if string.sub(line, 1, 1) == "#" then
            -- Ignore comment lines
        elseif string.sub(line, 1, 1) == "[" and string.sub(line, -1) == "]" then
            local sectionName = string.sub(line, 2, -2)
            foundSection = string.lower(sectionName) == currentFolderNameLower
        elseif foundSection then
            for part in string.gmatch(line, "([^::]+)") do
                table.insert(parts, part)
            end

            if #parts >= 6 then
                creditsInfo.songName = parts[1]
                creditsInfo.creddz = parts[2]
                creditsInfo.songNameColor = parts[3]
                creditsInfo.creddzColor = parts[4]
                creditsInfo.boxColor = parts[5]
                creditsInfo.tweenOutSection = tonumber(parts[6])
                isItReal = true
            end
            return
        end
    end
end

function hexToRGB(hex)
    return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

function RGBtoHSV(r, g, b)
    r, g, b = r / 255, g / 255, b / 255
    local max, min = math.max(r, g, b), math.min(r, g, b)
    local h, s, v
    v = max

    local d = max - min
    s = max == 0 and 0 or d / max

    if max == min then
        h = 0 -- achromatic
    else
        if max == r then
            h = (g - b) / d + (g < b and 6 or 0)
        elseif max == g then
            h = (b - r) / d + 2
        elseif max == b then
            h = (r - g) / d + 4
        end
        h = h / 6
    end
    return h, s, v
end

function HSVtoRGB(h, s, v)
    local r, g, b

    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    if i % 6 == 0 then
        r, g, b = v, t, p
    elseif i % 6 == 1 then
        r, g, b = q, v, p
    elseif i % 6 == 2 then
        r, g, b = p, v, t
    elseif i % 6 == 3 then
        r, g, b = p, q, v
    elseif i % 6 == 4 then
        r, g, b = t, p, v
    elseif i % 6 == 5 then
        r, g, b = v, p, q
    end

    return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
end

function getBorderColor(hex)
    -- Convert hex to RGB
    local r, g, b = hexToRGB(hex)

    -- Calculate the brightness
    local brightness = (r * 0.299 + g * 0.587 + b * 0.114) / 255

    -- Determine the skewed opposite brightness
    local oppositeBrightness
    if brightness > 0.25 then  -- Adjusted threshold
        -- Original color is relatively light, choose a darker color
        oppositeBrightness = brightness / 2  -- Making it darker
    else
        -- Original color is dark, choose a slightly lighter color
        oppositeBrightness = brightness + 0.25
    end

    -- Adjust to ensure there's enough contrast
    if oppositeBrightness > 0.95 then
        oppositeBrightness = 0.95
    elseif oppositeBrightness < 0.05 then
        oppositeBrightness = 0.05
    end

    -- Calculate the new color keeping the same hue and saturation
    local h, s, _ = RGBtoHSV(r, g, b)
    r, g, b = HSVtoRGB(h, s, oppositeBrightness)

    return string.format("%02X%02X%02X", r, g, b)
end

function onCreatePost()
    if checkFileExists(allSongsInfoPath, false) then
        findSongInfo(getTextFromFile(allSongsInfoPath, false), songName)
    end
    if isItReal then
        makeLuaSprite("credzBackdrop", nil, -320, screenHeight/2)
        makeGraphic("credzBackdrop", 320, 200, creditsInfo.boxColor)
        setObjectCamera("credzBackdrop", 'other')
        setProperty("credzBackdrop.alpha", 0.5, false)
        makeLuaText("songNameText", creditsInfo.songName, 300, -320, screenHeight/2 + getProperty("credzBackdrop.width", false)/6)
        makeLuaText("creddzText", creditsInfo.creddz, 300, -320, screenHeight/2 + getProperty("credzBackdrop.width", false)/3)
        setTextAlignment("songNameText", 'center')
        setTextAlignment("creddzText", 'center')
        setTextSize("songNameText", 24)
        setTextSize("creddzText", 20)
        setObjectCamera("songNameText", 'other')
        setObjectCamera("creddzText", 'other')

        setTextColor("songNameText", creditsInfo.songNameColor)
        setTextColor("creddzText", creditsInfo.creddzColor)

        setTextBorder("songNameText", 2, getBorderColor(creditsInfo.songNameColor))
        setTextBorder("creddzText", 2, getBorderColor(creditsInfo.creddzColor))
    end
    bpmTweener = 60/curBpm
end

function onSongStart()
    if isItReal then
        -- debugPrint("Credits: "..creditsInfo.creddz)
        -- debugPrint("Song Name: "..creditsInfo.songName)
        addLuaSprite("credzBackdrop", true)
        addLuaText("songNameText")
        addLuaText("creddzText")
        doTweenX("credzBackdropMove", "credzBackdrop", 0, bpmTweener, "bounceOut")
        doTweenX("songNameTextMove", "songNameText", 0, bpmTweener, "bounceOut")
        doTweenX("creddzTextMove", "creddzText", 0, bpmTweener, "bounceOut")
    end
end

function onSectionHit()
    if curSection == creditsInfo.tweenOutSection then
        doTweenX("credzBackdropMove2", "credzBackdrop", -320, bpmTweener*2, "sineInOut")
        doTweenX("songNameTextMove2", "songNameText", -320, bpmTweener*2, "sineInOut")
        doTweenX("creddzTextMove2", "creddzText", -320, bpmTweener*2, "sineInOut")
    end
end

function onTweenCompleted(tag, vars)
    if tag == "credzBackdropMove2" then
        removeLuaSprite("credzBackdrop", true)
    end
    if tag == "songNameTextMove2" then
        removeLuaText("songNameText", true)
    end
    if tag == "creddzTextMove2" then
        removeLuaText("creddzText", true)
    end
end