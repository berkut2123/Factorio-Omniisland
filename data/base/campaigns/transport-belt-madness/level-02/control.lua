require "util"
require "transportbeltmadness"

levels=
{
  {
    starting_location = {0, 4},
    area = {{-16, -9}, {16, 9}},
    level_width = 30,
    description = "level-03",
    recipes = {"transport-belt", "underground-belt"},
    ["resources"] ={},
    ["chests"]=
    {
      {
        item="iron-plate",
        input=1,
        output=5
      },
      {
        item="copper-plate",
        input=2,
        output=7
      },
      {
        item="iron-gear-wheel",
        input=3,
        output=6
      },
      {
        item="steel-plate",
        input=5,
        output=1
      },
      {
        item="coal",
        input=6,
        output=3
      },
      {
        item="electronic-circuit",
        input=7,
        output=2
      }
    }
  },
  {
    starting_location = {0, 4},
    area = {{-16, -9}, {16, 9}},
    description = "level-04",
    level_width = 30,
    recipes =
    {
      "transport-belt",
      "underground-belt",
      "fast-transport-belt",
      "fast-underground-belt"
    },
    ["resources"] ={},
    ["chests"]=
    {
      {
        item="iron-plate",
        input=1,
        output=9
      },
      {
        item="copper-plate",
        input=2,
        output=7
      },
      {
        item="iron-gear-wheel",
        input=3,
        output=6
      },
      {
        item="steel-plate",
        input=4,
        output=8
      },
      {
        item="coal",
        input=6,
        output=3
      },
      {
        item="electronic-circuit",
        input=7,
        output=2
      },
      {
        item="wood",
        input=8,
        output=4
      },
      {
        item="copper-ore",
        input=9,
        output=1
      }
    }
  }
}

script.on_init(function()
  global.story = story_init(story_table)
  global.transport_belt_madness = transport_belt_madness_init(levels)
  game.players[1].surface.always_day = true
  game.players[1].force.disable_research()
end)

script.on_event(defines.events, function(event)
  story_update(global.story, event, "level-03")
end)

