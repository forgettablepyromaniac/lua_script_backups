local rotationSpeed = 0
local rotateAmount = 20
local squishAmount = 0.2

function onCreatePost()
    rotationSpeed = 60 / curBpm
end

function onBeatHit()
    if curBeat % 2 == 1 then
        setProperty("iconP1.angle", rotateAmount)
        doTweenAngle("p1angle", "iconP1", 0, rotationSpeed, "sineOut")

        setProperty("iconP1.scale.x", 1 + squishAmount)
        doTweenX("p1squash", "iconP1.scale", 1, rotationSpeed, "sineOut")
    
        setProperty("iconP2.angle", -rotateAmount)
        doTweenAngle("p2angle", "iconP2", 0, rotationSpeed, "sineOut")

        setProperty("iconP2.scale.x", 1 - squishAmount)
        doTweenX("p2squash", "iconP2.scale", 1, rotationSpeed, "sineOut")
    else
        setProperty("iconP1.angle", -rotateAmount)
        doTweenAngle("p1angle", "iconP1", 0, rotationSpeed, "sineOut")

        setProperty("iconP1.scale.x", 1 - squishAmount)
        doTweenX("p1squash", "iconP1.scale", 1, rotationSpeed, "sineOut")
    
        setProperty("iconP2.angle", rotateAmount)
        doTweenAngle("p2angle", "iconP2", 0, rotationSpeed, "sineOut")

        setProperty("iconP2.scale.x", 1 + squishAmount)
        doTweenX("p2squash", "iconP2.scale", 1, rotationSpeed, "sineOut")
    end
end