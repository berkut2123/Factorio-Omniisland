require("logic.basicAnimator")
require("logic.basicState")
require("logic.emptyBoxCollider")

function getHeliFromBaseEntity(ent)
	for k,v in pairs(global.helis) do
		if v.baseEnt == ent then
			return v
		end
	end

	return nil
end

function findNearestAvailableHeli(pos, force, requestingPlayer)
	local nearestHeli = nil
	local nearestDist = nil

	if global.helis then
		for k, curHeli in pairs(global.helis) do
			if curHeli.baseEnt.valid and 
				curHeli.baseEnt.force == force and 
					(not curHeli.baseEnt.get_driver() or (curHeli.hasRemoteController and curHeli.remoteController.driverIsBot)) then

				if not requestingPlayer or (not curHeli.remoteController or curHeli.remoteController.owner == requestingPlayer) then
					local curDist = getDistance(pos, curHeli.baseEnt.position)
					
					if (not nearestDist) or (nearestDist and curDist < nearestDist) then
						nearestDist = curDist
						nearestHeli = curHeli
					end
				end
			end
		end
	end

	return nearestHeli, nearestDist
end

local frameFixes = {
	0, 			--1	
	0.015625, 	--2	
	0.046875, 	--3	
	0.0625, 	--4	
	0.078125, 	--5	
	0.109375, 	--6	
	0.125, 		--7	
	0.140625, 	--8	
	0.15625, 	--9	
	0.171875, 	--10	
	0.1796875, 	--11	
	0.1875, 	--12	
	0.203125, 	--13	
	0.21875, 	--14	
	0.2265625, 	--15	
	0.234375, 	--16	
	0.25, 		--17	
	0.265625, 	--18	
	0.2734375, 	--19	
	0.28125, 	--20	
	0.296875, 	--21	
	0.3125, 	--22	
	0.3203125, 	--23	
	0.328125, 	--24	
	0.34375, 	--25	
	0.359375, 	--26	
	0.375, 		--27	
	0.390625, 	--28	
	0.40625, 	--29	
	0.4375, 	--30	
	0.453125, 	--31	
	0.46875, 	--32	
	0.5, 		--33	
	0.515625, 	--34	
	0.546875, 	--35	
	0.5625, 	--36	
	0.578125, 	--37	
	0.609375, 	--38	
	0.625, 		--39	
	0.640625, 	--40	
	0.65625, 	--41	
	0.671875, 	--42	
	0.6796875, 	--43	
	0.6875, 	--44	
	0.703125, 	--45	
	0.71875, 	--46	
	0.7265625, 	--47	
	0.734375, 	--48	
	0.75, 		--49	
	0.765625, 	--50	
	0.7734375, 	--51	
	0.78125, 	--52	
	0.796875, 	--53	
	0.8125, 	--54	
	0.8203125, 	--55	
	0.828125, 	--56	
	0.84375, 	--57	
	0.859375, 	--58	
	0.875, 		--59	
	0.890625, 	--60	
	0.90625, 	--61	
	0.9375, 	--62	
	0.953125, 	--63
	0.984375, 	--64
}

--local modVersion = versionStrToInt(game.active_mods.HelicopterRevival)

maxCollisionHeight = 2

local maxBobbing = 0.05
local bobbingPeriod = 8*60

local colliderMaxHealth = 999999

local IsEntityBurnerOutOfFuel = function(ent)
	return ent.burner.remaining_burning_fuel <= 0 and ent.burner.inventory.is_empty()
end

local transferGridEquipment = function(srcEnt, destEnt)
	if srcEnt.grid and destEnt.grid then --assume they have the same size and destEnt.grid is empty.
		for i, equip in ipairs(srcEnt.grid.equipment) do
			local newEquip = destEnt.grid.put{name = equip.name, position = equip.position}

			if equip.type == "energy-shield-equipment" then newEquip.shield = equip.shield end
			newEquip.energy = equip.energy
		end
		srcEnt.grid.clear()
	end
end

heliEntityNames = ""
heliBaseEntityNames = ""

