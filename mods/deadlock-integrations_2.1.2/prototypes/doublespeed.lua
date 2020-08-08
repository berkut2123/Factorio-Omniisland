-- Update speeds to match belts after they've been updated
-- t1
if data.raw["loader-1x1"]["transport-belt-loader"] then
	data.raw["loader-1x1"]["transport-belt-loader"].speed = data.raw["transport-belt"]["transport-belt"].speed
end
if data.raw.furnace["transport-belt-beltbox"] then
	data.raw.furnace["transport-belt-beltbox"].crafting_speed = data.raw["transport-belt"]["transport-belt"].speed * 32
end
-- t2
if data.raw["loader-1x1"]["fast-transport-belt-loader"] then
	data.raw["loader-1x1"]["fast-transport-belt-loader"].speed = data.raw["transport-belt"]["fast-transport-belt"].speed
end
if data.raw.furnace["fast-transport-belt-beltbox"] then
	data.raw.furnace["fast-transport-belt-beltbox"].crafting_speed = data.raw["transport-belt"]["fast-transport-belt"].speed * 32
end
-- t3
if data.raw["loader-1x1"]["express-transport-belt-loader"] then
	data.raw["loader-1x1"]["express-transport-belt-loader"].speed = data.raw["transport-belt"]["express-transport-belt"].speed
end
if data.raw.furnace["express-transport-belt-beltbox"] then
	data.raw.furnace["express-transport-belt-beltbox"].crafting_speed = data.raw["transport-belt"]["express-transport-belt"].speed * 32
end

-- Bob's
-- t0
if data.raw["loader-1x1"]["basic-transport-belt-loader"] then
	data.raw["loader-1x1"]["basic-transport-belt-loader"].speed = data.raw["transport-belt"]["basic-transport-belt"].speed
end
if data.raw.furnace["basic-transport-belt-beltbox"] then
	data.raw.furnace["basic-transport-belt-beltbox"].crafting_speed = data.raw["transport-belt"]["basic-transport-belt"].speed * 32
end
-- t4
if data.raw["loader-1x1"]["turbo-transport-belt-loader"] then
	data.raw["loader-1x1"]["turbo-transport-belt-loader"].speed = data.raw["transport-belt"]["turbo-transport-belt"].speed
end
if data.raw.furnace["turbo-transport-belt-beltbox"] then
	data.raw.furnace["turbo-transport-belt-beltbox"].crafting_speed = data.raw["transport-belt"]["turbo-transport-belt"].speed * 32
end
-- t5
if data.raw["loader-1x1"]["ultimate-transport-belt-loader"] then
	data.raw["loader-1x1"]["ultimate-transport-belt-loader"].speed = data.raw["transport-belt"]["ultimate-transport-belt"].speed
end
if data.raw.furnace["ultimate-transport-belt-beltbox"] then
	data.raw.furnace["ultimate-transport-belt-beltbox"].crafting_speed = data.raw["transport-belt"]["ultimate-transport-belt"].speed * 32
end

-- Ultimate

-- ultimate t1
if data.raw["loader-1x1"]["ultra-fast-belt-loader"] then
	data.raw["loader-1x1"]["ultra-fast-belt-loader"].speed = data.raw["transport-belt"]["ultra-fast-belt"].speed
end
if data.raw.furnace["ultra-fast-belt-beltbox"] then
	data.raw.furnace["ultra-fast-belt-beltbox"].crafting_speed = data.raw["transport-belt"]["ultra-fast-belt"].speed * 32
end
-- ultimate t2
if data.raw["loader-1x1"]["extreme-fast-belt-loader"] then
	data.raw["loader-1x1"]["extreme-fast-belt-loader"].speed = data.raw["transport-belt"]["extreme-fast-belt"].speed
end
if data.raw.furnace["extreme-fast-belt-beltbox"] then
	data.raw.furnace["extreme-fast-belt-beltbox"].crafting_speed = data.raw["transport-belt"]["extreme-fast-belt"].speed * 32
end
-- ultimate t3
if data.raw["loader-1x1"]["ultra-express-belt-loader"] then
	data.raw["loader-1x1"]["ultra-express-belt-loader"].speed = data.raw["transport-belt"]["ultra-express-belt"].speed
end
if data.raw.furnace["ultra-express-belt-beltbox"] then
	data.raw.furnace["ultra-express-belt-beltbox"].crafting_speed = data.raw["transport-belt"]["ultra-express-belt"].speed * 32
end
-- ultimate t4
if data.raw["loader-1x1"]["extreme-express-belt-loader"] then
	data.raw["loader-1x1"]["extreme-express-belt-loader"].speed = data.raw["transport-belt"]["extreme-express-belt"].speed
end
if data.raw.furnace["extreme-express-belt-beltbox"] then
	data.raw.furnace["extreme-express-belt-beltbox"].crafting_speed = data.raw["transport-belt"]["extreme-express-belt"].speed * 32
end
-- ultimate t5
if data.raw["loader-1x1"]["ultimate-belt-loader"] then
	data.raw["loader-1x1"]["ultimate-belt-loader"].speed = data.raw["transport-belt"]["ultimate-belt"].speed
end
if data.raw.furnace["ultimate-belt-beltbox"] then
	data.raw.furnace["ultimate-belt-beltbox"].crafting_speed = data.raw["transport-belt"]["ultimate-belt"].speed * 32
end
