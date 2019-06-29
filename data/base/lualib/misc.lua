local math2d = require("math2d")
local locations = require(mod_name .. '.lualib.locations')
local tracker = require(mod_name .. ".lualib.player_tracker")
local story = require("story_2")

local misc = {}

local misc_update_data =
{
  radar_has_scanned_a_sector = false
}

misc.init = function()
  global.misc_update_data = misc_update_data
end

misc.on_load = function()
  misc_update_data = global.misc_update_data or misc_update_data
end

local assess_player = function()
  local notes = {}
  local expected_skill = 0

  if tracker.times_observed('used_quick_take') < 2 then
    table.insert(notes,'never used quick take')
  elseif tracker.times_observed('used_quick_take') < 20 then
    table.insert(notes,'used quick take sparingly')
  elseif tracker.times_observed('used_quick_take') > tracker.times_observed('opened_ent') then
    table.insert(notes,'used quick take prominently')
    expected_skill = expected_skill + 2
  else
    table.insert(notes,'used quick take')
    expected_skill = expected_skill + 1
  end

  if tracker.was_observed('used_quick_take_furnace') then
    table.insert(notes,'applied knowledge: used quick take on a furnace')
    expected_skill = expected_skill + 1
  end

  if tracker.was_observed('used_quick_take_am') then
    table.insert(notes,'applied knowledge: used quick take on an assembling machine')
    expected_skill = expected_skill + 1
  end

  if tracker.was_observed('electric-inserter_finished') and
     (tracker.first_observed('electric-inserter_finished') < tracker.first_observed('basic-mapping_finished')) then
    table.insert(notes,'researched optional tech first: electric-inserter')
  end

  if tracker.was_observed('electric-mining_finished') and
     (tracker.first_observed('electric-mining_finished') < tracker.first_observed('improved-equipment_finished')) then
    table.insert(notes,'researched optional tech first: electric-mining')
  end

  if tracker.first_observed('picked_up_item') < tracker.first_observed('gear_has_been_fed') then
    table.insert(notes,'used mechanic early: pickup item')
    expected_skill = expected_skill + 2
  end

  if tracker.first_observed('used_alt_mode') < tracker.first_observed('gear_has_been_fed') then
    table.insert(notes,'used mechanic early: alt mode')
    expected_skill = expected_skill + 2
  end

  if tracker.was_observed('used_quick_put') then
    table.insert(notes,'used untaught mechanic: quick put')
    expected_skill = expected_skill + 1
  end

  if tracker.times_observed('used_pipette') > 4 then
    table.insert(notes,'used untaught mechanic: pipette')
    expected_skill = expected_skill + 3
  end

  if tracker.was_observed('player_attacked_with_pickaxe') then
    table.insert(notes,'used untaught mechanic: melee attack')
    expected_skill = expected_skill + 3
  end

  if tracker.times_observed('used_copy_paste') > 1 then
    table.insert(notes,'used untaught mechanic: settings copy')
    expected_skill = expected_skill + 3
  end

  return notes, expected_skill
end

misc.radar_has_scanned_a_sector = function()
  return misc_update_data.radar_has_scanned_a_sector
end

local on_sector_scanned = function()
  misc_update_data.radar_has_scanned_a_sector = true
end


-- TODO: expose these through LuaDefines
misc.tile_size = 32
misc.chunk_size = 32


-- Figures out the zoom level you need to display a certain area in a cutscene
misc.get_cutscene_show_area_parameters = function(area, resolution, zoom_padding_tiles, position)
  zoom_padding_tiles = zoom_padding_tiles or 5
  position = position or math2d.bounding_box.get_centre(area)

  local horizontal_needed_tiles = math.max(math.abs(area.right_bottom.x - position.x),
                                           math.abs(area.left_top.x - position.x))
  local horizontal_zoom_level = resolution.width /
                                ((horizontal_needed_tiles + zoom_padding_tiles) * misc.tile_size * 2)

  local vertical_needed_tiles = math.max(math.abs(area.right_bottom.y - position.y),
                                         math.abs(area.left_top.y - position.y))
  local vertical_zoom_level = resolution.height /
                              ((vertical_needed_tiles + zoom_padding_tiles) * misc.tile_size * 2)

  local zoom = math.min(horizontal_zoom_level, vertical_zoom_level)

  return {position = position, zoom = zoom}
end

