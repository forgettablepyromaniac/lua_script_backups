-- EDIT THESE THREE VARIABLES AS YOU SEE FIT.
local sanity = 50 -- starting sanity: max is 100, min is 0. 0 means death, basically.
local sanityDrain = 2 -- amount of sanity that will be lost upon enemy hitting note, should be less for slower songs. Decimals should be supported.
local sanityBarTXT = 'Sanity' -- feel free to fuck with this on occasion to scare players. Make random capitalization happen or smthn, idk. use math.randomseed(os.time()) to help with that.
-- I RECCOMEND TO NOT TOUCH ANYTHING ELSE THX

local pill = false
local sex = 1 -- sex for 1 dollar fortnite card

function onCreate() -- originally by wubbzyfan and further edited by forgettablePyromaniac (aka quadrupleABatteries)
	makeLuaSprite('BBAR', nil, screenWidth / 2 - 280, screenHeight - 500); -- only change the subtraction parts if ur going to move the bars.
	makeGraphic('BBAR', 52, 220, '000000');
	setObjectCamera('BBAR', 'hud');
	addLuaSprite('BBAR', true);
	makeLuaSprite('fuckingBAR', nil, screenWidth / 2 - 274, screenHeight - 490);
	makeGraphic('fuckingBAR', 40, 200, 'ffffff');
	setObjectCamera('fuckingBAR', 'hud');
	addLuaSprite('fuckingBAR', true);
	makeLuaSprite('BAR', nil, screenWidth / 2 - 274, screenHeight - 490);
	makeGraphic('BAR', 40, 200, '000000');
	setObjectCamera('BAR', 'hud');
	addLuaSprite('BAR', true);
	precacheSound('pillBottle');
	precacheSound('tits');
	makeLuaSprite('forTheVine', 'openSourceAdobeAnimate', screenWidth / -12, screenHeight / -12);
	setObjectCamera('forTheVine', 'other');
	addLuaSprite('forTheVine', true);
	makeLuaText('sanityText', sanityBarTXT, 24, screenWidth / 2 - 305, screenHeight - 480)
	setTextSize('sanityText', 24)
	setTextColor('sanityText', 'ffffff')
	setTextBorder('sanityText', 1, '000000')
	setTextFont('sanityText', 'vcr.ttf')
	setTextAlignment('sanityText', 'center')
	addLuaText('sanityText')
end

function onCreatePost()
	sex = 100 / curBpm -- because doing it in the local beforehand throws an error because curBpm isn't initalized yet.
	
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if pill == false then
			if sanity > 0 then
				sanity = sanity - sanityDrain / 2
				if isSustainNote == false then
					sanity = sanity - sanityDrain / 2 -- janky bs but it works so suck it
				end
			if sanity < 0 then
				sanity = 0
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Pill' then
		healths = getProperty('health')
		setProperty('health', healths - 0.022) -- should cancel out healing from hitting the note? idk.
		runTimer('PillTime', 0.1, 9);
		playSound('pillBottle');
		sanity = sanity + 2
		pill = true
		doTweenColor('bartweenlolthree', 'fuckingBAR', 'ffccff', 0.01, 'sineOut'); -- super gay ass pink
		runTimer('fucking', 0.05)
	end
end

function onUpdate()
	health = getProperty('health')
	if pill == false then
		if sanity == 0 then
			setProperty('health', health - 0.005); -- kills u fast
		end
	end
	scaleObject('BAR', 1, 1 - sanity * 0.01); -- i fucking hate this thing.
	scaleObject('forTheVine', 0.4, 0.4); -- JUST SCALE THE RIGHT WAY BITCH
	setTextString('sanityText', sanityBarTXT)
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'PillTime' then
		if loopsLeft >= 1 then
			sanity = sanity + 1 -- in the end, this should increase sanity by 10 unless multiple pill notes are hit.
		else
			pill = false
		end
	end
	if tag == 'hmyes' then
		doTweenColor('bartweenloltwo', 'fuckingBAR', 'ffffff', sex, 'sineOut');
	end
	if tag == 'fucking' then
		doTweenColor('bartweenlolthree', 'fuckingBAR', 'ffffff', sex / 2, 'sineOut'); -- make it racist
	end
	
end

function onSectionHit()
	if sanity <= 20 then
	doTweenColor('bartweenlol', 'fuckingBAR', 'ff0000', 0.01, 'linear');
	playSound('tits');
	runTimer('hmyes', 0.05);
	end
end