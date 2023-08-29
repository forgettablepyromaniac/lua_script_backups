function onCreatePost()
    makeAnimatedLuaSprite("gfSpeeder", "characters/GF_Amogus", defaultGirlfriendX*1.3, defaultGirlfriendY*4, "sparrow") 
    addAnimationByIndices("gfSpeeder", "danceL", "une", "1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15", 24)
    addAnimationByIndices("gfSpeeder", "danceR", "une222", "1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15", 24)
    addLuaSprite("gfSpeeder", false)
    triggerEvent("Set GF Speed", 2, nil)
    setObjectOrder("gfGroup", 12)
    addOffset("gfSpeeder", "danceL", 4, 0)
    addOffset("gfSpeeder", "danceR", -4, 0)
end

function onCountdownTick(swagCounter)
    -- debugPrint(swagCounter)
    if swagCounter == 0 then
        playAnim("gfSpeeder", "danceL", true, false, 0)
    end
    if swagCounter == 2 then
        playAnim("gfSpeeder", "danceR", true, false, 0)
    end
end

function onSongStart()
    playAnim("gfSpeeder", "danceL", true, false, 0)
end

function onBeatHit()
    if curBeat % 4 == 0 then
        playAnim("gfSpeeder", "danceL", true, false, 0)
    elseif curBeat % 4 == 2 then
        playAnim("gfSpeeder", "danceR", true, false, 0)
    end
end

function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing' then 
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteSkins/faded'); --Change notetexture
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then 
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			end
		end
	end
end