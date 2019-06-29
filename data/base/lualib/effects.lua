require "story"
local locations = require(mod_name .. ".lualib.locations")
local map_expand = require(mod_name .. ".lualib.map_expand")
local check = require(mod_name .. ".lualib.check")
local util = require("util")
local campaign_util = require(mod_name .. ".lualib.campaign_util")
local tracker = require(mod_name .. ".lualib.player_tracker")
local technology_manager = require(mod_name .. ".lualib.technology_manager")

local effect = {}

effect.unlock_entities_in_area = function(area_name)
  local area = locations.get_area(area_name)
  assert(area,"effect.unlock_entities_in_area: attempting to use invalid area name "..area_name)
  for _, ent in pairs(locations.get_main_surface().find_entities_filtered({area=area})) do
    if not (ent.name == 'character' or ent.name == 'compilatron') then
      ent.minable = true
      ent.active = true
      ent.destructible = true
      ent.operable = true
      ent.rotatable = true
      ent.force = 'player'
    end
  end
end

effect.replace_compi_box = function(box_tag,goal_items)
  local box_ent = locations.get_surface_ent_from_tag(locations.get_main_surface(),box_tag)
  assert(box_ent,"effect.replace_compi_box: attempting to use invalid tag "..box_tag)
  local replacement_ent = box_ent.surface.create_entity({name='iron-chest',position=box_ent.position,force='player'})
  for _, item in pairs(goal_items) do
    box_ent.get_inventory(defines.inventory.chest).remove({name=item.name,count=item.goal})
  end
  for name, count in pairs(box_ent.get_inventory(defines.inventory.chest).get_contents()) do
    replacement_ent.get_inventory(defines.inventory.chest).insert({name=name,count=count})
  end
  box_ent.destroy()
end

effect.replace_consumer = function(consumer_tag,goal_items)
  local consumer_ent = locations.get_surface_ent_from_tag(locations.get_main_surface(),consumer_tag)
  if consumer_ent == nil then return false end
  local replacement_ent = consumer_ent.surface.create_entity({name='iron-chest',position=consumer_ent.position,force='player'})
  local abstract_consumer = global.consumers[consumer_tag]
  for _, item in pairs(goal_items) do
    if abstract_consumer[item.name] then
      abstract_consumer[item.name] = abstract_consumer[item.name] - item.goal
    end
  end
  for name, count in pairs(abstract_consumer) do
    if count > 0 then
      replacement_ent.insert({name=name,count=count})
    end
  end
  consumer_ent.destroy()
  global.consumers[consumer_tag] = nil
end

effect.take_items_from_player = function(itemlist)
  local player = main_player()
  for _, item in pairs(itemlist) do
    player.remove_item({name=item.name,count=item.count or item.goal})
  end
end

effect.refund_consumer = function(consumer_tag,goal_items)
  if global.consumers == nil then return {} end -- TODO: handle this better in the next NPE version
  local consumer = global.consumers[consumer_tag]
  if not consumer then return {} end
  for _, item in pairs(goal_items) do
    if consumer[item.name] then
      consumer[item.name] = consumer[item.name] - item.goal
    end
  end
  for name, count in pairs(consumer) do
    if count > 0 then
      main_player().insert({name=name,count=count})
    end
  end
end

effect.swap_tagged_with_fixed_entity = function(tag,entity_name)
  local to_be_replaced = locations.get_surface_ent_from_tag(locations.get_main_surface(),tag)
  local new_ent = locations.get_main_surface().create_entity({
      name=entity_name,
      position=to_be_replaced.position,
      force='player',
      create_build_effect_smoke = true,
      })
  to_be_replaced.destroy()
  new_ent.minable = false
  new_ent.destructible = false
  if new_ent.supports_backer_name() then
    new_ent.backer_name = ""
  end
  return new_ent
end

effect.swap_tagged_with_fixed_recipe = function(tag,recipe_name)
  local am = effect.swap_tagged_with_fixed_entity(tag,'escape-pod-assembler')
  am.recipe_locked = true
  am.set_recipe(recipe_name)
  return am
end

effect.turn_biters_around = function(area_list,destination_name)
  local dest = locations.get_pos(destination_name)
  if dest == nil then return end
  for _, area_name in pairs(area_list) do
    local area = locations.get_area(area_name)
    if area then
      local biters_in_area = locations.get_main_surface().find_entities_filtered({
        name='small-biter',
        area=area
      })
      for _, biter in pairs(biters_in_area) do
        local rand = math.random(1,100)
        if rand > 98 then
          biter.force = game.forces.enemy
          biter.set_command(
            {
              type = defines.command.wander,
              --destination=dest,
              radius = 5,
              distraction = defines.distraction.by_damage
            }
          )
        end
      end
    end
  end
end

