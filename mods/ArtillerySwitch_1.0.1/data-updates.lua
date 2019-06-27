local disabled_turret
local disabled_turret_item
local disabled_gun

local function create_disabled_wagon()
	for _, entity in pairs(data.raw["artillery-wagon"]) do
		
		disabled_turret = util.table.deepcopy(entity)

		disabled_turret_item = util.table.deepcopy(data.raw["item-with-entity-data"][disabled_turret.name])
		if disabled_turret_item == nil then
			disabled_turret_item =  util.table.deepcopy(data.raw["item-with-entity-data"]["artillery-wagon"])
		end
		
		disabled_turret_item.name = "disabled-" .. disabled_turret.name
		disabled_turret_item.place_result = "disabled-" .. disabled_turret.name
		
		disabled_turret.name = "disabled-" .. disabled_turret.name
		disabled_turret.localised_name = {"", {"entity-name." .. entity.name}, " (disabled)"}

		disabled_gun = util.table.deepcopy(data.raw["gun"][disabled_turret.gun])
		disabled_gun.name = "disabled-" .. disabled_turret.gun
		disabled_gun.tint = { r = 1.0, g = 0.0, b = 0.0, a = 1.0 }
		disabled_gun.attack_parameters.range = 0
		disabled_gun.attack_parameters.min_range = 0
		
		disabled_turret.gun = disabled_gun.name
	end
	
end
create_disabled_wagon()

data:extend({
	{
		type = "virtual-signal",
		name = "signal-disabled",
		localised_name = {"gui-alert-tooltip.title"},
		icon = "__core__/graphics/destroyed-icon.png",
		icon_size = 64,
		subgroup = "virtual-signal-color",
		order = "d[colors]-[9disabled]",
		hidden = true,
	}
})

data:extend({disabled_turret})
data:extend({disabled_turret_item})
data:extend({disabled_gun})