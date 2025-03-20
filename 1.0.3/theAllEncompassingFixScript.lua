originalZoom = 0.9
originalSpeed = 1

function onCreatePost()
    setProperty('showCombo', false)
    originalZoom = getProperty('camGame.zoom')
    originalSpeed = getProperty("cameraSpeed")

    if hasVocals then
        if checkFileExists("songs/"..songName.."/Voices-Opponent.ogg") and checkFileExists("songs/"..songName.."/Voices-Player.ogg") then
            vocalType = 2
        elseif checkFileExists("songs/"..songName.."/Voices.ogg") then
            vocalType = 1
        else
            vocalType = 0
        end
    end
end

function opponentNoteHit(i,d,t,s)
    if vocalType == 1 then
        setProperty("vocals.volume", 1)
    end
end

function onCountdownStarted()
    setProperty('camZooming', true)
end

function onGameOver()
    setProperty('camGame.zoom', originalZoom)
    setProperty('cameraSpeed', originalSpeed)
end

function onSongStart()
    triggerEvent("Add Camera Zoom", 0.015, 0.03)
end