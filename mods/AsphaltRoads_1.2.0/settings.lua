data:extend({
    {
        type = "bool-setting",
        name = "AR-use-items-from-bioindustries",
        setting_type = "startup",
        default_value = true,
        hidden = true,
        order  = "a",
    },
    {
        type = "bool-setting",
        name = "AR-use-items-from-woodgasification",
        setting_type = "startup",
        default_value = true,
        hidden = true,
        order  = "b",
    },
    {
        type = "bool-setting",
        name = "AR-use-items-from-pypetrol",
        setting_type = "startup",
        default_value = true,
        hidden = true,
        order  = "c",
    },
    {
        type = "string-setting",
        name = "AR-research-cost",
        setting_type = "startup",
        default_value = "level-1",
        allowed_values = {"level-0", "level-1", "level-2"},
        order  = "d",
    },
    {
        type = "int-setting",
        name = "AR-asphalt-stack-size",
        setting_type = "startup",
        default_value = 100,
        minimum_value = 10,
        maximum_value = 1000,
        order = "e",
    },
    {
        type = "string-setting",
        name = "AR-item-group",
        setting_type = "startup",
        default_value = "logistics",
        allowed_values = {"logistics", "dectorio", "asphalt"},
        order = "f",
    },
	{
        type = "bool-setting",
        name = "AR-enable-basic-marking-tiles",
        setting_type = "startup",
        default_value = true,
        order  = "g1",
    },
	{
        type = "bool-setting",
        name = "AR-enable-colored-hazard-marking",
        setting_type = "startup",
        default_value = true,
        order  = "g2",
    },
	{
        type = "bool-setting",
        name = "AR-enable-white-single-lines",
        setting_type = "startup",
        default_value = true,
        order  = "g3",
    },
	{
        type = "bool-setting",
        name = "AR-enable-white-double-lines",
        setting_type = "startup",
        default_value = true,
        order  = "g4",
    },
	{
        type = "bool-setting",
        name = "AR-enable-yellow-single-lines",
        setting_type = "startup",
        default_value = true,
        order  = "g5",
    },	
	{
        type = "bool-setting",
        name = "AR-enable-yellow-double-lines",
        setting_type = "startup",
        default_value = true,
        order  = "g6",
    },
	{
        type = "bool-setting",
        name = "AR-enable-tile-reconverter",
        setting_type = "runtime-global",
        default_value = true,
        order  = "g1",
    }
})

local optionalSettings = {
    ["Bio_Industries"] = {name = "AR-use-items-from-bioindustries"},
    ["Wood_Gasification"] = {name = "AR-use-items-from-woodgasification"},
    ["pypetroleumhandling"] = {name = "AR-use-items-from-pypetrol"}
}
for mod, setting in pairs(optionalSettings) do
    if mods[mod] then
        data.raw["bool-setting"][setting.name].hidden = false
    end
end

