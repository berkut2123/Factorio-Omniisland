require "util"
require "transportbeltmadness"

levels=
{
  {
    starting_location = {0, 3},
    area = {{-16, -16}, {16, 16}},
    level_width = 30,
    description = "level-05",
    recipes =
    {
      "transport-belt",
      "underground-belt",
      "fast-transport-belt",
      "fast-underground-belt",
      "express-transport-belt",
      "express-underground-belt",
      "long-handed-inserter"
    },
    ["resources"] = {},
    ["chests"]=
    {
      {
        item="iron-plate",
        input=1,
        input_position = {{-15, -5}, defines.direction.east},
        output=1,
        output_position = {{13, 1}, defines.direction.west}
      },
      {
        item="copper-plate",
        input=2,
        input_position = {{-15, -1}, defines.direction.east},
        output=2,
        output_position = {{13, -3}, defines.direction.west}
      },
      {
        item="iron-gear-wheel",
        input=3,
        input_position = {{-15, -12}, defines.direction.east},
        output=3,
        output_position = {{13, 8}, defines.direction.west}
      },
      {
        item="steel-plate",
        input=4,
        input_position = {{-12, -15}, defines.direction.south},
        output=4,
        output_position = {{10, 11}, defines.direction.north}
      },
      {
        item="coal",
        input=5,
        input_position = {{-4, -15}, defines.direction.south},
        output=5,
        output_position = {{2, 11}, defines.direction.north}
      },
      {
        item="electronic-circuit",
        input=6,
        input_position = {{0, -15}, defines.direction.south},
        output=6,
        output_position = {{-2, 11}, defines.direction.north}
      },
      {
        item="wood",
        input=7,
        input_position = {{-15, 8}, defines.direction.east},
        output=7,
        output_position = {{10, -15}, defines.direction.south}
      },
      {
        item="copper-ore",
        input=8,
        input_position = {{-12, 11}, defines.direction.north},
        output=8,
        output_position = {{13, -12}, defines.direction.west}
      },
      {
        item="advanced-circuit",
        input=9,
        input_position = {{-15, -3}, defines.direction.east},
        output=9,
        output_position = {{13, 10}, defines.direction.west}
      },
      {
        item="raw-fish",
        input=10,
        input_position = {{0, 11}, defines.direction.north},
        output=10,
        output_position = {{12, -15}, defines.direction.south}
      },
      {
        item="uranium-ore",
        input=11,
        input_position = {{13, -1}, defines.direction.west},
        output=11,
        output_position = {{-14, -15}, defines.direction.south}
      },
      {
        item="rail-signal",
        input=12,
        input_position = {{-2, -15}, defines.direction.south},
        output=12,
        output_position = {{-15, 10}, defines.direction.east}
      },
      {
        item="rail",
        input=13,
        input_position = {{-15, 1}, defines.direction.east},
        output=13,
        output_position = {{2, -15}, defines.direction.south}
      },
      {
        item="coin",
        input=14,
        input_position = {{-4, 11}, defines.direction.north},
        output=14,
        output_position = {{13, -5}, defines.direction.west}
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
  story_update(global.story, event, "")
end)

