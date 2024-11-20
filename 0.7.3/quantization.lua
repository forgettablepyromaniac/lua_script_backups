---
--- You dont need to credit me if you use this but do leave this comment here thank you :) -forgettablePryomaniac
---

local dontQuantize = {"Hurt Note"}

local variations = {
    noteColoursNormal = { -- default colorset.
        R = {'F9393F', 'FFFFFF', '651038'},   -- Red
        B = {'00FFFF', 'FFFFFF', '1542B7'},   -- Blue
        P = {'C24B99', 'FFFFFF', '3C1F56'},   -- Purple
        Y = {'F0E342', 'FFFFFF', '554320'},   -- Yellow
        K = {'ED36AD', 'FFFFFF', '5C185A'},   -- Pink
        O = {'E98F16', 'FFFFFF', '3F2D12'},   -- Orange
        C = {'4769B8', 'FFFFFF', '161B27'},   -- Cyan
        G = {'12FA05', 'FFFFFF', '0A4447'},   -- Green
        T = {'008080', 'FFFFFF', '004D4D'},   -- Teal
    },
    noteColoursFNF = { -- vanilla colors show up more often.
        R = {'F9393F', 'FFFFFF', '651038'},   -- Red
        B = {'00FFFF', 'FFFFFF', '1542B7'},   -- Blue
        Y = {'12FA05', 'FFFFFF', '0A4447'},   -- Green
        P = {'C24B99', 'FFFFFF', '3C1F56'},   -- Purple
        K = {'ED36AD', 'FFFFFF', '5C185A'},   -- Pink
        O = {'12FA05', 'FFFFFF', '0A4447'},   -- Green
        C = {'00FFFF', 'FFFFFF', '1542B7'},   -- Blue
        G = {'F0E342', 'FFFFFF', '554320'},   -- Yellow
        T = {'008080', 'FFFFFF', '004D4D'},   -- Teal
    },
    noteColoursStepMania = { -- brighter.
        R = {'FF0000', 'FFFFFF', '800000'},   -- Red
        B = {'0000FF', 'FFFFFF', '000080'},   -- Blue
        P = {'AA00AA', 'FFFFFF', '550055'},   -- Purple
        Y = {'FFFF00', 'FFFFFF', '808000'},   -- Yellow
        K = {'FF00FF', 'FFFFFF', '800080'},   -- Pink
        O = {'FFA500', 'FFFFFF', '804000'},   -- Orange
        C = {'00FFFF', 'FFFFFF', '008080'},   -- Cyan
        G = {'00FF00', 'FFFFFF', '008000'},   -- Green
        T = {'008080', 'FFFFFF', '004040'},   -- Teal
    },
    noteColoursOld = { -- aproximates how an older version of the script looked.
        R = {'F9393F', 'FFFFFF', '651038'},   -- Red
        B = {'00FFFF', 'FFFFFF', '1542B7'},   -- Blue
        P = {'C24B99', 'FFFFFF', '3C1F56'},   -- Purple
        Y = {'12FA05', 'FFFFFF', '0A4447'},   -- Green
        K = {'FF69B4', 'FFFFFF', 'C71585'},   -- Pink 
        O = {'F7EA00', 'FFFFFF', '756A26'},   -- Yellow
        C = {'00FFFF', 'FFFFFF', '1542B7'},   -- Blue
        G = {'12FA05', 'FFFFFF', '0A4447'},   -- Green
        T = {'008080', 'FFFFFF', '004D4D'},   -- Teal
    },
    noteColoursDeutan = {
        R = {'FF7F7F', 'FFFFFF', '803F3F'},   -- Deutan Red
        B = {'007FFF', 'FFFFFF', '00407F'},   -- Deutan Blue
        P = {'AF5FFF', 'FFFFFF', '57327F'},   -- Deutan Purple
        Y = {'FFFF99', 'FFFFFF', '808040'},   -- Deutan Yellow
        K = {'FF7FAF', 'FFFFFF', '803F57'},   -- Deutan Pink
        O = {'FFD27F', 'FFFFFF', '805020'},   -- Deutan Orange
        C = {'7FFFFF', 'FFFFFF', '407F7F'},   -- Deutan Cyan
        G = {'7FFF7F', 'FFFFFF', '3F803F'},   -- Deutan Green
        T = {'40A5A5', 'FFFFFF', '205252'},   -- Deutan Teal
    },
    noteColoursProtan = {
        R = {'FF8080', 'FFFFFF', '803F3F'},   -- Protan Red
        B = {'007FFF', 'FFFFFF', '004080'},   -- Protan Blue
        P = {'AF5FFF', 'FFFFFF', '572F7F'},   -- Protan Purple
        Y = {'FFFF7F', 'FFFFFF', '808040'},   -- Protan Yellow
        K = {'FF7FBF', 'FFFFFF', '80405F'},   -- Protan Pink
        O = {'FFC47F', 'FFFFFF', '805020'},   -- Protan Orange
        C = {'7FFFFF', 'FFFFFF', '407F7F'},   -- Protan Cyan
        G = {'7FFF7F', 'FFFFFF', '3F8040'},   -- Protan Green
        T = {'409090', 'FFFFFF', '205050'},   -- Protan Teal
    },
    noteColoursTritan = {
        R = {'FF6060', 'FFFFFF', '803030'},   -- Tritan Red
        B = {'A060FF', 'FFFFFF', '503080'},   -- Tritan Blue
        P = {'AA7FFF', 'FFFFFF', '554080'},   -- Tritan Purple
        Y = {'D4D46A', 'FFFFFF', '7A7A34'},   -- Tritan Yellow
        K = {'FF66BF', 'FFFFFF', '80407F'},   -- Tritan Pink
        O = {'E2A357', 'FFFFFF', '703B1F'},   -- Tritan Orange
        C = {'66BFFF', 'FFFFFF', '336680'},   -- Tritan Cyan
        G = {'66FF66', 'FFFFFF', '338033'},   -- Tritan Green
        T = {'4D8080', 'FFFFFF', '264040'},   -- Tritan Teal
    }
}

