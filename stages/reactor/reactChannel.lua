function onCreate()
    local spriteTable = {
        { file = "wall", scale = 0.8, xOffset = -500, yOffset = -200, xScroll = 0.5, yScroll = 0.3},
        { file = "coolLights", scale = 0.7, xOffset = -50, yOffset = 100, xScroll = 0.7, yScroll = 0.7},
        { file = "bar", scale = 0.8, xOffset = -700, yOffset = 240, xScroll = 0.8, yScroll = 0.8},
        { file = "susfloor", scale = 1.2, xOffset = -444, yOffset = 350, xScroll = 0.9, yScroll = 1},
        { file = "coir", scale = 0.8, xOffset = 350, yOffset = -150, xScroll = 0.87, yScroll = 1},
        { file = "beeper", scale = 0.8, xOffset = 1110, yOffset = -50, xScroll = 0.9, yScroll = 1},
        { file = "beeper", scale = 0.8, xOffset = 160, yOffset = -50, xScroll = 0.9, yScroll = 1},
        { file = "womp", scale = 1, xOffset = 550, yOffset = 400, xScroll = 0.95, yScroll = 1}
    }

    for i, e in ipairs(spriteTable) do
        makeLuaSprite(i, "reactor/"..e.file, e.xOffset, e.yOffset)
        setScrollFactor(i, e.xScroll, e.yScroll)
        scaleObject(i, e.scale, e.scale, true)
        addLuaSprite(i, false)
        -- debugPrint('hello')
    end

    scaleObject("3", 2, 0.8, true)
    setProperty("6.flipX", true, false)

    -- doTweenZoom("fff", "camGame", 0.5, 1, "linear")
end