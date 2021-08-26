local tile_trigger_effects = require("__base__/prototypes/tile/tile-trigger-effects")

if not settings.startup["aai-stone-path"].value then return end

local stone_path_vehicle_speed_modifier = 1.1

local ttfxmaps = base_tile_transition_effect_maps or {}

ttfxmaps.water_stone =
{
  filename_norm = "__base__/graphics/terrain/effect-maps/water-stone-mask.png",
  filename_high = "__base__/graphics/terrain/effect-maps/hr-water-stone-mask.png",
  count = 1,
  o_transition_tall = false
}

ttfxmaps.water_stone_to_land =
{
  filename_norm = "__base__/graphics/terrain/effect-maps/water-stone-to-land-mask.png",
  filename_high = "__base__/graphics/terrain/effect-maps/hr-water-stone-to-land-mask.png",
  count = 3,
  u_transition_count = 1,
  o_transition_count = 0
}

ttfxmaps.water_stone_to_out_of_map =
{
  filename_norm = "__base__/graphics/terrain/effect-maps/water-stone-to-out-of-map-mask.png",
  filename_high = "__base__/graphics/terrain/effect-maps/hr-water-stone-to-out-of-map-mask.png",
  count = 3,
  u_transition_count = 0,
  o_transition_count = 0
}

function init_transition_between_transition_common_options(base)
  local t = base or {}

  t.background_layer_offset = t.background_layer_offset or 1
  t.background_layer_group = t.background_layer_group or "zero"
  if (t.offset_background_layer_by_tile_layer == nil) then
    t.offset_background_layer_by_tile_layer = true
  end

  return t
end

local function create_transition_to_out_of_map_from_template(normal_res_template_path, high_res_template_path, options)
  return make_out_of_map_transition_template
  (
    { "out-of-map" },
    normal_res_template_path,
    high_res_template_path,
    {
      o_transition_tall = false,
      side_count = 8,
      inner_corner_count = 4,
      outer_corner_count = 4,
      u_transition_count = 1,
      o_transition_count = 1,
      base = init_transition_between_transition_common_options()
    },
    options.has_base_layer == true,
    options.has_background == true,
    options.has_mask == true
  )
end

local function water_transition_template_with_effect(to_tiles, normal_res_transition, high_res_transition, options)
  return make_generic_transition_template(to_tiles, water_transition_group_id, nil, normal_res_transition, high_res_transition, options, true, false, true)
end

local stone_path_to_out_of_map_transition =
  create_transition_to_out_of_map_from_template("__aai-industry__/graphics/terrain/stone-path/stone-path-out-of-map-transition.png",
                                                "__aai-industry__/graphics/terrain/stone-path/hr-stone-path-out-of-map-transition.png",
                                                { has_base_layer = true, has_background = true, has_mask = false })


-- ~~~STONE_STONE_PATH

local stone_path_transitions =
{
  water_transition_template_with_effect
  (
      water_tile_type_names,
      "__aai-industry__/graphics/terrain/stone-path/stone-path.png",
      "__aai-industry__/graphics/terrain/stone-path/hr-stone-path.png",
      {
        effect_map = ttfxmaps.water_stone,
        o_transition_tall = false,
        u_transition_count = 4,
        o_transition_count = 4,
        side_count = 8,
        outer_corner_count = 8,
        inner_corner_count = 8,
        --base = { layer = 40 }
      }
  ),
  stone_path_to_out_of_map_transition
}

local stone_path_transitions_between_transitions =
{
  make_generic_transition_template
  (
      nil,
      default_transition_group_id,
      water_transition_group_id,
      "__aai-industry__/graphics/terrain/stone-path/stone-path-transitions.png",
      "__aai-industry__/graphics/terrain/stone-path/hr-stone-path-transitions.png",
      {
        effect_map = ttfxmaps.water_stone_to_land,
        inner_corner_tall = true,
        inner_corner_count = 3,
        outer_corner_count = 3,
        side_count = 3,
        u_transition_count = 1,
        o_transition_count = 0
      },
      true,
      false,
      true
  ),
  make_generic_transition_template
  (
    nil,
    default_transition_group_id,
    out_of_map_transition_group_id,
    "__aai-industry__/graphics/terrain/stone-path/stone-path-out-of-map-transition-b.png",
    "__aai-industry__/graphics/terrain/stone-path/hr-stone-path-out-of-map-transition-b.png",
    {
      inner_corner_tall = true,
      inner_corner_count = 3,
      outer_corner_count = 3,
      side_count = 3,
      u_transition_count = 1,
      o_transition_count = 0,
      base = init_transition_between_transition_common_options()
    },
    true,
    true,
    false
  ),

  generic_transition_between_transitions_template
  (
      water_transition_group_id,
      out_of_map_transition_group_id,
      "__base__/graphics/terrain/out-of-map-transition/stone-path-shore-out-of-map-transition.png",
      "__base__/graphics/terrain/out-of-map-transition/hr-stone-path-shore-out-of-map-transition.png",
      {
        effect_map = ttfxmaps.water_stone_to_out_of_map,
        o_transition_tall = false,
        inner_corner_count = 3,
        outer_corner_count = 3,
        side_count = 3,
        u_transition_count = 1,
        o_transition_count = 0,
        base = init_transition_between_transition_water_out_of_map_options()
      },
      true,
      true,
      false
  )
}

