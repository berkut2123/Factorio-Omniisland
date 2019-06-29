require "util"
require "tightspot"

level =
{
  level_number = 5,
  time = 15 * 60 * 60,
  money = 10000,
  required_balance =
  {
    easy = 4000,
    normal = 9000,
    hard = 15000
  },
  center = {x = 0, y = 0},
  starting_land_prize = 10,
  price_increase = 2,
  area = {{-40, -40}, {40, 40}},
  recipes =
  {
    "iron-plate",
    "copper-plate",
    "copper-cable",
    "steel-plate",
    "electronic-circuit",
    "iron-gear-wheel",
    "advanced-circuit",
    "chemical-science-pack",
    "plastic-bar",
    "basic-oil-processing",
    "advanced-oil-processing",
    "engine-unit",
    "electric-mining-drill",
    "pipe",
    "solid-fuel-from-light-oil",
    "solid-fuel-from-petroleum-gas",
    "solid-fuel-from-heavy-oil"
  },
  items =
  {
    "coal",
    "transport-belt",
    "underground-belt",
    "fast-transport-belt",
    "fast-underground-belt",
    "splitter",
    "fast-splitter",
    "burner-inserter",
    "inserter",
    "long-handed-inserter",
    "fast-inserter",
    "filter-inserter",
    "red-wire",
    "green-wire",
    "wooden-chest",
    "stone-furnace",
    "steel-furnace",
    "electric-furnace",
    "offshore-pump",
    "pipe",
    "pipe-to-ground",
    "boiler",
    "steam-engine",
    "small-electric-pole",
    "medium-electric-pole",
    "big-electric-pole",
    "substation",
    "assembling-machine-1",
    "assembling-machine-2",
    "assembling-machine-3",
    "electric-mining-drill",
    "burner-mining-drill",
    "pumpjack",
    "oil-refinery",
    "chemical-plant",
    "storage-tank",
    "pump"
  },
  demand =
  {
    {
      item = "chemical-science-pack",
      price = 1500
    }
  }
}

level.offers = {}
for _, item in ipairs(level.items) do
  level.offers[#level.offers + 1] = tightspot_make_offer(item)
end

script.on_init(function()
  global.story = story_init(story_table)
  global.tightspot = tightspot_init(level)
  game.players[1].surface.always_day = true
  game.players[1].force.disable_research()
end)

script.on_event(defines.events, function(event)
  story_update(global.story, event, "")
end)
