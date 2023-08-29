local letters = {
    "W",
    "O",
    "A",
    "H",
    "L",
    "E",
    "S",
    "S"
}

local maxLetters = 8
local currentLetter = 1
local runn = false
local susss = true

function onCreatePost()
    if songName == "woahless-minus" then
        susss = false
    end
end

function onUpdatePost(elapsed)
    if week == "week8" then
        if susss == true then
            if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'..letters[currentLetter]) then
                playSound("keyTap")
                if currentLetter == maxLetters then
                    playSound("ToggleJingle")
                    loadSong('woahless-minus', 'normal', true);
                else
                    currentLetter = currentLetter + 1
                end
            end
        end
    end
end

function onStartCountdown()
	if buildTarget == 'browser' or buildTarget == 'android' or buildTarget == 'unknown' then
        if not runn == true then
            makeLuaSprite('fucker', 'empty', 0, 0);
            makeGraphic('fucker', screenWidth, screenHeight, '000000'); 
            setObjectCamera('fucker', 'camHUD');
            addLuaSprite('fucker', true);
            screenCenter('fucker', 'xy');
            makeLuaText('noWebsite', 'GTFO.', 640, 720);
            setTextAlignment('noWebsite', 'center');
            setTextFont('noWebsite', 'vcr.ttf'); 
            setTextColor('noWebsite', 'ffffff');
            setTextSize('noWebsite', 56);
            addLuaText('noWebsite');
            screenCenter('noWebsite', 'x');
            setObjectCamera('noWebsite', 'camHUD');
            addLuaSprite('noWebsite', true);
            return Function_Stop
        end
	end
    -- if buildTarget == 'linux' then
    --     debugPrint("based.")
	-- end
	return Function_Continue
end