effect.get_entities_to_swap_forces = function(box, from, everything, only_units)
  local protect_player_ents = not everything
  local froments = game.surfaces[1].find_entities_filtered({
    area = box,
    force = from
    })
  local to_change = {}
  for _, ent in pairs(froments) do
    if not (ent.name == 'character' or
            ent.name == 'compilatron' or
            (ent.name == 'lab' and protect_player_ents) or
            (ent.name == 'escape-pod-assembler' and protect_player_ents) or
            (ent.name == 'escape-pod-lab' and protect_player_ents) or
            (ent.name == 'escape-pod-power' and protect_player_ents) or
            (ent.name == 'wreck-pole' and protect_player_ents) or
            (only_units and ent.prototype.type ~= "unit")) then
      table.insert(to_change,ent)
    end
  end

  return to_change
end

effect.swap_forces = function(box, from, to, everything, only_units)
  local entities = effect.get_entities_to_swap_forces(box, from, everything, only_units)

  for _, entity in pairs(entities) do
    entity.force = to
  end

  return entities
end

effect.activate_radar = function(state)
  for _, player in pairs(game.players) do
    player.minimap_enabled = state
  end
end

effect.move_player_out_of_area = function(box)
  if check.player_inside_box(box) then
    main_player().teleport({
        x = box.right_bottom.x + 1,
        y = box.right_bottom.y + 1,
      })
  end
end

effect.activate_research = function(state)
  for _, player in pairs(game.players) do
    player.game_view_settings.show_research_info = state
  end
end

effect.activate_side_menu = function(state)
  for _, player in pairs(game.players) do
    player.game_view_settings.show_side_menu = state
  end
end

effect.activate_controller_gui = function(state)
  for _, player in pairs(game.players) do
    player.game_view_settings.show_controller_gui = state
  end
end

effect.activate_quick_bar = function(state)
  for _, player in pairs(game.players) do
    player.game_view_settings.show_quickbar = state
  end
end

effect.activate_shortcut_bar = function(state)
  for _, player in pairs(game.players) do
    player.game_view_settings.show_shortcut_bar = state
  end
end

effect.show_text_window = function(heading,blocks)
  if main_player().gui.center.disclaimer then
    main_player().gui.center.disclaimer.destroy()
  end
  local window = main_player().gui.center.add({
    type='frame',
    name='disclaimer',
    direction='vertical',
    style = 'dialog_frame_no_header_filler',
    caption = heading,
    })
  local holder = window.add({
    type='table',
    column_count=1,
    })

  for _, block in pairs(blocks) do

    local msg = holder.add({
      type='label',
      caption=block
      })
    msg.style.single_line = false
    msg.style.maximal_width = 300
    msg.style.bottom_padding = 10

  end
  local horizontal_flow = window.add({
    type='flow',
    direction='horizontal',
    })
  local thing = horizontal_flow.add({
    type = 'flow',
    direction='horizontal',
    style= 'quest_item_icons_wrapper'
  })
  thing.style.horizontally_stretchable = true
  thing.style.maximal_width = 300
  horizontal_flow.add({
    type='button',
    name='close-text-window',
    style='confirm_button',
    caption={'text-window.continue-button'},
    })

end

effect.unlock_technologies = function(tech_level, do_flying_text)
  if do_flying_text == nil then
    do_flying_text = true
  end

  technology_manager.set_tech_level(tech_level)
  if do_flying_text then
    campaign_util.flying_tech_unlocked()
  end
end

effect.discover_technologies = function(tech_level)
  technology_manager.discover_tech_level(tech_level)
end

effect.discover_all_tech_levels = function()
  technology_manager.discover_all_tech_levels()
end

effect.research_technologies = function(tech_level)
 technology_manager.research_up_to(tech_level)
end

effect.clone_area = function(area_name)
  local area = locations.get_template_surface().get_script_areas(area_name)[1].area
  if area then
    locations.get_template_surface().clone_area(
      {
        source_area = area,
        destination_area = area,
        destination_surface = locations.get_main_surface(),
        expand_map = false
      })
  end
end

effect.expand_map = function(expansion_args, skip_cutscene)
  if expansion_args then
    expansion_args = util.table.deepcopy(expansion_args)

    for _, section in pairs(expansion_args.sections) do
      section.template_section = locations.get_area(section.template_section)
      section.direction = defines.direction[section.direction]
      section.template = game.surfaces[section.template]
    end

    if skip_cutscene then
      expansion_args.skip_cutscene = true
    end

    --popup.show_popup(false)
    --quest.show_quest_gui(false)
    --move_players_from_map_edge()
    map_expand.expand(expansion_args)
  end
end

-- Can take a string location name, or just an actual location as a table
effect.spawn_biters = function(quant, position, force_name, unit_type, as_group)
  unit_type = unit_type or 'small-biter'

  if as_group == nil then
    as_group = false
  end

  if type(position) == 'string' then
    position = locations.get_pos(position)
  end

  assert(position)

  local group
  local units = {}
  if as_group then
    group = locations.get_main_surface().create_unit_group
    {
      position = position,
      force = force_name
    }
  end

  for _=1, quant do
    local actual_pos = locations.get_main_surface().find_non_colliding_position(unit_type, position, 100, 2)
    if actual_pos then
      local unit = locations.get_main_surface().create_entity
      {
        name = unit_type,
        position = actual_pos,
        force = force_name
      }
      if as_group then
        group.add_member(unit)
      end
      table.insert(units, unit)
    end
  end

  if as_group then
    return group
  else
    return units
  end
