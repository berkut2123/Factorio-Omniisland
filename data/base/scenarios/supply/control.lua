require "util"
require "story"
require "mod-gui"
time_modifier = 1.4
points_per_second_start = 5
points_per_second_level_subtract = 0.2
levels =
{
  -- 1
  {
    requirements =
    {
      {name = "stone", count = 15 }
    },
    time = 240
  },

  -- 2
  {
    requirements =
    {
      {name = "iron-plate", count = 30}
    },
    time = 300
  },

  -- 3
  {
    requirements =
    {
      {name = "iron-plate", count = 30},
      {name = "copper-plate", count = 30}
    },
    time = 300
  },

  -- 4
  {
    requirements =
    {
      {name = "iron-plate", count = 30},
      {name = "iron-gear-wheel", count = 30}
    },
    time = 300
  },

  -- 5
  {
    requirements =
    {
      {name = "iron-plate", count = 40},
      {name = "iron-gear-wheel", count = 30},
      {name = "copper-cable", count = 40}
    },
    time = 300
  },

  -- 6
  {
    requirements =
    {
      {name = "iron-plate", count = 40},
      {name = "iron-gear-wheel", count = 30},
      {name = "electronic-circuit", count = 30}
    },
    time = 300
  },

  -- 7
  {
    requirements =
    {
      {name = "iron-plate", count = 40},
      {name = "iron-gear-wheel", count = 30},
      {name = "electronic-circuit", count = 30},
      {name = "automation-science-pack", count = 10},
      {name = "firearm-magazine", count = 50}
    },
    time = 300
  },

  -- 8
  {
    requirements =
    {
      {name = "iron-plate", count = 40},
      {name = "iron-gear-wheel", count = 30},
      {name = "electronic-circuit", count = 30},
      {name = "automation-science-pack", count = 10},
      {name = "transport-belt", count = 20}
    },
    time = 300
  },

  -- 9
  {
    requirements =
    {
      {name = "iron-plate", count = 50},
      {name = "iron-gear-wheel", count = 30},
      {name = "electronic-circuit", count = 30},
      {name = "automation-science-pack", count = 10},
      {name = "transport-belt", count = 20},
      {name = "inserter", count = 20}
    },
    time = 300
  },

  -- 10
  {
    requirements =
    {
      {name = "iron-plate", count = 50},
      {name = "iron-gear-wheel", count = 30},
      {name = "electronic-circuit", count = 30},
      {name = "automation-science-pack", count = 10},
      {name = "logistic-science-pack", count = 10}
    },
    time = 300
  },

  -- 11
  {
    requirements =
    {
      {name = "iron-plate", count = 50},
      {name = "iron-gear-wheel", count = 30},
      {name = "electronic-circuit", count = 30},
      {name = "automation-science-pack", count = 20},
      {name = "logistic-science-pack", count = 20},
      {name = "fast-transport-belt", count = 10}
    },
    time = 300
  },

  -- 12
  {
    requirements =
    {
      {name = "iron-plate", count = 50},
      {name = "iron-gear-wheel", count = 30},
      {name = "electronic-circuit", count = 30},
      {name = "automation-science-pack", count = 20},
      {name = "logistic-science-pack", count = 20},
      {name = "steel-plate", count = 10}
    },
    time = 420
  },

  -- 13
  {
    requirements =
    {
      {name = "iron-gear-wheel", count = 30},
      {name = "electronic-circuit", count = 30},
      {name = "automation-science-pack", count = 20},
      {name = "logistic-science-pack", count = 20},
      {name = "steel-plate", count = 15},
      {name = "piercing-rounds-magazine", count = 50}
    },
    time = 300
  },

  -- 14
  {
    requirements =
    {
      {name = "iron-gear-wheel", count = 30},
      {name = "electronic-circuit", count = 30},
      {name = "automation-science-pack", count = 20},
      {name = "logistic-science-pack", count = 20},
      {name = "steel-plate", count = 15},
      {name = "grenade", count = 15},
      {name = "plastic-bar", count = 5}
    },
    time = 600
  },

  -- 15
  {
    requirements =
    {
      {name = "electronic-circuit", count = 30},
      {name = "automation-science-pack", count = 20},
      {name = "logistic-science-pack", count = 20},
      {name = "steel-plate", count = 15},
      {name = "advanced-circuit", count = 10}
    },
    time = 500
  },

  -- 16
  {
    requirements =
    {
      {name = "automation-science-pack", count = 20},
      {name = "logistic-science-pack", count = 20},
      {name = "steel-plate", count = 15},
      {name = "advanced-circuit", count = 10},
      {name = "solid-fuel", count = 10}
    },
    time = 500
  },

  -- 17
  {
    requirements =
    {
      {name = "automation-science-pack", count = 20},
      {name = "logistic-science-pack", count = 20},
      {name = "advanced-circuit", count = 10},
      {name = "engine-unit", count = 10},
      {name = "solid-fuel", count = 10}
    },
    time = 500
  },

  -- 18
  {
    requirements =
    {
      {name = "automation-science-pack", count = 20},
      {name = "logistic-science-pack", count = 20},
      {name = "chemical-science-pack", count = 20},
      {name = "grenade", count = 20}
    },
    time = 500
  },

  -- 19
  {
    requirements =
    {
      {name = "automation-science-pack", count = 30},
      {name = "logistic-science-pack", count = 30},
      {name = "chemical-science-pack", count = 30},
      {name = "stone-wall", count = 20}
    },
    time = 500
  },

  -- 20
  {
    requirements =
    {
      {name = "automation-science-pack", count = 40},
      {name = "logistic-science-pack", count = 40},
      {name = "chemical-science-pack", count = 40},
      {name = "stone-wall", count = 20},
      {name = "grenade", count = 20}
    },
    time = 600
  },

  -- 21
  {
    requirements =
    {
      {name = "automation-science-pack", count = 50},
      {name = "logistic-science-pack", count = 50},
      {name = "chemical-science-pack", count = 50},
      {name = "military-science-pack", count = 50}
    },
    time = 700
  }
}
local completed_label_color = {g = 0.6}

