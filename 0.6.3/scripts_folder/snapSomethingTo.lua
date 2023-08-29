function onEvent(name, value1, value2)
	if name == 'snapCameraTo' then
		setProperty('camFollow.x', value1)
		setProperty('camFollow.y', value2)
		setProperty('camFollowPos.x', value1)
		setProperty('camFollowPos.y', value2)
		triggerEvent("Change Camera Pos", value1, value2)
	elseif name == 'snapZoomTo' then
		setProperty('defaultCamZoom', value1)
		setProperty('camGame.zoom', value1)
	end
end