function onCreate()
    setProperty('showCombo', false);
end

function onUpdate(elapsed)
    local combo = getProperty('combo')
    
    if combo > 10 and (combo == 19 or combo == 49 or combo == 149 or combo == 249 or (combo + 1) % 100 == 0) then
        setProperty('showCombo', true)
    else
        setProperty('showCombo', false)
    end
end


