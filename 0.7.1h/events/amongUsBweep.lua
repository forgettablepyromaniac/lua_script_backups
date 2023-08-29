function onCreatePost()
    makeLuaSprite("amogler", null, 0, 0)
    makeGraphic("amogler", screenWidth, screenHeight, 'FF0000')
    setObjectCamera("amogler", 'other')
    setProperty("amogler.alpha", 0, false)
    addLuaSprite("amogler", false)
end

function onEvent(eventName, val1, val2, strumTime) --0.6 seconds
    if eventName == "amongUsBweep" then
        setProperty("amogler.alpha", 0.5, false)
        doTweenAlpha("amoglerfader", "amogler", 0, 0.6, "linear")
    end
end