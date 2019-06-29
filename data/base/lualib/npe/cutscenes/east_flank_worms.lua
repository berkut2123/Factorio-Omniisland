local cutscene = require(mod_name .. '.lualib.cutscene')
local locations = require(mod_name .. '.lualib.locations')
local colony_controller = require(mod_name .. '.lualib.colony_controller')
local eastern_cutscene_biters = require(mod_name .. '.lualib.npe.eastern_cutscene_biters')

local east_flank_worms = {}

 east_flank_worms.generate_cutscene = function()
  local story_nodes =
  {
    {
      name = "east_flank_worms-init",
      init = function()

        local east_worm_biters = eastern_cutscene_biters.get_east_flank_worm_group(6)
        east_worm_biters.set_command {
          type = defines.command.compound,
          structure_type = defines.compound_command.return_last,
          commands = {
            {
              type = defines.command.go_to_location,
              destination = locations.get_pos('cutscene-east-worms'),
              radius = 1,
              distraction = defines.distraction.none,
            },
            {
              type = defines.command.wander,
              radius = 1,
              distraction = defines.distraction.none,
            }
          }
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
              name = "pan_to_player"
            },
            {
              position = "target-4",
              transition_time = 60 * 1,
              time_to_wait = 60 * 1,
              zoom = 1,
              name = "copper_patch_view_one"
            },
            {
              position = "cutscene-east-worms",
              transition_time = 60 * 1,
              time_to_wait = 60 * 20,
              zoom = 1,
              name = "start_attack"
            },
            {
              position = "target-4",
              transition_time = 60 * 1,
              time_to_wait = 60 * 1,
              zoom = 1,
              name = "copper_patch_view_two"
            },
            {
              position = main_player().position,
              transition_time = 60 * 1.5,
              time_to_wait = 0,
              zoom = zoom
            },
          },

          final_transition_time = 60 * 1.5
        }

        cutscene.play(scene)
      end,

      condition = function()
        return cutscene.get_last_waypoint_reached_name() == "copper_patch_view_one"
      end
    },
    {
      name = " east_flank_worms-start_attack",
      condition = function()
        local biters_in_target = locations.get_main_surface().find_entities_filtered({
          name = 'small-biter',
          area = locations.get_area('colony-east-mid')
        })
        return not cutscene.is_any_cutscene_playing() or #biters_in_target > 0 or
          cutscene.get_last_waypoint_reached_name() == "start_attack"
      end,
      action = function()
        local group = eastern_cutscene_biters.get_east_flank_worm_group(6)
        for _, biter in pairs(group.members) do
          colony_controller.send_to_area(biter,locations.get_area('colony-east-mid'),1200)
        end
        colony_controller.register('colony-east-mid',0,1,'enemy',true)
        colony_controller.set_fast_mode(true)
      end
    },
    {
      name = " east_flank_worms-arrived",
      condition = function()
        local worms_in_target = locations.get_main_surface().find_entities_filtered({
          name = 'small-worm-turret',
          area = locations.get_area('colony-east-mid')
        })
        return not cutscene.is_any_cutscene_playing() or #worms_in_target > 0 or
          cutscene.get_last_waypoint_reached_name() == "copper_patch_view_two"
      end,
      action = function()
        colony_controller.deregister('colony-east-mid')
      end
    },
    {
      name = " east_flank_worms-final",
      condition = function()
        return not cutscene.is_any_cutscene_playing()
      end,
      action = function()

        colony_controller.set_fast_mode(false)
        colony_controller.register('colony-east-top',1,3,'enemy')
        colony_controller.register('colony-east-mid',1,3,'enemy')
        colony_controller.register('colony-east-bottom',1,3,'enemy')
      end
    }
  }

  return story_nodes
end

return  east_flank_worms