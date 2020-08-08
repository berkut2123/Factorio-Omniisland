-- Update speeds to match belts after they've been updated
-- t1
if data.raw["loader-1x1"]["transport-belt-loader"] then
	data.raw["loader-1x1"]["transport-belt-loader"].speed = data.raw["transport-belt"]["transport-belt"].speed
end
if data.raw.furnace["transport-belt-beltbox"] then
	data.raw.furnace["transport-belt-beltbox"].crafting_speed = data.raw["transport-belt"]["transport-belt"].speed * 18
end
-- t2
if data.raw["loader-1x1"]["fast-transport-belt-loader"] then
	data.raw["loader-1x1"]["fast-transport-belt-loader"].speed = data.raw["transport-belt"]["fast-transport-belt"].speed
end
if data.raw.furnace["fast-transport-belt-beltbox"] then
	data.raw.furnace["fast-transport-belt-beltbox"].crafting_speed = data.raw["transport-belt"]["fast-transport-belt"].speed * 18
end
-- t3
if data.raw["loader-1x1"]["express-transport-belt-loader"] then
	data.raw["loader-1x1"]["express-transport-belt-loader"].speed = data.raw["transport-belt"]["express-transport-belt"].speed
end
if data.raw.furnace["express-transport-belt-beltbox"] then
	data.raw.furnace["express-transport-belt-beltbox"].crafting_speed = data.raw["transport-belt"]["express-transport-belt"].speed * 18
end