end

effect.send_sequenced_attack = function(spawn_name,quant,force,seconds_between,target_list)
  local spawn = locations.get_pos(spawn_name)
  if spawn == nil then return end
  local command = {
      type = defines.command.compound,
      structure_type = defines.compound_command.return_last,
      commands = {}
      }
  for _, target_name in pairs(target_list) do
    local target_ent = locations.get_surface_ent_from_tag(locations.get_main_surface(),target_name)
    local target_pos = locations.get_pos(target_name)
    if target_ent then
      table.insert(command.commands,
        {
          type = defines.command.attack,
          target = target_ent,
          distraction = defines.distraction.none
        })
    elseif target_pos then
      table.insert(command.commands,
        {
          type = defines.command.go_to_location,
          destination = target_pos,
          distraction = defines.distraction.none
        })
      table.insert(command.commands,
        {
          type = defines.command.stop,
          ticks_to_wait = 60*seconds_between,
          distraction = defines.distraction.none
        })
    end
  end
  table.insert(command.commands,
  {
    type = defines.command.wander,
    radius = 10,
    distraction = defines.distraction.by_damage
  })

  local biters = {}
  for _=1,quant do
    local actual_pos = locations.get_main_surface().find_non_colliding_position('small-biter',spawn,30,2)
    if actual_pos then
      local biter = locations.get_main_surface().create_entity({
        name='small-biter',
        position = actual_pos,
        force = force
        })
      biter.set_command(command)
      table.insert(biters, biter)
    end
  end

  return biters
end


effect.attack_ent_with_group_via_rally = function(group,target,rally,follow_up)
  assert(group and group.valid)
  local rally_point = locations.get_pos(rally)
  local target_point = locations.get_pos(follow_up)

  assert(rally_point)
  assert(target_point)

  group.set_command
  {
    type = defines.command.compound,
    structure_type = defines.compound_command.return_last,
    commands = {
      {
        type = defines.command.go_to_location,
        destination = rally_point,
        distraction = defines.distraction.none
      },
      {
        type = defines.command.attack,
        target = target,
        distraction = defines.distraction.none
      },
      {
        type = defines.command.go_to_location,
        destination = target_point,
        distraction = defines.distraction.by_anything
      },
      {
        type = defines.command.wander,
        distraction = defines.distraction.by_anything,
        wander_in_group = false,
        radius = 10
      }
    }
  }
end

effect.turn_biters_hostile = function(area_name)
  -- within given area move biters to enemy force
  local toents = effect.swap_forces(locations.get_area(area_name),'peaceful','enemy', nil, true)
  for _, biter in pairs(toents) do
    biter.set_command(
      {
        type = defines.command.wander,
        radius = 20,
        distraction = defines.distraction.by_anything
    })
  end
end

effect.make_peaceful_biters_wander = function(area_name)
  -- within given area move biters to enemy force
  local area = locations.get_area(area_name)
  if area == nil then return end
  local toents = locations.get_main_surface().find_entities_filtered({
    name='small-biter',
    force='peaceful',
    area=area
    })
  for _, biter in pairs(toents) do
    biter.set_command(
      {
        type = defines.command.wander,
        radius = 60,
        distraction = defines.distraction.by_anything
    })
  end
end

effect.swap_recipes = function(recipe1,recipe2)
  local ams = locations.get_main_surface().find_entities_filtered({name='assembling-machine-1',force='player'})
  for _, am in pairs(ams) do
    if am.get_recipe() and (am.get_recipe().name == recipe1) then
      am.set_recipe(recipe2)
    end
  end
end

effect.disable_recipes = function(recipelist)
  for _, recipe in pairs(recipelist) do
    game.forces.player.recipes[recipe].enabled = false
  end
end

effect.enable_recipes = function(recipelist)
  for _, recipe in pairs(recipelist) do
    game.forces.player.recipes[recipe].enabled = true
  end
end

local on_player_mined_item = function(event)
  if global.behaviors then
    local list = {'copper-ore','iron-ore','coal','stone'}
    for _, item in pairs(list) do
      if event.item_stack.name == item then
        tracker.log_behavior('mined_'..item,300)
      end
    end
  end
end

local on_gui_click = function(event)
  if event.element then
    if event.element.name == 'close-text-window' then
      event.element.parent.parent.visible = false
      global.player_closed_text_window = true
      game.tick_paused = false
    end
  end
end

effect.events = {
  [defines.events.on_gui_click] = on_gui_click,
  [defines.events.on_player_mined_item] = on_player_mined_item,
}

return effect
