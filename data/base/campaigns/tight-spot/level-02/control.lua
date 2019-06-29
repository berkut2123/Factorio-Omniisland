require "util"
require "tightspot"

level =
{
  level_number = 2,
  time = 10 * 60 * 60,
  money = 10000,
  required_balance =
  {
    easy = 1000,
    normal = 2000,
    hard = 3000
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
    "electronic-circuit"
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
    "stone-furnace",
    "offshore-pump",
    "pipe",
    "pipe-to-ground",
    "boiler",
    "steam-engine",
    "small-electric-pole",
    "assembling-machine-1",
    "electric-mining-drill",
    "burner-mining-drill"
  },
  demand =
  {
    {
      item = "electronic-circuit",
      price = 15
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
  story_update(global.story, event, "level-03")
end)
