timer =
{
	new = function(func, frames, isInterval, timerData)
		local timer = 
		{
			valid = true,
			callback = func,
			runTick = game.tick + frames,
			interval = isInterval and frames,
			paused = false,
			data = timerData,
		}

		mtMgr.set(timer, "timer")

		return insertInGlobal("timers", timer)
	end,

	cancel = function(self)
		self.valid = false
	end,

	pause = function(self)
		self.paused = true
		self.remaining = self.runTick - game.tick
	end,

	resume = function(self)
		self.paused = false
		self.runTick = game.tick + self.remaining
	end,
}

function setTimeout(func, frames, timerData)
	return timer.new(func, frames, false, timerData)
end

function setInterval(func, frames, timerData)
	return timer.new(func, frames, true, timerData)
end

function OnTimerTick()
	local timers = global.timers

	if timers then
		for i = #timers, 1, -1 do
			local curTimer = timers[i]

			if not curTimer.valid then
				table.remove(timers, i)
			
			else
				if (not curTimer.paused) and curTimer.runTick <= game.tick then
					-- i don't know if this check is the correct way to catch it
					-- but sometimes after game load, the callback slot will be
					-- empty and cause a crash. this appears to fix that.
					-- seems this is only used by the fuel gauge as well
					if not curTimer.callback then
						curTimer.valid = false
						table.remove(timers, i)
					else
						curTimer:callback()

						if curTimer.interval then
							curTimer.runTick = game.tick + curTimer.interval

						else
							curTimer.valid = false
							table.remove(timers, i)
						end
					end
				end
			end
		end 
	end
end

mtMgr.assign("timer", {__index = timer})