function onCreate()
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '88percent' then 
            setPropertyFromGroup('unspawnNotes', i, 'multSpeed', 0.88);
        end
    end
end