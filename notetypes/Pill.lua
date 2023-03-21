function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Pill' then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'Pill'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'pillSplash'); -- change splash
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			if botPlay == true then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); -- fuck this bot.
			end
		end
	end
end