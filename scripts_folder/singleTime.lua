-- I moved a bunch of scripts that were unrelated into this one in order to (hopefully) save memory.
-- everything is LOOSELY commented, but things are everywhere lmao -fp
-- I think it helped, but only ~20mb

-- setup for future things

local dadColour = "XXXXXX"

local jayjayIsPinger = { -- placeholder
    'STRING A',
    'STRING B',
    'STRING C',
}

local thisIsDumb = { -- this is dumb but for loops are cool so idrc 
    'sickWindow',
    'goodWindow',
    'badWindow',
}

function formatString(str) -- SO ChatGPT
    str = string.gsub(str, "-", " ")
    local result = ""
    for word in string.gmatch(str, "%S+") do
        result = result .. string.upper(string.sub(word, 1, 1)) .. string.sub(word, 2) .. " "
    end
    result = string.sub(result, 1, -2)
    return result
end  

-- cursour stuff and sounds.

local function cursourOn()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
end

local function cursourOff()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
end

function returnToDefault()
    setPropertyFromClass("openfl.Lib", "application.window.title", "vs. FP & Friends")
end

function iAmDead()
    setPropertyFromClass("openfl.Lib", "application.window.title", "vs. FP & Friends - Owchies")
end

function letsStretchOurLegs()
    if mustHitSection == true then
        setTextColor('botplayTxt', "00FFFF");
        setTextColor('scoreTxt', "00FFFF");
    elseif gfSection == true then
        setTextColor('botplayTxt', "cc33ff");
        setTextColor('scoreTxt', "cc33ff");
    else
        setTextColor('botplayTxt', dadColour);
        setTextColor('scoreTxt', dadColour);
    end
end

function onCreatePost() -- lua script for misc things (mostly things that run once)
    if boyfriendName == "bf-back" then
        setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-backdead');
    end
    setTextString('botplayTxt', 'DEMO')
    setProperty('showCombo', false);
    cursourOff()

    local mainTitleText = "vs. FP & Friends - "..formatString(songName)
    setPropertyFromClass("openfl.Lib", "application.window.title", mainTitleText)

    if songName == "nqa" then
        setPropertyFromClass("openfl.Lib", "application.window.title", 'vs. FP & Friends - NQA') -- really dumb override.
    end

    if dadName == "pyro" or dadName == "Zackery" then
        dadColour = "ff9900"
    elseif dadName == "pico" or dadName == "saw" then
        dadColour = "3333ff"
    elseif dadName == "purp" then
        dadColour = "cc33ff"
    elseif dadName == "joemamma" then
        dadColour = "FF0000"
    else
        dadColour = "AAAAAA" -- elseif chain that could be a table... Too bad!
    end
    letsStretchOurLegs();

    jayjayIsPinger = {
        getPropertyFromClass('ClientPrefs', 'sickWindow'),
        getPropertyFromClass('ClientPrefs', 'goodWindow'),
        getPropertyFromClass('ClientPrefs', 'badWindow'),
    }
    setPropertyFromClass('ClientPrefs', 'sickWindow', 60)
    setPropertyFromClass('ClientPrefs', 'goodWindow', 110)
    setPropertyFromClass('ClientPrefs', 'badWindow', 150)
end

function onPause()
    cursourOn()
    playSound('unpawse')
end

-- function onEndSong()
--     cursourOn()
-- end
-- -- removed for being incompatable with end dialouges.

function onResume()
    cursourOff()
    playSound('pawse')
end

 -- below is all the Dialouge events so that I don't have to copy paste the same shit ad-nauseum in a variety of script files.

local allowCountdown = false
local startedFirstDialogue = false
local startedEndDialogue = false

function hideAnnoyingElements() -- todo: find Botplay Text name?
    local arrayOfElements = {
        'healthBar', 'iconP1', 'iconP2', 'scoreTxt'
    }
    for i, ree in pairs(arrayOfElements) do
        doTweenAlpha('doTweenTimeness'..i, ree, 0, 0.8, 'circOut')
    end
end

