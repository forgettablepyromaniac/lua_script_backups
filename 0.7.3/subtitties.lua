local paddingNum = 35
local timingNum = 30

local currentSub = 1
local tempSub = 1

local theFormula = 0

local oooCanWe = true -- vestage of settings.txt, easier to just set to true and move on.

function onCreatePost()
    if downscroll then
        theFormula = screenHeight*0.25
    else
        theFormula = screenHeight*0.75
    end
    if oooCanWe then
        for i = 1, 3 do
            makeLuaText("fpsubtitle"..i, "", screenWidth / 1.5, 0, theFormula)
            setObjectCamera("fpsubtitle"..i, 'other')
            setTextSize("fpsubtitle"..i, 32)
            setTextAutoSize("fpsubtitle"..i, true)
            setTextAlignment("fpsubtitle"..i, 'center')
            screenCenter("fpsubtitle"..i, 'x')
            setProperty("fpsubtitle"..i..".alpha", 0, false)
            setProperty("fpsubtitle"..i..".y", getProperty("fpsubtitle"..i..".y") + paddingNum * i)
            addLuaText("fpsubtitle"..i)
        end
    end
    timingNum = (timingNum/curBpm) / playbackRate
end

function onEvent(eventName, val1, val2, strumTime) -- shocking.
    if oooCanWe then
        if eventName == "subtitties" then
            if val2 == "clear" then
                subtitleClear()
            elseif val1 ~= nil then
                subtitleAnim(val1, val2)
            end
        end
    end
end

function subtitleClear()
    for i = 1, 3 do
        doTweenY("fpsubtitleClearWhyTween"..i, "fpsubtitle"..i, getProperty("fpsubtitle"..i..".y") - paddingNum, timingNum, "linear")
        doTweenAlpha("fpsubtitleClearAlphTween"..i, "fpsubtitle"..i, 0, timingNum, "linear")
    end
end

function subtitleAnim(text, colour)
    if string.sub(text, 1, 2) == "//" then
        tempSub = currentSub - 1
        if tempSub == 0 then
            tempSub = 3
        end
        setTextString("fpsubtitle"..tempSub, text:sub(3))
        tempSub = currentSub + 1
        if tempSub == 4 then
            tempSub = 1
        end
    else
        setTextString("fpsubtitle"..currentSub, text)
        doTweenY("fpsubtitleWhyTween"..currentSub, "fpsubtitle"..currentSub, getProperty("fpsubtitle"..currentSub..".y") - paddingNum, timingNum, "linear")
        doTweenAlpha("fpsubtitleAlphTween"..currentSub, "fpsubtitle"..currentSub, 1, timingNum, "linear")
        if colour ~= nil then
            setTextColor("fpsubtitle"..currentSub, colour)
        end

        tempSub = currentSub - 1 -- previous
        if tempSub == 0 then
            tempSub = 3
        end
        doTweenY("fpsubtitleWhyTween"..tempSub, "fpsubtitle"..tempSub, getProperty("fpsubtitle"..tempSub..".y") - paddingNum, timingNum, "linear")
        doTweenAlpha("fpsubtitleAlphTween"..tempSub, "fpsubtitle"..tempSub, 0, timingNum, "linear")
        
        tempSub = currentSub + 1 -- next
        if tempSub == 4 then
            tempSub = 1
        end
        setTextString("fpsubtitle"..tempSub, "")
        setProperty("fpsubtitle"..tempSub..".y", theFormula + paddingNum * 2)
        doTweenY("fpsubtitleWhyTween"..tempSub, "fpsubtitle"..tempSub, getProperty("fpsubtitle"..tempSub..".y") - paddingNum, timingNum, "linear")
        doTweenAlpha("fpsubtitleAlphTween"..tempSub, "fpsubtitle"..tempSub, 0.5, timingNum, "linear")

        currentSub = currentSub + 1
        if currentSub == 4 then
            currentSub = 1
        end
    end
end


function onTweenCompleted(tag, vars)
    if tag == "fpsubtitleClearWhyTween"..currentSub then
        for i = 1, 3 do
            -- local yOffset = paddingNum * (i - 1)  -- Adjust the Y offset calculation
            setProperty("fpsubtitle"..i..".y", getProperty("fpsubtitle"..i..".y") + yOffset)
        end
    end
end