misc.generate_screenshot_area_node = function(campaign_name, area_name, title)
  local node =
  {
    name = "screenshot_area_" .. title,

    init = function()
      if global.playthrough_number == nil then
        global.playthrough_number = game.forces.player.item_production_statistics.get_input_count('pollution') +
          game.forces.player.item_production_statistics.get_input_count('iron-ore')
      end
      if global.expected_skill == nil then
        _, global.expected_skill = assess_player()
      end

      global.saved_daytime = locations.get_main_surface().daytime
      locations.get_main_surface().daytime = 0
      misc.render_stats_to_area(area_name)
      local area = locations.get_area(area_name)
      local resolution = {width = 4096, height = 4096}
      local show_params = misc.get_cutscene_show_area_parameters(area, resolution, 0)
      game.take_screenshot
      {
        position = show_params.position,
        zoom = show_params.zoom,
        resolution={resolution.width, resolution.height},
        show_gui=false,
        show_entity_info=true,
        path = "campaign_base_screenshots/" ..  campaign_name .. '_' .. global.expected_skill .. '_' ..
          global.playthrough_number ..  "_" .. title  .. '.jpg'
      }
    end,
    condition = function()
      return story.check_seconds_passed("main_story",1)
    end,
    action = function()
      locations.get_main_surface().daytime = global.saved_daytime
      misc.destroy_render_objects(global.stat_lines)
      game.write_file("campaign_base_screenshots/email_to.txt",{"campaign-email-message.text"},false)
    end,
  }

  return node
end

misc.destroy_render_objects = function(list)
  for _, id in pairs(list) do
    rendering.destroy(id)
  end
end

local render_text_at_position = function(text,position)
  local new_id = rendering.draw_text({
    text = text,
    surface = locations.get_main_surface(),
    target = position,
    color = {r=1,g=1,b=1},
    scale = 4,
  })
  table.insert(global.stat_lines,new_id)
end

misc.convert_ticks_to_string = function(ticks)
  local text = ""
  ticks = tonumber(ticks)
  while ticks >= 60 do
    --add hours
    local hours = 60*60*60
    if (ticks / hours) > 0 then
      text = text..tostring(math.floor(ticks/hours))..':'
      ticks = ticks % hours
    end
    local minutes = 60*60
    if (ticks / minutes) > 0 then
      text = text..tostring(math.floor(ticks/minutes))..':'
      ticks = ticks % minutes
    end
    local seconds = 60
    if (ticks / seconds) > 0 then
      text = text..tostring(math.floor(ticks/seconds))
      ticks = ticks % seconds
    end
  end
  if text == "" then text = "0:0:0" end
  return text
end

local calc_distance_travelled = function()
  local total_distance = 0
  local last_pos = nil
  for _, position in pairs(global.player_positions) do
    if last_pos then
      total_distance = total_distance + math.floor(math2d.position.distance(last_pos,position))
    end
    last_pos = position
  end
  return total_distance
end



misc.render_stats_to_area = function(area_name)
  --data_output()
  local area = locations.get_area(area_name)
  local margin = 3
  local line_height = 2
  local starting_position = {
    x = area.left_top.x + margin,
    y = area.left_top.y + margin,
  }
  local notes, expected_skill = assess_player()

  misc.destroy_render_objects(global.stat_lines or {})
  global.stat_lines = {}

  render_text_at_position('playtime: '..tostring(misc.convert_ticks_to_string(game.ticks_played)),starting_position)
  starting_position.y = starting_position.y + line_height
  render_text_at_position('expected_skill: '..tostring(expected_skill),starting_position)
  starting_position.y = starting_position.y + line_height
  render_text_at_position('distance_travelled: '..tostring(calc_distance_travelled()),starting_position)
  starting_position.y = starting_position.y + line_height

  local behaviors_to_render = {
    'compi_helped',
    'opened_ent',
    'opened_furnace',
    'opened_burner_mining_drill',
    'opened_assembling_machine_1',
    'opened_escape_pod_lab',
    'opened_escape_pod_assembler',
    'opened_inventory',
    'opened_technology',
  }

  for _, name in pairs(behaviors_to_render) do
    starting_position.y = starting_position.y + line_height
    local times = tracker.times_observed(name)
    render_text_at_position(tostring(name..": "..times.."x "),starting_position)
  end
  starting_position.y = starting_position.y + line_height

  for _, warning in pairs(notes) do
    starting_position.y = starting_position.y + line_height
    render_text_at_position(warning,starting_position)
  end
end


misc.events = { [defines.events.on_sector_scanned] = on_sector_scanned }

return misc
