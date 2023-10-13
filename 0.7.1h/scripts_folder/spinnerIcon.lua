local rotationSpeed = 0
local rotateAmount = 360

function onCreatePost()
    rotationSpeed = 60 / curBpm
end

function onSectionHit()
    -- setProperty("iconP1.angle", rotateAmount)
    -- doTweenAngle("p1angle", "iconP1", 0, rotationSpeed, "sineOut")

    setProperty("iconP2.angle", -rotateAmount)
    doTweenAngle("p2angle", "iconP2", 0, rotationSpeed, "sineOut")
end