function onStartCountdown()
    if checkFileExists('data/'..songName..'/dialogue.json') then -- so that it doesn't get stuck when the file doesn't exist
        if not allowCountdown and not startedFirstDialogue then
            setProperty('inCutscene', true);
            runTimer('startDialogue', 0.8);
            startedFirstDialogue = true;
            return Function_Stop;
        end
        return Function_Continue;
    end
end

function onEndSong()
    if checkFileExists('data/'..songName..'/dialogue2.json') then -- same here, but for ending dialouge instead.
        if not allowCountdown and not startedEndDialogue then
            hideAnnoyingElements()
            setProperty('inCutscene', true);
            runTimer('startDialogueEnd', 0.8);
            startedEndDialogue = true;
            return Function_Stop;
        end
        return Function_Continue;
    end

    for i, eec in pairs(jayjayIsPinger) do
        setPropertyFromClass('ClientPrefs', thisIsDumb[i], eec)
    end
end

function onTimerCompleted(tag, loops, loopsLeft) -- I hate the timer system but it works so can't do much about that.
	if tag == 'startDialogue' then
		startDialogue('dialogue', 'cutScene');
	elseif tag == 'startDialogueEnd' then
		startDialogue('dialogue2', 'cutScene');
	end
end

-- Combo stuff

function onUpdate(elapsed)
    local combo = getProperty('combo')
    if combo > 10 and (combo == 19 or combo == 49 or combo == 149 or combo == 249 or (combo + 1) % 100 == 0) then -- this is dumb
        setProperty('showCombo', true)
    else
        setProperty('showCombo', false)
    end

    if getProperty("health") < 0 then
        iAmDead()
    end

    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN') then
        playSound("ToggleJingle") -- plays a funny sound when pressing (the) debug button
    end
end

-- HP fuckery.

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    hulth = getProperty('health')
    if week == "week8" then
        hulth = hulth - hulth/55 -- im weak baby
        setProperty('health', hulth)
    elseif songName == "jammin" or songName == "hammerhead" then -- more stupid-ass overrides.
        hulth = hulth - hulth/65
        setProperty('health', hulth)
    else
    hulth = hulth - hulth/50
    setProperty('health', hulth) -- so much hulth
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    hulth = getProperty('health')
    if songName == "curse" then
        hulth = hulth - 0.021
        setProperty('health', hulth)
    end

    -- if not isSustainNote then
    --     playSound('hitsound', 0.7)
    -- end -- this sounds incredibly fucking stupid and off beat no matter what I do, including fucking 'round with my offset.
    -- --if you really want this, uncomment it I guess.
end

-- credits Stuff.

local artistName = 'Unknown'
local redbookAudio = 0
local slightlyLeft = 0
local slightlyRight = 0
local orangebookAudio = 0
local greenbookAudio = 0
local purplebookAudio = 0
local beatDuration = 0

