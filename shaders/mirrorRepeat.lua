function onCreatePost()
    makeLuaSprite('mirror', '', 0, 0)
    makeLuaSprite('mirrorZoom', '', 0.985,0)
    makeLuaSprite('mirrorSkew', '', 0, 0)
    setProperty('mirror.angle', 0)
    setSpriteShader('mirror', "mirrorRepeat")
    runHaxeCode([[
        game.camGame.filters = [new ShaderFilter(game.getLuaObject('mirror').shader)];
        game.camHUD.filters = [new ShaderFilter(game.getLuaObject('mirror').shader)];
    ]])
    updateShader()
end

function updateShader()
    setShaderFloat('mirror', 'x', getProperty('mirror.x'))
    setShaderFloat('mirror', 'y', getProperty('mirror.y'))
    setShaderFloat('mirror', 'angle', getProperty('mirror.angle'))
    setShaderFloat('mirror', 'zoom', getProperty('mirrorZoom.x'))
    setShaderFloat('mirror', 'skew', getProperty('mirrorSkew.x'))
    setShaderFloat('mirror', 'tilt', getProperty('mirrorSkew.y'))
end

function onUpdate()
    updateShader()
end