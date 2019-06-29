require "util"
require "tightspot"

level =
{
  level_number = 3,
  time = 12 * 60 * 60,
  money = 10000,
  required_balance =
  {
    easy = 3000,
    normal = 10000,
    hard = 18000
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
    "electronic-circuit",
    "solar-panel",
    "steel-plate"
  },
  items =
  {
    "coal",
    "transport-belt",
    "underground-belt",
    "fast-transport-belt",
    "fast-underground-belt",
    "splitter",
    "burner-inserter",
    "inserter",
    "long-handed-inserter",
    "fast-inserter",
    "filter-inserter",
    "red-wire",
    "green-wire",
    "wooden-chest",
    "stone-furnace",
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
    "electric-mining-drill",
    "burner-mining-drill"
  },
  demand =
  {
    {
      item = "solar-panel",
      price = 600
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
  story_update(global.story, event, "level-04")
end)
