local config = {script_data = {}}

config.get_config = function()

  local data = {}


  data.game_config =
  {
    time_limit = 0,
    allow_spectators = false,
    no_rush_time = 0,
    base_exclusion_time = 0,
    reveal_team_positions = true,
    reveal_map_center = true,
    team_walls = true,
    team_turrets = true,
    turret_ammunition =
    {
      options = {"firearm-magazine"},
      selected = "firearm-magazine"
    },
    team_artillery = false,
    give_artillery_remote = false,
    auto_new_round_time = 0,
    protect_empty_teams = false,
    enemy_building_restriction = false,
    neutral_chests = false,
    seed = 0
  }

  data.victory =
  {
    last_silo_standing = true,
    space_race = true,
    required_rockets_sent = 1,
    production_score = false,
    required_production_score = 50000000,
    oil_harvest = false,
    required_oil = 1000000,
    kill_score = false,
    required_kill_score = 1000000
  }

  local items = game.item_prototypes

  local entity_name = "gun-turret"
  local prototype = game.entity_prototypes[entity_name]
  if not prototype then
    data.game_config.team_turrets = nil
    data.game_config.turret_ammunition = nil
  else
    local category = prototype.attack_parameters.ammo_category
    if category then
      local ammos = {}
      for name, item in pairs (items) do
        if item.type == "ammo" then
          local ammo = item.get_ammo_type()
          if ammo and ammo.category == category then
            table.insert(ammos, name)
          end
        end
      end
      data.game_config.turret_ammunition.options = ammos
      if not items["firearm-magazine"] then
        data.game_config.turret_ammunition.selected = ammos[1] or ""
      end
    end
  end

  data.team_config =
  {
    friendly_fire = true,
    unlock_combat_research = false,
    defcon_mode = false,
    max_players = 0,
    defcon_timer = 5,
    starting_chest_multiplier = 5,
    research_level =
    {
      options = {"none"},
      selected = "none"
    },
    average_team_displacement = math.floor(game.surfaces[1].get_starting_area_radius()) * 4,
    always_day = false,
    evolution_factor = 0,
    duplicate_starting_area_entities = false,
    technology_price_multiplier = 1
  }

  local packs = {}
  local sorted_packs = {}
  local techs = game.technology_prototypes
  for k, tech in pairs (techs) do
    for k, ingredient in pairs (tech.research_unit_ingredients) do
      if not packs[ingredient.name] then
        packs[ingredient.name] = true
        local order = tostring(items[ingredient.name].order) or "Z-Z"
        local added = false
        for k, t in pairs (sorted_packs) do
          if order < t.order then
            table.insert(sorted_packs, k, {name = ingredient.name, order = order})
            added = true
            break
          end
        end
        if not added then
          table.insert(sorted_packs, {name = ingredient.name, order = order})
        end
      end
    end
  end

  for k, t in pairs (sorted_packs) do
    table.insert(data.team_config.research_level.options, t.name)
  end

  data.research_ingredient_list = {}
  for k, research in pairs (data.team_config.research_level.options) do
    data.research_ingredient_list[research] = false
  end

  data.colors =
  {
    { name = "orange" , color = { r = 0.869, g = 0.5  , b = 0.130, a = 0.5 }},
    { name = "purple" , color = { r = 0.485, g = 0.111, b = 0.659, a = 0.5 }},
    { name = "red"    , color = { r = 0.815, g = 0.024, b = 0.0  , a = 0.5 }},
    { name = "green"  , color = { r = 0.093, g = 0.768, b = 0.172, a = 0.5 }},
    { name = "blue"   , color = { r = 0.155, g = 0.540, b = 0.898, a = 0.5 }},
    { name = "yellow" , color = { r = 0.835, g = 0.666, b = 0.077, a = 0.5 }},
    { name = "pink"   , color = { r = 0.929, g = 0.386, b = 0.514, a = 0.5 }},
    { name = "white"  , color = { r = 0.8  , g = 0.8  , b = 0.8  , a = 0.5 }},
    { name = "black"  , color = { r = 0.1  , g = 0.1  , b = 0.1,   a = 0.5 }},
    { name = "gray"   , color = { r = 0.4  , g = 0.4  , b = 0.4,   a = 0.5 }},
    { name = "brown"  , color = { r = 0.300, g = 0.117, b = 0.0,   a = 0.5 }},
    { name = "cyan"   , color = { r = 0.275, g = 0.755, b = 0.712, a = 0.5 }},
    { name = "acid"   , color = { r = 0.559, g = 0.761, b = 0.157, a = 0.5 }}
  }

  data.color_map = {}
  for k, color in pairs (data.colors) do
    data.color_map[color.name] = k
  end

  data.teams =
  {
    {name = game.backer_names[math.random(#game.backer_names)], color = "orange", team = "-", members = {}},
    {name = game.backer_names[math.random(#game.backer_names)], color = "purple", team = "-", members = {}}
  }


  data.starting_equipment =
  {
    options = {"none", "small", "medium", "large"},
    selected = "none"
  }

  data.starting_chest =
  {
    options = {"none", "small", "medium", "large"},
    selected = "none"
  }

  data.inventory_list =
  {
    none =
    {},
    small =
    {
      ["iron-plate"] = 200,
      ["pipe"] = 100,
      ["pipe-to-ground"] = 20,
      ["copper-plate"] = 200,
      ["iron-gear-wheel"] = 200,
      ["electronic-circuit"] = 200,
      ["transport-belt"] = 400,
      ["repair-pack"] = 20,
      ["inserter"] = 100,
      ["small-electric-pole"] = 50,
      ["burner-mining-drill"] = 50,
      ["stone-furnace"] = 50,
      ["burner-inserter"] = 100,
      ["assembling-machine-1"] = 20,
      ["electric-mining-drill"] = 20,
      ["boiler"] = 5,
      ["steam-engine"] = 10,
      ["offshore-pump"] = 2,
      ["wood"] = 50
    },
    medium =
    {
      ["iron-plate"] = 200,
      ["pipe"] = 100,
      ["pipe-to-ground"] = 20,
      ["iron-gear-wheel"] = 100,
      ["copper-plate"] = 100,
      ["steel-plate"] = 100,
      ["electronic-circuit"] = 400,
      ["transport-belt"] = 400,
      ["underground-belt"] = 20,
      ["splitter"] = 20,
      ["repair-pack"] = 20,
      ["inserter"] = 150,
      ["small-electric-pole"] = 100,
      ["medium-electric-pole"] = 50,
      ["fast-inserter"] = 50,
      ["long-handed-inserter"] = 50,
      ["burner-inserter"] = 100,
      ["burner-mining-drill"] = 50,
      ["electric-mining-drill"] = 40,
      ["stone-furnace"] = 100,
      ["steel-furnace"] = 30,
      ["assembling-machine-1"] = 40,
      ["assembling-machine-2"] = 20,
      ["boiler"] = 10,
      ["steam-engine"] = 20,
      ["chemical-plant"] = 20,
      ["oil-refinery"] = 5,
      ["pumpjack"] = 8,
      ["offshore-pump"] = 2,
      ["wood"] = 50
    },
    large =
    {
      ["iron-plate"] = 200,
      ["pipe"] = 100,
      ["pipe-to-ground"] = 20,
      ["copper-plate"] = 200,
      ["steel-plate"] = 200,
      ["electronic-circuit"] = 400,
      ["iron-gear-wheel"] = 250,
      ["transport-belt"] = 400,
      ["underground-belt"] = 40,
      ["splitter"] = 40,
      ["repair-pack"] = 20,
      ["inserter"] = 200,
      ["burner-inserter"] = 50,
      ["small-electric-pole"] = 50,
      ["burner-mining-drill"] = 50,
      ["electric-mining-drill"] = 50,
      ["stone-furnace"] = 100,
      ["steel-furnace"] = 50,
      ["electric-furnace"] = 20,
      ["assembling-machine-1"] = 50,
      ["assembling-machine-2"] = 40,
      ["assembling-machine-3"] = 20,
      ["fast-inserter"] = 100,
      ["long-handed-inserter"] = 100,
      ["medium-electric-pole"] = 50,
      ["substation"] = 10,
      ["big-electric-pole"] = 10,
      ["boiler"] = 10,
      ["steam-engine"] = 20,
      ["chemical-plant"] = 20,
      ["oil-refinery"] = 5,
      ["pumpjack"] = 10,
      ["offshore-pump"] = 2,
      ["wood"] = 50
    }
  }

  data.equipment_list =
  {
    none =
    {
      ["pistol"] = 1,
      ["firearm-magazine"] = 10
    },
    small =
    {
      ["submachine-gun"] = 1,
      ["firearm-magazine"] = 30,
      ["shotgun"] = 1,
      ["shotgun-shell"] = 20,
      ["iron-axe"] = 1,
      ["heavy-armor"] = 1
    },
    medium =
    {
      ["steel-axe"] = 3,
      ["submachine-gun"] = 1,
      ["firearm-magazine"] = 40,
      ["shotgun"] = 1,
      ["shotgun-shell"] = 20,
      ["car"] = 1,
      ["modular-armor"] = 1
    },
    large =
    {
      ["steel-axe"] = 3,
      ["submachine-gun"] = 1,
      ["piercing-rounds-magazine"] = 40,
      ["combat-shotgun"] = 1,
      ["piercing-shotgun-shell"] = 20,
      ["rocket-launcher"] = 1,
      ["rocket"] = 80,
      ["construction-robot"] = 25,
      ["car"] = 1,
      ["power-armor"] = 1,
      ["fusion-reactor-equipment"] = 1,
      ["exoskeleton-equipment"] = 1,
      ["energy-shield-equipment"] = 2,
      ["personal-roboport-mk2-equipment"] = 1
    }
  }

  data.prototypes =
  {
    chest = "steel-chest",
    wall = "stone-wall",
    gate = "gate",
    turret = "gun-turret",
    artillery = "artillery-turret",
    artillery_ammo = "artillery-shell",
    silo = "rocket-silo",
    tile_1 = "refined-concrete",
    tile_2 = "refined-hazard-concrete-left",
    artillery_remote = "artillery-targeting-remote",
    oil = "crude-oil",
    oil_resource = "crude-oil"
  }

  data.silo_offset = {x = 0, y = 0}
  data.chest_offset = {x = 0, y = 16}

  return data
end

config.give_equipment = function(player)
  if not config.script_data.config.equipment_list then return end
  if not config.script_data.config.starting_equipment then return end
  local setting = config.script_data.config.starting_equipment.selected
  if not setting then return end
  local equipment = config.script_data.config.equipment_list[setting]
  if not equipment then return end
  local items = game.item_prototypes
  local list = {items = {}, armor, equipment = {}}
  for name, count in pairs (equipment) do
    local item = items[name]
    if item then
      if item.type == "armor" then
        local count = count
        if not list.armor then
          list.armor = item
        end
        count = count - 1
        if count > 0 then
          list.items[item] = (list.items[item] or 0) + count
        end
      elseif item.place_as_equipment_result then
        list.equipment[item] = (list.equipment[item] or 0) + count
      else
        list.items[item] = (list.items[item] or 0) + count
      end
    else
      equipment[name] = nil
    end
  end
  local put_equipment = false
  if list.armor then
    local stack = player.get_inventory(defines.inventory.character_armor)[1]
    stack.set_stack{name = list.armor.name}
    local grid = stack.grid
    if grid then
      put_equipment = true
      for prototype, count in pairs (list.equipment) do
        local equipment = prototype.place_as_equipment_result
        for k = 1, count do
          if not grid.put{name = equipment.name} then
            player.insert{name = prototype.name}
          end
        end
      end
    end
  end

  if not put_equipment then
    for prototype, count in pairs (list.equipment) do
      player.insert{name = prototype.name, count = count}
    end
  end

  for prototype, count in pairs (list.items) do
    player.insert{name = prototype.name, count = count}
  end
end

config.localised_names =
{
  seed = {"gui-map-generator.map-seed"}
}

-- "" for no tooltip
config.localised_tooltips =
{
  friendly_fire = "",
  always_day = "",
  evolution_factor = "",
  duplicate_starting_area_entities = "",
  friendly_fire = "",
  technology_price_multiplier = ""
}

return config
