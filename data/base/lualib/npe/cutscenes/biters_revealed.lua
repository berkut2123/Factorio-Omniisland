local cutscene = require(mod_name .. '.lualib.cutscene')
local expansions = require(mod_name .. '.lualib.npe.expansions')
local effects = require(mod_name .. '.lualib.effects')
local locations = require(mod_name .. '.lualib.locations')
local eastern_cutscene_biters = require(mod_name .. '.lualib.npe.eastern_cutscene_biters')
local colony_controller = require(mod_name .. '.lualib.colony_controller')
local util = require('util')

local biters_revealed = {}

biters_revealed.generate_cutscene = function()
  local story_nodes =
  {
    {
      name = "biters_revealed-init",
      init = function()
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
              position = 'spawn-1',
              transition_time = 60 * 2.5,
              time_to_wait = 60 * 2.5,
              zoom = 0.5,
              name = "pan_to_biters"
            },
            {
              position = 'biter-wreckage',
              transition_time = 60 * 1,
              time_to_wait = 60 * 15,
              zoom = 1,
              name = "biters_attack"
            },
            {
              position = 'biter-wreckage',
              transition_time = 60 * 1,
              time_to_wait = 0,
              zoom = 0.5,
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

        local expansion = util.table.deepcopy(expansions['west-expansion'])
        expansion.waypoints_after = scene.waypoints
        expansion.final_transition_time = scene.final_transition_time

        effects.expand_map(expansion)
        colony_controller.register_spawn_area('spawn-west')
      end,

      condition = function()
        return cutscene.get_last_waypoint_reached_name() == "zoom_in_on_player"
      end
    },
    {
      name = "biters_revealed-pan_to_biters",
      init = function()
        -- Create the biters now, to send for attack later
        eastern_cutscene_biters.get_scout_group(3)
      end,
      condition = function()
        return cutscene.get_last_waypoint_reached_name() == "pan_to_biters"
      end,
      action = function()
        colony_controller.register('colony-wreck-far',0,1,'peaceful',true)
        colony_controller.set_fast_mode(true)
      end
    },
    {
      name = "biters_revealed-biters_attack",
      init = function()
        local group = eastern_cutscene_biters.get_scout_group()
        local target = locations.get_surface_ent_from_tag(locations.get_main_surface(), "close-wreckage")
        target.force = game.forces.player
        effects.attack_ent_with_group_via_rally(group,target,'rally-5','rally-5')
      end,
       condition = function()
        return cutscene.get_last_waypoint_reached_name() == "biters_attack"
      end,
      action = function()

      end
    },
    {
      name = "biters_revealed-final",
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

return biters_revealed