data.raw.item["stone"].place_as_tile = {
  result = "rough-stone-path",
  condition_size = 1,
  condition = { "water-tile" },
}

data:extend({
  -----------//////////////////////////////////////////////////////////////STONE-PATH
  {
    type = "tile",
    name = "rough-stone-path",
    order = "a-a-a",
    needs_correction = false,
    minable = {mining_time = 0.05, result = "stone"},
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg", volume = 0.8},
    collision_mask = {"ground-tile"},
    walking_speed_modifier = 1.2,
    layer = 59,
    decorative_removal_probability = 0.15,
    variants =
    {
      main =
      {
        {
          picture = "__aai-industry__/graphics/terrain/stone-path/stone-path-1.png",
          count = 10,
          size = 1,
          hr_version =
          {
            picture = "__aai-industry__/graphics/terrain/stone-path/hr-stone-path-1.png",
            count = 10,
            size = 1,
            scale = 0.5
          }
        },
        {
          picture = "__aai-industry__/graphics/terrain/stone-path/stone-path-2.png",
          count = 5,
          size = 2,
          probability = 0.039,
          hr_version =
          {
            picture = "__aai-industry__/graphics/terrain/stone-path/hr-stone-path-2.png",
            count = 5,
            size = 2,
            probability = 0.039,
            scale = 0.5
          }
        },
      },
      inner_corner =
      {
        picture = "__aai-industry__/graphics/terrain/stone-path/stone-path-inner-corner.png",
        count = 5,
        tall = false,
        hr_version =
        {
          picture = "__aai-industry__/graphics/terrain/stone-path/hr-stone-path-inner-corner.png",
          count = 5,
          tall = false,
          scale = 0.5
        }
      },
      outer_corner =
      {
        picture = "__aai-industry__/graphics/terrain/stone-path/stone-path-outer-corner.png",
        count = 5,
        tall = false,
        hr_version =
        {
          picture = "__aai-industry__/graphics/terrain/stone-path/hr-stone-path-outer-corner.png",
          count = 5,
          tall = false,
          scale = 0.5
        }
      },
      side =
      {
        picture = "__aai-industry__/graphics/terrain/stone-path/stone-path-side.png",
        count = 10,
        tall = false,
        hr_version =
        {
          picture = "__aai-industry__/graphics/terrain/stone-path/hr-stone-path-side.png",
          count = 10,
          tall = false,
          scale = 0.5
        }
      },
      u_transition =
      {
        picture = "__aai-industry__/graphics/terrain/stone-path/stone-path-u.png",
        count = 2,
        tall = false,
        hr_version =
        {
          picture = "__aai-industry__/graphics/terrain/stone-path/hr-stone-path-u.png",
          count = 2,
          tall = false,
          scale = 0.5
        }
      },
      o_transition =
      {
        picture = "__aai-industry__/graphics/terrain/stone-path/stone-path-o.png",
        count = 2,
        hr_version =
        {
          picture = "__aai-industry__/graphics/terrain/stone-path/hr-stone-path-o.png",
          count = 2,
          scale = 0.5
        }
      }
    },
    transitions = stone_path_transitions,
    transitions_between_transitions = stone_path_transitions_between_transitions,

    walking_sound = table.deepcopy(data.raw.tile["stone-path"].walking_sound),
    build_sound = table.deepcopy(data.raw.tile["stone-path"].build_sound),
    map_color={r=86, g=82, b=74},
    scorch_mark_color = {r = 0.373, g = 0.307, b = 0.243, a = 1.000},
    pollution_absorption_per_second = 0,
    vehicle_friction_modifier = 1 + (data.raw.tile["stone-path"].vehicle_friction_modifier - 1) / 2,

    trigger_effect = tile_trigger_effects.stone_path_trigger_effect()
  },
})
