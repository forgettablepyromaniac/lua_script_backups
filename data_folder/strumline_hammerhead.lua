-- local whatTheFuck = false

function onCreatePost() -- huge credits to shadowmario
	luaDebugMode = true;
	runHaxeCode([[
		game.dadGroup.y += 40;
		for (dad in game.dadGroup)
		{
			dad.cameraPosition[1] -= 40;
		}
		
		bfX = game.dadGroup.x;
		bfY = game.dadGroup.y;

		mario = new Character(bfX - 175, bfY, 'pico');
		mario.scrollFactor.set(0.97, 0.97);
		mario.y += mario.positionArray[1] - 50;
		game.addBehindDad(mario);
	]]);
end

function onCountdownTick(counter)
	runHaxeCode([[
		if (]]..counter..[[ % mario.danceEveryNumBeats == 0 && mario.animation.curAnim != null && !StringTools.startsWith(mario.animation.curAnim.name, 'sing') && !mario.stunned)
		{
			mario.dance();
		}
	]]);
end

function onBeatHit()
	runHaxeCode([[
		if (]]..curBeat..[[ % mario.danceEveryNumBeats == 0 && mario.animation.curAnim != null && !StringTools.startsWith(mario.animation.curAnim.name, 'sing') && !mario.stunned)
		{
			mario.dance();
		}
	]]);
end

function onUpdate(elapsed)
	runHaxeCode([[
		if (game.startedCountdown && game.generatedMusic)
		{
			if (!mario.stunned && mario.holdTimer > Conductor.stepCrochet * 0.0011 * mario.singDuration && StringTools.startsWith(mario.animation.curAnim.name, 'sing') && !StringTools.endsWith(mario.animation.curAnim.name, 'miss'))
			{
				mario.dance();
			}
		}
	]]);
end

function strumNoteHit(id, direction, noteType, isSustainNote)
	runHaxeCode([[
		mario.playAnim(game.singAnimations[]]..direction..[[], true);
		mario.holdTimer = 0;
	]]);
end

-- function onStepHit()
-- 	if gfSection == true then
-- 		if whatTheFuck == true then
-- 			triggerEvent("Camera Follow Pos", tostring(defaultOpponentX), tostring(defaultOpponentY + 400));
-- 		end
-- 	end
-- end

-- function onEvent(eventName, value1, value2)
-- 	if eventName == "cameraMario" then
-- 		if whatTheFuck == true then
-- 			whatTheFuck = false
-- 			triggerEvent("Camera Follow Pos", "", "");
-- 		else
-- 			whatTheFuck = true
-- 		end
-- 	end
-- end