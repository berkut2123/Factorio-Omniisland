local itemgroups = 
{
    {name="logistics", group="logistics", order="i"},
    {name="dectorio", group="dectorio", order="i-c-a"},
    {name="asphalt", group="AR-road-construction",order ="a"}
}
local ig_name = "logistics"
local ig_order = "i"

if settings.startup["AR-item-group"].value == "asphalt" then
	data:extend({
		{
			type = "item-group",
			name = "AR-road-construction",
			order = "d-b",
			icon = "__AsphaltRoads__/graphics/icon-group/road-construction.png",
			icon_size = 64,
		}
	})
end

for _,ig in pairs(itemgroups) do
    if ig.name == settings.startup["AR-item-group"].value and data.raw["item-group"][ig.group] ~= nil then
        ig_name = ig.group
        ig_order = ig.order
    end
end

data:extend(
{  
    {
        type = "item-subgroup",
        name = "Arci-asphalt-1",
        group = ig_name,
        order = ig_order,
    },
    {
        type = "item-subgroup",
        name = "Arci-asphalt-2",
        group = ig_name,
        order = ig_order,
    },
    {
        type = "item-subgroup",
        name = "Arci-asphalt-3",
        group = ig_name,
        order = ig_order,
    }
})