function onCountdownStarted()
    redbookAudio = screenWidth / 2.5; -- declare variables.
    orangebookAudio = screenHeight / 2;
    bluebookAudio = screenHeight / 3;
    greenbookAudio = screenHeight / 1.7;
    purplebookAudio = screenHeight / 1.5;
    slightlyLeft = screenWidth / 3;
    slightlyRight = screenWidth / 3.5 + 8; -- this is fucking stupid
    if checkFileExists('data/'..songName..'/songCreatorName.txt') then
        artistName = getTextFromFile('data/'..songName..'/songCreatorName.txt');
    end
    if artistName == "Unknown" then
        Function_Stop();
    end -- If there is no info to show, there is no reason to continue.
    -- debugPrint('NAME: ', artistName);
    -- debugPrint('SHARTER: ', charterName);
    -- debugPrint('SONG: ', songName);

    makeLuaSprite('creditBackground', 'empty', 0, 0);
	makeGraphic('creditBackground', redbookAudio, screenHeight, '000000'); 
	setObjectCamera('creditBackground', 'camHUD');
    setProperty('creditBackground.alpha', 0); -- today I learned you can do setProperty with your own sprites. Useful to know.
	addLuaSprite('creditBackground', false);
    screenCenter('creditBackground', 'xy');
    makeLuaText('theSongName', '"'..formatString(songName)..'"', redbookAudio, redbookAudio, bluebookAudio); -- stupid dumb unoptimized code.
    if songName == "nqa" then
        setTextString('theSongName', '"NQA"'); -- really dumb override for exception where I want every letter uppercased.
    end
	setTextAlignment('theSongName', 'center');
	setTextFont('theSongName', 'vcr.ttf'); 
    setTextColor('theSongName', 'ffffff');
	setTextSize('theSongName', 56);
    setProperty('theSongName.alpha', 0);
    addLuaText('theSongName');
    screenCenter('theSongName', 'x');

	makeLuaText('artistText', 'Composer:', redbookAudio, slightlyLeft, orangebookAudio);
	setTextAlignment('artistText', 'left');
	setTextFont('artistText', 'vcr.ttf');
    setTextColor('artistName', 'ffffff');
	setTextSize('artistText', 48);
    setProperty('artistText.alpha', 0);
    addLuaText('artistText');

    makeLuaText('artistName', artistName, redbookAudio, slightlyRight, greenbookAudio);
	setTextAlignment('artistName', 'right');
	setTextFont('artistName', 'vcr.ttf');
    if artistName == "ChewyPig" then
        setTextColor('artistName', 'cc33ff'); 
    elseif artistName == "SawyerNQA" then
        setTextColor('artistName', '3333ff');  -- this is dumb.
    elseif artistName == "RedTv53" then
        setTextColor('artistName', 'e60000'); 
    else 
        setTextColor('artistName', 'ff9900'); 
    end
	setTextSize('artistName', 40);
    setProperty('artistName.alpha', 0);
    addLuaText('artistName');

    if songName == "hammerhead" then
        makeLuaText('withEdits', "with edits by fp", redbookAudio, redbookAudio, purplebookAudio);
        setTextString('artistText', 'Original Artist:');
        setTextAlignment('withEdits', 'center');
        setTextFont('withEdits', 'vcr.ttf');
        setTextColor('withEdits', 'ff9900'); 
        setTextSize('withEdits', 24);
        setProperty('withEdits.alpha', 0);
        addLuaText('withEdits');
        screenCenter('withEdits', 'x');
    end
end

function onCountdownTick(swagCounter)
    if swagCounter == 3 then -- funny varName
        beatDuration = 60 / curBpm
        doTweenAlpha('2tweenMeDaddy', 'theSongName', 1, beatDuration, 'sineInOut')
        doTweenAlpha('2tweenMeDaddy2', 'artistText', 1, beatDuration, 'sineInOut')
        doTweenAlpha('2tweenMeDaddy3', 'artistName', 1, beatDuration, 'sineInOut')
        doTweenAlpha('2tweenMeDaddy4', 'creditBackground', 0.5, beatDuration, 'sineInOut')
        if songName == "hammerhead" then
            doTweenAlpha('2tweenMeDaddy5', 'withEdits', 1, beatDuration, 'sineInOut')
        end
    end
end

function onBeatHit()
    if curBeat == 8 then 
        local fuckMeSideways = beatDuration * 2
        doTweenAlpha('tweenMeDaddy', 'theSongName', 0, fuckMeSideways, 'sineInOut')
        doTweenAlpha('tweenMeDaddy2', 'artistText', 0, fuckMeSideways, 'sineInOut')
        doTweenAlpha('tweenMeDaddy3', 'artistName', 0, fuckMeSideways, 'sineInOut')
        doTweenAlpha('tweenMeDaddy4', 'creditBackground', 0, fuckMeSideways, 'sineInOut')
        if songName == "hammerhead" then
            doTweenAlpha('tweenMeDaddy5', 'withEdits', 0, fuckMeSideways, 'sineInOut')
        end
    end
end

-- window stuff vvv

function onGameOver()
    iAmDead()
end

function onDestroy()
    returnToDefault()
    cursourOn()
    for i, eec in pairs(jayjayIsPinger) do
        setPropertyFromClass('ClientPrefs', thisIsDumb[i], eec)
    end
end

-- Bar colours.

function onSectionHit()
    letsStretchOurLegs();
end