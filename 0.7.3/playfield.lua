function onCreate()
    makeLuaSprite("playfield")
    makeGraphic("playfield", 1, screenHeight)
    setObjectCamera("playfield", "HUD")
    setProperty("playfield.alpha", 0.35)
    setBlendMode("playfield", "darken")
    addLuaSprite("playfield", false)
end

function onUpdate(elapsed) -- silly majic number baloney
    setProperty("playfield.x", getPropertyFromGroup("playerStrums", 0, "x") - 20)
    scaleObject("playfield", (getPropertyFromGroup("playerStrums", 3, "x") - getPropertyFromGroup("playerStrums", 0, "x")) + getPropertyFromGroup("playerStrums", 3, "width") + 40, 1)
end