local chars = {"boyfriend", "dad", "gf"}

function onCreatePost()
    makeLuaSprite('RGB', '', 0, 0)
    makeLuaSprite( 'LD', '', 0, 0)
    makeLuaSprite('BWS', '', 0, 0)
    for _, v in ipairs(chars) do
        setSpriteShader(v, callCustomFunc("getFileName", {scriptName}))
    end
    updateShader()
end

function updateShader()
    for _, v in ipairs(chars) do
        setShaderFloat(v, 'uR', getProperty('RGB.x'))
        setShaderFloat(v, 'uG', getProperty('RGB.y'))
        setShaderFloat(v, 'uB', getProperty('RGB.offset.x'))

        setShaderFloat(v, 'uBrightness', getProperty('LD.x'))

        setShaderFloat(v, 'uBW', getProperty('BWS.x'))
        setShaderFloat(v, 'uSepia', getProperty('BWS.y'))
    end
end

function onUpdate()
    updateShader()
end

-- basic implementation

-- function onCreate()
--     callCustomFunc("runShader", {"basicFilters"}) -- basically calls initShader and runs the shader's setup lua.
-- end

-- function onUpdate()
--     setProperty("RGB.x", 0)
--     setProperty("RGB.y", 0)
--     setProperty("RGB.offset.x", 0)
--     setProperty("LD.x", 0)
--     setProperty("BWS.x", 0)
--     setProperty("BWS.y", 0)
-- end