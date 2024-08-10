local noteColors = { -- RGB Shader
    {'101010', 'FF0000', '990022'}, -- L
    {'101010', 'FF0000', '990022'}, -- D
    {'101010', 'FF0000', '990022'}, -- U
    {'101010', 'FF0000', '990022'}  -- R
}

function stripFilepath(path)
    local fileName = path:match("^.+/(.+)$") or path
    fileName = fileName:match("(.+)%..+$") or fileName
    return fileName
end

function onCreatePost() -- script by FP
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == stripFilepath(scriptName) then
            setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true)
            setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true)
            setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)

            local d = getPropertyFromGroup('unspawnNotes', i, 'noteData')
            local colorSet = noteColors[d + 1]
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.r', getColorFromHex(colorSet[1]))
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.g', getColorFromHex(colorSet[2]))
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.b', getColorFromHex(colorSet[3]))
            if botPlay == true then
                setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true) -- fuck this bot.
            end
        end
    end
end