require("map_sets")
require("map_scripts")
require("points")
require("config")
local mod_gui = require("mod-gui")
local util = require("util")

function select_from_probability_table(probability_table)
  local roll_max = 0
  for _, item in pairs(probability_table) do
    roll_max = roll_max + item.probability
  end

  local roll_value = math.random(0, roll_max - 1)
  for _, item in pairs(probability_table) do
    roll_value = roll_value - item.probability
    if (roll_value < 0) then
      return item.value
    end
  end
end

function select_inventory() return select_from_probability_table(global.inventory_probabilities) end

function select_equipment() return select_from_probability_table(global.equipment_probabilities) end

function select_challange_type() return select_from_probability_table(global.challange_type_probabilities) end

function save_round_statistics()

  local round_data = "\nRound "..global.round_number.."\n  Time: "..format_time(time_left()).."\n  Type: "..global.challenge_type.."\n  Inventory: "..global.round_inventory.."\n  Equipment: "..global.round_equipment.."\n  Players per team: "..global.players_per_team.."\n  Number of players: "..#global.online_players.."\n  Tasks:"

  for k, item in pairs (global.task_items) do
    round_data = round_data.."\n    "..item.name..": "..item.count
  end

  if global.winners then
    round_data = round_data.."\n  Number of winning teams: "..#global.winners
    for k, force in pairs (global.winners) do
      round_data = round_data.."\n    "..force.name..": "
      for j, player in pairs (force.players) do
        if j == 1 then
          round_data = round_data..player.name
        else
          round_data = round_data..", "..player.name
        end
      end
    end
  end

  round_data = round_data.."\n"
  game.write_file("round_statistics.txt", round_data, true, 0)

end

function start_challenge()

  global.winners = {}
  global.round_number = global.round_number + 1
  if global.recent_round_number == global.recent_round_count then
    global.recent_round_number = 0
    global.recent_points = {}
  end
  global.recent_round_number = global.recent_round_number + 1
  global.round_timer_value = game.tick
  global.winners = {}
  global.force_points = {}

  global.round_inventory = select_inventory()
  global.round_equipment = select_equipment()
  global.challenge_type = select_challange_type()

  set_teams()

  if global.challenge_type == "production" then
    generate_production_task()
    fill_input_chests()
    return
  end

  if global.challenge_type == "shopping_list" then
    generate_shopping_list_task()
    return
  end

end

function create_teams()
  if not game.forces["spectators"] then
    game.create_force("spectators")
  end
  for k, force in pairs(global.force_list) do
    if not game.forces[force.name] then
      local force = game.create_force(force.name)
      setup_unlocks(force)
      force.disable_research()
      force.set_ammo_damage_modifier("bullet", -1)
      force.set_ammo_damage_modifier("flamethrower", -1)
      force.set_ammo_damage_modifier("capsule", -1)
      force.set_ammo_damage_modifier("cannon-shell", -1)
      force.set_ammo_damage_modifier("grenade", -1)
      force.set_ammo_damage_modifier("electric", -1)
      force.worker_robots_speed_modifier = 3
    end
  end
  for k, force in pairs (game.forces) do
    for j, friend in pairs (game.forces) do
      if force.name ~= friend.name then
        force.set_cease_fire(friend, true)
        force.set_friend(friend, true)
      end
    end
  end
end

function set_areas(i)
  shuffle_table(global.force_list)
  if not global.previous_map_size then
    global.previous_map_size = 5
  else
    global.previous_map_size = map_sets[global.current_map_index].map_set_size
  end
  global.previous_map_index = global.current_map_index
  global.current_map_index = i
  if not map_sets[i] then return end
  for k, player in pairs (game.players) do
    set_spectator(player)
  end
  global.clear_areas_tick = game.tick + global.number_of_teams + 1
end

function decide_player_team(player)
  if not global.online_players then return end
  if not player.connected then
    player.force = game.forces.spectators
    return
  end
  if player.afk_time >= global.afk_time then player.force = game.forces.spectators end
  if player.force.name == "spectators" then return end
  table.insert(global.online_players, player)
end

