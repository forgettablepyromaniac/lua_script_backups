function onCreate()
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '50percent' then 
            setPropertyFromGroup('unspawnNotes', i, 'multSpeed', 0.5);
        end
    end
end