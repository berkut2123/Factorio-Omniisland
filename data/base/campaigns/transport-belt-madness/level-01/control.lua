require "util"
require "transportbeltmadness"

levels=
{
  {
    show_rules = true,
    starting_location = {0, 0},
    area = {{-9, -9}, {9, 9}},
    level_width = 14,
    description = "level-01",
    recipes = {"transport-belt", "underground-belt"},
    resources = {},
    chests=
    {
      {
        item="iron-plate",
        input=1,
        output=5
      },
      {
        item="copper-plate",
        input=2,
        output=4
      },
      {
        item="steel-plate",
        input=4,
        output=1
      },
      {
        item="copper-ore",
        input=5,
        output=2
      }
    }
  },
  {
    starting_location = {0, 0},
    area = {{-9, -9}, {9, 9}},
    level_width = 14,
    description = "level-02",
    recipes = {"transport-belt", "underground-belt"},
    resources ={},
    chests =
    {
      {
        item="iron-plate",
        input=1,
        output=6
      },
      {
        item="copper-plate",
        input=2,
        output=7
      },
      {
        item="steel-plate",
        input=3,
        output=1
      },
      {
        item="copper-ore",
        input=4,
        output=8
      },
      {
        item="iron-ore",
        input=6,
        output=2
      },
      {
        item="coal",
        input=7,
        output=9
      },
      {
        item="wood",
        input=8,
        output=4
      },
      {
        item="iron-gear-wheel",
        input=9,
        output=3
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
  story_update(global.story, event, "level-02")
end)

