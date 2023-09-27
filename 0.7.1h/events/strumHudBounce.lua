local areWeBouncin = false
local areWeTurnin = false
local bacc2Norm = -50 --default 0
local bacc2FUCKYOU = 0 -- fuck you downscroll cucks
local bounceAmount = 0 -- default 20
local rotateAmount = 3 -- default 2
local bpmTweenorAgain = 0
local tweenTypeBounce = "elasticOut"
local tweenTypeRotate = "sineOut"
local multiplierSpeed = 4

function updateSpeed()
    multiplierSpeed = 60 * multiplierSpeed
    bpmTweenorAgain = multiplierSpeed/curBpm
end

function onCreatePost()
    updateSpeed()
end

function onEvent(eventName, val1, val2, strumTime)
    if eventName == "strumHudBounce" then
        if val1 ~= '' then
            if val1 == "true" then
                areWeBouncin = true
            else
                areWeBouncin = false
            end
        end
        if val2 ~= '' then
            if val2 == "true" then
                areWeTurnin = true
            else
                areWeTurnin = false
            end
        end
    end
    if eventName == "strumHudMovementTypes" then
        if val1 ~= '' then
            tweenTypeBounce = val1
        end
        if val2 ~= '' then
            tweenTypeRotate = val2
        end
    end
    if eventName == "strumHudAmounts" then
        if val1 ~= '' then
            bounceAmount = val1
        end
        if val2 ~= '' then
            rotateAmount = val2
        end
    end
    if eventName == "strumHudSpeed" then
        if val1 ~= '' then
            multiplierSpeed = val1
            updateSpeed()
        end
    end
end

function onBeatHit()
    if curBeat % 4 == 0 then
        if areWeBouncin then
            setProperty("strumHUD.y", bounceAmount, false)
            if not downscroll then
                doTweenY("strumHUDshoomver", "strumHUD", bacc2Norm, bpmTweenorAgain, tweenTypeBounce)
            else
                doTweenY("strumHUDshoomver", "strumHUD", bacc2FUCKYOU, bpmTweenorAgain, ttweenTypeBounce)
            end
        end
        if areWeTurnin then
            setProperty("strumHUD.angle", rotateAmount, false)
            doTweenAngle("strumHUDrotater", "strumHUD", 0, bpmTweenorAgain, tweenTypeRotate)
        end
    end
    if curBeat % 4 == 2 then
        if areWeBouncin then
            setProperty("strumHUD.y", bounceAmount, false)
            if not downscroll then
                doTweenY("strumHUDshoomver", "strumHUD", bacc2Norm, bpmTweenorAgain, tweenTypeBounce)
            else
                doTweenY("strumHUDshoomver", "strumHUD", bacc2FUCKYOU, bpmTweenorAgain, tweenTypeBounce)
            end
        end
        if areWeTurnin then
            setProperty("strumHUD.angle", -rotateAmount, false)
            doTweenAngle("strumHUDrotater", "strumHUD", 0, bpmTweenorAgain, tweenTypeRotate)
        end
    end
    -- debugPrint(curBeat % 4)
end