stateFuncs = {
	landed = {
		init = function(heli)
			heli.baseEnt.effectivity_modifier = 0
			heli.baseEnt.friction_modifier = 50

			heli.lockedBaseOrientation = heli.baseEnt.orientation

			heli.landedColliderCreationDelay = 2

			heli:setFloodlightEntities(false)

			for k, curGG in pairs(heli.gaugeGuis) do
				curGG:setPointerNoise("gauge_fs", "speed", false)
				curGG:setPointerNoise("gauge_hr", "height", false)
				curGG:setPointerNoise("gauge_hr", "rpm", false)
			end

			heli:setFuelGaugeTarget(0, true)
		end,

		OnTick = function(heli)
			if heli.landedColliderCreationDelay > 0 then
				if heli.landedColliderCreationDelay == 1 then
					heli:setCollider("landed")
					heli:updateEntityRotations()
				end

				heli.landedColliderCreationDelay = heli.landedColliderCreationDelay - 1
			end

			if heli.baseEnt.orientation ~= heli.lockedBaseOrientation then
				heli.baseEnt.orientation = heli.lockedBaseOrientation
			end

			local speed = heli.baseEnt.speed
			if speed > 0.25 then --54 km/h
				local players = getCarPlayers(heli.baseEnt)

				heli.baseEnt.damage(speed * 210, game.forces.neutral)

				if not heli.baseEnt.valid then --destroy event might already be executed
					heli:dealCrashDamage(players, speed)

					return false
				end
			end
		end,

		OnUp = function(heli)
			heli:changeState(heli.engineStarting)
		end,
	},
	engineStarting = {
		init = function(heli)
			heli.lockedBaseOrientation = heli.baseEnt.orientation

			heli:setRotorTargetRPF(heli.rotorMaxRPF)

			if not (heli.burnerDriver and heli.burnerDriver.valid) then
				heli.burnerDriver = heli.surface.create_entity{name="character", force = game.forces.neutral, position = heli.baseEnt.position}
				heli.childs.burnerEnt.set_driver(heli.burnerDriver)
			end

			if heli.floodlightEnabled then
				heli:setFloodlightEntities(true)
			end

			for k, curGG in pairs(heli.gaugeGuis) do
				curGG:setPointerNoise("gauge_fs", "speed", true, 5)
				curGG:setPointerNoise("gauge_hr", "height", true, 0.5, 0.2, 12, 18)
				curGG:setPointerNoise("gauge_hr", "rpm", true, 50)
			end

			heli.lastFuelGaugeTargetVal = 1
		end,

		OnTick = function(heli)
			if heli.baseEnt.orientation ~= heli.lockedBaseOrientation then
				heli.baseEnt.orientation = heli.lockedBaseOrientation
			end

			heli:handleFuelConsumption()
			heli:landIfEmpty()

			if heli.rotorRPF == heli.rotorMaxRPF then
				heli:changeState(heli.ascend)
			end
		end,
	},
	ascend = {
		init = function(heli)
			heli.baseEnt.effectivity_modifier = 1
			heli.baseEnt.friction_modifier = 1

			local time = heli:setTargetHeight(heli.maxHeight)
			--heli.bobbingAnimator = basicAnimator.new(heli.curBobbing, 0, time*60, "linear")

			heli:setCollider("flying")
		end,

		OnTick = function(heli)
			heli:updateEntityRotations()
			heli:handleFuelConsumption()
			heli:landIfEmpty()
			heli:handleInserters()

			--if heli.bobbingAnimator and not heli.bobbingAnimator.isDone then
			--	heli.curBobbing = heli.bobbingAnimator:nextFrame()
			--end

			if heli.height > maxCollisionHeight then
				heli:setCollider("none")
			end

			if heli.height == heli.maxHeight then
				heli:changeState(heli.hovering)
			end
		end,

		OnMaxHeightChanged = function(heli)
			heli:setTargetHeight(heli.maxHeight)
		end,
	},
	hovering = {
		init = function(heli)
			--heli.bobbingAnimator = basicAnimator.new(0, maxBobbing, bobbingPeriod, "cyclicSine")
		end,

		OnTick = function(heli)
			heli:updateEntityRotations()
			heli:handleFuelConsumption()
			heli:landIfEmpty()
			heli:handleInserters()

			--[[
			local isDone
			heli.curBobbing, isDone = heli.bobbingAnimator:nextFrame()

			if isDone then
				heli.bobbingAnimator:reset()
			end
			]]
		end,

		OnMaxHeightChanged = function(heli)
			heli:setTargetHeight(heli.maxHeight)
		end,
	},
	descend = {
		init = function(heli)
			local time = heli:setTargetHeight(0)
			--heli.bobbingAnimator = basicAnimator.new(heli.curBobbing, 0, time*60, "linear")
		end,

		deinit = function(heli)
			heli:reactivateAllInserters()
		end,

		OnTick = function(heli)
			heli:updateEntityRotations()
			heli:handleFuelConsumption()
			heli:handleInserters()

			--if heli.bobbingAnimator and not heli.bobbingAnimator.isDone then
			--	heli.curBobbing = heli.bobbingAnimator:nextFrame()
			--end

			if heli.height <= maxCollisionHeight and not (heli.childs.collisionEnt and heli.childs.collisionEnt.valid) then
				heli:setCollider("flying")
			end

			if heli.height == 0 then
				heli:changeState(heli.engineStopping)
			end
		end,

		OnUp = function(heli)
			print("descend OnUp")
			heli:changeState(heli.ascend)
		end,
	},
	engineStopping = {
		init = function(heli)
			heli.childs.burnerEnt.set_driver(nil)

			if heli.burnerDriver and heli.burnerDriver.valid then
				heli.burnerDriver.destroy()
				heli.burnerDriver = nil
			end

			heli:setRotorTargetRPF(0)

			heli:changeState(heli.landed)
		end,
	},
}

