function toBool(str)
	return str:lower() == 'true';
end

function changePropertyFromGroup(group, item, variable, amount)
	return setPropertyFromGroup(group, item, variable, getPropertyFromGroup(group, item, variable) + amount);
end

function tweenNoteScale(object, scale)
	doTweenX('tweenNoteScaleX'..object, getProperty('strumLineNotes.members['..object..']')..'.scale', scale, 1, 'sineInOut')
	doTweenY('tweenNoteScaleY'..object, getProperty('strumLineNotes.members['..object..']')..'.scale', scale, 1, 'sineInOut')
end

local tweens = {
    ['left'] = function(i, notReverse) -- Use notReverse for horizontal tweens
		if i < 4 then
				return screenWidth / 2;
		end
		if i < 8 then
			setPropertyFromGroup('strumLineNotes', i, 'visible', true);
			if notReverse then
				changePropertyFromGroup('strumLineNotes', i, 'x', -400)
				return screenWidth / 2 - screenWidth / 3;
			else
				return - 400;
			end
		end
		if i < 12 then
			return screenWidth / 2 + screenWidth / 3;
		end
    end,    

    ['middle'] = function(i)
        if i < 4 then
    	    return screenWidth / 2 - screenWidth / 3;
		end
		if i < 8 then
	    	setPropertyFromGroup('strumLineNotes', i, 'visible', true);
	    	return screenWidth / 2;
		end
		if i < 12 then
			return screenWidth / 2 + screenWidth / 3;
		end
    end,

    ['right'] = function(i, notReverse)
		if i < 4 then
			return screenWidth / 2 - screenWidth / 3;
		end
		if i < 8 then
			setPropertyFromGroup('strumLineNotes', i, 'visible', true);
			if notReverse then
				changePropertyFromGroup('strumLineNotes', i, 'x', screenWidth + 800)
				return screenWidth / 2 + screenWidth / 3;
			else
				return screenWidth + 400;
			end
		end
		if i < 12 then
			return screenWidth / 2;
		end
    end
}

local verticalTweens = {['middle'] = true}

function returnAnim(name)
    for i=0, getProperty('strumLineNotes.length')-1 do
	local sepVal = tweens[name](i, true);
	setPropertyFromGroup('strumLineNotes', i, 'x', sepVal - (160 * 0.65) / 2 + (i%4 - 3 / 2) * (160 * 0.65));
    end
end

function tweenAnim(name, notReverse)
    for i=0, getProperty('strumLineNotes.length')-1 do
		local sepVal = tweens[name](i, notReverse);

		if i > 3 and i < 8 then
			if verticalTweens[name] then
				local downscrollMult = -1;
				if downscroll then downscrollMult = 1 end

				setPropertyFromGroup('strumLineNotes', i, 'x', sepVal - (160 * 0.65) / 2 + (i%4 - 3 / 2) * (160 * 0.65));
				if notReverse then
					setPropertyFromGroup('strumLineNotes', i, 'y', (getProperty('strumLine.y') + 200 * downscrollMult))
					noteTweenY('tweenNoteY'..i, i, getProperty('strumLine.y'), 1, 'sineInOut');
					noteTweenX('tweenNote'..i, i, sepVal - (160 * 0.65) / 2 + (i%4 - 3 / 2) * (160 * 0.65), 1, 'sineInOut');
				else
					noteTweenY('VEtweenNoteY'..i, i, getPropertyFromGroup('strumLineNotes', i, 'y') + (200 * downscrollMult), 1, 'sineInOut');
				end
			else
				noteTweenX('tweenNote'..i, i, sepVal - (160 * 0.65) / 2 + (i%4 - 3 / 2) * (160 * 0.65), 1, 'sineInOut');
			end
		else
			if notReverse then
				local thing = 3
				if i >= 0 and i <= 3 then
				local thingy = i + 11
				noteTweenX('tweenNote'..i, i,  getPropertyFromGroup('opponentStrums', 1, 'x')+(sepVal - (160 * 0.65) / 2 + (i%4 - 3 / 2) * (160 * 0.65)), 1, 'sineInOut');
				thing = thing -1
				end
				if i >= 8 and i <= 11 then
					local thingy = i - 8
					noteTweenX('tweenNote'..i, i,  (getPropertyFromGroup('opponentStrums',1,'x') - 1695 )+(sepVal - (160 * 0.65) / 2 + (i%4 - 3 / 2) * (160 * 0.65)), 1, 'sineInOut');
				end
				
			else
				local player = getPropertyFromGroup('strumLineNotes', i, 'player')
				if i >= 0 and i <= 3 then
					noteTweenX('tweenNote'..i, i, (screenWidth / 2 - (screenWidth / 4 * (1 + 1*-2))) - (160 * 0.7) / 2 + (i%4 - 3 / 2) * (160 * 0.7), 1, 'sineInOut');
				end
				if i >= 8 and i <= 11 then
					noteTweenX('tweenNote'..i, i, (screenWidth / 2 - (screenWidth / 4 * (1 + 0*-2))) - (160 * 0.7) / 2 + (i%4 - 3 / 2) * (160 * 0.7), 1, 'sineInOut');
				end
			end
		end
	end
end

function onEvent(name, value1, value2)
	if name == 'Show Strums' then
		tweenAnim(value2, toBool(value1))
	end
end

function onTweenCompleted(tag)
	if tag:sub(1, 2) == 'VE' then
		for i=4, 7 do
			changePropertyFromGroup('strumLineNotes', i, 'x', -screenWidth);
		end
	end

	if tag:sub(1, 14) == 'tweenNoteScale' then
		local stupid = tag:sub(-2);
		if not tonumber(stupid) then
			stupid = stupid:sub(-1);
		end

		updateHitboxFromGroup('strumLineNotes', tonumber(stupid))
	end
end

function onCreatePost()
	if songName == "jammin" or songName == "hammerhead" then
		for i=0, getProperty('opponentStrums.length')-1 do
			if i >= 0 and i <= 3 then
				setPropertyFromGroup('opponentStrums',i,'x', getPropertyFromGroup('opponentStrums',i,'x') + 640 )
			end
		end

		for i=0, getProperty('playerStrums.length')-1 do
			if i >= 0 and i <= 3 then
				setPropertyFromGroup('playerStrums',i,'x', getPropertyFromGroup('playerStrums',i,'x') - 640 )
			end
		end
	end
end