function set_teams()
  global.online_players = {}
  for k, player in pairs(game.players) do
    decide_player_team(player)
  end
  global.number_of_teams = math.max(2, math.floor((#global.online_players)^0.5))
  global.number_of_teams = math.min(global.number_of_teams, #global.force_list)
  shuffle_table(global.online_players)
  for k, player in pairs (global.online_players) do
    set_player(player, k)
  end
  for k, player in pairs (global.online_players) do
    give_starting_inventory(player)
  end
end

function toggle_leaderboard(player)
  local gui = player.gui.center
  local frame = gui.leaderboard
  if frame then
    frame.destroy()
    return
  end
  frame = gui.add{type = "table", name = "leaderboard", column_count = 2}
  frame.style.horizontal_spacing = 0
  update_leaderboard(player)
  player.opened = frame
end

function update_leaderboard(player)
  local flow = player.gui.center.leaderboard

  if not flow then return end
  flow.clear()

  local frame = flow.add{type = "frame", caption = {"recent"}}
  add_leaderboard_table(frame, global.recent_points)

  local frame = flow.add{type = "frame", caption = {"all-time"}}
  add_leaderboard_table(frame, global.points)

end

function add_leaderboard_table(gui, points)

  local any = false
  for k, v in pairs (points) do
    any = true
    break
  end
  if any then
    local check_name = game.players[gui.player_index].name
    local scroll = gui.add{type = "scroll-pane"}
    scroll.style.maximal_height = 560
    local inner_flow = scroll.add{type = "frame", style = "image_frame"}
    inner_flow.style.left_padding = 4
    inner_flow.style.right_padding = 12
    inner_flow.style.bottom_padding = 4
    inner_flow.style.top_padding = 4
    leaderboard_table = inner_flow.add{type = "table", column_count = 3}
    leaderboard_table.style.column_alignments[1] = "right"
    leaderboard_table.style.column_alignments[3] = "right"
    leaderboard_table.style.horizontal_spacing = 16
    leaderboard_table.style.vertical_spacing = 8
    leaderboard_table.draw_horizontal_line_after_headers = true
    leaderboard_table.draw_vertical_lines = true

    count = 1
    for k, caption in pairs ({"", "name", "points"}) do
      local label = leaderboard_table.add{type = "label", caption = {caption}}
      label.style.font = "default-bold"
    end
    for name, points in spairs(points, function(t, a, b) return t[b] < t[a] end) do
      local this = leaderboard_table.add{type = "label", caption = "#"..count}
      this.style.font_color = {r = 1, g = 1, b = 0.2}
      this.style.font = "default-semibold"
      local that = leaderboard_table.add{type = "label", caption = name}
      if name == check_name then
        that.style.font_color = {r = 1, g = 0.6, b = 0.1}
        that.style.font = "default-semibold"
      end
      leaderboard_table.add{type = "label", caption = util.format_number(points)}
      count = count + 1
    end
  else
    gui.add{type = "label", caption = {"none-in-leaderboard"}}
  end
end

function set_player(player, k)
  set_spectator(player)
  local index = (k % global.number_of_teams) + 1
  local team = global.force_list[index]
  local force = game.forces[team.name]
  set_character(player, force)
  local c = team.color
  player.color = {r = c[1], g = c[2], b = c[3], a = c[4]}

end

function setup_unlocks(force)
  if not force.valid then return end
  force.research_all_technologies()
  local disallowed_map = {}
  for k, name in pairs (global.disabled_items) do
    disallowed_map[name] = true
  end
  for recipe_name, recipe in pairs (force.recipes) do
    if disallowed_map[recipe_name] then
      recipe.enabled = false
    end
  end
end

function generate_production_task()

  local items_to_choose
  local number_of_items
  local type = global.challenge_type

  number_of_items = math.random(1, global.max_count_of_production_tasks)
  items_to_choose = global.item_list

  shuffle_table(items_to_choose)
  local task_items = {}
  local max_count = calculate_task_item_multiplayer(number_of_items)
  global.round_input = nil
  for k = 1, number_of_items do
    local item = items_to_choose[k]
    if item.input then
      if not global.round_input then
        global.round_input = item.input
      else
        break
      end
    end
    task_items[k] = {}
    task_items[k].name = item.name
    task_items[k].count = math.random(2, max_count)*item.count
  end
  global.task_items = task_items
  global.progress = {}
  for j, force in pairs (game.forces) do
    global.progress[force.name] = {}
    for k, item in pairs (global.task_items) do
      global.progress[force.name][item.name] = 0
    end
  end

end

function generate_shopping_list_task()
  shuffle_table(global.item_list)
  local multiplier = math.ceil((#global.online_players)/global.players_per_team)
  local number_of_items = math.random(1, global.max_count_of_production_tasks)
  local max_count = calculate_task_item_multiplayer(number_of_items)
  task_items = {}
  global.round_input = nil
  for k = 1, number_of_items do
    local item = global.item_list[k]
    if item.input then
      if not global.round_input then
        global.round_input = item.input
      else
        break
      end
    end
    task_items[k] = {}
    task_items[k].name = global.item_list[k].name
    task_items[k].count = math.random(2, max_count)*global.item_list[k].count*multiplier
    task_items[k].remaining = task_items[k].count
  end
  global.task_items = task_items
  global.progress = {}
  for j, force in pairs (game.forces) do
    global.progress[force.name] = {}
    for k, item in pairs (global.task_items) do
      global.progress[force.name][item.name] = 0
    end
  end
end

function create_visibility_buttons(player)
  local gui = mod_gui.get_button_flow(player)
  for k, button in pairs ({{name = "toggle_leaderboard_button", type = "button", caption = {"leaderboard"}}}) do
    if not gui[button.name] then
      local button = gui.add(button)
      button.style = mod_gui.button_style
    end
  end
end

function update_spectate_button(player)

  local gui = mod_gui.get_button_flow(player)
  local button = gui.spectate_button
  local visibility = global.start_round_tick ~= nil
  if button then
    button.visible = visibility
    return
  end
  button = gui.add{type = "button", name = "spectate_button", style = mod_gui.button_style}
  button.visible = visibility
  if player.force.name == "spectators" then
    button.caption = {"unspectate"}
  else
    button.caption = {"spectate"}
  end
end

function check_end_of_round()
  if game.tick ~= global.end_round_tick then return end
  save_round_statistics()
  global.end_round_tick = nil
  global.start_round_tick = game.tick + global.time_between_rounds
  global.chests = nil
  global.input_chests = nil
  global.task_items = nil
  global.progress = nil
  global.challenge_type = nil

  for k, player in pairs(game.players) do
    end_round_gui_update(player)
  end
  game.play_sound{path = "utility/research_completed"}
end

function chart_all()
  if game.tick % 120 ~= 0 then return end
  for k, force in pairs (game.forces) do
    force.chart_all()
  end
end

function end_round_gui_update(player)
  local gui = mod_gui.get_frame_flow(player)
  update_end_timer(player)
  update_task_table(player)
  player.print({"next-round-soon", (global.time_between_rounds/60)})
  set_spectator(player)
  update_spectate_button(player)
  if not gui.winners_frame then return end
  gui.winners_frame.caption = {"round-winners"}
end

function update_gui()
  local tick = game.tick
  for k, player in pairs(game.players) do
    if k % 60 == tick % 60 then
      update_end_timer(player)
      update_task_table(player)
    end
  end
end

function check_start_round()
  if game.tick ~= global.start_round_tick then return end
  global.start_round_tick = nil
  game.surfaces[1].regenerate_decorative()
  start_challenge()
  for k, player in pairs(game.players) do
    update_task_table(player)
    update_winners_list(player)
    update_spectate_button(player)
  end
end

function check_start_set_areas()
  if not global.start_round_tick then return end
  --Calculates when to start settings the areas
  if global.start_round_tick - ((2 * global.number_of_teams) + 1 + ((global.number_of_teams) * global.ticks_to_generate_entities)) == game.tick then
    set_areas(math.random(#map_sets))
  end
end

function check_start_setting_entities()
  --Start setting the entities
  if not global.set_entities_tick then return end
  local entities = map_sets[global.current_map_index].map_set_entities
  local distance = map_sets[global.current_map_index].map_set_size
  local index = math.ceil((global.set_entities_tick - game.tick)/global.ticks_to_generate_entities)
  if index == 0 then
    global.set_entities_tick = nil
    return
  end
  local listed = global.force_list[index]
  if not listed then return end

  local grid_position = get_spawn_coordinate(index)
  local force = game.forces[listed.name]
  local offset_x = grid_position[1] * (distance*2 + global.distance_between_areas)
  local offset_y = grid_position[2] * (distance*2 + global.distance_between_areas)
  recreate_entities(entities, offset_x, offset_y, force, global.ticks_to_generate_entities)
end

function check_set_areas()
  if not global.set_areas_tick then return end
  local set = map_sets[global.current_map_index]
  local distance = set.map_set_size
  local index = global.set_areas_tick - game.tick

  if index == 0 then
    global.set_areas_tick = nil
    global.set_entities_tick = game.tick + (global.number_of_teams * global.ticks_to_generate_entities)
    return
  end
  local listed = global.force_list[index]
  if not listed then return end

  local grid_position = get_spawn_coordinate(index)
  local force = game.forces[listed.name]

  if not force then
    game.print(listed.name.." is not a valid force")
    return
  end

  if not force.valid then return end
  local offset_x = grid_position[1] * (distance*2 + global.distance_between_areas)
  local offset_y = grid_position[2] * (distance*2 + global.distance_between_areas)
  create_tiles(set, offset_x, offset_y, true)
  force.set_spawn_position({offset_x, offset_y}, game.surfaces[1])
  force.rechart()
end

function check_clear_areas()
  if not global.clear_areas_tick then return end
  if not global.previous_map_index then
    global.previous_map_index = 1
  end
  local set = map_sets[global.previous_map_index]
  local distance = set.map_set_size
  local index = global.clear_areas_tick - game.tick
  if index == 0 then
    global.clear_areas_tick = nil
    global.set_areas_tick = game.tick + global.number_of_teams
    return
  end
  local grid_position = get_spawn_coordinate(index)
  local offset_x = grid_position[1] * (distance*2 + global.distance_between_areas)
  local offset_y = grid_position[2] * (distance*2 + global.distance_between_areas)
  create_tiles(set, offset_x, offset_y, true, true)
end

function check_chests()
  if not global.chests then return end
  if game.tick % 30 ~= 0 then return end
  local task = global.challenge_type
  if not task then return end
  local update_chest
  if task == "production" then
    update_chest = check_chests_production
  elseif task == "shopping_list" then
    update_chest = check_chests_shopping_list
  else
    error("Unknown challenge type: "..task)
  end
  for k, chest in pairs (global.chests) do
    if not chest.valid then
      table.remove(global.chests, k)
    else
      update_chest(chest)
    end
  end
  for k, force in pairs (game.forces) do
    check_victory(force)
  end
end

function check_chests_shopping_list(chest)
  if not global.task_items then return end
  for k, item in pairs (global.task_items) do
    local count = chest.get_item_count(item.name)
    if count > item.remaining then
      count = item.remaining
    end
    if count > 0 then
      chest.remove_item({name = item.name, count = count})
      global.progress[chest.force.name][item.name] = global.progress[chest.force.name][item.name] + count
      item.remaining = item.remaining - count
    end
  end
end

function check_chests_production(chest)
  if not global.task_items then return end
  for k, item in pairs (global.task_items) do
    local count = chest.get_item_count(item.name)
    if count + global.progress[chest.force.name][item.name] > item.count then
      count = item.count - global.progress[chest.force.name][item.name]
    end
    if count > 0 then
      chest.remove_item({name = item.name, count = count})
      global.progress[chest.force.name][item.name] = global.progress[chest.force.name][item.name] + count
    end
  end
end

function check_input_chests()
  if game.tick % 1024 ~= 0 then return end
  fill_input_chests()
end

function fill_input_chests()
  if not global.input_chests then return end
  if not global.round_input then return end
  if not game.item_prototypes[global.round_input] then game.print("BAD INPUT ITEM") return end
  for k, chest in pairs (global.input_chests) do
    if chest.valid then
      chest.clear_items_inside()
      chest.insert{name = global.round_input, count = 10000}
    else
      table.remove(global.input_chests, k)
    end
  end
end

function check_victory(force)
  if not global.challenge_type then return end
  if not force.valid then return end
  if not global.winners then return end

  for k, winners in pairs (global.winners) do
    if force == winners then
      return
    end
  end

  local challenge_type = global.challenge_type

  if challenge_type == "production" then
    local finished_tasks = 0
    for k, item in pairs (global.task_items) do
      if global.progress[force.name][item.name] >= item.count then
        finished_tasks = finished_tasks +1
      end
    end
    if finished_tasks >= #global.task_items then
      team_finished(force)
    end
    return
  end

  if challenge_type == "shopping_list" then
    if global.winners[1] then return end
    local finished_tasks = 0
    for k, item in pairs (global.task_items) do
      if item.remaining == 0 then
        finished_tasks = finished_tasks +1
      end
    end
    if finished_tasks >= #global.task_items then
      shopping_task_finished()
    end
    return
  end
end

function shopping_task_finished()
  local total_points = global.points_per_win * global.number_of_teams
  local points_per_task = total_points/(#global.task_items)
  for k, item in pairs (global.task_items) do
    for j, force in pairs (game.forces) do
      calculate_force_points(force, item, points_per_task)
    end
  end

  for name, points in spairs(global.force_points, function(t, a, b) return t[b] < t[a] end) do
    if points > 0 then
      table.insert(global.winners, game.forces[name])
    end
  end
  global.end_round_tick = game.tick + 1
  for k, player in pairs (game.players) do
    update_winners_list(player)
  end
end

function calculate_force_points(force,item, points)
  if points <= 0 then return end
  if not global.progress then return end
  if not global.progress[force.name] then return end
  if not global.progress[force.name][item.name] then return end
  if not item.count then return end
  if global.progress[force.name][item.name] <= 0 then return end
  local count = global.progress[force.name][item.name]
  local total = item.count
  local awarded_points = math.floor((count/total)*points)
  give_force_players_points(force, awarded_points)
end

function create_task_frame(player)
  local gui = mod_gui.get_frame_flow(player)
  local frame = gui.task_frame
  if frame then
    frame.destroy()
  end
  frame = gui.add{name = "task_frame", type = "frame", direction = "vertical", caption = {"round", global.recent_round_number, global.recent_round_count}}
  update_task_table(player)
end

function update_task_table(player)
  local gui = mod_gui.get_frame_flow(player)
  local frame = gui.task_frame
  if not frame then return end
  frame.clear()
  frame.caption = {"round", global.recent_round_number, global.recent_round_count}
  local task = global.challenge_type
  if global.start_round_tick ~= nil then
    frame.add{type = "label", caption = {"round-starting-soon", format_time(global.start_round_tick - game.tick)}}
    return
  end
  local task_label = frame.add{type = "label", caption = {task}, style = "caption_label"}
  frame.add{type = "label", name = "round_timer", caption = {"elapsed-time", format_time(time_left())}}
  local task_table = frame.add{type = "table", column_count = 3}
  task_table.style.horizontal_spacing = 8
  task_table.style.vertical_spacing = 8
  task_table.style.column_alignments[2] = "right"
  task_table.style.column_alignments[3] = "right"
  local spectating = player.force.name == "spectators"
  local headers
  local table_string
  if task == "production" then
    headers = {"item-name", "current", "goal"}
    table_string = "count"
  elseif task == "shopping_list" then
    headers = {"item-name", "current", "remaining"}
    table_string = "remaining"
  else
    error("Unknown task type: "..task)
  end
  if spectating then
    headers[2] = ""
  end
  for k, caption in pairs (headers) do
    local label = task_table.add{type = "label", caption = {caption}}
    label.style.font = "default-bold"
  end
  local progress = global.progress[player.force.name]
  if not progress then error("force progress is nil: "..player.force.name) end
  local items = game.item_prototypes
  for k, item in pairs (global.task_items) do
    local label = task_table.add{type = "label", caption = items[item.name].localised_name}
    label.style.font = "default-semibold"
    local progress = task_table.add{type = "label", caption = util.format_number(progress[item.name])}
    if spectating then
      progress.caption = ""
    end
    task_table.add{type = "label", caption = util.format_number(item[table_string])}
  end
end

function time_left()
  return game.tick - global.round_timer_value
end

function create_joined_game_gui(player)
  local gui = player.gui.center
  if gui.center_splash then return end
  local frame = gui.add{type = "frame", name = "center_splash",direction = "vertical", caption = {"center-label-welcome"}}
  local label = frame.add{type = "label", name = "center_label", caption = {"center-label"}}
  label.style.single_line = false
  label.style.maximal_width = 500
  local center_table = frame.add{type = "table", name = "center_table", column_count = 2}
  center_table.add{type = "button", name = "join-game", caption = {"join-game"} }
  center_table.add{type = "button", name = "remain-spectate", caption = {"remain-spectate"} }
end

function update_end_timer(player)
  if not player.connected then return end
  if not global.end_round_tick then return end
  local gui = mod_gui.get_frame_flow(player)
  if not gui.winners_frame then return end
  gui.winners_frame.caption = {"winner-end-round", format_time(global.end_round_tick - game.tick)}
end

function team_finished(force)
  if not force.valid then return end
  if not global.progress then return end
  if not global.progress[force.name] then return end

  table.insert(global.winners, force)
  local points = global.points_per_win

  for j, winning_force in pairs (global.winners) do
    if winning_force == force then
      points = math.floor(points/j)
      break
    end
  end

  if #global.winners == 1 then
    global.end_round_tick = game.tick + global.time_before_round_end
  end
  give_force_players_points(force, points)
  for k, player in pairs(game.players) do
    if player.force ~= force then
      player.print({"finished-task", {"color."..force.name}})
      player.play_sound({path = "utility/game_lost"})
    else
      player.print({"your-team-win", global.force_points[force.name]})
      player.play_sound({path = "utility/game_won"})
      set_spectator(player)
    end
    update_winners_list(player)
    update_leaderboard(player)
  end
  save_points_list()
end

function save_points_list()
  local points_lua = "function give_points()\n  return\n  {\n"
  for name, points in pairs (global.points) do
    points_lua = points_lua .. "    [\""..name.."\"] = "..points..", \n";
  end
  points_lua = points_lua .. "  }\nend"
  game.write_file("points.lua", points_lua, false, 0)
end

function give_force_players_points(force, points)
  if not force.valid then return end
  if points <= 0 then return end
  if not global.force_points then global.force_points = {} end

  if not global.force_points[force.name] then
    global.force_points[force.name] = points
  else
    global.force_points[force.name] = global.force_points[force.name] + points
  end

  for k, player in pairs (force.players) do
    if not global.points[player.name] then
      global.points[player.name] = points
    else
      global.points[player.name] = global.points[player.name] + points
    end

    if not global.recent_points[player.name] then
      global.recent_points[player.name] = points
    else
      global.recent_points[player.name] = global.recent_points[player.name] + points
    end
  end
  update_player_tags()
end

function update_player_tags()
  local count = 1
  local players = game.players
  for name, points in spairs(global.points, function(t, a, b) return t[b] < t[a] end) do
    local player = players[name]
    if player then
      player.tag = "[#"..count.."]"
    end
    count = count + 1
  end
end

function update_winners_list(player)
  local gui = mod_gui.get_frame_flow(player)
  local frame = gui.winners_frame
  if not global.winners then return end
  if #global.winners == 0 then
    if frame then frame.destroy() end return
  end
  if not global.force_points then return end

  if not frame then
    frame = gui.add{type = "frame", name = "winners_frame", caption = {"winner-end-round", format_time(global.end_round_tick - game.tick)}, direction = "vertical"}
    local winners_table = frame.add{type = "table", name = "winners_table", column_count = 5}
    winners_table.style.column_alignments[4] = "right"
    winners_table.style.column_alignments[5] = "right"
    winners_table.style.horizontal_spacing = 8
    for k, caption in pairs ({"", "name", "members", "time", "points"}) do
      local label = winners_table.add{type = "label", caption = {caption}}
      label.style.font = "default-bold"
    end
  end

  for k, force in pairs(global.winners) do
    if k > 5 then break end
    if not global.force_points[force.name] then break end
    if not gui.winners_frame.winners_table[force.name] then

      local winners_table = gui.winners_frame.winners_table
      local place = winners_table.add{type = "label", caption = "#"..k}
      place.style.font = "default-semibold"
      place.style.font_color = {r = 1, g = 1, b = 0.2}
      local this = winners_table.add{type = "label", name = force.name, caption = {"", {"color."..force.name}, " ", {"team"}}}
      local color = {r = 0.8, g = 0.8, b = 0.8, a = 0.8}

      for i, check_force in pairs (global.force_list) do
        if force.name == check_force.name then
          local c = check_force.color
          color = {r = 1 - (1 - c[1]) * 0.5, g = 1 - (1 - c[2]) * 0.5, b = 1 - (1 - c[3]) * 0.5, a = 1}
          break
        end
      end

      this.style.font_color = color
      local caption = ""
      local count = 0
      for j, player in pairs(force.connected_players) do
        count = count + 1
        if count == 1 then
          caption = caption..player.name
        else
          caption = caption..", "..player.name
        end
      end
      local players_label = winners_table.add{type = "label", caption = caption}
      players_label.style.single_line = false
      players_label.style.maximal_width = 300
      winners_table.add{type = "label", caption = format_time(time_left())}
      winners_table.add{type = "label", caption = global.force_points[force.name]}
    end
  end
end

function set_spectator(player)
  if not player.connected then return end
  if not player.character then return end

  local character = player.character
  player.character = nil
  if character then
    character.destroy()
  end
  player.set_controller{type = defines.controllers.ghost}
end

function set_character(player, force)
  if not player.connected then return end
  if not force.valid then return end
  player.force = force
  local character = player.surface.create_entity{name = "character", position = player.surface.find_non_colliding_position("character", player.force.get_spawn_position(player.surface), 10, 2), force = force}
  player.set_controller{type = defines.controllers.character, character = character}
  give_equipment(player)
end

function give_starting_inventory(player)
  if not player.connected then return end
  if not player.character then return end
  if not global.starting_inventories[global.round_inventory] then return end
  for k, item in pairs (global.starting_inventories[global.round_inventory]) do
    local count = math.ceil(item.count*((#global.online_players/global.number_of_teams)/#player.force.players))
    if count > 0 then
      player.insert{name = item.name, count = count}
    end
  end
end

function give_equipment(player)
  if not player.connected then return end
  if not player.character then return end
  if not global.round_equipment then return end

  if global.round_equipment == "small" then
    player.insert{name = "power-armor", count = 1}
    local p_armor = player.get_inventory(5)[1].grid
    p_armor.put({name = "fusion-reactor-equipment"})
    p_armor.put({name = "exoskeleton-equipment"})
    p_armor.put({name = "personal-roboport-equipment"})
    p_armor.put({name = "personal-roboport-equipment"})
    p_armor.put({name = "personal-roboport-equipment"})
    player.insert{name="construction-robot", count = 30}
    player.insert{name="blueprint", count = 3}
    player.insert{name="deconstruction-planner", count = 1}
    return
  end
end

function shuffle_table(t)
  local count = 2
  local math = math
  local player = game.connected_players[math.random(#game.connected_players)]
  if player then
    count = (math.random(1 + string.len(player.name) + math.ceil(math.abs(player.position.x + player.position.y))) % 16) + 1
  end
  for k = 1, count do
    local iterations = #t
    for i = iterations, 2, -1 do
      local j = math.random(i)
      t[i], t[j] = t[j], t[i]
    end
  end
end

function format_time(ticks)
  local seconds = ticks / 60
  local minutes = math.floor((seconds)/60)
  local seconds = math.floor(seconds - 60*minutes)
  return string.format("%d:%02d", minutes, seconds)
end

function spairs(t, order)
  local keys = {}
  for k in pairs(t) do keys[#keys+1] = k end
  if order then
    table.sort(keys, function(a, b) return order(t, a, b) end)
  else
    table.sort(keys)
  end

  local i = 0
  return function()
    i = i + 1
    if keys[i] then
      return keys[i], t[keys[i]]
    end
  end
end

function fill_leaderboard()
  global.points = give_points()
  global.recent_points = {}
  for k, player in pairs (game.players) do
    update_leaderboard(player)
  end
end

function is_in_area(entity, force)
  local origin = force.get_spawn_position(entity.surface)
  local position = entity.position
  local max_distance = map_sets[global.current_map_index].map_set_size
  if origin.x + max_distance < position.x or
  origin.x - max_distance > position.x or
  origin.y + max_distance < position.y or
  origin.y - max_distance > position.y then
    return false
  end
  return true
end

team_production = {}

team_production.on_init = function ()
  setup_config()
  global.online_players = {}
  global.winners = {}
  global.points = {}
  global.recent_points = {}
  global.chests = {}
  global.input_chests = {}
  global.round_number = 0
  global.recent_round_number = 0
  global.number_of_teams = 2
  create_teams()
  fill_leaderboard()
  game.surfaces[1].always_day = true
  game.map_settings.pollution.enabled = false
end

team_production.on_player_created = function(event)
  local player = game.players[event.player_index]
  if not (player and player.valid) then return end
  create_task_frame(player)
  set_spectator(player)
  update_end_timer(player)
  create_visibility_buttons(player)
  update_spectate_button(player)
end

team_production.on_player_joined_game = function(event)
  local player = game.players[event.player_index]
  if not (player and player.valid) then return end

  if global.start_round_tick then
    set_spectator(player)
  else
    local player_on_team = false
    for k, check_player in pairs (global.online_players) do
      if player == check_player then
        player_on_team = true
        break
      end
    end

    if not player_on_team then
      player.force = game.forces.spectators
      set_spectator(player)
      create_joined_game_gui(player)
    end
  end
  update_end_timer(player)
  if global.end_round_tick then
    update_winners_list(player)
  end
  update_player_tags()
end

team_production.on_tick = function(event)
  check_end_of_round()
  check_chests()
  check_input_chests()
  check_clear_areas()
  check_set_areas()
  check_start_setting_entities()
  check_start_set_areas()
  check_start_round()
  update_gui()
  chart_all()
end

team_production.on_built_entity = function(event)
  local entity = event.created_entity
  if not (entity and entity.valid) then return end
  local position = entity.position
  local force = entity.force
  if not is_in_area(entity, force) then
    entity.destroy()
  end
end

team_production.on_gui_click = function(event)
  local player = game.players[event.player_index]
  local gui = event.element
  if not (player and player.valid and gui and gui.valid and gui.name) then return end
  if gui.name == "spectate_button" then
    if player.force.name == "spectators" then
      player.force = game.forces.player
      player.print({"left-spectators"})
      gui.caption = {"spectate"}
    else
      player.force = game.forces.spectators
      player.print({"joined-spectators"})
      gui.caption = {"unspectate"}
    end
    return
  end

  if gui.name == "join-game" then
    table.insert(global.online_players, player)
    set_player(player, #global.online_players)
    give_starting_inventory(player)
    player.gui.center.center_splash.destroy()
    return
  end

  if gui.name == "remain-spectate" then
    player.force = game.forces.spectators
    player.gui.center.center_splash.destroy()
    return
  end

  if gui.name == "toggle_leaderboard_button" then
    toggle_leaderboard(player)
    return
  end

end

team_production.on_gui_closed = function(event)
  local gui = event.element
  if not (gui and gui.valid and gui.name) then return end
  if gui.name == "leaderboard" then
    gui.destroy()
    return
  end
end

team_production.on_marked_for_deconstruction = function(event)
  local player = game.players[event.player_index]
  local entity = event.entity
  if not (player and player.valid and entity and entity.valid) then return end
  local force = player.force
  if not is_in_area(entity, force) then
    entity.cancel_deconstruction(force)
  end
end

return team_production
