function onCreatePost() 
	local dadSheet = ''
	local bfSheet = ''

	switch(string.lower(getProperty('dad.curCharacter')),
	{
   		['pyro'] = function()
       		dadSheet = 'NOTE_orange'
    	end,
    	['zackery'] = function()
        	dadSheet = 'NOTE_orange'
    	end,
		['pico'] = function()
        	dadSheet = 'NOTE_orange'
    	end,
		default = function()
        	dadSheet = 'default'
    	end,
	})

	switch(string.lower(getProperty('boyfriend.curCharacter')),
	{
		default = function()
        	bfSheet = 'default'
    	end,
	})

	if dadSheet ~= '' and not getPropertyFromClass('PlayState', 'isPixelStage') then
		for i=0,4,1 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/' .. dadSheet)
			for i = 0, getProperty('unspawnNotes.length') -1 do
				if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') and getPropertyFromGroup('unspawnNotes', i, 'texture') == '' then
					if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Third Player Note' then
						-- for some reason using not doesn't work here
					else
						setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/' .. dadSheet);
					end
				end
			end
		end
	end
	if bfSheet ~= '' and not getPropertyFromClass('PlayState', 'isPixelStage') then
		for i=0,4,1 do
			setPropertyFromGroup('playerStrums', i, 'texture', 'notes/' .. bfSheet)
			for i = 0, getProperty('unspawnNotes.length') -1 do
				if getPropertyFromGroup('unspawnNotes', i, 'mustPress') and getPropertyFromGroup('unspawnNotes', i, 'texture') == '' then
					if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Third Player Note' then
						-- for some reason using not doesn't work here
					else
						setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/' .. bfSheet);
					end
				end
			end
		end
	end
end

-- fuck you lua devs, now i gotta write my own switch statements
function switch(value, cases)
    local case = cases[value]
    if case then
        case()
    else
        local default = cases.default
        if default then
            default()
        end
    end
end

function onCreate()
	luaDebugMode = true
end
-- script written by redstoneruler <3