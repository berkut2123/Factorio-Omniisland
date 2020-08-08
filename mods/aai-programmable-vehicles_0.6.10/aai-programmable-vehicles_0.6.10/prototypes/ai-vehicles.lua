local data_util = require("data-util")

local vehicle_impact_low = 0.01
local vehicle_impact_med = 0.25
local vehicle_impact_max = 1

local show_navigator = false

-- vanilla
data.raw.car.tank.guns = {"tank-cannon"}
if not data.raw.car["vehicle-flame-tank"] then
  table.insert(data.raw.car.tank.guns, "tank-flamethrower")
end
if not data.raw.car["vehicle-chaingunner"] then
  table.insert(data.raw.car.tank.guns, "tank-machine-gun")
end

-- aircraft mod
if data.raw.car["cargo-plane"] then
  -- hauler types should not have guns
  data.raw.car["cargo-plane"].guns = nil
end

-- more than 2 variants is excessive
if data.raw.car["gunship"] then
  data.raw.car["gunship"].guns = { "aircraft-machine-gun", "aircraft-rocket-launcher"}
end
if data.raw.car["jet"] then
  data.raw.car["jet"].guns = { "aircraft-machine-gun", "napalm-launcher"}
end
if data.raw.car["flying-fortress"] then
  data.raw.car["flying-fortress"].guns = { "aircraft-cannon", "flying-fortress-rocket-launcher"}
end

local function add_resistance(resistances, resistance)
    local resistance_updated = false
    for _, old_resistance in ipairs(resistances) do
        if old_resistance.type == resistance.type then
            resistance_updated = true
            local old_pdt = (100 - (old_resistance.percent or 0))/100
            local add_pdt = (100 - (resistance.percent or 0))/100
            local total_pdt = old_pdt * add_pdt

            old_resistance.percent = 100 - (total_pdt * 100)
            old_resistance.decrease = math.max((old_resistance.decrease or 0), (resistance.decrease or 0))
        end
    end
    if not resistance_updated then
        table.insert(resistances, resistance)
    end
end

local function replace_resistance(resistances, resistance)
    local resistance_updated = false
    for _, old_resistance in ipairs(resistances) do
        if old_resistance.type == resistance.type then
            resistance_updated = true
            old_resistance.percent = resistance.percent or 0
            old_resistance.decrease = resistance.decrease or 0
        end
    end
    if not resistance_updated then
        table.insert(resistances, resistance)
    end
end

