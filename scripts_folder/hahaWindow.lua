function onCreate()
    setPropertyFromClass("openfl.Lib", "application.window.title",'Psych Engine - vs. FP & Co.')
end

function onUpdate()
    if getProperty("health") < 0 then
        setPropertyFromClass("openfl.Lib", "application.window.title",'Psych Engine - Owchie')
    end
end