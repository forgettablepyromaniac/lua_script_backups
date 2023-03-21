function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GRUB' then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'GRUBNOTE_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'grubSplash'); -- change splash
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
				if botPlay == true then
					setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); -- fuck this bot.
				end
			end
		end
	end
end