local function make_composite_unit_from_vehicle(vehicle)

    local localised_name = vehicle.localised_name or { "entity-name.".. vehicle.name}
    vehicle.localised_name = localised_name

    -- do any required vehicle modifications
    if (not vehicle.weight) or vehicle.weight <= 0 or data_util.string_to_number(vehicle.consumption) <= 1 then return end
    vehicle.resistances = vehicle.resistances or {}
    vehicle.fast_replaceable_group = nil
    add_resistance(vehicle.resistances, {type = "impact", percent = 50, decrease = 200  }) -- take less damage

    -- only 1 gun per vehicle
    if vehicle.guns and #vehicle.guns > 1 then
        -- assume last gun is best?
        --vehicle.guns = {vehicle.guns[#vehicle.guns]}
        -- assume first gun is best?
        vehicle.guns = {vehicle.guns[1]}
    end

    -- collision_box should be square otherwise it will get stuck during rotation
    vehicle.collision_box = vehicle.collision_box or {{0,0},{0,0}}
    local extent_min = math.min(-vehicle.collision_box[1][1], -vehicle.collision_box[1][2], vehicle.collision_box[2][1], vehicle.collision_box[2][2])
    vehicle.collision_box = {{-extent_min,-extent_min},{extent_min,extent_min}}
    vehicle.order = "z["..data_util.programmable_identifier.."]" -- make sure it's picked up in control.lua
    vehicle.subgroup = "cars"

    -- solid used for auto-vehicle mode base
    local solid = table.deepcopy(vehicle)
    solid.name = solid.name .. data_util.composite_suffix.."solid"
    solid.order = "z-z"
    solid.flags = solid.flags or {}
    table.insert(solid.flags, "player-creation")
    solid.resistances = solid.resistances or {}
    solid.has_belt_immunity = true
    --add_resistance(solid.resistances, {type = "impact", decrease = 200 }) -- immune to small bumps
    -- immune to bumps breaks the nudge anti-stuck function
    --add_resistance(solid.resistances, {type = "impact", percent = 99.5 }) -- take less damage (but not 0)
    --replace_resistance(solid.resistances, {type = "impact", percent = 99.99 }) -- take less damage (but not 0)
    data:extend{solid}

    -- ghost used for unit-mode base
    local ghost = table.deepcopy(vehicle)
    ghost.name = ghost.name .. data_util.composite_suffix.."ghost"
    ghost.collision_box = {{-0.0, -0.0}, {0.0, 0.0}}
    ghost.collision_mask = { "not-colliding-with-itself" }
    ghost.order = "z-z"
    ghost.has_belt_immunity = true
    data:extend{ghost}

    -- this is the ai driver
    local driver = table.deepcopy(data.raw.character.character)
    driver.crafting_categories = nil
    driver.loot_pickup_distance = 0
    driver.icon = vehicle.icon
    driver.icon_size = vehicle.icon_size or 32
    driver.icons = vehicle.icons
    driver.alert_when_damaged = true
    driver.selectable_in_game = false
    driver.localised_name = localised_name
    driver.name = vehicle.name .. data_util.composite_suffix.."driver"
    driver.character_corpse  = nil
    driver.collision_mask = { "not-colliding-with-itself" }

    data:extend{ driver }

    -- navigator - an invisible unit to direct the vehicle while in unit (move_to) mode
    local navigator_size = math.min(extent_min, 0.49)
    data:extend{
        {
            type = "unit",
            name = vehicle.name.. data_util.composite_suffix.."navigator",
            icon = vehicle.icon,
            icons = vehicle.icons,
            icon_size = vehicle.icon_size or 32,
            flags = {"placeable-neutral", "placeable-off-grid"},
            selectable_in_game = false,
            order="z-z",
            max_health = 1000000,
            healing_per_tick = 1000000,
            alert_when_damaged = false,
            selection_box = {{-1.0, -1.0}, {1.0, 1.0}},
            collision_box = {{-navigator_size,-navigator_size},{navigator_size,navigator_size}},
            --collision_mask = { "item-layer", "object-layer", "player-layer", "water-tile"},
            --collision_mask = { "item-layer", "object-layer", "water-tile"},
            vision_distance = 1,
            -- should be faster than vehicle speed. The vehicle holds it back
            movement_speed = 0.5,
            has_belt_immunity = true,
            distance_per_frame = 0.5,
            pollution_to_join_attack = 0.0,
            destroy_when_commands_fail = true,
            distraction_cooldown = 0,
            run_animation = (show_navigator and {
                    filename = "__aai-programmable-vehicles__/graphics/entity/debug-navigator.png",
                    width = 128,
                    height = 128,
                    frame_count = 1,
                    direction_count = 1,
                    } or {
                    filename = "__aai-programmable-vehicles__/graphics/blank.png",
                    width = 1,
                    height = 1,
                    frame_count = 1,
                    direction_count = 1,
                }),
            attack_parameters = {
                ammo_category = "melee",
                ammo_type = {
                    action = {
                        action_delivery = {
                            target_effects = {
                                damage = {
                                    amount = 10, -- the damage needs to be there to simulate drive-crushing damage otherwise unit gets stuck
                                    type = "laser"
                                },
                                type = "damage"
                            },
                            type = "instant"
                        },
                        type = "direct"
                    },
                    category = "melee",
                    target_type = "entity"
                },
                animation = {
                    filename = "__aai-programmable-vehicles__/graphics/blank.png",
                    width = 1,
                    height = 1 ,
                    frame_count = 1,
                    direction_count = 1,
                },
                cooldown = 30,
                range = 0.5,
                type = "projectile"
            },
            localised_name = localised_name
        }
    }

    -- buffer - an invisible object used to find open spaces and avoid getting stuck on things
    local buffer = extent_min * 1.5
    data:extend{
        {
            type = "simple-entity",
            name = vehicle.name.. data_util.composite_suffix.."buffer",
            icon = vehicle.icon,
            icons = vehicle.icons,
            icon_size = vehicle.icon_size or 32,
            flags = {"placeable-neutral", "placeable-off-grid"},
            subgroup = "grass",
            order = "z-z",
            collision_box = {{-buffer, -buffer}, {buffer, buffer}},
            collision_mask = vehicle.collision_mask or { "item-layer", "player-layer", "water-tile"},
            selection_box = {{-0.0, -0.0}, {0.0, 0.0}},
            selectable_in_game = false,
            render_layer = "resource",
            pictures = {{
                    filename = "__aai-programmable-vehicles__/graphics/blank.png",
                    width = 1,
                    height = 1
            }},
            localised_name = localised_name
        }
    }

    -- virtual signal: allows unit to be specified without confusion with inventory items (unit items)
    local original_icons = vehicle.icons or {{ icon = vehicle.icon, icon_size = vehicle.icon_size or 32 }}
    local signal_icons = {}

    table.insert(signal_icons, { icon = "__aai-programmable-vehicles__/graphics/icons/ids/id_background.png" })
    for _, original_icon in pairs(original_icons) do
      table.insert(signal_icons, original_icon)
    end
    table.insert(signal_icons, { icon = "__aai-programmable-vehicles__/graphics/icons/ids/id_overlay.png" })
    local virtual_signal = {
        type = "virtual-signal",
        name = vehicle.name.. data_util.composite_suffix.."signal",
        icons = signal_icons,
        icon_size = 32,
        subgroup = "vehicle-ids",
        order = "a[vehicle]",
        localised_name = { "vehicle-signal", localised_name}
    }

    data:extend{ virtual_signal }
end

function aai_make_ai_vehicles(vehicle)

  log( "aai_make_ai_vehicles: " .. vehicle.name )
  local a_entity = vehicle

  local valid_guns = {}
  if vehicle.guns then
    for _, gun in pairs(vehicle.guns) do
      if data.raw.gun[gun] then
        table.insert(valid_guns, gun)
        log( "aai_make_ai_vehicles gun: " .. gun )
      end
    end
  end
  if #valid_guns == 0 then
    valid_guns[1] = 0
  end
  log( "aai_make_ai_vehicles: " .. vehicle.name .. " valid guns: " .. #valid_guns )

  local a_item
  for _, item in pairs(data.raw["item-with-entity-data"]) do
    if item.place_result and item.place_result == a_entity.name then
      a_item = item
      break
    end
  end
  if not a_item then
    for _, item in pairs(data.raw.item) do
      if item.place_result and item.place_result == a_entity.name then
        a_item = item
        break
      end
    end
  end
  if not a_item then return end
  log( "aai_make_ai_vehicles: " .. vehicle.name .. " found item " .. a_item.name )

  local a_recipe
  for _, recipe in pairs(data.raw.recipe) do
    if (recipe.result and recipe.result == a_item.name)
      or (recipe.results and recipe.results[1] and (
        (recipe.results[1][1] and recipe.results[1][1]  == a_item.name)
        or (recipe.results[1].name and recipe.results[1].name == a_item.name)
      ))
      or (recipe.normal and recipe.normal.result and recipe.normal.result == a_item.name)
      or (recipe.normal and recipe.normal.results and recipe.normal.results[1] and (
        (recipe.normal.results[1][1] and recipe.normal.results[1][1] == a_item.name)
        or (recipe.normal.results[1].name and recipe.normal.results[1].name == a_item.name)
      )) then
        a_recipe = recipe
        break
    end
  end
  if not a_recipe then return end
  log( "aai_make_ai_vehicles: " .. vehicle.name .. " found recipe" )

  local a_tech
  for _, tech in pairs(data.raw.technology) do
    if tech.effects then
      for _, effect in pairs(tech.effects) do
          if effect.recipe and effect.recipe == a_recipe.name then
            a_tech = tech
            break
          end
      end
    end
    if a_tech then break end
  end
  if a_tech then
    log( "aai_make_ai_vehicles: " .. vehicle.name .. " found tech" )
  end

  -- modify a
  --a_entity.guns = { valid_guns[1] }
  --a_entity.localised_name = {"split-vehicle", {"entity-name.".. a_entity.name}, {"item-name."..valid_guns[1]}}
  --a_item.localised_name = {"split-vehicle", {"entity-name.".. a_entity.name}, {"item-name."..valid_guns[1]}}
  --a_item.localised_name = {"split-vehicle", {"item-name.".. a_item.name}, {"item-name."..valid_guns[1]}}
  -- recipe gets auto-named

  for i = 1, #valid_guns, 1 do
    local b_gun = valid_guns[i]
    log( "aai_make_ai_vehicles ai version: " .. vehicle.name .. " with " .. b_gun )
    local b_item = table.deepcopy(a_item)
    b_item.name = a_item.name .."-"..b_gun

    local original_icons = vehicle.icons or {{ icon = vehicle.icon, icon_size = vehicle.icon_size or 32 }}
    local item_icons = {}

    local base_icon_size = 32
    table.insert(item_icons, { icon = "__aai-programmable-vehicles__/graphics/blank.png", icon_size = base_icon_size })
    for _, original_icon in pairs(original_icons) do
      table.insert(item_icons, original_icon)
    end
    table.insert(item_icons, { icon = "__aai-programmable-vehicles__/graphics/icons/ai_overlay.png" })
    b_item.icons = item_icons
    b_item.icon_size = base_icon_size

    local b_recipe = {
      type = "recipe",
      name = b_item.name,
      category = "crafting",
      ingredients = {
        {a_item.name, 1},
        {"electronic-circuit", 1}
      },
      result = b_item.name,
      enabled = false,
      subgroup = "ai-vehicles",
      allow_as_intermediate = false,
    }
    b_recipe.icons = item_icons
    b_recipe.icon_size = base_icon_size

    local b_recipe_reverse = {
      type = "recipe",
      name = b_item.name.."-reverse",
      category = "crafting",
      ingredients = {
        {b_item.name, 1},
      },
      result = a_item.name,
      enabled = false,
      allow_as_intermediate = false,
      subgroup = "ai-vehicles-reverse",
      localised_name = {"remove-ai", {"entity-name.".. a_entity.name}}
    }


    local b_entity = table.deepcopy(a_entity)
    b_entity.name = b_entity.name .. "-" .. b_gun
    if b_gun == 0 or #valid_guns == 1 then
      b_item.localised_name = {"split-vehicle", {"entity-name.".. a_entity.name}}
      b_entity.localised_name = {"split-vehicle", {"entity-name.".. a_entity.name}}
    else
      b_entity.guns = { b_gun }
      b_item.localised_name = {"split-vehicle-with", {"entity-name.".. a_entity.name}, {"item-name."..b_gun}}
      b_entity.localised_name = {"split-vehicle-with", {"entity-name.".. a_entity.name}, {"item-name."..b_gun}}
    end
    b_entity.icons = item_icons
    b_entity.icon_size = base_icon_size

    b_item.place_result = b_entity.name

    local mine_item = settings.startup["aai-remove-ai-on-mine"].value and a_item or b_item

    if b_entity.minable then
      b_entity.minable.result = mine_item.name
    else
      b_entity.minable = { mining_time = 0.5, result = mine_item.name }
    end
    b_entity.placeable_by = {item = b_item.name, count=1}


    -- energy per hitpoint is the impact damage multiplier
    local multiplier = vehicle_impact_low
    if string.find(b_entity.name, "tank", 1, true) then
        multiplier = vehicle_impact_med -- tanks should deal some impact damage
    end
    if string.find(b_entity.name, "tumbler", 1, true) then
        multiplier = vehicle_impact_max -- ramming specialist should deal high damage
    end
    -- higher means deals less damage
    b_entity.energy_per_hit_point = (b_entity.energy_per_hit_point or 1) / multiplier

    if a_tech then
      table.insert(a_tech.effects, {
        type = "unlock-recipe",
        recipe = b_recipe.name
      })
      if not settings.startup["aai-remove-ai-on-mine"].value then
        table.insert(a_tech.effects, {
          type = "unlock-recipe",
          recipe = b_recipe_reverse.name
        })
        data:extend({b_recipe_reverse})
      end
    end
    data:extend({b_entity, b_item, b_recipe})

    make_composite_unit_from_vehicle(b_entity)
  end
end

local vehicles_to_process = {}
for _,vehicle in pairs(data.raw.car) do -- beware loop
    if (not string.find(vehicle.name, data_util.composite_suffix, 1, true))
    and (not string.find(vehicle.order or "", "no-aai", 1, true)) then
      if data_util.table_contains(aai_vehicle_exclusions, vehicle.name) then
        log("Exclude vehicle from programmable AI: " .. vehicle.name)
      else
        table.insert(vehicles_to_process, vehicle)
      end
    end
end

for _, vehicle in pairs(vehicles_to_process) do
  aai_make_ai_vehicles(vehicle)
end
