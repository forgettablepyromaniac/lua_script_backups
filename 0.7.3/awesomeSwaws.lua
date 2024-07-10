function getTheVars(str)
    local ayo, sus = str:match("([^:]+):([^:]+)")
    return ayo, sus
end

function handleNotes(laneToChange, finalSpeed, timeItTakes, mustPressCondition)
    for i = 0, getProperty('notes.length') - 2 do
        if getPropertyFromGroup('notes', i, 'noteData') == laneToChange - 1 then
            if getPropertyFromGroup('notes', i, 'mustPress') == mustPressCondition then
                startTween('noteTweenMultSpeed'..i, 'notes['..i..']', {multSpeed = finalSpeed}, timeItTakes / playbackRate, {ease = 'linear'})
            end
        end
    end
    for i = 0, getProperty('unspawnNotes.length') - 1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteData') == laneToChange - 1 then
            if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == mustPressCondition then
                startTween('unspawnNoteTweenMultSpeed'..i, 'unspawnNotes['..i..']', {multSpeed = finalSpeed}, timeItTakes / playbackRate, {ease = 'linear'})
            end
        end
    end
end

function onEvent(e, val1, val2, strumTime)
    if e == "awesomeSwaws" then
        local laneToChange, whoIsIt = getTheVars(val1)
        local timeItTakes, finalSpeed = getTheVars(val2)
        
        if whoIsIt == "dad" then
            handleNotes(laneToChange, finalSpeed, timeItTakes, false)
        elseif whoIsIt == "bf" then
            handleNotes(laneToChange, finalSpeed, timeItTakes, true)
        elseif whoIsIt == "both" then
            handleNotes(laneToChange, finalSpeed, timeItTakes, false)
            handleNotes(laneToChange, finalSpeed, timeItTakes, true)
        else
            debugPrint("WRONG!")
        end
    end
end

function goodNoteHitPre(i)
    callMethodFromClass('flixel.tweens.FlxTween', 'cancelTweensOf', {instanceArg('notes.members['..i..']')})
end

-- function onTweenCompleted(t)
--     debugPrint(t)
-- end