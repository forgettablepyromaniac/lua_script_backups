function stripFilepath(path)
    local fileName = path:match("^.+/(.+)$") or path
    fileName = fileName:match("(.+)%..+$") or fileName
    return fileName
end

function onCreate() -- script by FP
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == stripFilepath(scriptName) then
            setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true)
            setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true)
            setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
        end
    end
end