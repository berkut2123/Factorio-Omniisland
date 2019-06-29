local locations = require(mod_name .. '.lualib.locations')
local quest_gui = require(mod_name .. '.lualib.quest_gui')
local trigger = require(mod_name .. '.lualib.trigger')
local effect = require(mod_name .. '.lualib.effects')
local cutscene = require(mod_name .. '.lualib.cutscene')
local compi = require(mod_name .. '.lualib.compi')
local function_save = require(mod_name .. '.lualib.function_save')
local misc = require(mod_name .. '.lualib.misc')
local check = require(mod_name .. '.lualib.check')
local attacks = require(mod_name .. '.lualib.attacks')
local technology_manager = require(mod_name .. '.lualib.technology_manager')
local story = require('story_2')


local base_controller = {}

local bases_list -- initialised in on_load
local base_controller_data = {
  base_stages = {}
}


local check_set_up = function()
  if bases_list == nil then
    error("trying to use base_controller before it has been set up by on_load!")
  end
end

base_controller.get_cutscene_show_full_base_parameters = function(base_name, player)
  check_set_up()

  local base_data = bases_list[base_name]
  return misc.get_cutscene_show_area_parameters(locations.get_area(base_data.perimeter), player.display_resolution)
end

base_controller.generate_mainframe_story_nodes = function(base_name)
  check_set_up()

  local base_data = bases_list[base_name]

  local base_powered = function()
    local lamp_1 = locations.get_surface_ent_from_tag(locations.get_main_surface(), base_data.lamp_1)
    local lamp_2 = locations.get_surface_ent_from_tag(locations.get_main_surface(), base_data.lamp_2)

    return lamp_1.energy > 0 or lamp_2.energy > 0
  end

  local connect_power =
  {
    name = base_name .. "_connect_power",

    init = function()
      local quest_layout =
      {
        {
          item_name = 'power-' .. base_name,
          icons = {'utility/electricity_icon'},
        },
      }

      if base_data.feed then
        for _, item in pairs(base_data.feed) do
          local item_to_feed = item[2]
          local amount = item[3]

          table.insert(quest_layout,
            {
              item_name = 'consume-' .. item_to_feed,
              icons = {'item/' .. item_to_feed},
              goal = amount
            })
        end
      end
      effect.discover_technologies(base_data.override_tech)
      quest_gui.set('power-' .. base_name, quest_layout)
    end,

    condition = function()
      local powered = base_powered()

      if powered then
        quest_gui.update_state('power-' .. base_name, 3)
      else
        quest_gui.update_state('power-' .. base_name, 1)
      end

      local feed_done = true
      for _, item in pairs(base_data.feed) do
        local feeder = item[1]
        local item_to_feed = item[2]
        local amount = item[3]

        if not check.items_fed_in(feeder, {{name = item_to_feed, goal = amount}}) then
          feed_done = false
        end
      end

      return powered and feed_done
    end,

    action = function()
      quest_gui.unset()
    end
  }

  local go_to_mainframe =
  {
    name = base_name .. "_go_to_mainframe",

    init = function()
      trigger.add_trigger('base_trigger_' .. base_name, locations.get_area(base_data.trigger))

      local quest_layout =
      {
        {
          item_name = 'go-to-mainframe-' .. base_name,
          icons = {'utility/electricity_icon'},
        },
      }

      quest_gui.set('override-' .. base_name, quest_layout)
    end,

    update = function()
      local still_powered = base_powered()
      if not still_powered then
        trigger.remove_trigger('base_trigger_' .. base_name)
        story.jump_to_node('main_story', base_name .. '_connect_power')
      end
    end,

    condition = function()
      local triggered = trigger.is_trigger_done('base_trigger_' .. base_name, true)
      return triggered
    end,

    action = function()
      quest_gui.unset()
    end
  }

  local compi_override_mainframe_1 =
  {
    name = base_name .. "_override_mainframe_1",

    init = function()
      attacks.pause()
      local switch_pos = locations.get_surface_ent_from_tag(locations.get_main_surface(), base_data.switch).position
      switch_pos.x = switch_pos.x - 1
      switch_pos.y = switch_pos.y + 1


      compi.walk_to(switch_pos)
      compi.set_direction(defines.direction.northeast)

      for _, player in pairs(game.connected_players) do
        local show_base_params = base_controller.get_cutscene_show_full_base_parameters(base_name, player)

        local activate_mainframe_cutscene =
        {
          type=defines.controllers.cutscene,
          waypoints =
          {
            {
              target = global.compilatron.entity,
              zoom = 1.5,
              transition_time = 60 * 1,
              time_to_wait = 60 * 1
            },
            {
              target = global.compilatron.entity,
              zoom = 2,
              transition_time = 60 * 1,
              time_to_wait = 0
            },
            {
              target = global.compilatron.entity,
              zoom = 2,
              transition_time = 0,
              time_to_wait =  60 * 2
            },
            {
              target = global.compilatron.entity,
              zoom = 2,
              transition_time = 0,
              time_to_wait =  60 * 2
            },
            {
              position = show_base_params.position,
              transition_time = 60 * 1,
              time_to_wait = 60 * 3,
              zoom = show_base_params.zoom
            },
            {
              position = show_base_params.position,
              transition_time = 0,
              time_to_wait = 60 * 5,
              zoom = show_base_params.zoom
            }
          },
          final_transition_time = 60 * 2
        }

        cutscene.play(activate_mainframe_cutscene, {player})
      end
    end,

    condition = function()
      return cutscene.get_last_waypoint_reached() == 1
    end
  }

  local compi_override_mainframe_2 =
  {
    name = base_name .. "_override_mainframe_2",

    init = function()
      compi.say("Initialising Mainframe...")
    end,

    condition = function()
      return cutscene.get_last_waypoint_reached() == 2
    end
  }

  local compi_override_mainframe_3 =
  {
    name = base_name .. "_override_mainframe_3",

    init = function()
      compi.set_direction()
      compi.say("Mainframe Initialised")
    end,

    condition = function()
      return cutscene.get_last_waypoint_reached() == 3
    end,

    action = function()
      compi.say()
    end
  }

  local compi_override_mainframe_4 = {
    name = base_name .. "_override_mainframe_4",

    init = function()
      local base_area = locations.get_area(base_data.perimeter)
      local tiles = locations.get_main_surface().find_tiles_filtered { area = base_area, name = "refined-hazard-concrete-right" }

      local tile_lines_tmp = {}
      for _, tile in pairs(tiles) do
        if tile_lines_tmp[tile.position.x] == nil then
          tile_lines_tmp[tile.position.x] = {}
        end
        table.insert(tile_lines_tmp[tile.position.x], tile)
      end

      local tile_lines = {}
      for _, line in pairs(tile_lines_tmp) do
        table.insert(tile_lines, line)
      end

      table.sort(tile_lines, function(a, b)
        return a[1].position.x > b[1].position.x
      end)

      local tick = game.tick + 60 * 1

      local time = 60 * 2.5
      local step = time / #tile_lines

      for _, line in pairs(tile_lines) do
        function_save.run_at_tick(math.floor(tick), "convert_tiles", line)
        tick = tick + step
      end
    end,

    condition = function()
      return cutscene.get_last_waypoint_reached() == 4
    end
  }

  local compi_override_mainframe_5 =
  {
    name = base_name .. "_override_mainframe_5",

    init = function()
      local switch = locations.get_surface_ent_from_tag(locations.get_main_surface(), base_data.switch)
      switch.power_switch_state = true
      locations.get_main_surface().play_sound{path="mainframe-activated"}
    end,

    condition = function()
      return not cutscene.is_any_cutscene_playing()
    end,

    -- Convert base entities to player force and unlock tech
    action = function()
      attacks.resume()
      base_controller.unlock_area(base_data.perimeter)
      effect.unlock_technologies(base_data.override_tech)
      if base_data.outer_areas then
        for _, area_name in pairs(base_data.outer_areas) do
          base_controller.unlock_area(area_name)
        end
      end
    end,
  }

  return {
    connect_power,
    go_to_mainframe,
    compi_override_mainframe_1,
    compi_override_mainframe_2,
    compi_override_mainframe_3,
    compi_override_mainframe_4,
    compi_override_mainframe_5
  }
