function onEvent(name, val1, val2)
    if name == 'Play Animation (Player 3)' then
		runHaxeCode([[
			]]..val2..[[.playAnim(']]..val1..[[', true);
			]]..val2..[[.specialAnim = true;
		]]);
		triggerEvent('Play Animation', val1, 'gf')
	end
end
function onUpdate(elapsed)
	runHaxeCode([[
		if(]]..val2..[[.animation.curAnim.finished == false)
		{
			]]..val2..[[.holdTimer = 0;
		}
		if(]]..val2..[[.animation.curAnim.finished == true)
		{
			]]..val2..[[.specialAnim = true;
		}
	]])
end
-- Script written by RedstoneRuler