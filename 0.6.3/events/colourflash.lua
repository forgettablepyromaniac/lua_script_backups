function onEvent(name, value1, value2) -- by FP
	if name == 'colourflash' then
		if flashingLights == true then
			cameraFlash("camHUD", value1, value2, true)
		end
	end
end