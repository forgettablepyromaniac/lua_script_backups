local angleshit = 0.6;
local anglevar = 0.6;
local plsDoAFunny = false

function onBeatHit()
    if plsDoAFunny == true then
        triggerEvent('Add Camera Zoom', 0.06,0.04)
        if curBeat % 2 == 0 then
            angleshit = anglevar;
        else
            angleshit = -anglevar;
        end
        setProperty('camHUD.angle',angleshit*3)
        setProperty('camGame.angle',angleshit*3)
        doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.002, 'circOut')
        doTweenX('tuin', 'camHUD', -angleshit*8, crochet*0.001, 'linear')
        doTweenAngle('tt', 'camGame', angleshit, stepCrochet*0.002, 'circOut')
        doTweenX('ttrn', 'camGame', -angleshit*8, crochet*0.001, 'linear')
	else
        setProperty('camHUD.angle',0)
		setProperty('camHUD.x',0)
		setProperty('camHUD.x',0)
    end
end
function onStepHit()
    if plsDoAFunny == true then
        if curStep % 4 == 0 then
            doTweenY('rrr', 'camHUD', -12, stepCrochet*0.002, 'circOut')
            doTweenY('rtr', 'camGame.scroll', 12, stepCrochet*0.002, 'sineIn')
        end
        if curStep % 4 == 2 then
            doTweenY('rir', 'camHUD', 0, stepCrochet*0.002, 'sineIn')
            doTweenY('ryr', 'camGame.scroll', 0, stepCrochet*0.002, 'sineIn')
        end
    end
end

function onEvent(eventName, value1, value2)
    if eventName == "boppinCamera" then
        if value1 == "true" then
            plsDoAFunny = true
        else
            plsDoAFunny = false
        end
    end
end