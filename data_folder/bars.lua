function onCreate()
	groom, feed, batt = 150, 150, 150 --- max is 333, least is 0. also use getProperty('health')
	makeLuaSprite('battaBar', '', 160, 54); --start of batteryBar
	makeGraphic('battaBar', batt, 40, '00FF00');
	setObjectCamera('battaBar', 'hud');
	setProperty('battaBar.alpha', 1);
    addLuaSprite('battaBar');
	makeLuaSprite('yummyBar', '', 160, 124); --start of yummyBar
	makeGraphic('yummyBar', batt, 40, 'EF9B00');
	setObjectCamera('yummyBar', 'hud');
	setProperty('yummyBar.alpha', 1);
    addLuaSprite('yummyBar');
	makeLuaSprite('pedoBar', '', 160, 196); --start of pedoBar
	makeGraphic('pedoBar', batt, 40, '0037FF');
	setObjectCamera('pedoBar', 'hud');
	setProperty('pedoBar.alpha', 1);
    addLuaSprite('pedoBar');
   	makeLuaSprite('needBars', 'needBars', 20, 50); -- The final layer of this onion
	doTweenAlpha('moveBars', 'needBars', 0, 0.1, 'linear');
	doTweenAlpha('moveBatt', 'battaBar', 0, 0.1, 'linear');
	doTweenAlpha('moveYumm', 'yummyBar', 0, 0.1, 'linear');
	doTweenAlpha('movePedo', 'pedoBar', 0, 0.1, 'linear');
	doTweenAlpha('fuckThisBar', 'healthBar', 0, 0.1, 'linear');
	setObjectCamera('needBars', 'hud');
	addLuaSprite('needBars', false);
end

function goodNoteHit(id, noteData, noteType, isSustainNote) 
	if noteType == 'FEED' then
		feed = feed + 25
		playSound('feeding')
	end
	if noteType == 'GRUB' then
		groom = groom + 25
		playSound('brush')
	end
	if noteType == 'BATT' then
		batt = batt + 25
		playSound('battery')
	end
end

function onCreatePost()
	-- setProperty('iconP1.visible', false);
    -- setProperty('iconP2.visible', false);
end

function onUpdate()
	battColor = '00FF00'
	yummColor = 'EF9B00'
	pedoColor = '0037FF'
	if batt < 50 then
		battColor = 'FC0303'
	end
	if feed < 50 then
		yummColor = 'FC0303'
	end
	if groom < 50 then
		pedoColor = 'FC0303'
	end
	makeGraphic('battaBar', batt, 40, battColor);
	makeGraphic('yummyBar', feed, 40, yummColor);
	makeGraphic('pedoBar', groom, 40, pedoColor);
end

function onUpdatePost() -- shoutout space.fla
	if downscroll == false then
		setProperty('iconP1.x', 1100)
		setProperty('iconP2.x', 25)
		setProperty('iconP1.y', 580)
		setProperty('iconP2.y', 600)
	end
	if downscroll == true then
		setProperty('iconP1.x', 1100)
		setProperty('iconP2.x', 25)
		setProperty('iconP1.y', 250)
		setProperty('iconP2.y', 250)
		if middlescroll == true then
		setProperty('iconP1.x', 1100)
		setProperty('iconP2.x', 25)
		setProperty('iconP1.y', 580)
		setProperty('iconP2.y', 600)
		end
	end
end   

function onSongStart()
	doTweenAlpha('moveBars', 'needBars', 0.9, 1.7, 'linear');
	doTweenAlpha('moveBatt', 'battaBar', 0.9, 1.7, 'linear');
	doTweenAlpha('moveYumm', 'yummyBar', 0.9, 1.7, 'linear');
	doTweenAlpha('movePedo', 'pedoBar', 0.9, 1.7, 'linear');
	if downscroll == false then
		noteTweenY('noteMove1', 0, 800, 1.5, 'sineInOut');
		noteTweenY('noteMove2', 1, 800, 1.5, 'sineInOut');
		noteTweenY('noteMove3', 2, 800, 1.5, 'sineInOut');
		noteTweenY('noteMove4', 3, 800, 1.5, 'sineInOut');
		noteTweenAngle('noteSpin1', 0, 720, 2, 'sineInOut');
		noteTweenAngle('noteSpin2', 1, 720, 2, 'sineInOut');
		noteTweenAngle('noteSpin3', 2, 720, 2, 'sineInOut');
		noteTweenAngle('noteSpin4', 3, 720, 2, 'sineInOut');
    end
    if downscroll == true then
		noteTweenY('noteMove1', 0, -200, 1.5, 'sineInOut');
		noteTweenY('noteMove2', 1, -200, 1.5, 'sineInOut');
		noteTweenY('noteMove3', 2, -200, 1.5, 'sineInOut');
		noteTweenY('noteMove4', 3, -200, 1.5, 'sineInOut');
		noteTweenAngle('noteSpin1', 0, -720, 2, 'sineInOut');
		noteTweenAngle('noteSpin2', 1, -720, 2, 'sineInOut');
		noteTweenAngle('noteSpin3', 2, -720, 2, 'sineInOut');
		noteTweenAngle('noteSpin4', 3, -720, 2, 'sineInOut');
    end
    if middlescroll == true then
    	noteTweenAngle('noteSpin5', 4, 360, 2, 'sineInOut');
		noteTweenAngle('noteSpin6', 5, 360, 2, 'sineInOut');
		noteTweenAngle('noteSpin7', 6, 360, 2, 'sineInOut');
		noteTweenAngle('noteSpin8', 7, 360, 2, 'sineInOut');
        if downscroll == false then
			noteTweenX('noteMove5', 4, 720, 2, 'sineInOut');
			noteTweenX('noteMove6', 5, 830, 2, 'sineInOut');
			noteTweenX('noteMove7', 6, 940, 2, 'sineInOut');
			noteTweenX('noteMove8', 7, 1050, 2, 'sineInOut');
		end
		if downscroll == true then
			noteTweenX('noteMove5', 4, 640, 2, 'sineInOut');
			noteTweenX('noteMove6', 5, 750, 2, 'sineInOut');
			noteTweenX('noteMove7', 6, 860, 2, 'sineInOut');
			noteTweenX('noteMove8', 7, 970, 2, 'sineInOut');
		end
    end
end

function onBeatHit()
		groom = groom - 1.25
		feed = feed - 1.75
		batt = batt - 0.75
	if batt > 333 then
		batt = 333
	end
	if feed > 333 then
		feed = 333
	end
	if groom > 333 then
		groom = 333
	end
	if batt < 0 then
		batt = 0
		health = getProperty('health');
		setProperty('health', health - 0.075);
	end
	if feed < 0 then
		feed = 0
		health = getProperty('health');
		setProperty('health', health - 0.075);
	end
	if groom < 0 then
		groom = 0
		health = getProperty('health');
		setProperty('health', health - 0.075);
	end
	if batt < 50 or feed < 50 or groom < 50 then
		playSound('bep')
	end
end
