function getHeliControllerIndexByOwner(p)
	if global.heliControllers then
		for i, curController in ipairs(global.heliControllers) do
			if curController.owner == p then
				return i
			end
		end
	end
end

function getHeliControllerByOwner(p)
	local i = getHeliControllerIndexByowner(p)
	if i then return global.heliControllers[i] end
end

function getHeliControllerIndexByHeli(heli)
	if global.heliControllers then
		for i, curController in ipairs(global.heliControllers) do
			if curController.heli == heli then
				return i
			end
		end
	end
end

function getHeliControllerByHeli(heli)
	local i = getHeliControllerIndexByHeli(heli)
	if i then return global.heliControllers[i] end
end

function assignHeliController(owner, heli, target, targetIsPlayer)
	local oldControllerIndex = searchIndexInTable(global.heliControllers, heli, "heli")
	
	if oldControllerIndex then
		global.heliControllers[oldControllerIndex]:destroy()
		table.remove(global.heliControllers, oldControllerIndex)
	end

	insertInGlobal("heliControllers", heliController.new(owner, heli, target, targetIsPlayer))
end

heliControllerState = {
	getUp = 1,
	orientToTarget = 2,
	moveToTarget = 3,
	creepToPosition = 4,
	land = 5,
	stop = 6,
}

