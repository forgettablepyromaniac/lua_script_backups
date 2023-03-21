local artistName = 'Unknown'
local redbookAudio = 0
local slightlyLeft = 0
local slightlyRight = 0
local orangebookAudio = 0
local greenbookAudio = 0
local purplebookAudio = 0

function onCreatePost()
    redbookAudio = screenWidth / 2.5; -- declare variables.
    orangebookAudio = screenHeight / 2;
    bluebookAudio = screenHeight / 3;
    greenbookAudio = screenHeight / 1.7;
    purplebookAudio = screenHeight / 1.5;
    slightlyLeft = screenWidth / 3;
    slightlyRight = screenWidth / 3.5 + 8;
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
    setProperty('creditBackground.alpha', 0.5); -- today I learned you can do setProperty with your own sprites. Useful to know.
	addLuaSprite('creditBackground', false);
    screenCenter('creditBackground', 'xy');

    makeLuaText('theSongName', '"'..songName..'"', redbookAudio, redbookAudio, bluebookAudio); -- stupid dumb unoptimized code.
	setTextAlignment('theSongName', 'center');
	setTextFont('theSongName', 'vcr.ttf'); 
    setTextColor('theSongName', 'ffffff');
	setTextSize('theSongName', 56);
    addLuaText('theSongName');
    screenCenter('theSongName', 'x');

	makeLuaText('artistText', 'Artist:', redbookAudio, slightlyLeft, orangebookAudio);
	setTextAlignment('artistText', 'left');
	setTextFont('artistText', 'vcr.ttf');
    setTextColor('artistName', 'ffffff');
	setTextSize('artistText', 48);
    addLuaText('artistText');

    makeLuaText('artistName', artistName, redbookAudio, slightlyRight, greenbookAudio);
	setTextAlignment('artistName', 'right');
	setTextFont('artistName', 'vcr.ttf');
    if artistName == "ChewyPig" then
        setTextColor('artistName', 'cc33ff'); 
    elseif artistName == "SawyerNQA" then
        setTextColor('artistName', '3333ff'); 
    elseif artistName == "RedTv53" then
        setTextColor('artistName', 'e60000'); 
    else 
        setTextColor('artistName', 'ff9900'); 
    end
	setTextSize('artistName', 40);
    addLuaText('artistName');

    if songName == "hammerhead" then
        makeLuaText('withEdits', "with edits by fp", redbookAudio, redbookAudio, purplebookAudio);
        setTextString('artistText', 'Original Artist:');
        setTextAlignment('withEdits', 'center');
        setTextFont('withEdits', 'vcr.ttf');
        setTextColor('withEdits', 'ff9900'); 
        setTextSize('withEdits', 24);
        addLuaText('withEdits');
        screenCenter('withEdits', 'x');
    end
end

function onBeatHit()
    if curBeat == 8 then 
        doTweenAlpha('tweenMeDaddy', 'theSongName', 0, 1, 'sineInOut')
        doTweenAlpha('tweenMeDaddy2', 'artistText', 0, 1, 'sineInOut')
        doTweenAlpha('tweenMeDaddy3', 'artistName', 0, 1, 'sineInOut')
        doTweenAlpha('tweenMeDaddy4', 'creditBackground', 0, 1, 'sineInOut')
        if songName == "hammerhead" then
            doTweenAlpha('tweenMeDaddy5', 'withEdits', 0, 1, 'sineInOut')
        end
    end
end