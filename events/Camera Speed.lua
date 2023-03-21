function onEvent(name, value1)
	if name == 'Camera Speed' then
		targetSpeed = tonumber(value1);
			setProperty('cameraSpeed', targetSpeed);
		end
	end