function update_info()
  local level = levels[global.level]
  local accumulated = global.accumulated
  for k, player in pairs (game.players) do
    local frame = mod_gui.get_frame_flow(player).frame
    local table = frame.table
    for index, item in pairs(level.requirements) do
      local accumulated = accumulated[item.name]
      local label = table[item.name]
      label.caption = accumulated .. "/" .. item.count
      if accumulated == item.count then
        label.style.font_color = completed_label_color
      end
    end
  end
end

function get_time_left()
  return global.level_started_at + time_modifier * levels[global.level].time * 60 - game.tick
end

local low_time_left_label_color = {r = 1}

function update_time_left(tick)
  --If given not given a tick, we update regardless
  if tick and tick % 60 ~= 0 then return end
  local time_left = get_time_left()
  if time_left < 0 then
    time_left = 0
  end
  local caption = {"time-left", util.formattime(time_left)}
  local low_time_left = time_left < 60 * 30
  for k, player in pairs (game.players) do
    local label = mod_gui.get_frame_flow(player).frame.time_left
    label.caption = caption
    if low_time_left then
      label.style.font_color = low_time_left_label_color
    end
  end
end

story_table =
{
  {
    {
      action = function()
        if not game.is_multiplayer() then
          game.show_message_dialog{text = {"welcome"}}
          game.show_message_dialog{text = {"rules1"}}
          game.show_message_dialog{text = {"rules2"}}
          game.show_message_dialog{text = {"rules3"}}
          game.show_message_dialog{text = {"rules4"}}
          game.show_message_dialog{text = {"rules5"}}
        end
      end
    },
    {},
    {
      name = "level-start",
      init = function(event)
        global.accumulated = {}
        global.required = {}
        global.labels = {}
        local level = levels[global.level]
        for k, player in pairs (game.players) do
          make_frame(player)
        end
        for index, item in pairs(levels[global.level].requirements) do
          global.accumulated[item.name] = 0
          global.required[item.name] = item.count
        end
        if global.level < #levels then
          for k, player in pairs (game.players) do
            update_frame(player, levels[global.level + 1])
          end
          local item_prototypes = game.item_prototypes
          for index, item in pairs(levels[global.level + 1].requirements) do
            local diff
            if global.required[item.name] ~= nil then
              diff = item.count - global.required[item.name]
            else
              diff = item.count
            end
            for k, player in pairs (game.players) do
              update_table(player, diff, item)
            end
          end
        end
        global.level_started_at = event.tick
        update_info()
        update_time_left()
      end
    },
    {
      name = "level-progress",
      update = function(event)
        update_time_left(event.tick)
        local update_info_needed = false
        local level = levels[global.level]
        for index, chest in pairs(global.chests) do
          if chest.valid then
            local inventory = chest.get_inventory(defines.inventory.chest)
            local contents = inventory.get_contents()
            for itemname, count in pairs(contents) do
              if global.accumulated[itemname] then
                local counttoconsume = global.required[itemname] - global.accumulated[itemname]
                if counttoconsume > count then
                  counttoconsume = count
                end
                if counttoconsume ~= 0 then
                  inventory.remove{name = itemname, count = counttoconsume}
                  global.accumulated[itemname] = global.accumulated[itemname] + counttoconsume
                  update_info_needed = true
                end
              end
            end
          end
        end
        if update_info_needed then
          update_info()
        end
      end,
      condition = function(event)
        local level = levels[global.level]
        local time_left = get_time_left()

        if event.name == defines.events.on_gui_click and
           event.element.name == "next_level" then
          local seconds_left = math.floor(time_left / 60)
          local points_addition = math.floor(seconds_left * (points_per_second_start - global.level * points_per_second_level_subtract))
          game.print({"time-bonus", util.format_number(points_addition), seconds_left})
          global.points = global.points + points_addition
          for k, player in pairs (game.players) do
            if mod_gui.get_button_flow(player).next_level ~= nil then
              mod_gui.get_button_flow(player).next_level.destroy()
            end
          end
          return true
        end

        local result = true
        for index, item in pairs(level.requirements) do
          local accumulated = global.accumulated[item.name]
          if accumulated < item.count then
            result = false
          end
        end

        if result then
          for k, player in pairs (game.players) do
            if mod_gui.get_button_flow(player).next_level == nil then
              mod_gui.get_button_flow(player).add{type = "button", name = "next_level", caption={"next-level"}, style = mod_gui.button_style}
            end
          end
        end

        if time_left <= 0 then
          if result == false then
            for k, player in pairs (game.players) do
              player.set_ending_screen_data({"points-achieved", util.format_number(global.points)})
            end
            game.set_game_state{game_finished=true, player_won=false}
            return false
          else
            return true
          end
        end

        return false
      end,
      action = function(event, story)
        for k, player in pairs (game.players) do
          if mod_gui.get_button_flow(player).next_level ~= nil then
            mod_gui.get_button_flow(player).next_level.destroy()
          end
        end
        global.level = global.level + 1
        local points_addition = (global.level - 1) * 10
        game.print({"level-completed", global.level - 1, util.format_number(points_addition)})
        global.points = global.points + points_addition

        if global.level < #levels + 1 then
          for k, player in pairs (game.players) do
            mod_gui.get_frame_flow(player).frame.destroy()
          end
          story_jump_to(story, "level-start")
        end
      end
    },
    {
      action = function()
        for k, player in pairs (game.players) do
          player.set_ending_screen_data({"points-achieved", util.format_number(global.points)})
        end
      end
    }
  }
}

