local directions = {'left', 'down', 'up', 'right'};
local strumSong;
strumData = {}

function toBool(str)
	return str:lower() == 'true';
end

function splitLuaText(s, delimiter)
    result = {};
    for token in s:gmatch("[^"..delimiter.."]+") do
   		table.insert(result, token)
    end
    return result;
end

function strumCallScripts(functionName, args)
	callScript('data/'..strumSong..'/strumline', functionName, args);
	callScript('scripts/strumline/script', functionName, args);
end

function loadSongData()
	local text;
	if checkFileExists('data/strumData.txt') then
		if checkFileExists('data/'..strumSong..'/strumData.txt') then
			text = getTextFromFile('data/'..strumSong..'/strumData.txt');
		else
			text = getTextFromFile('data/strumData.txt');
		end
	else
		if checkFileExists('data/'..strumSong..'/strumData.txt') then
			text = getTextFromFile('data/'..strumSong..'/strumData.txt');
		else
			return {['alreadyVisible'] = 'false'}
		end
	end

	local splitTable = splitLuaText(text, '\n');
	local dum = {}

	for stupid, str in pairs(splitTable) do
		if stupid ~= #splitTable then 
			str = str:sub(1, -2);
		end

		str = splitLuaText(str, ':');
		dum[str[1]] = str[2];
	end

	splitTable = nil;
	return dum;
end

function generateStaticArrows()
    local alreadyVisible = strumData['alreadyVisible'] or 'true';
    addHaxeLibrary('Std');

    runHaxeCode([[
		var version = Std.int(StringTools.replace(StringTools.replace("]]..version..[[", '.', ''), 'h', '.1'));
		game.setOnLuas('convertedVersion', version);

		if (version<61)
		{
			return;
		}

        for (i in 0...8)
        {
            var spr = game.strumLineNotes.members[i];
            //spr.setGraphicSize(spr.width / 0.7 * 0.65);
            spr.updateHitbox();

	    	var seperation = FlxG.width / 2;
	    	if (i > 3)
				seperation += FlxG.width / 3;
        }

		var stupidList = ['left', 'down', 'up', 'right']; // God forgive me :(

        for (i in 0...4)
        {
            var babyArrow = new StrumNote(0, game.strumLine.y, i + 4, 0);

			if (version<063)
			{
				babyArrow.animation.addByPrefix('static', 'arrow' + stupidList[i].toUpperCase());
				babyArrow.animation.addByPrefix('pressed', stupidList[i]+' press', 24, false);
				babyArrow.animation.addByPrefix('confirm', stupidList[i]+' confirm', 24, false);
			}

			babyArrow.downScroll = ClientPrefs.downScroll;
			game.opponentStrums.add(babyArrow);
			game.strumLineNotes.insert(4+i, babyArrow);
			babyArrow.postAddedToGroup();

			babyArrow.visible = false;
			babyArrow.x -= FlxG.width;
			//babyArrow.setGraphicSize(babyArrow.width / 0.7 * 0.65);
			babyArrow.updateHitbox();
        }

        for (note in game.unspawnNotes)
        {
			if (note.isSustainNote) 
			{
				//note.setGraphicSize(note.width / 0.7 * 0.65, note.height);
			}
			else 
			{
				//note.setGraphicSize(note.width / 0.7 * 0.65);
			}
            note.updateHitbox();
        }

		game.singAnimations = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT', 'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];
    ]])

    if toBool(alreadyVisible) then
		callScript('scripts/strumlineAnims', 'returnAnim', {strumData['animationType'] or 'left'});
    end
end

function onCreatePost()
	if songName == "jammin" or songName == "hammerhead" then
  	  luaDebugMode = true; -- Seen any issues? Report them on the GameBanana page!
  	  strumSong = songName:lower():gsub(" ", "-");
		strumData = loadSongData();
  	  generateStaticArrows();
	end
end

function onUpdate(elapsed)
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Third Player Note' then
		strumCallScripts('strumNoteHit', {id, direction, isSustainNote}); -- 4 5 6 7 6 7 = left down up right up right
		if direction == 4 then
			triggerEvent("Play Animation", "singLEFT", "GF")
		elseif direction == 5 then
			triggerEvent("Play Animation", "singDOWN", "GF")
		elseif direction == 6 then
			triggerEvent("Play Animation", "singUP", "GF")
		else
			triggerEvent("Play Animation", "singRIGHT", "GF")
		end
	end
end