end


local convert_tiles = function(tiles)
  local set_tiles_data = {}
  for _, tile in pairs(tiles) do
    table.insert(set_tiles_data, {name = "refined-concrete", position = tile.position})
  end

  locations.get_main_surface().set_tiles(set_tiles_data)
  locations.get_main_surface().play_sound{path="entity-build/substation"}
end
function_save.add_function("convert_tiles", convert_tiles)


base_controller.unlock_area = function(area_name)
  local entities = locations.get_main_surface().find_entities_filtered{ area = locations.get_area(area_name) }

  for _, entity in pairs(entities) do
    if entity.force.name == 'pre-placed' or entity.force.name == 'train-gate' then
      if entity.name == 'assembling-machine-1' or
        entity.name == 'assembling-machine-2' or
        entity.name == 'assembling-machine-3' then
        entity.recipe_locked = false
      end

      if entity.prototype.name == "gate" then
        entity.operable = true
      end

      if entity.operable then
        entity.force = "player"
        entity.minable = true
        entity.rotatable = true
        entity.active = true
        entity.destructible = true
      end
    end
  end
end

base_controller.init = function(bases)
  global.base_controller_data = base_controller_data
  bases_list = bases
end

base_controller.on_load = function(bases)
  bases_list = bases
  base_controller_data = global.base_controller_data or base_controller_data
end

local check_data = function()
  for _, base in pairs(bases_list) do
    if locations.get_area(base.perimeter) == nil then
      error("base_controller: cant find perimeter area - "..base.perimeter)
    end
    if locations.get_area(base.trigger) == nil then
      error("base_controller: cant find trigger area - "..base.trigger)
    end
    if locations.get_pos(base.compi_spawn) == nil then
      error("base_controller: cant find compi spawn point - "..base.compi_spawn)
    end
    if locations.get_pos(base.compi_stand) == nil then
      error("base_controller: cant find compi stand point - "..base.compi_stand)
    end
    if base.override_tech and not technology_manager.tech_level_exists(base.override_tech) then
      error("base_controller: invalid techlevel - " .. base.override_tech)
    end
    if not locations.get_surface_ent_from_tag(locations.get_template_surface(), base.lamp_1) then
      error("base_controller: lamp missing - " .. base.lamp_1)
    end
    if not locations.get_surface_ent_from_tag(locations.get_template_surface(), base.lamp_2) then
      error("base_controller: lamp missing - " .. base.lamp_2)
    end
    if not locations.get_surface_ent_from_tag(locations.get_template_surface(), base.switch) then
      error("base_controller: switch missing - " .. base.switch)
    end
    if base.outer_areas then
      for _, area in pairs(base.outer_areas) do
        if locations.get_area(area) == nil then
          error("base_controller: invalid outer area - " .. area)
        end
      end
    end
  end
end

local check_data_done = false
local on_tick = function()
  -- We check data here because we need to access the 'game' object, which is not available in on_load
  if campaign_debug_mode and not check_data_done then
    check_data()
    check_data_done = true
  end
end

base_controller.events = {[defines.events.on_tick] = on_tick}

return base_controller

