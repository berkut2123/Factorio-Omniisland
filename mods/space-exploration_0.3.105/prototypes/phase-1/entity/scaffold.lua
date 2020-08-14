local data_util = require("data_util")

local auto_hr = function(sr)
  local hr = table.deepcopy(sr)
  hr.scale = 0.5 * (sr.scale or 1)
  hr.filename = data_util.replace(hr.filename, "/sr/", "/hr/")
  hr.width = sr.width * 2
  hr.height = sr.height * 2
  sr.hr_version = hr
  return sr
end

local make_scaffold_pictures = function(width, height)
  local layers = {}
  local x_base = -(width+1)/2*32
  local y_base = -(height+1)/2*32
  for i = 1, width, 1 do
    for j = 1, height, 1 do
      if j == 1 then
        if i == 1 then
          table.insert(layers, auto_hr({
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-nw.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+0, y_base+j*32+0),
            animation_speed = 1,
          }))
          table.insert(layers, auto_hr({
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-nw-shadow.png",
            priority = "high",
            width = 40,
            height = 40,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+4, y_base+j*32+4),
            animation_speed = 1,
          }))
        elseif i < width then
          table.insert(layers, auto_hr({
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-n.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+0, y_base+j*32+0),
            animation_speed = 1,
          }))
          table.insert(layers, auto_hr({
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-n-shadow.png",
            priority = "high",
            width = 32,
            height = 40,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+8, y_base+j*32+4),
            animation_speed = 1,
          }))
        else
          table.insert(layers, auto_hr({
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-ne.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+0, y_base+j*32+0),
            animation_speed = 1,
          }))
          table.insert(layers, auto_hr({
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-ne-shadow.png",
            priority = "high",
            width = 32,
            height = 40,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+8, y_base+j*32+4),
            animation_speed = 1,
          }))
        end
      elseif j < height then
        if i == 1 then
          table.insert(layers, auto_hr({
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-w.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+0, y_base+j*32+0),
            animation_speed = 1,
          }))
          table.insert(layers, auto_hr({
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-w-shadow.png",
            priority = "high",
            width = 40,
            height = 32,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+4, y_base+j*32+8),
            animation_speed = 1,
          }))
        elseif i < width then
          table.insert(layers, auto_hr({
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-m.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+0, y_base+j*32+0),
            animation_speed = 1,
          }))
          table.insert(layers, auto_hr({
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-m-shadow.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+8, y_base+j*32+8),
            animation_speed = 1,
          }))
        else
          table.insert(layers, auto_hr({
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-e.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+0, y_base+j*32+0),
            animation_speed = 1,
          }))
          table.insert(layers, auto_hr({
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-e-shadow.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+8, y_base+j*32+8),
            animation_speed = 1,
          }))
        end
      else
        if i == 1 then
          table.insert(layers, auto_hr({
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-sw.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+0, y_base+j*32+0),
            animation_speed = 1,
          }))
          table.insert(layers, auto_hr({
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-sw-shadow.png",
            priority = "high",
            width = 40,
            height = 24,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+4, y_base+j*32+4),
            animation_speed = 1,
          }))
        elseif i < width then
          table.insert(layers, auto_hr({
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-s.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+0, y_base+j*32+0),
            animation_speed = 1,
          }))
          table.insert(layers, auto_hr({
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-s-shadow.png",
            priority = "high",
            width = 32,
            height = 24,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+8, y_base+j*32+4),
            animation_speed = 1,
          }))
        else
          table.insert(layers, auto_hr({
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-se.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+0, y_base+j*32+0),
            animation_speed = 1,
          }))
          table.insert(layers, auto_hr({
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/scaffold/sr/scaffold-se-shadow.png",
            priority = "high",
            width = 32,
            height = 24,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(x_base+i*32+8, y_base+j*32+4),
            animation_speed = 1,
          }))
        end
      end
    end
  end

  return { layers = layers }

end


data:extend({
  --[[{
    type = "assembling-machine",
    name = data_util.mod_prefix .. "gate-addon-scaffold",
    icon = "__space-exploration-graphics__/graphics/icons/scaffold.png",
    icon_size = 64,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    max_health = 700,
    corpse = "big-remnants",
    order = "a[ancient]-g[gate]-z[scaffold]",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-4/2+1/32, -4/2+1/32}, {4/2-1/32, 4/2-1/32}},
    selection_box = {{-4/2+1/32, -4/2+1/32}, {4/2-1/32, 4/2-1/32}},
    drawing_box = {{-4/2+1/32, -4/2+1/32}, {4/2-1/32, 4/2-1/32}},
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound = {
      apparent_volume = 1.5,
      idle_sound = {
        filename = "__base__/sound/idle1.ogg",
        volume = 0.6
      },
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t1-1.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t1-2.ogg",
          volume = 0.8
        }
      }
    },
    collision_mask = {"not-colliding-with-itself"},
    animation = make_scaffold_pictures(4,4),
    crafting_categories = {"fixed-recipe"},
    fixed_recipe = data_util.mod_prefix .. "gate-addon",
    crafting_speed = 1,
    energy_source = {type = "void"},
    energy_usage = "1000kW",
    ingredient_count = 12,
    module_specification = { module_slots = 0 },
    allowed_effects = {},
  },]]--
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "gate-platform-scaffold",
    icon = "__space-exploration-graphics__/graphics/icons/scaffold.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    max_health = 1000,
    corpse = "big-remnants",
    order = "a[ancient]-g[gate]-z[scaffold]",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-9/2+1/32, -3/2+1/32}, {9/2-1/32, 3/2-1/32}},
    selection_box = {{-9/2+1/32, -3/2+1/32}, {9/2-1/32, 3/2-1/32}},
    drawing_box = {{-9/2+1/32, -3/2+1/32}, {9/2-1/32, 3/2-1/32}},
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound = {
      apparent_volume = 1.5,
      idle_sound = {
        filename = "__base__/sound/idle1.ogg",
        volume = 0.6
      },
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t1-1.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t1-2.ogg",
          volume = 0.8
        }
      }
    },
    collision_mask = {"not-colliding-with-itself"},
    animation = make_scaffold_pictures(9,3),
    crafting_categories = {"fixed-recipe"},
    fixed_recipe = data_util.mod_prefix .. "gate-platform",
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4,
    },
    energy_usage = "1000kW",
    ingredient_count = 12,
    module_specification = { module_slots = 0 },
    allowed_effects = {},
  }
})
