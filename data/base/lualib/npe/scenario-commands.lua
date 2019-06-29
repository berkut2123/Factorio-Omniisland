local story = require('story_2')
local effect = require(mod_name .. ".lualib.effects")
local expansions = require(mod_name .. '.lualib.npe.expansions')
local locations = require(mod_name .. ".lualib.locations")
local misc = require(mod_name .. ".lualib.misc")

local fast_mode = function(data)
  local player = game.players[data.player_index]

  player.insert{name = "copper-plate", count = 1000}
  player.insert{name = "iron-plate", count = 1000}
  player.insert{name = "iron-gear-wheel", count = 500}
  player.insert{name = "copper-cable", count = 500}
  player.insert{name = "electronic-circuit", count = 500}
  player.insert{name = "wood", count = 100}
  player.insert{name = "coal", count = 100}
  player.insert{name = "automation-science-pack", count = 500}
  if type(tonumber(data.parameter)) == 'number' then
    game.speed = data.parameter
  else
    game.speed = 5
  end
end

local skip = function(data)
  local chapters = {}
  chapters['handcrafting'] = function (player)
    player.insert({name='stone-furnace',count=2})
    player.insert({name='transport-belt',count=2})
    player.insert({name='burner-mining-drill',count=2})
    player.insert({name='coal',count=20})
    player.insert({name='wooden-chest',count=1})
  end
  chapters['trigger-build'] = function (player)
    chapters['handcrafting'](player)
  end
  chapters['repair-assembler'] = function (player)
    chapters['trigger-build'](player)
  end
  chapters['repair-lab'] = function (player)
    effect.swap_tagged_with_fixed_recipe('iron-gear-wheel-wreck','iron-gear-wheel')
    player.insert({name='iron-plate',count=50})
    player.insert({name='transport-belt',count=5})
    chapters['repair-assembler'](player)
  end
  chapters['load-lab'] = function(player)
    chapters['repair-lab'](player)
    player.insert({name='iron-gear-wheel',count=50})
    player.insert({name='copper-plate',count=50})
    effect.swap_tagged_with_fixed_recipe('automation-science-pack-wreck','automation-science-pack')
    effect.swap_tagged_with_fixed_entity('lab-wreck','escape-pod-lab')
  end
  chapters['electronics'] = function (player)
    chapters['load-lab'](player)
    player.force.technologies["basic-mining"].researched = true
    player.force.technologies["basic-logistics"].enabled = true
    player.force.technologies["basic-electronics"].researched = true
    player.force.technologies["basic-mapping"].enabled = true
    player.insert({name='burner-mining-drill',count=3})
    player.insert({name='stone-furnace',count=7})
    player.insert({name='wooden-chest',count=7})
    player.insert({name='wood',count=15})
    player.insert({name='coal',count=100})
    player.insert({name='transport-belt',count=10})
    player.insert({name='iron-gear-wheel',count=20})
    player.insert({name='iron-plate',count=50})
    player.insert({name='copper-cable',count=50})
    player.insert({name='small-electric-pole',count=2})
    player.insert({name='automation-science-pack',count=20})
    player.insert({name='assembling-machine-1',count=1})
    effect.activate_research(true)
    effect.activate_side_menu(true)
    effect.activate_controller_gui(true)
  end
  chapters['build-radar'] = function (player)
    chapters['electronics'](player)
    player.insert({name='automation-science-pack',count=10})
    player.force.technologies["basic-mapping"].researched = true
    player.force.technologies["basic-mining"].researched = true
    player.insert({name='radar',count=1})
    player.minimap_enabled = true
  end
  chapters['scan-wreck'] = function (player)
    chapters['build-radar'](player)
    player.force.technologies["analyse-ship"].enabled = true
    player.force.technologies["basic-logistics"].enabled = true
    player.insert({name='automation-science-pack',count=30})
    effect.expand_map(expansions['west-expansion'],true)
  end
  chapters['prepare'] = function (player)
    chapters['scan-wreck'](player)
    player.force.technologies["analyse-ship"].researched = true
    player.force.technologies["basic-logistics"].researched = true
    player.insert({name='iron-plate',count=60})
    --player.insert({name='iron-gear-wheel',count=60})
    player.insert({name='copper-plate',count=50})
    player.insert({name='burner-inserter',count=10})
    player.insert({name='transport-belt',count=30})
    player.insert({name='copper-cable',count=10})
    --player.insert({name='burner-mining-drill',count=3})
    player.insert({name='stone-furnace',count=3})
    player.insert({name='electronic-circuit',count=10})
    player.insert({name='assembling-machine-1',count=2})
    player.insert({name='steam-engine',count=1})
    player.insert({name='lab',count=1})
    player.insert({name='offshore-pump',count=1})
    player.insert({name='boiler',count=1})
    player.insert({name='pipe',count=10})
  end
  chapters['rebuild'] = function (player)
    chapters['prepare'](player)
    player.force.technologies["improved-equipment"].enabled = true
    player.force.technologies["basic-optics"].enabled = true
    player.force.technologies["electric-mining"].enabled = true
    player.force.technologies["electric-inserter"].enabled = true
    player.insert({name='iron-gear-wheel',count=10})
    player.insert({name='copper-plate',count=10})
    player.insert({name='iron-plate',count=40})
    player.insert({name='coal',count=50})
    player.insert({name='automation-science-pack',count=10})
    effect.expand_map(expansions['east-expansion'],true)
    game.forces['player'].set_spawn_position(locations.get_pos('pond-player-spawn'),locations.get_main_surface())
    player.teleport(locations.get_pos('pond-player-spawn'))
  end
  chapters['military'] = function (player)
    chapters['rebuild'](player)
    player.force.technologies["improved-equipment"].researched = true
    player.force.technologies["basic-military"].enabled = true
    player.teleport(locations.get_pos('pond-player-spawn'))
  end
  chapters['entrench'] = function (player)
    chapters['military'](player)
    player.force.technologies["basic-military"].researched = true
    player.force.technologies["active-defense"].enabled = true
    player.force.technologies["passive-defense"].enabled = true
    player.force.technologies["repair-tech"].enabled = true
    player.insert({name='pistol',count=1})
    player.insert({name='iron-plate',count=400})
    player.insert({name='firearm-magazine',count=10})
    player.insert({name='electric-mining-drill',count=8})
    player.insert({name='gun-turret',count=1})
  end
  chapters['fortify'] = function (player)
    chapters['entrench'](player)
    player.force.technologies["active-defense"].researched = true
    player.force.technologies["repair-tech"].researched = true
    player.force.technologies["electric-mining"].researched = true
    player.force.technologies["basic-optics"].researched = true
    player.insert({name='firearm-magazine',count=150})
    player.insert({name='gun-turret',count=9})
  end
  chapters['survive'] = function (player)
    chapters['fortify'](player)
    effect.expand_map(expansions['final'],true)
    player.force.technologies["passive-defense"].researched = true
    player.force.technologies["improved-equipment"].enabled = true
    player.insert({name='firearm-magazine',count=2000})
    player.insert({name='automation-science-pack',count=2000})
    player.insert({name='logistic-science-pack',count=2000})
    player.insert({name='lab',count=10})
    player.insert({name='small-electric-pole',count=10})
    player.insert({name='gun-turret',count=9})
  end
  local player = game.players[data.player_index]
  if chapters[data.parameter] then
    chapters[data.parameter](player)
    story.jump_to_node("main_story", data.parameter)
    global.compilatron.reset = true
  else
    local chapter_list = "("
    for index, _ in pairs(chapters) do
      chapter_list = chapter_list..index..','
    end
    player.print("supported chapters: "..chapter_list)
  end
end

local spawn = function(data)
  local player = game.players[data.player_index]
  local surface = player.surface
  local character = surface.create_entity({
    name="character",
    position=player.position,
    force = game.forces.player,
  })
  player.character = character
end

local data_output = function()
  print(serpent.line(global.behaviors))
end

local convert = function(data)
  local player = game.players[data.player_index]
  if data.parameter and type(tonumber(data.parameter)) == 'number' then
    player.print(misc.convert_ticks_to_string(data.parameter))
  else
    player.print("please provide a number to convert")
  end
end

local render_stats = function()
  misc.render_stats_to_area('starting-area')
end

if campaign_debug_mode then
  commands.add_command("skip","Skip to the given story node with everything you need to continue", skip)
  commands.add_command("fast_mode", "Grants starting items and sets game speed high", fast_mode)
  commands.add_command("spawn", "Gives the player a new body", spawn)
  commands.add_command("data_output", "prints the player behavior data", data_output)
  commands.add_command("render_stats", "prints the player behavior data to the world", render_stats)
  commands.add_command("convert", "converts ticks into a string", convert)
end