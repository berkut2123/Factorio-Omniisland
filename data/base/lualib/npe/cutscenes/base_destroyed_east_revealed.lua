local cutscene = require(mod_name .. '.lualib.cutscene')
local expansions = require(mod_name .. '.lualib.npe.expansions')
local effects = require(mod_name .. '.lualib.effects')
local locations = require(mod_name .. '.lualib.locations')
local eastern_cutscene_biters = require(mod_name .. '.lualib.npe.eastern_cutscene_biters')
local colony_controller = require(mod_name .. '.lualib.colony_controller')
local command_callback = require(mod_name .. '.lualib.command_callback')
local math2d = require('math2d')
local util = require('util')

local base_destroyed_east_revealed = {}

local colonies =
{
  'crashsite-nest-1',
  'crashsite-nest-2',
  'crashsite-nest-3',
  'crashsite-nest-4'
}

local on_biters_arrived_at_base = function(_, colonise_group)
  -- The biters arrived, split up their group and have them all attack random targets for a while

  local biters = colonise_group.members
  colonise_group.destroy()

  effects.swap_forces(locations.get_area('starting-area'), 'player', 'bystander', true)
  local _targets = effects.get_entities_to_swap_forces(locations.get_area('starting-area'), 'bystander', true)

  -- only attack targets that can be derstroyed
  local targets = {}
  for _, target in pairs(_targets) do
    if target.health then
      target.destructible = true
      table.insert(targets, target)
    end
  end

  local target_index = 1
  local colony_index = 1

  for _, biter in pairs(biters) do
    local target = targets[target_index]

    target_index = target_index + 1
    if target_index > #targets then
      target_index = 1
    end

    colony_index = colony_index + 1
    if colony_index > #colonies then
      colony_index = 1
    end

    biter.set_command
    {
      type = defines.command.attack,
      target = target,
      distraction = defines.distraction.none
    }
  end
end
command_callback.add_callback("on_biters_arrived_at_base", on_biters_arrived_at_base)

local force_biters_into_bases = function()
  local biters_in_starting_area =  locations.get_main_surface().find_entities_filtered
  {
    force = 'enemy',
    type = "unit",
    area = locations.get_area('starting-area')
  }

  local free_biters = {}
  for _, biter in pairs(biters_in_starting_area) do

    local in_any_area = false
    for _, colony in pairs(colonies) do
      if math2d.bounding_box.contains_point(locations.get_area(colony), biter.position) then
        in_any_area = true
      end
    end

    if not in_any_area then
      table.insert(free_biters, biter)
    end
  end

  local colony_index = 1
  for _, biter in pairs(free_biters) do
    colony_index = colony_index + 1
    if colony_index > #colonies then
      colony_index = 1
    end

    biter.set_command
    {
      type = defines.command.compound,
      structure_type = defines.compound_command.return_last,
      commands =
      {
        {
          type = defines.command.go_to_location,
          destination = math2d.bounding_box.get_centre(locations.get_area(colonies[colony_index])),
          distraction = defines.distraction.none
        },
        {
          type = defines.command.wander,
          radius = 3,
          distraction = defines.distraction.by_anything
        },
      }
    }
  end
end

base_destroyed_east_revealed.generate_cutscene = function()
  local story_nodes =
  {
    {
      name = "base_destroyed_east_revealed-init",
      init = function()
        -- These look weird if they just hang around and dont participate, so just remove them, it easier than having them join in
        eastern_cutscene_biters.destroy_all()

        -- Create the biters now, to send for attack later
        local spawn_pos = locations.get_pos('spawn-1')
        global.colonise_group = effects.spawn_biters(100, spawn_pos, 'enemy', 'small-biter', true)

        local scene =
        {
          waypoints =
          {
            {
              position = main_player().position,
              transition_time = 60 * 2,
              time_to_wait = 0,
              zoom = 0.5,
              name = "zoom_in_on_player"
            },
            {
              target = global.colonise_group,
              transition_time = 60 * 2,
              time_to_wait = 0,
              zoom = 0.5,
              name = "pan_to_biters"
            },
            {
              target = global.colonise_group,
              transition_time = 0,
              time_to_wait = 60 * 8,
              zoom = 0.5,
              name = "biters_move_to_base"
            },
            {
              position = 'crash-site',
              transition_time = 60 * 7,
              time_to_wait = 60 * 15,
              zoom = 0.5,
              name = "biters_eat_base"
            },
            {
              position = 'crash-site',
              transition_time = 0,
              time_to_wait = 60 * 20,
              zoom = 0.5,
              name = "biters_colonise"
            },
            {
              position = main_player().position,
              transition_time = 60 * 2.5,
              time_to_wait = 0,
              zoom = 0.5,
            },
          },

          final_transition_time = 60 * 1.5
        }

        local expansion = util.table.deepcopy(expansions['east-expansion'])
        expansion.waypoints_after = scene.waypoints
        expansion.final_transition_time = scene.final_transition_time
        local safe_place = locations.get_main_surface().find_non_colliding_position_in_box('character',
          locations.get_area('exit-right'),1)
        main_player().teleport(safe_place)
        effects.expand_map(expansion)
      end,

      condition = function()
        return cutscene.get_last_waypoint_reached_name() == "pan_to_biters"
      end
    },
    {
      name = "base_destroyed_east_revealed-biters-attack-base",
      init = function()
        local go_to_base_command =
        {
            type = defines.command.go_to_location,
            destination = locations.get_pos('exit-left'),
            distraction = defines.distraction.none
        }

        command_callback.set_command(global.colonise_group, go_to_base_command, "on_biters_arrived_at_base")
        global.colonise_group = nil
      end,

      condition = function()
        return cutscene.get_last_waypoint_reached_name() == "biters_eat_base"
      end
    },
    {
      name = "base_destroyed_east_revealed-biters-colonise",

      init = function()
        for _, colony in pairs(colonies) do
          colony_controller.register(colony, 1, 2)
        end
        colony_controller.set_fast_mode(true)
      end,

      update = function()
        if game.tick % 60 ~= 0 then
          return
        end

        -- continually send unoccupied biters to make bases
        force_biters_into_bases()
      end,

       condition = function()
        return cutscene.get_last_waypoint_reached_name() == "biters_colonise"
      end
    },
    {
      name = "base_destroyed_east_revealed-final",
      condition = function()
        return not cutscene.is_any_cutscene_playing()
      end,

      action = function()
        colony_controller.set_fast_mode(false)
      end
    }
  }

  return story_nodes
end

return base_destroyed_east_revealed