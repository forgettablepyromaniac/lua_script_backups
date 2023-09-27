function onCreate()
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '75percent' then 
            setPropertyFromGroup('unspawnNotes', i, 'multSpeed', 0.75);
        end
    end
end