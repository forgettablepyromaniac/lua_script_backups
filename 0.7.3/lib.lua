function onCreate() -- dude LarryFrosty is the GOAT
    runHaxeCode([[
        createGlobalCallback('callCustomFunc', function(funcName:String, ?args:Array<Dynamic>) {
            args ??= [];
            var result:Dynamic = parentLua.call(funcName, args);
            if (result != Function_Continue) return result;
            else return null;
        });
    ]])
end

function getFileName(filePath)
    local fileName = filePath:match("([^/\\]+)%.lua$")
    return fileName
end

-- obsolete, use currentModDirectory

-- function getBasePath(filePath)
--     local basePath = filePath:match("^[^/\\]+[\\/]([^/\\]+)")
--     return basePath
-- end

function runShader(shader)
    if shadersEnabled then
        initLuaShader(shader)
        addLuaScript("shaders/"..shader..".lua")
    end
end

function round(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function hudBox(color) -- called black but can be any color
    makeLuaSprite("black")
    makeGraphic("black", screenWidth, screenHeight, color)
    setObjectCamera("black", "HUD")
    addLuaSprite("black")
end

function tweenNumber(startValue, endValue, duration, options)
    options = callMethodFromClass('psychlua.LuaUtils', 'getLuaTween', {options})
    runHaxeCode([[
        var options = luaOptions;
        FlxTween.num(startValue, endValue, duration, {
            type: options.type,
            ease: options.ease,
            startDelay: options.startDelay,
            loopDelay: options.loopDelay,

            onUpdate: function(twn:FlxTween) {
                if (options.onUpdate != null) game.callOnLuas(options.onUpdate, [twn.value]);
            },
            onStart: function(twn:FlxTween) {
                if (options.onStart != null) game.callOnLuas(options.onStart, [twn.value]);
            },
            onComplete: function(twn:FlxTween) {
                if (options.onComplete != null) game.callOnLuas(options.onComplete, [twn.value]);
            }   
        });
    ]], {startValue = startValue, endValue = endValue, duration = duration, luaOptions = options})
end