heliBase = {
	---------- default vals -----------
	valid = true,

	goUp = false,

	startupProgress = 0,
	height = 0,
	targetHeight = 0,
	maxHeight = 5,
	curBobbing = 0,

	heightSpeed = 0, 
	heightAcceleration = 0.001,

	maxHeightUperLimit = 20,
	maxHeightLowerLimit = 3,

	rotorOrient = 0,
	rotorRPF = 0,
	rotorTargetRPF = 0,

	fuelGaugeVal = 0,
	fuelGaugeTargetVal = 0,
	lastFuelGaugeTargetVal = 0,
	fuelGaugeSpeed = 0.005,

	gaugeGuis = {},

	hasLandedCollider = false,
	landedColliderCreationDelay = 1, --frames. workaround for inserters trying to access collider inventory when created at the same time.

	floodlightEnabled = false,

	baseEngineConsumption = 20000,

	inserterScanRadius = 5,

	fullTankFlightTime = 15 * 60 * 60, --in ticks
	tankWarningRatio = 3 / 15, --3 min
	tankCriticalWarningRatio = 0.5 / 15, --30s

	------------------------------------------------------------

	new = function(placementEnt, baseEnt, childEnts, mt)
		transferGridEquipment(placementEnt, baseEnt)
		baseEnt.health = placementEnt.health

		local obj = {
			version = versionStrToInt(game.active_mods.HelicopterRevival),

			lockedBaseOrientation = baseEnt.orientation,

			baseEnt = baseEnt,
			childs = childEnts,

			surface = placementEnt.surface,

			deactivatedInserters = {},
		}

		placementEnt.destroy()

		obj.baseEnt.effectivity_modifier = 0

		for k,v in pairs(obj.childs) do
			if game.active_mods["Krastorio2"] then --Krastorio 2 workaround
				v.get_inventory(defines.inventory.fuel).insert({name = "fuel", count = 200})
			else
				v.get_inventory(defines.inventory.fuel).insert({name = "coal", count = 50})
			end
			v.destructible = false
		end

		setmetatable(obj, mt)
		obj:changeState(obj.landed)

		return obj
	end,

	destroy = function(self)
		self.valid = false
		
		if self.baseEnt and self.baseEnt.valid then
			--self.baseEnt.destroy()
		end

		for k,v in pairs(self.childs) do
			if v and v.valid then
				v.destroy()
			end
		end

		if self.burnerDriver and self.burnerDriver.valid then
			self.burnerDriver.destroy()
		end
		if self.floodlightDriver and self.floodlightDriver.valid then
			self.floodlightDriver.destroy()
		end

		self:reactivateAllInserters()

		for k, curGG in pairs(self.gaugeGuis) do
			curGG:destroy()
		end
	end,

	---------------- events ----------------

	OnLoad = function(self)
		if self.curState then
			setmetatable(self.curState, basicState.mt)
		end
		if self.previousState then
			setmetatable(self.previousState, basicState.mt)
		end
		if self.hasLandedCollider and self.childs.collisionEnt then
			setmetatable(self.childs.collisionEnt, emptyBoxCollider.mt)
		end
	end,

	OnTick = function(self)
		if not self.baseEnt.valid then
			self:destroy()
			return
		end

		self:redirectPassengers()
		self:updateRotor()
		self:updateHeight()
		self:updateFuelGauge()
		self:updateEntityPositions()
		self.curState.OnTick(self)

		if self.valid then
			self:handleColliderDamage()
		end
	end,

	OnUp = function(self)
		self.curState.OnUp(self)
	end,

	OnDown = function(self)
		self:changeState(self.descend)
	end,

	OnIncreaseMaxHeight = function(self)
		self.maxHeight = math.min(self.maxHeightUperLimit, self.maxHeight + 1)
		self.curState.OnMaxHeightChanged(self)
	end,

	OnDecreaseMaxHeight = function(self)
		self.maxHeight = math.max(self.maxHeightLowerLimit, self.maxHeight - 1)
		self.curState.OnMaxHeightChanged(self)
	end,

	OnToggleFloodlight = function(self)
		self.floodlightEnabled = not self.floodlightEnabled

		if not self.floodlightEnabled then
			self:setFloodlightEntities(false)

		elseif self.height ~= 0 or self.rotorTargetRPF > 0 then
			self:setFloodlightEntities(true)
		end
	end,

	OnPlayerEjected = function(self)
		if self.childs.collisionEnt and self.hasLandedCollider then
			self.childs.collisionEnt.ejectPlayers()
		end
	end,


	---------------- states ----------------

	landed = basicState.new({
		name = "landed",
	}),

	engineStarting = basicState.new({
		name = "engineStarting",
	}),

	ascend = basicState.new({
		name = "ascend",
	}),

	hovering = basicState.new({
		name = "hovering",
	}),

	descend = basicState.new({
		name = "descend",
	}),

	engineStopping = basicState.new({
		name = "engineStopping",
	}),


	---------------- utility ---------------

	reactivateAllInserters = function(self)
		for k, curInserter in pairs(self.deactivatedInserters) do
			if curInserter.valid then
				curInserter.active = true
			end
		end

		self.deactivatedInserters = {}
	end,

	reactivateSafeInserters = function(self)
		for i = #self.deactivatedInserters, 1, -1 do
			local curInserter = self.deactivatedInserters[i]

			if not curInserter.valid then
				table.remove(self.deactivatedInserters, i)

			elseif getDistance(curInserter.position, self.baseEnt.position) > self.inserterScanRadius then
				curInserter.active = true
				table.remove(self.deactivatedInserters, i)
			end
		end
	end,

	deactivateNearbyInserters = function(self)
		local p = self.baseEnt.position
		local area = {{p.x - self.inserterScanRadius, p.y - self.inserterScanRadius}, {p.x + self.inserterScanRadius, p.y + self.inserterScanRadius}}

		local inserters = self.surface.find_entities_filtered{
			type = "inserter",
			area = area,
		}

		for k, curInserter in pairs(inserters) do
			if curInserter.active then
				curInserter.active = false
				table.insert(self.deactivatedInserters, curInserter)
			end
		end
	end,

	handleInserters = function(self)
		if settings.global["heli-deactivate-inserters"].value then
			self:deactivateNearbyInserters()
			self:reactivateSafeInserters()

		elseif #self.deactivatedInserters > 0 then
			self:reactivateAllInserters()
		end
	end,

	setTargetHeight = function(self, targetHeight)
		self.targetHeight = targetHeight
		return 60
	end,

	setRotorTargetRPF = function(self, targetRPF)
		self.rotorTargetRPF = targetRPF
	end,

	setFuelGaugeTarget = function(self, targetFuel, suppressAlert)
		self.fuelGaugeTargetVal = targetFuel

		if not suppressAlert then
			local alert
			if self.fuelGaugeTargetVal <= self.tankCriticalWarningRatio and self.lastFuelGaugeTargetVal > self.tankCriticalWarningRatio then
				alert = {name = "signal-heli-fuel-warning-critical", str = {"heli-alert-fuel-warning-critical"}}

			elseif self.fuelGaugeTargetVal <= self.tankWarningRatio and self.lastFuelGaugeTargetVal > self.tankWarningRatio then
				alert = {name = "signal-heli-fuel-warning", str = {"heli-alert-fuel-warning"}}
			end

			if alert then
				local players = getCarPlayers(self.baseEnt)
				for k, curPlayer in pairs(players) do
					if curPlayer.mod_settings["heli-fuel-alert"].value then
						curPlayer.add_custom_alert(self.baseEnt, {type = "virtual", name = alert.name}, alert.str, false)
					end
				end
			end
		end
		self.lastFuelGaugeTargetVal = self.fuelGaugeTargetVal
	end,

	changeHeight = function(self, newHeight)
		local delta = newHeight - self.height
		local oldY = self.baseEnt.position.y

		self.baseEnt.teleport({x = self.baseEnt.position.x, y = self.baseEnt.position.y - delta})

		
		if newHeight == self.targetHeight then
			self.height = self.targetHeight

		else
			--cant just apply the delta, the height would not reflect the sum of teleports,
			--causing the shadow to move down.
			--probably because of precision loss from lua->c++ / double->float
			self.height = self.height + oldY - self.baseEnt.position.y
		end
	end,

	landIfEmpty = function(self)
		local driver = self.baseEnt.get_driver()
		if not driver or not driver.valid or IsEntityBurnerOutOfFuel(self.baseEnt) then
			self:OnDown()
		end
	end,

	reassignCurState = function(self)
		if self.curState then
			local s = self[self.curState.name]

			if s and type(s) == "table" and s.name == self.curState.name then
				self.curState = s
			end
		end
	end,

	changeState = function(self, newState)
		--[[
		for k,v in pairs(heli) do
			if v == newState then
				printA("change state: " .. k)
				break
			end
		end
		]]

		self.previousState = self.curState

		if self.curState and self.curState.deinit then
			self.curState.deinit(self)
		end

		self.curState = newState

		if self.curState.init then
			self.curState.init(self)
		end
	end,

	insertIntoCar = function(self, car, player)
		if car and car.valid and player and player.valid then
			if not car.get_driver() then
				car.set_driver(player)
				return true
			end

			if not car.get_passenger() then
				car.set_passenger(player)
				return true
			end

			return false
		end
	end,

	redirectPassengers = function(self)
		for k, curChild in pairs(self.childs) do
			if curChild and curChild.valid then
				local curDriver = curChild.get_driver()
				local curPassenger = curChild.get_passenger()

				if curDriver and curDriver.valid then
					if k == "burnerEnt" and self.burnerDriver then
						if curDriver ~= self.burnerDriver then
							self:insertIntoCar(self.baseEnt, curDriver)
							curChild.set_driver(self.burnerDriver)
						end
					
					elseif k == "floodlightEnt" and self.floodlightDriver then
						if curDriver ~= self.floodlightDriver then
							self:insertIntoCar(self.baseEnt, curDriver)
							curChild.set_driver(self.floodlightDriver)
						end

					else
						if not self:insertIntoCar(self.baseEnt, curDriver) then
							curChild.set_driver(nil)
						end
					end
				end

				if curPassenger and curPassenger.valid then
					if not self:insertIntoCar(self.baseEnt, curPassenger) then
						curChild.set_passenger(nil)
					end
				end
			end
		end
	end,

	setCollider = function(self, name)
		if self.childs.collisionEnt and self.childs.collisionEnt.valid then
			self.childs.collisionEnt.destroy()
			self.childs.collisionEnt = nil
			self.hasLandedCollider = false
		end

		if name == "landed" then
			self.childs.collisionEnt = emptyBoxCollider.new({
				surface = self.surface,
				position = self.baseEnt.position,
				orientation = self.baseEnt.orientation,
				force = game.forces.neutral,
				boxLengths = 
				{
					ends = 3,
					sides = 4.8,
				},
				nameEnds = "heli-landed-collision-end-entity-_-",
				nameSides = "heli-landed-collision-side-entity-_-",
			})
			
			self.childs.collisionEnt.ejectPlayers()
			self.hasLandedCollider = true

		elseif name == "flying" then
			self.childs.collisionEnt = self.surface.create_entity{
				name = "heli-flying-collision-entity-_-",
				force = game.forces.neutral,
				position = self.baseEnt.position,
			}
		end

		if self.childs.collisionEnt then
			if game.active_mods["Krastorio2"] then --Krastorio 2 workaround
				self.childs.collisionEnt.get_inventory(defines.inventory.fuel).insert({name = "fuel", count = 200})
			else
				self.childs.collisionEnt.get_inventory(defines.inventory.fuel).insert({name = "coal", count = 50})
			end
			self.childs.collisionEnt.operable = false
		end
	end,

	setFloodlightEntities = function(self, enabled)
		if enabled then
			if not (self.childs.floodlightEnt and self.childs.floodlightEnt.valid) then
				self.childs.floodlightEnt = self.surface.create_entity{name = "heli-floodlight-entity-_-", force = game.forces.neutral, position = self.baseEnt.position}
				if game.active_mods["Krastorio2"] then --Krastorio 2 workaround
					self.childs.floodlightEnt.get_inventory(defines.inventory.fuel).insert({name = "fuel", count = 200})
				else
					self.childs.floodlightEnt.get_inventory(defines.inventory.fuel).insert({name = "coal", count = 50})
				end
			end
			self.childs.floodlightEnt.orientation = self.baseEnt.orientation
			self.childs.floodlightEnt.operable = false

			if not (self.floodlightDriver and self.floodlightDriver.valid) then
				self.floodlightDriver = self.surface.create_entity{name="character", force = game.forces.neutral, position = self.baseEnt.position}
			end

			self.childs.floodlightEnt.set_driver(self.floodlightDriver)
		else

			if self.childs.floodlightEnt and self.childs.floodlightEnt.valid then
				self.childs.floodlightEnt.destroy()
			end
			self.childs.floodlightEnt = nil

			if self.floodlightDriver and self.floodlightDriver.valid then
				self.floodlightDriver.destroy()
			end
			self.floodlightDriver = nil
		end
	end,

	dealCrashDamage = function(self, players, speed)
		for k, curPlayer in pairs(players) do
			if curPlayer.character and curPlayer.character.valid then
				curPlayer.character.damage((150 + speed * 175) * settings.global["heli-crash-dmg-mult"].value, game.forces.neutral)
			end
		end
	end,

	handleColliderDamage = function(self)
		if self.childs.collisionEnt then
			if self.childs.collisionEnt.health ~= colliderMaxHealth then
				local players = getCarPlayers(self.baseEnt)
				local speed = self.childs.collisionEnt.speed

				self.baseEnt.speed = speed
				self.baseEnt.damage(colliderMaxHealth - self.childs.collisionEnt.health, game.forces.neutral)

				if not self.baseEnt.valid then --destroy event might already be executed
					self:dealCrashDamage(players, speed)

					return false
				end 
				self.childs.collisionEnt.health = colliderMaxHealth
			end
		end
		return true
	end,

	getFuelFullness = function(self)
		local remainingFuel = self.baseEnt.burner.remaining_burning_fuel
		local bbInv = self.baseEnt.burner.inventory

		for i = 1, #bbInv do
			local curStack = bbInv[i]

			if curStack and curStack.valid_for_read then
				remainingFuel = remainingFuel + curStack.count * curStack.prototype.fuel_value
			end
		end

		if game.active_mods["Krastorio2"] then
			remainingFuel = remainingFuel * 16
		end

		local burner = self.baseEnt.burner
		local full_value = 0
		if burner.currently_burning then
			full_value = burner.currently_burning.fuel_value * burner.currently_burning.stack_size * #burner.inventory
		end
		if full_value > 0 then
			return remainingFuel / full_value
		else
			return 0
		end
	end,

	handleFuelConsumption = function(self)
		self:consumeBaseFuel()
		self:setFuelGaugeTarget(self:getFuelFullness())
	end,

	consumeBaseFuel = function(self)
		
		local baseBurner = self.baseEnt.burner

		baseBurner.remaining_burning_fuel = baseBurner.remaining_burning_fuel - self.baseEngineConsumption

		if baseBurner.remaining_burning_fuel <= 0 then
			if baseBurner.inventory.is_empty() then
				local mod = self.baseEnt.effectivity_modifier
				self.baseEnt.effectivity_modifier = 0

				local driver = self.baseEnt.get_driver()
				if driver and driver.valid then
					driver.riding_state = {acceleration = defines.riding.acceleration.accelerating, direction = defines.riding.direction.straight}
				
				else	
					driver = self.surface.create_entity{name = "character", force = self.baseEnt.force, position = self.baseEnt.position}
					self.baseEnt.set_driver(driver)
					driver.riding_state = {acceleration = defines.riding.acceleration.accelerating, direction = defines.riding.direction.straight}
					driver.destroy()
					self.baseEnt.set_driver(nil)
				end

				self.baseEnt.effectivity_modifier = mod
			else
				local fuelItemStack = nil
				for i = 1, #baseBurner.inventory do
					if baseBurner.inventory[i] and baseBurner.inventory[i].valid_for_read then
						fuelItemStack = baseBurner.inventory[i]
						break
					end
				end

				if fuelItemStack then
					baseBurner.currently_burning = fuelItemStack.name
					baseBurner.remaining_burning_fuel = fuelItemStack.prototype.fuel_value
					baseBurner.inventory.remove({name = fuelItemStack.name})
				end
			end
		end

		if self.burnerDriver and self.burnerDriver.valid then
			self.burnerDriver.riding_state = {acceleration = defines.riding.acceleration.accelerating, direction = defines.riding.direction.straight}
			if self.childs.burnerEnt.burner.remaining_burning_fuel < 1000 then
				if game.active_mods["Krastorio2"] then --Krastorio 2 workaround
					self.childs.burnerEnt.get_inventory(defines.inventory.fuel).insert({name = "fuel", count = 1})
				else
					self.childs.burnerEnt.get_inventory(defines.inventory.fuel).insert({name = "coal", count = 1})
				end
			end
		end
	end,

	updateRotor = function(self)
		if self.rotorRPF ~= self.rotorTargetRPF then
			if self.rotorRPF < self.rotorTargetRPF then
				self.rotorRPF = math.min(self.rotorRPF + self.rotorRPFacceleration, self.rotorTargetRPF)

			else
				self.rotorRPF = math.max(self.rotorRPF - self.rotorRPFacceleration, self.rotorTargetRPF)
			end
		end

		if self.rotorRPF > 0 then
			self.rotorOrient = self.rotorOrient + self.rotorRPF
			if self.rotorOrient > 1 then self.rotorOrient = self.rotorOrient - 1 end

			local frameFix = frameFixes[math.floor(self.rotorOrient * 64) + 1]
			self.childs.rotorEnt.orientation = frameFix
			self.childs.rotorEntShadow.orientation = frameFix
		end


		for k, curGG in pairs(self.gaugeGuis) do
			curGG:setGauge("gauge_hr", "rpm", self.rotorRPF * 3600 * self.engineReduction + math.abs(self.baseEnt.speed) * 100)
		end
	end,

	updateHeight = function(self)
		if self.height ~= self.targetHeight then
			local dir = 1
			if self.targetHeight < self.height then
				dir = -1
			end

			local desiredSpeed = (self.targetHeight - self.height) / 90 + dir * 0.005

			if self.heightSpeed < desiredSpeed then
				self.heightSpeed = math.min(self.heightSpeed + self.heightAcceleration, desiredSpeed)
			else
				self.heightSpeed = math.max(self.heightSpeed - self.heightAcceleration, desiredSpeed)
			end

			local newHeight = self.height + self.heightSpeed

			if fEqual(newHeight, self.targetHeight, 0.01) then
				self:changeHeight(self.targetHeight)
				self.heightSpeed = 0
			else
				self:changeHeight(newHeight)
			end
		end

		for k, curGG in pairs(self.gaugeGuis) do
			curGG:setGauge("gauge_hr", "height", self.height)
		end
	end,

	updateFuelGauge = function(self)
		if self.fuelGaugeVal ~= self.fuelGaugeTargetVal then
			if self.fuelGaugeVal < self.fuelGaugeTargetVal then
				self.fuelGaugeVal = math.min(self.fuelGaugeVal + self.fuelGaugeSpeed, self.fuelGaugeTargetVal)

			else
				self.fuelGaugeVal = math.max(self.fuelGaugeVal - self.fuelGaugeSpeed, self.fuelGaugeTargetVal)
			end
		end

		for k, curGG in pairs(self.gaugeGuis) do
			curGG:setGauge("gauge_fs", "fuel", self.fuelGaugeVal)
			if self.curState.name ~= "landed" then
				if self.fuelGaugeTargetVal <= self.tankCriticalWarningRatio then
					curGG:setLedBlinking("gauge_fs", "fuel", true, 20, "heli-fuel-warning")

				elseif self.fuelGaugeTargetVal <= self.tankWarningRatio then
					curGG:setLedBlinking("gauge_fs", "fuel", true, 60, "heli-fuel-warning")

				else
					curGG:setLedBlinking("gauge_fs", "fuel", false)
				end
			else
				curGG:setLedBlinking("gauge_fs", "fuel", false)
			end
		end
	end,

	updateEntityPositions = function(self)
		local baseVec = math3d.vector2.rotate({0,1}, math.pi * 2 * self.baseEnt.orientation)
		local vec = math3d.vector2.mul(baseVec, self.baseEnt.speed)

		local basePos = self.baseEnt.position

		self.childs.bodyEnt.teleport({x = basePos.x - vec[1], y = basePos.y - vec[2] + self.bodyOffset - self.curBobbing})
		self.childs.rotorEnt.teleport({x = basePos.x - vec[1], y = basePos.y - vec[2] + self.rotorOffset - self.curBobbing})
		
		self.childs.rotorEntShadow.teleport({x = basePos.x - vec[1], y = basePos.y - vec[2] + self.height})
		self.childs.bodyEntShadow.teleport({x = basePos.x - vec[1], y = basePos.y - vec[2] + self.height})

		if self.childs.floodlightEnt then
			local lightOffsetVec = math3d.vector2.mul(baseVec, self.height)
			self.childs.floodlightEnt.teleport({x = basePos.x - vec[1] - lightOffsetVec[1], y = basePos.y - vec[2] - lightOffsetVec[2] + self.height})
		end
		
		if self.childs.collisionEnt then
			if not self.hasLandedCollider then
				local initVec = {0,1}
				local mul = 2
				if self.baseEnt.speed < 0 then
					initVec = {0,-1}
					local x = self.baseEnt.orientation
					mul = math.abs(math.sin(math.pi*2*x))*1.2 + math.sin(math.pi*x) + 3 --dont ask
				end

				vec = math3d.vector2.mul(math3d.vector2.rotate(initVec, math.pi * 2 * self.baseEnt.orientation), mul)
				self.childs.collisionEnt.teleport({x = basePos.x - vec[1], y = basePos.y - vec[2]})
				self.childs.collisionEnt.speed = self.baseEnt.speed

			else
				self.childs.collisionEnt.teleport({x = basePos.x - vec[1], y = basePos.y - vec[2]})
				self.childs.collisionEnt.speed = self.baseEnt.speed
			end
		end


		local off = (1 - math.sin(math.pi*self.baseEnt.orientation)) * 0.7
		local center = {x = basePos.x, y = basePos.y - off}
		local radius = 2
		snap = self.baseEnt.orientation
		snap = snap * (1 - math.sin(math.pi * snap)*0.05) 
		snap = math.abs(snap * 64) / 64
		local vec = math3d.vector2.mul(math3d.vector2.rotate({0,1}, math.pi * 2 * snap), radius)

		self.childs.burnerEnt.teleport({x = center.x + vec[1], y = center.y + vec[2] - self.curBobbing})

		for k, curGG in pairs(self.gaugeGuis) do
			curGG:setGauge("gauge_fs", "speed", math.abs(self.baseEnt.speed) * 216) --speed * 60 = m/s, * 3.6 = km/h
		end
	end,

	updateEntityRotations = function(self)
		self.childs.bodyEnt.orientation = self.baseEnt.orientation
		self.childs.bodyEntShadow.orientation = self.baseEnt.orientation
		self.childs.burnerEnt.orientation = self.baseEnt.orientation

		if self.childs.collisionEnt then
			self.childs.collisionEnt.orientation = self.baseEnt.orientation
		end

		if self.childs.floodlightEnt then
			self.childs.floodlightEnt.orientation = self.baseEnt.orientation
		end
	end,

	isBaseOrChild = function(self, ent)
		if self.baseEnt == ent then
			return true
		end

		for k,v in pairs(self.childs) do
			if v == ent then
				return true
			end
		end

		if self.hasLandedCollider and self.childs.collisionEnt then
			return self.childs.collisionEnt.isChildEntity(ent)
		end

		return false
	end,

	addGaugeGui = function(self, gg)
		if #self.gaugeGuis == 0 then
			self.gaugeGuis = {}
		end

		table.insert(self.gaugeGuis, gg)
	end,

	removeGaugeGui = function(self, gg)
		for i, curGG in ipairs(self.gaugeGuis) do
			if curGG == gg then
				table.remove(self.gaugeGuis, i)
				return
			end
		end
	end,
}