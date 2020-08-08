require("functions")

if smeltingsteel.value == true then
data:extend({
  {
    type = "recipe",
    name = "steelspc",
	category = "smelting",
	subgroup = "raw-material",
	normal =
    {
      enabled = "false",
	  energy_required = 60,
	  ingredients = {{"iron-plate", 10}},
      result = "steel-plate"
    },
    expensive =
    {
      enabled = "false",
	  energy_required = 90,
	  ingredients = {{"iron-plate", 20}},
      result = "steel-plate"
    }
  },
})

add_technology_unlock("steel-processing", "steelspc")
end

if smeltingcable.value == true then
data:extend({
  {
	type = "recipe",
	name = "copper-cablespc",
	category = "electronics",
	normal =
	{
	  enabled = "true",
	  energy_required = 2,
	  ingredients = {{"copper-plate", 2}},
	  result = "copper-cable",
	  result_count = 1
	},
	expensive =
	{
	  enabled = "true",
	  energy_required = 4,
	  ingredients = {{"copper-plate", 10}},
	  result = "copper-cable",
	  result_count = 2
	}
  },
})
if recipe("tinned-copper-cable") then
data:extend({
  {
	type = "recipe",
	name = "tin-cablespc",
	category = "electronics",
	normal =
	{
	  enabled = "false",
	  energy_required = 2,
	  ingredients =
      {
        {"copper-cable", 10},
        {"tin-plate", 4},
      },
	  result = "tinned-copper-cable",
	  result_count = 2
	},
	expensive =
	{
	  enabled = "false",
	  energy_required = 4,
	  ingredients =
      {
        {"copper-cable", 20},
        {"tin-plate", 8},
      },
	  result = "tinned-copper-cable",
	  result_count = 2
	}
  },
})
end
end

if smeltingsolder.value == true then
if recipe("tinned-copper-cable") then
data:extend({
{
	type = "recipe",
	name = "angels-solder-mixture-sp",
    category = "crafting",
    subgroup = "angels-alloys",
	normal =
	{
    energy_required = 4,
	enabled = "false",
    ingredients ={
      {type="item", name="angels-plate-lead", amount=4},
      {type="item", name="solid-carbon", amount=4},
	  {type="item", name="tinned-copper-cable", amount=2},
	},
    results=
    {
      {type="item", name="angels-solder-mixture", amount=2},
    },
	},
	expensive =
	{
    energy_required = 8,
	enabled = "false",
    ingredients ={
      {type="item", name="angels-plate-lead", amount=8},
      {type="item", name="solid-carbon", amount=8},
	  {type="item", name="tinned-copper-cable", amount=4},
	},
    results=
    {
      {type="item", name="angels-solder-mixture", amount=2},
    },
	}
  }
})
end
--[[
data:extend({
  {
	type = "recipe",
	name = "lead-ingotspc",
	category = "blast-smelting",
	subgroup = "angels-lead",
	normal =
	{
    energy_required = 4,
	enabled = "false",
    ingredients ={
      {type="item", name="lead-plate", amount=10},
      {type="item", name="solid-carbon", amount=4},
	},
    results=
    {
      {type="item", name="ingot-lead", amount=1},
    },
    main_product= "ingot-lead"
	},
	expensive =
	{
    energy_required = 4,
	enabled = "false",
    ingredients ={
      {type="item", name="lead-plate", amount=20},
      {type="item", name="solid-carbon", amount=8},
	},
    results=
    {
      {type="item", name="ingot-lead", amount=1},
    },
    main_product= "ingot-lead"
	}
  },
  {
	type = "recipe",
	name = "tin-ingotspc",
	category = "blast-smelting",
	subgroup = "angels-tin",
	normal =
	{
    energy_required = 4,
	enabled = "false",
    ingredients ={
      {type="item", name="tin-plate", amount=10},
      {type="item", name="solid-coke", amount=4},
	},
    results=
    {
      {type="item", name="ingot-tin", amount=1},
    },
    main_product= "ingot-tin"
	},
	expensive =
	{
    energy_required = 4,
	enabled = "false",
    ingredients ={
      {type="item", name="tin-plate", amount=20},
      {type="item", name="solid-coke", amount=8},
	},
    results=
    {
      {type="item", name="ingot-tin", amount=1},
    },
    main_product= "ingot-tin"
	}
  },
})
]]--
end

if smeltingglass.value == true then
data:extend({
  {
    type = "recipe",
    name = "glassspc",
	category = "smelting",
	subgroup = "raw-material",
	normal =
    {
      enabled = "false",
	  energy_required = 40,
	  ingredients = {{"quartz", 20}},
      result = "glass"
    },
    expensive =
    {
      enabled = "false",
	  energy_required = 60,
	  ingredients = {{"quartz", 40}},
      result = "glass"
    }
  },
})

add_technology_unlock("angels-metallurgy-1", "glassspc")
end