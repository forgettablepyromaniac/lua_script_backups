local forceZooming = false; -- shoutout Redstone
local globalZoomVal = false;
function onEvent(name, value1, value2)
    if name == "Set Camera State" then
		local setValue = false;
		if value1 == 'true' then
			setValue = true;
		end
		setProperty('camZooming', setValue)
		if value2 == 'true' then
			--debugPrint("FORCING CAMERA");
			forceZooming = true;
			globalZoomVal = setValue;
		else
			--debugPrint("NOT FORCING CAMERA");
		end
		--debugPrint("SET CAM ZOOM TO ", setValue);
	end
end

function onUpdate(elapsed)
	if forceZooming == true and not getProperty('camZooming') == globalZoomVal then
		--debugPrint("ZOOM STATE IS DIFFERENT, SETTING BACK TO ", globalZoomVal);
		setProperty('camZooming', globalZoomVal);
	end
end