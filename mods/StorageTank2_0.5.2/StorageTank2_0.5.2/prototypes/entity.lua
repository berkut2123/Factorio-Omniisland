--[[ Copyright (c) 2017 Optera
 * Part of Storage Tank mk2
 *
 * See LICENSE.md in the project directory for license information.
--]]

local copy_prototype = require('__flib__.data_util').copy_prototype

data.raw["item"]["storage-tank"].stack_size = 10

local base_tank = data.raw["storage-tank"]["storage-tank"]
base_tank.fast_replaceable_group = base_tank.fast_replaceable_group or "storage-tank"
base_tank.next_upgrade = "storage-tank2"

local tank2 = copy_prototype(base_tank, "storage-tank2")
tank2.next_upgrade = nil
tank2.max_health = 1000
tank2.fluid_box =
  {
    base_area = 1000,
    pipe_covers = pipecoverspictures(),
    pipe_connections =
    {
      { position = {-1, -2} },
      { position = {2, 1} },
      { position = {1, 2} },
      { position = {-2, -1} },
      { position = {1, -2} },
      { position = {2, -1} },
      { position = {-2, 1} },
      { position = {-1, 2} },
    }
  }
tank2.rotatable = false
tank2.two_direction_only = true
tank2.pictures.picture =
  {
    layers =
    {
      {
        filename = "__StorageTank2__/graphics/entity/storage-tank2.png",
        priority = "extra-high",
        width = 110,
        height = 108,
        shift = util.by_pixel(0, 4),
        hr_version =
        {
          filename = "__StorageTank2__/graphics/entity/hr-storage-tank2.png",
          priority = "extra-high",
          width = 219,
          height = 215,
          shift = util.by_pixel(-0.25, 3.75),
          scale = 0.5
        }
      },
      -- overlapping base shadows similar to Custom storage Tank by Xagros
      {
        filename = "__base__/graphics/entity/storage-tank/storage-tank-shadow.png",
        priority = "extra-high",
        x = 146,
        width = 146,
        height = 77,
        shift = util.by_pixel(30, 22.5),
        draw_as_shadow = true,
        hr_version = {
          filename = "__base__/graphics/entity/storage-tank/hr-storage-tank-shadow.png",
          priority = "extra-high",
          x = 291,
          width = 291,
          height = 153,
          shift = util.by_pixel(29.75, 22.25),
          scale = 0.5,
          draw_as_shadow = true
        }
      },
      {
        filename = "__base__/graphics/entity/storage-tank/storage-tank-shadow.png",
        priority = "extra-high",
        width = 146,
        height = 77,
        shift = util.by_pixel(30, 22.5),
        draw_as_shadow = true,
        hr_version = {
          filename = "__base__/graphics/entity/storage-tank/hr-storage-tank-shadow.png",
          priority = "extra-high",
          width = 291,
          height = 153,
          shift = util.by_pixel(29.75, 22.25),
          scale = 0.5,
          draw_as_shadow = true
        }
      }
    }
  }


data:extend({
  tank2
})