local cutscene = require(mod_name .. '.lualib.cutscene')
local effects = require(mod_name .. '.lualib.effects')
local locations = require(mod_name .. '.lualib.locations')
local colony_controller = require(mod_name .. '.lualib.colony_controller')
local eastern_cutscene_biters = require(mod_name .. '.lualib.npe.eastern_cutscene_biters')

local biters_close_in = {}

biters_close_in.generate_cutscene = function()
  local story_nodes =
  {
    {
      name = "biters_close_in-init",
      init = function()

        local close_in_biters = eastern_cutscene_biters.get_close_in_group(6)
        close_in_biters.set_command
        {
          type = defines.command.wander,
          distraction = defines.distraction.none,
          wander_in_group = true,
        }

        local zoom = 0.5

        local scene =
        {
          type=defines.controllers.cutscene,
          waypoints=
          {
            {
              position = main_player().position,
              zoom = zoom,
              transition_time = 60 * 1.5,
              time_to_wait = 0,
            },
            {
              position = "spawn-1",
              transition_time = 60 * 2.5,
              time_to_wait = 60 * 1,
              zoom = zoom,
              name = "pan_to_biters"
            },
            {
              position = "spawn-1",
              transition_time = 60 * 1,
              time_to_wait = 60 * 1,
              zoom = 1,
              name = "zoom_in_on_biters"
            },
            {
              position = "spawn-1",
              transition_time = 60 * 1,
              time_to_wait = 60 * 0,
              zoom = 1,
              name = "start_attack"
            },
            {
              target = close_in_biters,
              transition_time = 60 * 0.5,
              time_to_wait = 60 * 7,
              zoom = 1,
            },
            {
              position = 'rally-6',
              transition_time = 60 * 3,
              time_to_wait = 60 * 5,
              zoom = 1,
            },
            {
              position = 'rally-6',
              transition_time = 60 * 1,
              time_to_wait = 0,
              zoom = zoom,
            },
            {
              position = main_player().position,
              transition_time = 60 * 1.5,
              time_to_wait = 0,
              zoom = zoom
            }
          },

          final_transition_time = 60 * 1.5
        }

        cutscene.play(scene)
      end,

      condition = function()
        return cutscene.get_last_waypoint_reached_name() == "pan_to_biters"
      end
    },
    {
      name = "biters_close_in-start_attack",

      init = function()
        local group = eastern_cutscene_biters.get_close_in_group(6)

        local bait = group.surface.create_entity
        {
          name = 'bait-chest',
          force = "player",
          position = group.position
        }
        group.set_command
        {
          type = defines.command.attack,
          target = bait
        }
      end,

      condition = function()
        return cutscene.get_last_waypoint_reached_name() == "start_attack"
      end
    },
    {
      name = "biters_close_in-follow_biters",

      init = function()
        -- TODO: have the worms roar and wiggle
        --locations.get_main_surface().play_sound{path="worm-sends-biters"}

        local group = eastern_cutscene_biters.get_close_in_group(6)
        local target = locations.get_surface_ent_from_tag(locations.get_main_surface(), "mid-wreckage")
        target.force = game.forces.player
        effects.attack_ent_with_group_via_rally(group,target,'rally-6','rally-6')
        colony_controller.register('colony-wreck-mid',0,2,'peaceful',true)
        colony_controller.set_fast_mode(true)

      end,
    },
    {
      name = "biters_close_in-finish-attack",
      condition = function()
        local target = locations.get_surface_ent_from_tag(locations.get_main_surface(), "mid-wreckage")
        return target == nil
      end,
      action = function()
        local group = eastern_cutscene_biters.get_close_in_group(6)
        for _, biter in pairs(group.members) do
          colony_controller.send_to_area(biter,locations.get_area('colony-wreck-mid'),1200)
        end
      end
    },
    {
      name = "biters_close_in-final",
      condition = function()
        return not cutscene.is_any_cutscene_playing()
      end,
      action = function()
        colony_controller.set_fast_mode(false)
        local group = eastern_cutscene_biters.get_advance_group(3)
        for _, biter in pairs(group.members) do
          colony_controller.send_to_area(biter,locations.get_area('colony-crash-west'),12000)
        end
      end
    }
  }

  return story_nodes
end

return biters_close_in