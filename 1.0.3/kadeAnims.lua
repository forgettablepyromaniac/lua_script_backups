cantBop = false

function opponentNoteHitPre(i,d,t,s)
    if s then
        setPropertyFromGroup('notes', i, 'noAnimation', true)
        setProperty('dad.holdTimer', 0)
    end
end

function goodNoteHitPre(i,d,t,s)
    if s then
        char = getPropertyFromGroup('notes', i, 'gfNote') and 'gf' or 'boyfriend'
        setPropertyFromGroup('notes', i, 'noAnimation', true)
        setProperty(char..'.holdTimer', 0)
    end
end

function onUpdatePost(elapsed) -- if note is player's sustain, stop player from premature boppage.
    if getProperty("notes.length") > 0 then
        cantBop = getPropertyFromGroup('notes', getProperty("notes.length")-1, 'isSustainNote') and getPropertyFromGroup('notes', getProperty("notes.length")-1, 'mustPress')
    else
        cantBop = false
    end
end

function onBeatHit() -- works better on shorter sing anims.
    if getProperty("boyfriend.animation.curAnim.finished") and
    getProperty("boyfriend.animation.curAnim.name") ~= "idle"
    and curBeat % getProperty("boyfriend.danceEveryNumBeats") == 0
    and not getProperty("boyfriend.specialAnim")
    and not cantBop then 
        characterDance("bf")
    end
end