heliController = 
{
	new = function(player, heli, target, targetIsPlayer)
		local obj = 
		{
			valid = true,

			owner = player,
			heli = heli,
			targetIsPlayer = targetIsPlayer,

			curStateId = heliControllerState.getUp,
			stateChanged = true,
		}

		if targetIsPlayer then
			obj.targetPlayer = target
			obj.targetPos = target.position
		else
			obj.targetPos = target
		end

		if not heli.baseEnt.get_driver() then
			obj.driverIsBot = true
			obj.driver = heli.surface.create_entity{name = "character", force = player.force, position = player.position}
			heli.baseEnt.set_driver(obj.driver)
		else
			obj.driverIsBot = false
			obj.driver = heli.baseEnt.get_driver()
		end

		heli.hasRemoteController = true
		heli.remoteController = obj

		setmetatable(obj, {__index = heliController})

		OnHeliControllerCreated(obj)
		return obj
	end,

	curState = function(self)
		return heliControllerStates[self.curStateId](self)
	end,

	destroy = function(self)
		self.valid = false
		self.heli.hasRemoteController = nil
		self.heli.remoteController = nil

		if self.driverIsBot and self.driver and self.driver.valid then
			self.driver.destroy()
		end

		OnHeliControllerDestroyed(self)
	end,

	stopAndDestroy = function(self)
		if self.driverIsBot then
            -- Told to explicitly stop, make sure to clear the flag
            self.targetIsPlayer = false
			self:changeState(heliControllerState.stop)
		else
			self:destroy()
		end
	end,

	OnTick = function(self)		
		if not (self.heli.valid and self.heli.baseEnt.valid and self.owner.valid) then
			self:destroy()
			return
		end

		local curDriver = self.heli.baseEnt.get_driver()
		local curPassenger = self.heli.baseEnt.get_passenger()

		if not (curDriver and curDriver.valid) then
			if self.driverIsBot then
				self:destroy()
			else
				self.driverIsBot = true
				self.driver = self.heli.surface.create_entity{name = "character", force = self.owner.force, position = self.owner.position}
				self.heli.baseEnt.set_driver(self.driver)
				self.heli:OnUp()
			end

		elseif self.driverIsBot and curDriver ~= self.driver then
			if self.driver and self.driver.valid then
				self.driver.destroy()
				self.driver = curDriver
				self.driverIsBot = false
			end
			if self.targetIsPlayer and curDriver == self.targetPlayer.character then
				self:destroy()
				return
			end

		elseif self.driverIsBot and curPassenger and curPassenger.valid then
			if self.driver and self.driver.valid then
				self.driver.destroy()
				self.driver = curPassenger
				self.driverIsBot = false
			end
			self.heli.baseEnt.set_driver(curPassenger)
			
			if self.targetIsPlayer and curPassenger == self.targetPlayer.character then
				self:destroy()
				return
			end

		else
			if self.targetIsPlayer then
				if self.targetPlayer.valid then
					self.targetPos = {x = self.targetPlayer.position.x, y = self.targetPlayer.position.y - 1}
				else
                    -- Invalid player target, clear the flag
                    self.targetIsPlayer = false
					self:stopAndDestroy()
					return
				end
			end

			local old = self.curStateId
			self:curState()

			if old == self.curStateId then
				self.stateChanged = false
			else
				self.stateChanged = true
			end
		end
	end,

	changeState = function(self, newState)
		self.curStateId = newState
	end,

	setRidingState = function(self, acc, dir)
		if not acc then
			acc = self.driver.riding_state.acceleration
		end

		if not dir then
			dir = self.driver.riding_state.direction
		end

		self.driver.riding_state = {acceleration = acc, direction = dir}
	end,

	holdSpeed = function(self, speed)
		local dir = self.driver.riding_state.direction

		if math.abs(1 - (self.heli.baseEnt.speed / speed)) < 0.05 then
			self.heli.baseEnt.speed = speed
		else

			if self.heli.baseEnt.speed > speed then
				self:setRidingState(defines.riding.acceleration.braking)
			else
				self:setRidingState(defines.riding.acceleration.accelerating)
			end
		end
	end,

	getTargetOrientation = function(self)
		local curPos = self.heli.childs.bodyEntShadow.position

		local vec = {x = self.targetPos.x - curPos.x, y = curPos.y - self.targetPos.y}
		local len = math.sqrt(vec.x ^ 2 + vec.y ^ 2)

		vec.x = vec.x / len
		vec.y = vec.y / len


		local angle = math.atan2(vec.y, vec.x)
		self.targetOrient = 1.25 - (angle / (2 * math.pi))
		if self.targetOrient > 1 then self.targetOrient = self.targetOrient - 1 end
	end,

	getSteeringToTargetOrientation = function(self)
		local curOrient = self.heli.baseEnt.orientation

		if math.abs(self.targetOrient - curOrient) < 0.02 then
			return defines.riding.direction.straight
		else
			local deltaLeft = 0
			local deltaRight = 0

			if self.targetOrient < curOrient then
				deltaLeft = curOrient - self.targetOrient
				deltaRight = 1 - curOrient + self.targetOrient
			else
				deltaLeft = curOrient + 1 - self.targetOrient
				deltaRight = self.targetOrient - curOrient
			end

			if deltaLeft < deltaRight then
				return defines.riding.direction.left
			else
				return defines.riding.direction.right
			end
		end
	end,

	------------- states ---------------
	getUp = function(self)
		if self.stateChanged then
			self.heli:OnUp()
		elseif self.heli.height >= maxCollisionHeight then
			self:changeState(heliControllerState.orientToTarget)
		end
	end,

	orientToTarget = function(self)
		if self.stateChanged then
			self.targetOrientation = self:getTargetOrientation()
		else
			local dir = self:getSteeringToTargetOrientation()

			self:setRidingState(defines.riding.acceleration.nothing, dir)

			if dir == defines.riding.direction.straight then
				self:changeState(heliControllerState.moveToTarget)
			end
		end
	end,

	moveToTarget = function(self)
		local dist = getDistance(self.heli.childs.bodyEntShadow.position, self.targetPos)

		if self.stateChanged then
			self.updateOrientationCooldown = 30
			self.oldDist = -1
		end

		self.updateOrientationCooldown = self.updateOrientationCooldown - 1
		if self.updateOrientationCooldown <  3 or dist < 10 then
			if self.updateOrientationCooldown == 0 then
				self.updateOrientationCooldown = 30
				if dist >= 10 then
					self:setRidingState(nil, defines.riding.direction.straight)
				end
			end

			self.targetOrientation = self:getTargetOrientation()
			self:setRidingState(nil, self:getSteeringToTargetOrientation())
		else
			--self:setRidingState(nil, defines.riding.direction.straight)
		end

		if dist < 150 then
			local creepZone = 0.5
			local landingZone = 1
			local desiredSpeed = 1.5 - (1.2247448 - (dist - creepZone) / 150)^2

			self:holdSpeed(desiredSpeed)

			if dist <= landingZone and (dist <= creepZone or dist == self.oldDist) then
				self:setRidingState(defines.riding.acceleration.braking)
				self:changeState(heliControllerState.creepToPosition)
			end

			self.oldDist = dist
		else
			self:setRidingState(defines.riding.acceleration.accelerating)
		end
	end,

	creepToPosition = function(self)
		local curPos = self.heli.childs.bodyEntShadow.position
		
		if self.stateChanged then
			self:setRidingState(defines.riding.acceleration.braking, defines.riding.direction.straight)
			self.heli.baseEnt.speed = 0
            --targetIsPlayer will be updated else where
			--self.targetIsPlayer = false

			local curDist = getDistance(curPos, self.targetPos)
			local alignFactor = 1.1
			local alignVec = {x = (self.targetPos.x - curPos.x) / curDist * alignFactor,  y = (self.targetPos.y - curPos.y) / curDist * alignFactor}
			self.targetPos = {x = self.targetPos.x + alignVec.x, y = self.targetPos.y + alignVec.y}

			local creepFrames = 60
			self.creepVec = {x = (self.targetPos.x - curPos.x) / creepFrames, y = (self.targetPos.y - curPos.y) / creepFrames}

			self.oldDist = 100
		end

		self.heli.baseEnt.teleport({x = self.heli.baseEnt.position.x + self.creepVec.x, y = self.heli.baseEnt.position.y + self.creepVec.y})
		self.heli:updateEntityPositions()

		local dist = getDistance(self.heli.childs.bodyEntShadow.position, self.targetPos)
		if dist < 0.2 or dist > self.oldDist then
            -- If targeting the player and we shouldn't land when we catch up, then just stop, otherwise land
            if( self.targetIsPlayer and self.targetPlayer.mod_settings["heli-remote-dont-land-following-player"].value )then
                self:changeState(heliControllerState.stop)
            else
                self:changeState(heliControllerState.land)
            end
		end

		self.oldDist = dist
	end,

	land = function(self)
		local d = extractPlayer(self.driver)
        
        if not ((not self.driverIsBot and d and d.valid) and d.mod_settings["heli-remote-dont-auto-land-player"].value) then
            self.heli:OnDown()
        end

		self:destroy()
	end,

	stop = function(self)
		self:setRidingState(defines.riding.acceleration.braking, defines.riding.direction.straight)
		
		if self.heli.baseEnt.speed == 0 then
            if( self.targetIsPlayer and self.targetPlayer.mod_settings["heli-remote-dont-land-following-player"].value )then
                local dist = getDistance(self.heli.childs.bodyEntShadow.position, self.targetPos)
                if dist > 0.2 then
                    -- Player moved off, orient on them
                    self:changeState(heliControllerState.orientToTarget)
                end
            else
                self:changeState(heliControllerState.land)
            end
		end
	end,
	------------------------------------
}

heliControllerStates = {
	heliController.getUp,
	heliController.orientToTarget,
	heliController.moveToTarget,
	heliController.creepToPosition,
	heliController.land,
	heliController.stop,
}