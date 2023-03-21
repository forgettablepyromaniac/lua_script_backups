function onCreate()
	math.randomseed(os.time()) -- uses Operating System's Clock for starting seed, thanks stackOverflow
	math.random(); -- doing this
	math.random(); -- multiple times
	math.random(); -- to allow (for) 
	math.random(); -- better randomization
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is a Blammed Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Blammed Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'DODGENOTE_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
			end
		end
	end
	--debugPrint('Script started!')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'Blammed Note' then
		setProperty('health', -500);
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Blammed Note' then
		health = getProperty('health');
		smidge = 1 / (health*7)
		-- debugPrint('Health: ', health, ' Smidge: ', smidge)
		if smidge > 0.275 then
			smidge = 0.275
		end
		setProperty('health', health + smidge);
		health = getProperty('health');
		if health > 1.6 then
			setProperty('health', 1.6);
		elseif noteData == 0 then
			triggerEvent('Play Animation', 'dodge-left', 'bf')
		elseif noteData == 1 then
			triggerEvent('Play Animation', 'dodge-down', 'bf')
		elseif noteData == 2 then
			triggerEvent('Play Animation', 'dodge-up', 'bf')
		elseif noteData == 3 then
			triggerEvent('Play Animation', 'dodge-right', 'bf')
		end
		triggerEvent('Add Camera Zoom', '0.025', '0.04');
	end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
	if noteType == 'Blammed Note' then
	rand = math.random(1, 2)
	-- debugPrint('rand num: ', rand);
	if rand == 1 then
		triggerEvent('Play Animation', 'attack2', 'dad')
	else
		triggerEvent('Play Animation', 'attack1', 'dad')
	end
	playSound('clownAttack', 1);
	end
end