story_init_helpers(story_table)

script.on_init(function()
  validate_prototypes()
  global.story = story_init(story_table)
  game.map_settings.pollution.enabled = false
  game.forces.enemy.evolution_factor = 0
  global.required = {}
  global.chests = {}
  for k, chest in pairs (game.surfaces[1].find_entities_filtered{name = "red-chest"}) do
    chest.minable = false
    chest.destructible = false
    global.chests[chest.unit_number] = chest
  end
  global.level = 1
  global.points = 0
end)

script.on_event(defines.events, function(event)
  on_joined(event)
  story_update(global.story, event, "")
end)

function on_joined(event)
  if event.name ~= defines.events.on_player_created then return end
  local player = game.players[event.player_index]
  player.insert{name = "iron-plate", count = 8}
  make_frame(player)
  if global.level < #levels then
    update_frame(player, levels[global.level + 1])
    for index, item in pairs(levels[global.level + 1].requirements) do
      local diff
      if global.required[item.name] ~= nil then
        diff = item.count - global.required[item.name]
      else
        diff = item.count
      end
      update_table(player,diff,item)
    end
  end
end

function make_frame(player)
  local flow = mod_gui.get_frame_flow(player)
  if flow.frame then
    flow.frame.destroy()
  end
  local frame = flow.add{type = "frame", name = "frame", direction = "vertical", caption = {"level", global.level}}
  frame.add{type = "label", name = "time_left", caption = {"time-left", "-"}}
  frame.add{type = "label", caption = {"points-per-second", points_per_second_start - global.level * points_per_second_level_subtract}}
  frame.add{type = "label", caption = {"points", util.format_number(math.floor(global.points))}}
  frame.add{type = "label", caption = {"required-items"}, style = "caption_label"}
  local table = frame.add{type = "table", name = "table", column_count = 2}
  table.style.column_alignments[2] = "right"
  for index, item in pairs(levels[global.level].requirements) do
    table.add{type = "label", caption = {"", game.item_prototypes[item.name].localised_name, {"colon"}}}
    table.add{type = "label", caption = "0/" .. item.count, name=item.name}
  end
  return frame
end

function update_frame(player, next_level)
  local frame = mod_gui.get_frame_flow(player).frame
  if not frame then
    frame = make_frame(player)
  end
  frame.add{type= "label", caption={"next-level"}, style = "caption_label"}
  local next_level_table = frame.add{type = "table", column_count=2, name = "next_level_table"}
  next_level_table.style.column_alignments[2] = "right"
end

function update_table(player, diff, item)
  local table = mod_gui.get_frame_flow(player).frame.next_level_table
  if not table then game.print("No table for update_table function") return end
  if diff ~= 0 then
    table.add{type = "label", caption = {"", game.item_prototypes[item.name].localised_name, {"colon"}}}
  end
  if diff > 0 then
    table.add{type = "label", caption = "+" .. diff}
    return
  end
  if diff < 0 then
    table.add{type = "label", caption = diff}
    return
  end
end

function validate_prototypes()
  local items = game.item_prototypes
  local is_error = false
  local bad_items = {}
  for k, level in pairs (levels) do
    for k, item in pairs (level.requirements) do
      if not items[item.name] or item.count <= 0 then
        is_error = true
        bad_items[item.name] = item.count
      end
    end
  end
  if is_error then
    error("Bad prototypes in supply challenge:\n"..serpent.block(bad_items))
  end
end

function test_fill_chest_requirements()
  assert(global.chests)
  local index, chest = next(global.chests)
  assert(chest.valid)
  local level = levels[global.level]
  assert(level)
  for k, item in pairs (level.requirements) do
    chest.insert(item)
  end
  global.level_started_at = (game.tick + 5) - (level.time * 60 * time_modifier)
end