local defaultColors = { -- will be replaced.
    {'000000', '000000', '000000'},
    {'FF0000', 'FF0000', 'FF0000'},
    {'00FF00', '00FF00', '00FF00'},
    {'0000FF', '0000FF', '0000FF'}
}

local beatColors = { -- switched to the mania standard for quant coloring
    {divisor = 192 / 4,  color = 'R'},  -- Red
    {divisor = 192 / 6,  color = 'P'},  -- Purple
    {divisor = 192 / 8,  color = 'B'},  -- Blue
    {divisor = 192 / 12,  color = 'P'}, -- Purple
    {divisor = 192 / 16, color = 'Y'},  -- Yellow
    {divisor = 192 / 24, color = 'K'},  -- Pink
    {divisor = 192 / 32, color = 'O'},  -- Orange
    {divisor = 192 / 48, color = 'C'},  -- Cyan
    {divisor = 192 / 64, color = 'G'}   -- Green, all others are assumed Teal.
}

function round(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function setRgbShader(group, index, r, g, b)
    setPropertyFromGroup(group, index, 'rgbShader.r', r)
    setPropertyFromGroup(group, index, 'rgbShader.g', g)
    setPropertyFromGroup(group, index, 'rgbShader.b', b)
end

function shouldQuantize(t)
    if #dontQuantize == 0 then
        return true -- Quantize everything if array is empty
    end
    for _, v in ipairs(dontQuantize) do
        if t == v then
            return false -- Skip quantizing if noteType is in dontQuantize
        end
    end
    return true
end

function quantNotes()
    local bpmChanges = getPropertyFromClass('backend.Conductor', 'bpmChangeMap')
    local currentBPM = bpm

    for i = 0, getProperty('unspawnNotes.length') - 1 do
        local strumTime = getPropertyFromGroup('unspawnNotes', i, 'strumTime')
        local newTime = strumTime

        for j = 1, #bpmChanges do
            if strumTime > bpmChanges[j].songTime then
                currentBPM = bpmChanges[j].bpm
                newTime = strumTime - bpmChanges[j].songTime
            end
        end


        local t = getPropertyFromGroup("unspawnNotes", i, "noteType")

        if shouldQuantize(t) then
            local col = 'T'  -- Default to teal
            local noteBeat = (currentBPM * (newTime - getPropertyFromClass("backend.ClientPrefs", "data.noteOffset"))) / 1000 / 60 -- thanks _threedott
            local beat = round(noteBeat * 48, 0)

            for _, entry in ipairs(beatColors) do
                if beat % entry.divisor == 0 then
                    col = entry.color
                    break
                end
            end

            local colorType = 'noteColours'..getModSetting("quantType")
            local colors = variations[colorType][col]

            setRgbShader('unspawnNotes', i, getColorFromHex(colors[1]), getColorFromHex(colors[2]), getColorFromHex(colors[3]))
            
            if getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then -- keep sustain the same color as parent.
                setRgbShader('unspawnNotes', i, getPropertyFromGroup('unspawnNotes', i, 'prevNote.rgbShader.r'), getPropertyFromGroup('unspawnNotes', i, 'prevNote.rgbShader.g'), getPropertyFromGroup('unspawnNotes', i, 'prevNote.rgbShader.b'))
            end
        end
    end
end

function onCountdownStarted()
    defaultColors = getPropertyFromClass("backend.ClientPrefs", "data.arrowRGB") -- to have receptors return to their regular color

    for i = 1, #defaultColors do
        for j = 1, 3 do
            local hexColor = callMethodFromClass('StringTools', 'hex', {defaultColors[i][j]}) -- thanks Larry
            defaultColors[i][j] = string.sub(hexColor, 3) -- remove 0xFF
        end
    end

    quantNotes()
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    setRgbShader('playerStrums', noteData, getPropertyFromGroup('notes', membersIndex, 'rgbShader.r'), getPropertyFromGroup('notes', membersIndex, 'rgbShader.g'), getPropertyFromGroup('notes', membersIndex, 'rgbShader.b'))
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    setRgbShader('opponentStrums', noteData, getPropertyFromGroup('notes', membersIndex, 'rgbShader.r'), getPropertyFromGroup('notes', membersIndex, 'rgbShader.g'), getPropertyFromGroup('notes', membersIndex, 'rgbShader.b'))
end

function onKeyRelease(key)
    local colors = defaultColors[key + 1]
    setRgbShader('playerStrums', key, getColorFromHex(colors[1]), getColorFromHex(colors[2]), getColorFromHex(colors[3]))
    callMethod('playerStrums.members['..key..'].playAnim', {'static'})
end