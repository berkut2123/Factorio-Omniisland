local locations = require(mod_name .. '.lualib.locations')
local cutscene = require(mod_name .. '.lualib.cutscene')
local compi = require(mod_name .. '.lualib.compi')
local misc = require(mod_name .. '.lualib.misc')
local function_save = require(mod_name .. '.lualib.function_save')
local helper_story = require(mod_name .. '.lualib.npe.helper_story')
local math2d = require('math2d')

local compi_build_iron_cutscene = {}



local tell_player_done_building = function()
  compi.walk_to(math2d.bounding_box.get_centre(locations.get_area('compi-trigger-cutscene-crash')))
  compi.say_later({"compi.story-automation-complete"})
end
function_save.add_function('tell_player_done_building', tell_player_done_building)

compi_build_iron_cutscene.generate_cutscene = function()

  local build_iron_cutscene_nodes =
  {
    {
      name = 'compi-builds-iron-1',

      init = function()
        helper_story.set_paused(true)

        for _, player in pairs(game.connected_players) do

          local iron_area = locations.get_area('iron-patch-construction')
          local show_iron_area_params = misc.get_cutscene_show_area_parameters(iron_area, player.display_resolution, 10)

          local compi_cutscene = {
            type = defines.controllers.cutscene,
            waypoints =
            {
              {
                position = player.position,
                zoom = show_iron_area_params.zoom,
                transition_time = 60 * 1,
                time_to_wait = 60 * 0,
                name = "zoom_out"
              },
              {
                position = show_iron_area_params.position,
                zoom = show_iron_area_params.zoom,
                transition_time = 60 * 2,
                time_to_wait = 60 * 15,
              },
              {
                position = player.position,
                zoom = show_iron_area_params.zoom,
                transition_time = 60 * 2,
                time_to_wait = 60 * 2
              }
            },
            final_transition_time = 60 * 1
          }

          cutscene.play(compi_cutscene, { player })
        end
      end,

      condition = function()
        return cutscene.get_last_waypoint_reached_name() == "zoom_out"
      end
    },

    {
      name = 'compi-builds-iron-2',
      init = function()
        compi.build_area('iron-patch-construction', {force = 'bystander'})
        global.compi_build_completed_callback = "tell_player_done_building"
        compi.compi_build_callback()
      end,

      condition = function()
        return not cutscene.is_any_cutscene_playing()
      end
    },

    {
      name = 'compi-builds-iron-cleanup',
      init = function()
        helper_story.set_paused(false)
        global.compilatron.reset = true
      end,
    }
  }

  return build_iron_cutscene_nodes
end

return compi_build_iron_cutscene