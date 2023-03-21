function onEvent(name, val1, val2)
    if name == 'Play Animation (Player 3)' then
		runHaxeCode([[
			]]..val2..[[.playAnim(']]..val1..[[', true);
		]]);
	end
end
function onUpdate(elapsed)
	runHaxeCode([[
		if(]]..val2..[[.animation.curAnim.finished == false)
		{
			]]..val2..[[.holdTimer = 0;
		}
	]])
end
-- Script written by RedstoneRuler