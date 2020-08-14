local Spaceship = {}

Spaceship.names_tech_integrity = {
  {name = mod_prefix.."spaceship-integrity", bonus_per_level = 100, infinite = false},
  {name = mod_prefix.."factory-spaceship-1", bonus_per_level = 500, infinite = true}
}
Spaceship.integrity_base = 300

Spaceship.name_spaceship_console = mod_prefix .. "spaceship-console"
Spaceship.name_spaceship_console_output = mod_prefix .. "spaceship-console-output"
Spaceship.console_output_offset = {x = 1.5, y = -1}

Spaceship.name_spaceship_clamp_keep = mod_prefix .. "spaceship-clamp"
Spaceship.name_spaceship_clamp_place = mod_prefix .. "spaceship-clamp-place"

Spaceship.engines = {
  [mod_prefix .. "spaceship-rocket-engine"] = { name = mod_prefix .. "spaceship-rocket-engine", thrust = 100 / 5, max_energy = 1837 },
  [mod_prefix .. "spaceship-antimatter-engine"]= { name = mod_prefix .. "spaceship-antimatter-engine", thrust = 500 / 5, max_energy = 18370 }
}
Spaceship.names_engines = {}

Spaceship.names_booster_tanks = {
  mod_prefix .. "spaceship-rocket-booster-tank",
  mod_prefix .. "spaceship-antimatter-booster-tank"
}

--[[
Spaceship.name_spaceship_rocket_engine = mod_prefix .. "spaceship-rocket-engine"
Spaceship.name_spaceship_rocket_booster_tank = mod_prefix .. "spaceship-rocket-booster-tank"
Spaceship.rocket_engine_thrust = 100
Spaceship.rocket_engine_thrust_full_energy = 1837 -- the energy the furnaces contains when fully powered

Spaceship.name_spaceship_antimatter_engine = mod_prefix .. "spaceship-antimatter-engine"
Spaceship.name_spaceship_antimatter_booster_tank = mod_prefix .. "spaceship-antimatter-booster-tank"
Spaceship.antimatter_engine_thrust = 200
Spaceship.antimatter_engine_thrust_full_energy = 18370 -- the energy the furnaces contains when fully powered
]]--

Spaceship.names_spaceship_floors = {mod_prefix .. "spaceship-floor"}
Spaceship.names_spaceship_walls = {mod_prefix .. "spaceship-wall"}
Spaceship.names_spaceship_gates = {mod_prefix .. "spaceship-gate"}
Spaceship.names_spaceship_bulkheads = {
  mod_prefix .. "spaceship-wall",
  mod_prefix .. "spaceship-gate",
  Spaceship.name_spaceship_clamp_keep,
}
for _, engine in pairs(Spaceship.engines) do
  table.insert(Spaceship.names_engines, engine.name)
  table.insert(Spaceship.names_spaceship_bulkheads, engine.name)
end
Spaceship.signal_for_own_spaceship_id = {type = "item", name = Spaceship.name_spaceship_console}
Spaceship.signal_for_destination_spaceship = {type = "virtual", name = mod_prefix.."spaceship"}
Spaceship.signal_for_speed = {type = "virtual", name = "signal-speed"}
Spaceship.signal_for_distance = {type = "virtual", name = "signal-distance"}
Spaceship.signal_for_launch = {type = "virtual", name = mod_prefix.."spaceship-launch"}
Spaceship.signal_for_anchor_using_left = {type = "virtual", name = mod_prefix.."anchor-using-left-clamp"}
Spaceship.signal_for_anchor_using_right = {type = "virtual", name = mod_prefix.."anchor-using-right-clamp"}
Spaceship.signal_for_anchor_to_left = {type = "virtual", name = mod_prefix.."anchor-to-left-clamp"}
Spaceship.signal_for_anchor_to_right = {type = "virtual", name = mod_prefix.."anchor-to-right-clamp"}

Spaceship.energy_per_launch_integrity_delta_v = 150 * 1000

Spaceship.name_spaceship_gui_root = mod_prefix.."spaceship-gui"
Spaceship.name_window_close = "spaceship_close_button"

Spaceship.particle_spawn_range = 24 -- same as laser turret range
Spaceship.particles = {
  ["speck"] = { multiplier = 1/1000, speed = 1/100, min_speed = 0,
      graphic_name = mod_prefix.."spaceship-speck-graphic"
  },
  ["rock-small"] = { multiplier = 1/3000, speed = 1/300, min_speed = 5,
      projectile_name =   mod_prefix.."spaceship-obstacle-rock-small-projectile",
      graphic_name =      mod_prefix.."spaceship-obstacle-rock-small-graphic",
      targetable_name =   mod_prefix.."spaceship-obstacle-rock-small-targetable",
  },
  ["rock-medium"] = { multiplier = 1/20000, speed = 1/400, min_speed = 15, destroys_floor = true,
      projectile_name =   mod_prefix.."spaceship-obstacle-rock-medium-projectile",
      graphic_name =      mod_prefix.."spaceship-obstacle-rock-medium-graphic",
      targetable_name =   mod_prefix.."spaceship-obstacle-rock-medium-targetable",
  },
  ["rock-large"] = { multiplier = 1/2000000, speed = 1/1000, min_speed = 50, min_size = 1000, destroys_floor = true,
      projectile_name =   mod_prefix.."spaceship-obstacle-rock-large-projectile",
      graphic_name =      mod_prefix.."spaceship-obstacle-rock-large-graphic",
      targetable_name =   mod_prefix.."spaceship-obstacle-rock-large-targetable",
  },
}
Spaceship.all_targetables = {}
for _, particle in pairs(Spaceship.particles) do
  if particle.targetable_name then
    table.insert(Spaceship.all_targetables, particle.targetable_name)
  end
end

Spaceship.partical_speed_power = 0.75 -- 0.5 would be sqrt, 0 is static, 1 is linear with speed.

Spaceship.space_drag = 1/100 / 5
Spaceship.minimum_impulse = 1/100
Spaceship.minimum_mass = 1
Spaceship.speed_taper = 200
Spaceship.travel_speed_multiplier = 1/200

Spaceship.integrity_pulse_interval = 60 * 60 * 10

Spaceship.tile_status = {}

--[[
change to:
{
  outer = 0 or 1. outer skin of tiles including diagonals
  floor = 0 or 1, has floor otherwise exterior
  exposed = 0 for contained, or higher for any tile exposed to space
  wall = 0 or 1, walls only
  bulkhead = 0 or 1, any bulkhead
  connection nil or distance to console.
}

]]--

Spaceship.tile_status.exterior = 1 -- any tile not with flooring (without bulkhead)
Spaceship.tile_status.wall_exterior = 2 -- bulkeahd outside of flooring
Spaceship.tile_status.bulkhead_exterior = 3 -- bulkeahd outside of flooring
Spaceship.tile_status.floor = 4 -- unknown floor
Spaceship.tile_status.wall = 5 -- unknown bulkhead
Spaceship.tile_status.bulkhead = 6 -- unknown bulkhead
Spaceship.tile_status.floor_exterior = 7 -- outside floor
Spaceship.tile_status.floor_interior = 8 -- contained floor
Spaceship.tile_status.floor_console_disconnected = 9 -- disconnected floor
Spaceship.tile_status.wall_console_disconnected = 10 -- disconnected bulkhead
Spaceship.tile_status.bulkhead_console_disconnected = 11 -- disconnected bulkhead
Spaceship.tile_status.floor_console_connected = 12 -- connected floor
Spaceship.tile_status.wall_console_connected = 13 -- connected bulkhead
Spaceship.tile_status.bulkhead_console_connected = 14 -- connected bulkhead


  --[[ tile statuses
    1 = exterior
    2 = floor_pending (on the edge of checking, used for next tick)
    3 = unknown floor (exists but unknown containment statis)
    4 = exterior floor
    5 = bulkhead (floor with wall or gate)
    6 = interior (contained) floor
  ]]--

--[[
console sends out a pule over all connected spaceship tiles (with a max based on tech)
then consider all tiles with wall or gate.
divide tiles into groups, ones that touch the outside are not part of the ship.
]]--

Spaceship.names = {
  "Abaddon", "Ackbar", "Aegis", "Albatross", "Alchemist", "Albion", "Alexander",
    "Angler", "Apparition", "ArchAngel", "Assassin", "Avenger", "Axe",
  "Bade", "Bardiche", "Battleth", "Blackbird", "Bounty Hunter", "Breaker",
    "Brigandine","Bullfinch", "Buzzard",
  "Cartographer", "Catface", "Calamari", "Canary", "Caravel", "Carrak", "Citadel", "Clockwerk",
    "Chimera", "Coot", "Cormorant", "Crane", "Crossbill", "Crow", "Cuckoo",
  "Darkstar", "Dauntless", "Desby", "Dragon", "Drake", "Dream", "Doombringer",
    "Dolphin", "Devourer", "Dunn",
  "Eagle", "Earthshaker", "Earl Grey", "Egret", "Eider", "Ember", "Enigma", "Eris", "Excalibur",
  "Falcon", "Falx", "Feral Pigeon", "Firecrest", "Firefly", "Flying Duckman",
    "Fountain", "Fulmar",
  "Gadwall", "Gannet", "Garganey", "Gigantosaurus", "Ghast", "Ghoul", "Ghost",
    "Glaive", "Goldcrest", "Goldeneye", "Goldfinch", "Goosander", "Goose",
    "Goshawk", "Grasshopper", "Greenfinch", "Griffon", "Grouse", "Guillemot",
  "Halberd", "Hammer", "Hammerhead", "Harrier", "Hawk", "Harking", "Heron", "Hippogryph", "Honeybadger", "Honeybear",
  "Iron Cordon", "Ingot", "Intrepid", "Invoker", "Isabella",
  "Jack Snipe", "Jackdaw", "Jay",
  "Kamsta", "Katherine", "Kestrel", "Kingfisher", "Kite", "Knight", "Kraken",
  "Lapwing", "Lance", "Lancer", "Lick", "Linnet", "Lucas",
  "Magi", "Magpie", "Mallard",  "Mangonel", "Medusa", "Memento", "Merlin",
    "Mistress", "Mocking Jay", "Monstrosity", "Moorhen", "Musk",
  "Naga", "Narwhal", "Nebulon", "Nemesis", "Newton", "Nexela", "Nial", "Nicholas",
    "Nightjar", "Nissa", "Nightingale", "Night Stalker",
  "Oracle", "Orca", "Ostricth", "Outrider", "Owl",
  "Partridge", "Pangolin", "Penguin", "Peregrine", "Petrel", "Phantom",
    "Pheasant", "Phoenix", "Piccard", "Pintail", "Pioneer",
    "Pipit", "Plover", "Prophet", "Prowler", "Pochard", "Puffin",
  "Quail",
  "Radiance", "Raptor", "Raven", "Razor", "Razorbill", "Red Kite", "Redshank",
    "Redstart", "Redwing", "Requiem",
    "Riccardo", "Robin", "Roc", "Rook", "Rossi", "Rogue", "Ruff",
  "Sanderling", "Sawfish", "Scythe", "Seraph", "Serenity", "Sickle", "Shadow",
    "Shag", "Sharknado", "Shelduck", "Sherrif", "Shoveler", "Sin Eater", "Siren",
    "Siskin",  "Skylark", "Skyshark", "Skywalker", "Skywrath", "Smew", "Snek",
    "Snipe",  "Sparrowhawk", "Spear", "Spectre", "Spinosaur", "Spynx",
    "Starchaser", "Starling", "Stonechat", "Swallow", "Swan", "Swift", "Swordfish",
  "Tachyon", "Tali", "Tantive", "Teal", "Templar", "Terrorblade", "Tesla", "Thanatos",
    "Throne", "Thrush", "Tigress", "Tin Can", "Titan", "Trebuchet",
    "Trimaran", "Turnstone", "Turing", "Tusk", "Twite",
  "Ursa", "Undertaker", "Undying Dodo", "Underlord",
  "Vengeance", "Viper", "Virtue", "Visage", "Void Hunter", "Volt", "Vulture",
  "Wagtail", "Warbird", "Warbler", "Warcry", "Warden", "Warlock", "Warlord", "Warrunner",
    "Waxwing", "Weaver", "Wheatear", "Whimbrel", "Whinchat", "Whitestar",
    "Wigeon", "Windranger", "Woodcock", "Wraith", "Wrath", "Wren", "Wyvern", "Wyrm",
  "Xena", "Xenon", "Xylem",
  "Yacht", "Yellowhammer", "Yettie",
  "Zenith", "Zilla", "Zombie", "Zweihander"
}



function Spaceship.is_floor(tile_name)
  return Util.table_contains(Spaceship.names_spaceship_floors, tile_name)
end

function Spaceship.is_wall(entity_name)
  return Util.table_contains(Spaceship.names_spaceship_walls, entity_name)
end

function Spaceship.is_gate(entity_name)
  return Util.table_contains(Spaceship.names_spaceship_gates, entity_name)
end

function Spaceship.is_wall_or_gate(entity_name)
  return Spaceship.is_wall(entity_name) or Spaceship.is_gate(entity_name)
end

function Spaceship.from_index(spaceship_index)
  if global.spaceships then return global.spaceships[tonumber(spaceship_index)] end
end

function Spaceship.from_entity(entity)
  for _, spaceship in pairs(global.spaceships) do
    if spaceship.console and spaceship.console.valid and spaceship.console.unit_number == entity.unit_number then
      return spaceship
    end
  end
end

function Spaceship.from_surface_position(surface, position)
  local x = math.floor(position.x or position[1])
  local y = math.floor(position.y or position[2])
  -- TODO allow multiple spaceships per surface
  for _, spaceship in pairs(global.spaceships) do
    if spaceship.own_surface_index then
      if spaceship.own_surface_index == surface.index then
        return spaceship
      end
    elseif spaceship.console and spaceship.console.valid and spaceship.console.surface == surface then
      -- check tiles
      if spaceship.known_tiles and spaceship.known_tiles[x] and spaceship.known_tiles[x][y] and
        (spaceship.known_tiles[x][y] == Spaceship.tile_status.floor_console_connected
        or spaceship.known_tiles[x][y] == Spaceship.tile_status.bulkhead_console_connected) then
          return spaceship
      end
    end
  end
end


function Spaceship.from_name(name)
  for _, spaceship in pairs(global.spaceships) do
    if spaceship.name == name then
      return spaceship
    end
  end
end

function Spaceship.from_own_surface_index(surface_index) -- can't be a zone
  if global.spaceships then
    for _, spaceship in pairs(global.spaceships) do
      if spaceship.own_surface_index == surface_index then
        return spaceship
      end
    end
  end
end

function Spaceship.get_own_surface(spaceship)
  return game.surfaces["spaceship-"..spaceship.index]
end

function Spaceship.get_current_surface(spaceship)
  if spaceship.zone_index then
    local zone = Zone.from_zone_index(spaceship.zone_index)
    if zone then
      return Zone.get_make_surface(zone)
    end
  end
  return Spaceship.get_own_surface(spaceship)
end


function Spaceship.get_integrity_limit(force)
  local integrity = Spaceship.integrity_base
  for _, tech in pairs(Spaceship.names_tech_integrity) do
    if tech.infinite then
      if force.technologies[tech.name] then
        integrity = integrity + (force.technologies[tech.name].level - 1) * tech.bonus_per_level
      end
    else
      local i = 1
      while force.technologies[tech.name.."-"..i]
        and force.technologies[tech.name.."-"..i].researched do
        integrity = integrity + tech.bonus_per_level
        i = i + 1
      end
    end
  end
  return integrity
end

function Spaceship.get_launch_energy_cost(spaceship)
  if spaceship.zone_index and spaceship.integrity_stress then
    local zone = Zone.from_zone_index(spaceship.zone_index)
    if zone then
      local delta_v = Zone.get_launch_delta_v(zone)
      local energy_cost = delta_v * spaceship.integrity_stress * Spaceship.energy_per_launch_integrity_delta_v
      return energy_cost
    end
  end
end

function Spaceship.get_launch_energy(spaceship)
  --spaceship.launch_energy = nil
  spaceship.launch_energy = nil
  if spaceship.zone_index and spaceship.console and spaceship.console.valid and spaceship.known_tiles then
    spaceship.launch_energy = 0
    local surface = spaceship.console.surface
    local tanks = surface.find_entities_filtered{name = Spaceship.names_booster_tanks }
    for _, tank in pairs(tanks) do
      local tank_x = math.floor(tank.position.x)
      local tank_y = math.floor(tank.position.y)

      if spaceship.known_tiles[tank_x] and spaceship.known_tiles[tank_x][tank_y]
        and spaceship.known_tiles[tank_x][tank_y] == Spaceship.tile_status.floor_console_connected
        and #tank.fluidbox > 0 then
          local fluidbox = tank.fluidbox[1] or {amount = 0}
          if fluidbox.amount > 0 then
            spaceship.launch_energy = spaceship.launch_energy + fluidbox.amount * game.fluid_prototypes[fluidbox.name].fuel_value
          end
      end
    end
  end
  return spaceship.launch_energy
end

function Spaceship.get_console_or_middle_position(spaceship)
  if spaceship.console and spaceship.console.valid then
    return spaceship.console.position
  end
  if spaceship.known_tiles_average_x and spaceship.known_tiles_average_y then
    return {x = known_tiles_average_x, y = known_tiles_average_y}
  end
end

function Spaceship.get_boarding_position(spaceship)
  if spaceship.known_tiles_average_x and spaceship.known_bounds then
    return {
      x = spaceship.known_bounds.left_top.x + math.random() * (spaceship.known_bounds.right_bottom.x - spaceship.known_bounds.left_top.x),
      y = spaceship.known_bounds.right_bottom.y + 32
    }
  end
  if spaceship.console and spaceship.console.valid then
    return Util.vectors_add(spaceship.console.position, {x = 64 * ( math.random() - 0.5), y = 64})
  end
end

function Spaceship.gui_close(player)
  if player.gui.left[Spaceship.name_spaceship_gui_root] then
    player.gui.left[Spaceship.name_spaceship_gui_root].destroy()
  end
end


function Spaceship.destroy(spaceship)
  if spaceship.zone_index or not spaceship.own_surface_index then -- don't remove the whole surface if in space
    global.spaceships[spaceship.index]  = nil
    spaceship.valid = false

    -- if a player has this gui open then close it
    local gui_name = Spaceship.name_spaceship_gui_root
    for _, player in pairs(game.connected_players) do
      if player.gui.left[gui_name] and player.gui.left[gui_name].spaceship_index.children_names[1] == (""..spaceship.index) then
          player.gui.left[gui_name].destroy()
        end
    end
    if spaceship.own_surface_index then
      game.delete_surface(spaceship.own_surface_index)
      spaceship.own_surface_index = nil
    end
  end
end

function Spaceship.get_destination_zone(spaceship)
  if spaceship.destination then
    if spaceship.destination.type == "spaceship" then
      return Spaceship.from_index(spaceship.destination.index)
    else
      return Zone.from_zone_index(spaceship.destination.index)
    end
  end
end

function Spaceship.is_near_destination(spaceship)
  if spaceship.near then
    if not spaceship.destination then
      return true
    elseif spaceship.near.type == spaceship.destination.type
     and spaceship.near.index == spaceship.destination.index then
       return true
    end
  end
  return false
end

function Spaceship.is_at_destination(spaceship)
  if spaceship.destination and spaceship.destination.type ~= "spaceship" and spaceship.zone_index and spaceship.zone_index == spaceship.destination.index then
     return true
  end
  return false
end

function Spaceship.launch(spaceship)
  if not spaceship.is_launching then Log.trace("Abort launch not is_launching") return end

  spaceship.is_launching = false

  if not spaceship.zone_index then Log.trace("Abort launch no zone_index") return end
  if not spaceship.integrity_valid then Log.trace("Abort launch not integrity_valid") return end
  if not spaceship.known_tiles then Log.trace("Abort launch not known_tiles") return end
  if not spaceship.console and spaceship.console.valid then Log.trace("Abort launch not known_tiles") return end

  local current_surface = spaceship.console.surface
  local current_zone = Zone.from_surface(current_surface)

  local required_energy = Spaceship.get_launch_energy_cost(spaceship)

  --Spaceship.get_launch_energy(spaceship)
  -- same code but keep tanks references
  spaceship.launch_energy = 0
  local tanks = current_surface.find_entities_filtered{name = Spaceship.names_booster_tanks }
  for _, tank in pairs(tanks) do
    local tank_x = math.floor(tank.position.x)
    local tank_y = math.floor(tank.position.y)

    if spaceship.known_tiles[tank_x] and spaceship.known_tiles[tank_x][tank_y]
      and spaceship.known_tiles[tank_x][tank_y] == Spaceship.tile_status.floor_console_connected
      and #tank.fluidbox > 0 then
        local fluidbox = tank.fluidbox[1] or {amount = 0}
        if fluidbox.amount > 0 then
          spaceship.launch_energy = spaceship.launch_energy + fluidbox.amount * game.fluid_prototypes[fluidbox.name].fuel_value
        end
    end
  end

  if not (required_energy and spaceship.launch_energy and spaceship.launch_energy >= required_energy) then return end

  local ship_surface
  if spaceship.own_surface_index then
    ship_surface = game.surfaces["spaceship-" .. spaceship.index]
  end
  if not ship_surface then
    local map_gen_settings = {
      autoplace_controls = {
        ["planet-size"] = { frequency = 1/1000, size = 1 }
      }
    }
    map_gen_settings.autoplace_settings={
      ["decorative"]={
        treat_missing_as_default=false,
        settings={
        }
      },
      ["entity"]={
        treat_missing_as_default=false,
        settings={
        }
      },
      ["tile"]={
        treat_missing_as_default=false,
        settings={
          ["se-space"]={}
        }
      },
    }
    ship_surface = game.create_surface("spaceship-"..spaceship.index, map_gen_settings)

    ship_surface.freeze_daytime = true
    ship_surface.daytime = 0.4 -- dark but not midnight
    spaceship.own_surface_index = ship_surface.index
  end
  if not ship_surface then
    game.print("Error creating ship surface")
    return
  end
  if current_surface == ship_surface then
    game.print("Same surface")
    return
  end

  -- point of no return
  log("spaceship launch start")

  for _, tank in pairs(tanks) do
    local tank_x = math.floor(tank.position.x)
    local tank_y = math.floor(tank.position.y)

    if spaceship.known_tiles[tank_x] and spaceship.known_tiles[tank_x][tank_y]
      and spaceship.known_tiles[tank_x][tank_y] == Spaceship.tile_status.floor_console_connected
      and #tank.fluidbox > 0 then
        local fluidbox = tank.fluidbox[1] or {amount = 0}
        if fluidbox.amount > 0 and required_energy > 0 then
          local energy_per_fuel = game.fluid_prototypes[fluidbox.name].fuel_value
          local consume = math.ceil(math.min(fluidbox.amount, required_energy / energy_per_fuel))
          required_energy = required_energy - consume * energy_per_fuel
          fluidbox.amount = fluidbox.amount - consume
          if fluidbox.amount > 0 then
            tank.fluidbox[1] = fluidbox
          else
            tank.fluidbox[1] = nil
          end
        end
    end
  end

  -- copy ship to surface
  local min_x = nil
  local max_x = nil
  local min_y = nil
  local max_y = nil
  for x, x_tiles in pairs(spaceship.known_tiles) do
    if min_x == nil or x < min_x then min_x = x end
    if max_x == nil or x > max_x then max_x = x end
    for y, status in pairs(x_tiles) do
      if status == Spaceship.tile_status.floor_console_connected
        or status == Spaceship.tile_status.bulkhead_console_connected then
          if min_y == nil or y < min_y then min_y = y end
          if max_y == nil or y > max_y then max_y = y end
      end
    end
  end
  max_x = max_x + 1 -- whole tile
  max_y = max_y + 1 -- whole tile
  local max_extent = math.max(max_x - min_x, max_y, min_y)
  ship_surface.request_to_generate_chunks({x = (min_x + max_x / 2), y = (min_y + max_y / 2)} )
  ship_surface.force_generate_chunk_requests()
  local area = {
    left_top = {x = min_x, y = min_y},
    right_bottom = {x = max_x, y = max_y},
  }
  current_surface.clone_area{
    destination_surface = ship_surface,
    source_area = area,
    destination_area = table.deepcopy(area),
    clone_tiles = true,
    clone_entities = true,
    clone_decoratives = false,
    clear_destination = true,
    expand_map = true
  }
  local bad_tiles = ship_surface.find_tiles_filtered{ name = {name_out_of_map_tile} }
  local set_tiles = {}
  for _, tile in pairs(bad_tiles) do
    table.insert(set_tiles, {position = tile.position, name=name_space_tile})
    ship_surface.set_hidden_tile(tile.position, name_space_tile)
  end
  ship_surface.set_tiles(set_tiles)

  local change_tiles_zone = {} -- surface set_tiles specification
  local change_tiles_ship = {}
  -- transfer the console
  local old_console = spaceship.console
  local console_clone = ship_surface.find_entity(Spaceship.name_spaceship_console, spaceship.console.position)
  spaceship.console = console_clone
  spaceship.console_output = nil
  old_console.destroy()

  for x = min_x, max_x do
    for y = min_y, max_y do
      if spaceship.known_tiles[x] and spaceship.known_tiles[x][y] and
        (spaceship.known_tiles[x][y] == Spaceship.tile_status.floor_console_connected
        or spaceship.known_tiles[x][y] == Spaceship.tile_status.bulkhead_console_connected) then
          -- valid tile remove from zone
          local under_tile = current_surface.get_hidden_tile({x=x,y=y})
          if under_tile == nil or Spaceship.is_floor(under_tile) then
            under_tile = "landfill" -- fallback
          end
          table.insert(change_tiles_zone, {name = under_tile, position = {x=x,y=y}})
          local entities = current_surface.find_entities_filtered{
            area = {left_top={x=x,y=y}, right_bottom={x=x+1,y=y+1}}
          }
          for _, entity in pairs(entities) do
            if entity.type == "character" then
              local clone = ship_surface.find_entity(entity.name, entity.position)
              if clone and entity.player then
                entity.player.teleport(clone.position, ship_surface)
                clone.destroy()
              else
                for _, playerdata in pairs(global.playerdata) do
                  if playerdata.character == entity then
                    playerdata.character = clone
                  end
                end
                entity.destroy()
              end
            else
              entity.destroy()
            end
          end
      else
        -- invalid tile remove from ship
        table.insert(change_tiles_ship, {name = name_space_tile, position = {x=x,y=y}})
        local entities = ship_surface.find_entities_filtered{
          area = {left_top={x=x,y=y}, right_bottom={x=x+1,y=y+1}}
        }
        for _, entity in pairs(entities) do
          if entity.type == "straight-rail"
           or entity.name == Spaceship.name_spaceship_clamp_keep then
            -- only remove if it is not overlapping valid tiles.
            local valid = false
            for x2 = math.floor(entity.position.x)-1, math.floor(entity.position.x) do
              if not valid then
                for y2 = math.floor(entity.position.y)-1, math.floor(entity.position.y) do
                  if spaceship.known_tiles[x2] and spaceship.known_tiles[x2][y2] and
                    (spaceship.known_tiles[x2][y2] == Spaceship.tile_status.floor_console_connected
                    or spaceship.known_tiles[x2][y2] == Spaceship.tile_status.bulkhead_console_connected) then
                      valid = true break
                  end
                end
              end
            end
            if not valid then
              entity.destroy()
            end
          else
            entity.destroy()
          end
        end
      end
      ship_surface.set_hidden_tile({x=x,y=y}, name_space_tile)
    end
  end
  current_surface.set_tiles(change_tiles_zone, true)
  ship_surface.set_tiles(change_tiles_ship, true)

  local cars = ship_surface.find_entities_filtered{type = "car"}
  for _, car in pairs(cars) do
    if not string.find(car.name, mod_prefix.."space") then
      car.active = false
    end
  end

  spaceship.near = {type="zone", index= spaceship.zone_index}
  spaceship.stopped = true
  spaceship.zone_index = nil

  spaceship.near_star = Zone.get_star_from_child(current_zone)
  Spaceship.set_light(spaceship, ship_surface)

  Spaceship.deactivate_engines(spaceship)

  CondenserTurbine.reset_surface(ship_surface)

  if not Zone.is_space(current_zone) then -- started from land, space zome entities
    -- space the ground entities
    -- unground the space entities
    local names_for_spaced = {}
    local names_grounded = {}
    for name, prototype in pairs(game.entity_prototypes) do
      if string.find(name, name_suffix_spaced, 1, true) then
        table.insert(names_for_spaced, util.replace(name, name_suffix_spaced, ""))
      end
      if string.find(name, name_suffix_grounded, 1, true) then
        table.insert(names_grounded, name)
      end
    end
    local entities_for_spaced = ship_surface.find_entities_filtered{name = names_for_spaced}
    for _, entity in pairs(entities_for_spaced) do
      swap_structure(entity, entity.name..name_suffix_spaced)
    end
    local entities_grounded = ship_surface.find_entities_filtered{name = names_grounded}
    for _, entity in pairs(entities_grounded) do
      swap_structure(entity, util.replace(entity.name, name_suffix_grounded, ""))
    end
  end

  local destroy_names = {}
  for _, name in pairs(ShieldProjector.get_sub_entity_names(event)) do
    table.insert(destroy_names, name)
  end
  local destroy_entities = ship_surface.find_entities_filtered{name = destroy_names}
  for _, entity in pairs(destroy_entities) do
    entity.destroy()
  end

  ShieldProjector.find_on_surface(ship_surface)

  for _, player in pairs(game.connected_players) do
    if player.surface.index == current_surface.index or player.surface.index == ship_surface.index then
      player.play_sound{path = "se-spaceship-woosh", volume = 1}
    end
  end

  log("spaceship launch end")

end

function Spaceship.land_at_position(spaceship, position, ignore_average)
  if spaceship.own_surface_index and spaceship.near and spaceship.near.type == "zone" and spaceship.known_tiles then
    local destination_zone = Zone.from_zone_index(spaceship.near.index)
    if not destination_zone then return end

    local ship_surface = game.surfaces["spaceship-" .. spaceship.index]
    local target_surface = Zone.get_make_surface(destination_zone)

    local offset_x = util.to_rail_grid(position.x - spaceship.known_tiles_average_x)
    local offset_y = util.to_rail_grid(position.y - spaceship.known_tiles_average_y)
    if ignore_average then
      offset_x = util.to_rail_grid(position.x)
      offset_y = util.to_rail_grid(position.y)
    end

    local min_x = nil
    local max_x = nil
    local min_y = nil
    local max_y = nil

    for x, x_tiles in pairs(spaceship.known_tiles) do
      if min_x == nil or x < min_x then min_x = x end
      if max_x == nil or x > max_x then max_x = x end
      for y, status in pairs(x_tiles) do
        if status == Spaceship.tile_status.floor_console_connected
          or status == Spaceship.tile_status.bulkhead_console_connected then
            if min_y == nil or y < min_y then min_y = y end
            if max_y == nil or y > max_y then max_y = y end
        end
      end
    end

    max_x = max_x + 1 -- whole tile
    max_y = max_y + 1 -- whole tile

    local source_area = {
      left_top = {
        x = min_x,
        y = min_y
      },
      right_bottom = {
        x = max_x,
        y = max_y
      },
    }
    local destination_area = {
      left_top = {
        x = min_x + offset_x,
        y = min_y + offset_y
      },
      right_bottom = {
        x = max_x + offset_x,
        y = max_y + offset_y
      },
    }
    local dont_land_on = table.deepcopy(Ancient.vault_entrance_structures)
    table.insert(dont_land_on, Ancient.name_gate_blocker)
    table.insert(dont_land_on, Ancient.name_gate_blocker_void)
    for name, stuff in pairs(Ancient.gate_fragments) do
      table.insert(dont_land_on, name)
    end
    if target_surface.count_entities_filtered{name = dont_land_on, area = destination_area} > 0 then
      return
    end

    local destroy_names = {}
    for _, particle in pairs(Spaceship.particles) do
      if particle.graphic_name then
        table.insert(destroy_names, particle.graphic_name)
      end
      if particle.projectile_name then
        table.insert(destroy_names, particle.projectile_name)
      end
      if particle.targetable_name then
        table.insert(destroy_names, particle.targetable_name)
      end
    end

    for _, name in pairs(ShieldProjector.get_sub_entity_names(event)) do
      table.insert(destroy_names, name)
    end
    local destroy_entities = ship_surface.find_entities_filtered{name = destroy_names}
    for _, entity in pairs(destroy_entities) do
      entity.destroy()
    end

    Zone.apply_markers(destination_zone) -- in case the surface exists

    -- copy ship to surface

    local change_tiles_zone = {}
    for x, x_tiles in pairs(spaceship.known_tiles) do
      for y, status in pairs(x_tiles) do
        if status == Spaceship.tile_status.floor_console_connected
          or status == Spaceship.tile_status.bulkhead_console_connected then
            local tile = ship_surface.get_tile({x,y})
            if Spaceship.is_floor(tile.name) then
              table.insert(change_tiles_zone, {name = tile.name, position = {
                x = x + offset_x,
                y = y + offset_y}})
            end
        end
      end
    end
    target_surface.set_tiles(change_tiles_zone, true)

    -- clear the target area
    for x = min_x, max_x do
      for y = min_y, max_y do
        if spaceship.known_tiles[x] and spaceship.known_tiles[x][y] and
          (spaceship.known_tiles[x][y] == Spaceship.tile_status.floor_console_connected
          or spaceship.known_tiles[x][y] == Spaceship.tile_status.bulkhead_console_connected) then
            local area = {
              left_top={
                x=x + offset_x,
                y=y + offset_y},
              right_bottom={
                x=x+1 + offset_x,
                y=y+1 + offset_y}}
            --target_surface.destroy_decoratives{area = area} -- not required, flooring does it
            local entities = target_surface.find_entities_filtered{ area = area }
            for _, entity in pairs(entities) do
              if entity.type == "character" then
                entity.health = entity.health * 0.1
              else
                entity.destroy() -- maybe use die?
              end
            end
        end
      end
    end

    -- do this before cloning
    if not Zone.is_space(destination_zone) then -- started from space (spacehsip), ending on land
      -- un-space the ground entities
      -- ground the space entities
      local names_for_grounded = {}
      local names_spaced = {}
      for name, prototype in pairs(game.entity_prototypes) do
        if string.find(name, name_suffix_grounded, 1, true) then
          table.insert(names_for_grounded, util.replace(name, name_suffix_grounded, ""))
        end
        if string.find(name, name_suffix_spaced, 1, true) then
          table.insert(names_spaced, name)
        end
      end
      local entities_for_grounded = ship_surface.find_entities_filtered{name = names_for_grounded}
      for _, entity in pairs(entities_for_grounded) do
        swap_structure(entity, entity.name..name_suffix_grounded)
      end
      local entities_spaced = ship_surface.find_entities_filtered{name = names_spaced}
      for _, entity in pairs(entities_spaced) do
        swap_structure(entity, util.replace(entity.name, name_suffix_spaced, ""))
      end
    end

    ship_surface.clone_area{
      destination_surface = target_surface,
      source_area = source_area,
      destination_area = destination_area,
      clone_tiles = false,
      clone_entities = true,
      clone_decoratives = false,
      clear_destination_entities  = false,
      clear_destination_decoratives = false,
      expand_map = true
    }

    local characters = ship_surface.find_entities_filtered{type = "character"}
    for _, character in pairs(characters) do
      local target_position = {
        x = character.position.x + offset_x,
        y = character.position.y + offset_y,
      }
      local clone = target_surface.find_entity( character.name, target_position ) -- find equivalent character on target surface
      if character.player then -- player is attached
        local player = character.player
        if clone then
          player.set_controller{type = defines.controllers.ghost} -- detatch from character
          player.teleport(character.position, target_surface)
          player.set_controller{type = defines.controllers.character, character = clone} -- attach clone
          remote.call("jetpack", "stop_jetpack_immediate", {character = clone})
        else
          player.teleport(target_position, target_surface)
          remote.call("jetpack", "stop_jetpack_immediate", {character = character})
        end
      else -- no player attached, try to preserve detatched connection
        if clone then
          for player_index, playerdata in pairs(global.playerdata) do
            local player = game.players[player_index]
            if playerdata.character and playerdata.character == character then
              playerdata.character = clone
            end
          end
          remote.call("jetpack", "stop_jetpack_immediate", {character = clone})
        end
      end
    end

    -- transfer the console
    local old_console = spaceship.console
    local console_clone = target_surface.find_entity(Spaceship.name_spaceship_console, {
      x = spaceship.console.position.x + offset_x,
      y = spaceship.console.position.y + offset_y,
    })
    if not console_clone then
      Log.trace("Error finding console clone")
    end
    spaceship.console = console_clone
    spaceship.console_output = nil
    old_console.destroy()

    for x = min_x, max_x do
      for y = min_y, max_y do
        if spaceship.known_tiles[x] and spaceship.known_tiles[x][y] and
          (spaceship.known_tiles[x][y] == Spaceship.tile_status.floor_console_connected
          or spaceship.known_tiles[x][y] == Spaceship.tile_status.bulkhead_console_connected) then
            local entities = ship_surface.find_entities_filtered{
              area = {
                left_top={
                  x=x + offset_x,
                  y=y + offset_y},
                right_bottom={
                  x=x+1 + offset_x,
                  y=y+1 + offset_y}}
            }
            for _, entity in pairs(entities) do
              entity.destroy()
            end
        end
      end
    end
    game.delete_surface(ship_surface)
    spaceship.own_surface_index = nil
    spaceship.zone_index = spaceship.near.index
    spaceship.near = nil
    spaceship.stopped = true
    spaceship.is_moving = false
    spaceship.speed = 0
    local engines = target_surface.find_entities_filtered{name = Spaceship.names_engines}
    for _, engine in pairs(engines) do
      engine.active = false
    end

    CondenserTurbine.reset_surface(target_surface)

    ShieldProjector.find_on_surface(target_surface)

    local cars = target_surface.find_entities_filtered{type = "car"}
    for _, car in pairs(cars) do
      if Zone.is_space(destination_zone) then
        if not string.find(car.name, mod_prefix.."space") then
          car.active = false
        end
      else
        car.active = true
      end
    end

    Spaceship.start_integrity_check(spaceship)

    for _, player in pairs(game.connected_players) do
      if player.surface.index == target_surface.index or player.surface.index == ship_surface.index then
        player.play_sound{path = "se-spaceship-woosh", volume = 1}
      end
    end

  end
end

function Spaceship.anchor_scouting_tick(player, spaceship)
  --local frequency = 5
  --if (game.tick % frequency) == 0 and spaceship.known_tiles then
  if spaceship.known_tiles then
    local offset_x =  util.to_rail_grid(player.position.x - spaceship.known_tiles_average_x)
    local offset_y =  util.to_rail_grid(player.position.y - spaceship.known_tiles_average_y)

    for x, x_tiles in pairs(spaceship.known_tiles) do
      for y, status in pairs(x_tiles) do
        if status == Spaceship.tile_status.floor_console_connected
          or status == Spaceship.tile_status.bulkhead_console_connected then
            local position ={
              x = x + offset_x,
              y = y + offset_y
            }
            rendering.draw_rectangle{
              color = {r = 0.125, g = 0.125, b = 0, a = 0.01},
              filled = true,
              left_top = position,
              right_bottom = { x = position.x + 1, y = position.y + 1 },
              surface = player.surface,
              time_to_live = 2
            }
        end
      end
    end
  end
end

function Spaceship.start_anchor_scouting(spaceship, player)
  if not spaceship.near and spaceship.near.type == "zone" then return end
  local zone = Zone.from_zone_index(spaceship.near.index)
  if not zone then return end

  local playerdata = get_make_playerdata(player)
  -- enter remote view
  playerdata.anchor_scouting_for_spaceship_index = spaceship.index

  local character = player.character
  if character then
    playerdata.character = character
  end
  player.set_controller{type = defines.controllers.ghost}
  --player.set_controller{type = defines.controllers.spectator}

  if character then
    -- stop the character from continuing input action (running to doom)
    character.walking_state = {walking = false, direction = defines.direction.south}
    character.riding_state = {acceleration = defines.riding.acceleration.braking, direction = defines.riding.direction.straight}
    character.shooting_state = {state = defines.shooting.not_shooting, position=character.position}
  end

  local surface = Zone.get_make_surface(zone)
  local position = {x=0,y=0}
  if playerdata.surface_positions and playerdata.surface_positions[surface.index] then
    position = playerdata.surface_positions[surface.index]
  end

  player.teleport(position, surface)

end

function Spaceship.stop_anchor_scouting(player)
  local playerdata = get_make_playerdata(player)
  if playerdata.anchor_scouting_for_spaceship_index then
    playerdata.anchor_scouting_for_spaceship_index = nil
    if playerdata.remote_view_active then
      local surface = player.surface
      local position = player.position
      RemoteView.stop(player)
      RemoteView.start(player)
      player.teleport(position, surface)
    else
      if playerdata.character and playerdata.character.valid then
        player.teleport(playerdata.character.position, playerdata.character.surface)
        player.set_controller{type = defines.controllers.character, character = playerdata.character}
      elseif not player.character then
        Respawn.die(player)
      end
    end
  end
end


function Spaceship.on_gui_click(event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]
  root = gui_element_or_parent(element, Spaceship.name_spaceship_gui_root)
  if not root then return end
  local playerdata = get_make_playerdata(player)
  local spaceship = Spaceship.from_index(root.spaceship_index.children_names[1])
  if not spaceship then
    if playerdata.anchor_scouting_for_spaceship_index then
      Spaceship.stop_anchor_scouting(player)
    end
    return
  end

  if element.name == "launch" then

    if spaceship.zone_index then
      spaceship.is_launching = true
      spaceship.is_landing = false
      Spaceship.start_integrity_check(spaceship)
    end

  elseif element.name == "anchor" then

    if spaceship.near and spaceship.near.type == "zone" then
      if playerdata.anchor_scouting_for_spaceship_index then
        local position = table.deepcopy(player.position)
        Spaceship.stop_anchor_scouting(player)
        Spaceship.land_at_position(spaceship, position)
      else
        spaceship.is_launching = false
        spaceship.is_landing = true
        Spaceship.start_anchor_scouting(spaceship, player)
        Spaceship.start_integrity_check(spaceship)
      end
    elseif playerdata.anchor_scouting_for_spaceship_index then
        Spaceship.stop_anchor_scouting(player)
    end

  elseif element.name == "board" then

    if spaceship.near and spaceship.near.type == "spaceship" then
      local othership = Spaceship.from_index(spaceship.near.index)
      if othership then
        if not othership.own_surface_index then
          player.print({"space-exploration.fail-board-target-anchored"})
        else
          local character = player.character
          if not character then
            local playerdata = get_make_playerdata(player)
            character = playerdata.character
          end
          if not character then
            player.print({"space-exploration.fail-board-no-character"})
          else
            if character.surface.index ~= spaceship.own_surface_index then
              player.print({"space-exploration.fail-board-remote-character"})
            else
              local surface = Spaceship.get_current_surface(othership)
              local boarding_position = Spaceship.get_boarding_position(othership)
              teleport_non_colliding_player(player, boarding_position, surface)
              Spaceship.gui_close(player)
            end
          end
        end
      end
    end

  elseif element.name == "stop" then

    spaceship.stopped = true
    spaceship.target_speed = nil

  elseif element.name == "start" then

    spaceship.stopped = false
    spaceship.target_speed = nil
    Spaceship.start_integrity_check(spaceship)

  elseif element.name == "cancel_anchor_scouting" then

    Spaceship.stop_anchor_scouting(player)

  elseif element.name == "start-integrity-check" then

    spaceship.max_speed = 0
    Spaceship.start_integrity_check(spaceship, 0.1)

  elseif element.name == "rename" then

    local name_flow = element.parent
    element.destroy()
    name_flow["show-name"].destroy()
    local name_label = name_flow.add{ type = "textfield", name="write-name", text=spaceship.name, style="space_platform_textfield_short"}
    local rename_button = name_flow.add{ type = "sprite-button", name="rename-confirm", sprite="utility/enter",
      tooltip={"space-exploration.rename-something", {"space-exploration.spaceship"}}, style="space_platform_sprite_button_small"}

  elseif element.name == "rename-confirm" then

    local name_flow = element.parent
    element.destroy()
    local new_name = string.trim(name_flow["write-name"].text)
    if newname ~= "" and new_name ~= spaceship.name then
      --do change name stuff
      spaceship.name = new_name
    end
    name_flow["write-name"].destroy()
    local name_label = name_flow.add{ type = "label", name="show-name", caption="The " ..spaceship.name, style="space_platform_title_short"}
    local rename_button = name_flow.add{ type = "sprite-button", name="rename", sprite="utility/rename_icon_normal",
      tooltip={"space-exploration.rename-something", {"space-exploration.spaceship"}}, style="space_platform_sprite_button_small"}

  elseif element.name == "spaceship-list-zones" then

    local value = player_get_dropdown_value(player, element.name, element.selected_index)
    if type(value) == "table" then
      if value.type == "zone" then
        local zone_index = value.index
        local zone = Zone.from_zone_index(zone_index)
        if zone then
          spaceship.destination = {type = "zone", index = zone_index}
          spaceship.travel_message = {"space-exploration.spaceship-travel-message-new-course-plotted"}
          --spaceship.destination_zone_index = zone_index
          Log.trace("set destination to location: " .. zone.name )
        end

      elseif value.type == "spaceship" then
        local spaceship_index = value.index
        local destination_spaceship = Spaceship.from_index(spaceship_index)
        if destination_spaceship == spaceship then
          player.print({"space-exploration.spaceship-cannot-set-destination-to-self"})
        else
          spaceship.destination = {type = "spaceship", index = spaceship_index}
          spaceship.travel_message = {"space-exploration.spaceship-travel-message-new-course-plotted"}
          Log.trace("set destination to spaceship : " .. spaceship.name )
        end
      end
      Spaceship.update_output_combinator(spaceship)
    else
      Spaceship.gui_close(player)
      Log.trace("Error: Non-table value ")
    end

  elseif element.name == "clear_filter" then
    element.parent.filter_list.text = ""
    Spaceship.gui_update_destinations_list(player)
  elseif element.name == Spaceship.name_window_close then
    Spaceship.gui_close(player)
  end
end
Event.addListener(defines.events.on_gui_click, Spaceship.on_gui_click)
Event.addListener(defines.events.on_gui_selection_state_changed, Spaceship.on_gui_click)


function Spaceship.on_gui_checked_state_changed(event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]
  root = gui_element_or_parent(element, Spaceship.name_spaceship_gui_root)
  if not root then return end
  local spaceship = Spaceship.from_index(root.spaceship_index.children_names[1])
  if not spaceship then return end
  if element.name == "list-zones-alphabetical" then
    local playerdata = get_make_playerdata(player)
    playerdata.zones_alphabetical = element.state
    Spaceship.gui_update_destinations_list(player)
  end
end
Event.addListener(defines.events.on_gui_checked_state_changed, Spaceship.on_gui_checked_state_changed)

function Spaceship.gui_update_destinations_list(player)

  local playerdata = get_make_playerdata(player)
  local root = player.gui.left[Spaceship.name_spaceship_gui_root]
  if not root then return end
  local spaceship = Spaceship.from_index(root.spaceship_index.children_names[1])
  if not spaceship then return end
  if root then

    local filter = nil
    if root.filter_flow and root.filter_flow.filter_list then
      filter = string.trim(root.filter_flow.filter_list.text)
      if filter == "" then
        filter = nil
      end
    end

    -- update the list
    local destination_zone = Spaceship.get_destination_zone(spaceship)
    if not destination_zone then destination_zone = Zone.from_zone_index(spaceship.zone_index) end

    local list, selected_index, values = Zone.dropdown_list_zone_destinations(spaceship.force_name, destination_zone, playerdata.zones_alphabetical, filter)
    root["spaceship-list-zones"].items = list
    root["spaceship-list-zones"].selected_index = selected_index or 1
    player_set_dropdown_values(player, "spaceship-list-zones", values)
  end
end

function Spaceship.on_gui_text_changed(event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]
  local root = gui_element_or_parent(element, Spaceship.name_spaceship_gui_root)
  if root then -- remote view
    if element.name == "filter_list" then
      Spaceship.gui_update_destinations_list(player)
    end
  end
end
Event.addListener(defines.events.on_gui_text_changed, Spaceship.on_gui_text_changed)

function Spaceship.gui_update(player)
  local root = player.gui.left[Spaceship.name_spaceship_gui_root]
  if root then
    local spaceship = Spaceship.from_index(root.spaceship_index.children_names[1])

    if spaceship then
      local playerdata = get_make_playerdata(player)

      --local inv = spaceship.container.get_inventory(defines.inventory.chest)
      --local inv_used = count_inventory_slots_used(inv)

      --root["cargo_capacity"].caption="Cargo: " .. math.min(inv_used, #inv) .. " / " .. #inv
      --root["cargo_capacity_progress"].value=math.min(inv_used, #inv) / #inv

      local energy_required = Spaceship.get_launch_energy_cost(spaceship)

      if root["launch_energy"] then
        if spaceship.zone_index then
          if energy_required and spaceship.launch_energy then
            --root["launch_energy"].caption="Launch energy: " .. Util.format_energy(spaceship.launch_energy) .. " / " .. Util.format_energy(energy_required, true)
            root["launch_energy"].caption={"space-exploration.spaceship-launch-energy", Util.format_energy(spaceship.launch_energy) .. " / " .. Util.format_energy(energy_required, true)}
            root["launch_energy_progress"].value = math.min(1, spaceship.launch_energy / energy_required)
          else
            --root["launch_energy"].caption="Launch energy: Requires valid integrity check."
            root["launch_energy"].caption={"space-exploration.spaceship-launch-energy-invalid"}
            root["launch_energy_progress"].value = 0
          end
        else
          -- repurpose for speed
          if spaceship.speed > 0 then
            --root["launch_energy"].caption="Speed: " .. string.format("%.2f", spaceship.speed or 0) .. " / " .. string.format("%.2f", spaceship.max_speed or 0)
            root["launch_energy"].caption={"space-exploration.spaceship-speed", string.format("%.2f", spaceship.speed or 0) .. " / " .. string.format("%.2f", spaceship.max_speed or 0)}
            root["launch_energy_progress"].value = math.min(1, spaceship.speed / (spaceship.max_speed or spaceship.speed))
          else
            --root["launch_energy"].caption="Speed: 0 / ".. string.format("%.2f", spaceship.max_speed or 0)
            root["launch_energy"].caption={"space-exploration.spaceship-speed", " 0 / " .. string.format("%.2f", spaceship.max_speed or 0)}
            root["launch_energy_progress"].value = 0
          end
        end
      end

      if root["structural_integrity"] and root["structural_integrity_progress"] then
        if spaceship.integrity_stress_structure and spaceship.integrity_limit then
          --root["structural_integrity"].caption="Structural Stress (Hull): " .. spaceship.integrity_stress_structure .. " / " .. spaceship.integrity_limit
          root["structural_integrity"].caption={"space-exploration.spaceship-structural-stress-hull", spaceship.integrity_stress_structure .. " / " .. spaceship.integrity_limit}
          root["structural_integrity_progress"].value = math.min(1, spaceship.integrity_stress_structure / spaceship.integrity_limit)
        else
          --root["structural_integrity"].caption="Structural Stress (Hull): NA (Invalid containment)."
          root["structural_integrity"].caption={"space-exploration.spaceship-structural-stress-hull-invalid"}
          root["structural_integrity_progress"].value = 0
        end
      end

      if root["container_integrity"] and root["container_integrity_progress"] then
        if spaceship.integrity_stress_container and spaceship.integrity_limit then
          --root["container_integrity"].caption="Structural Stress (Containers): " .. spaceship.integrity_stress_container .. " / " .. spaceship.integrity_limit
          root["container_integrity"].caption={"space-exploration.spaceship-structural-stress-container", spaceship.integrity_stress_container .. " / " .. spaceship.integrity_limit}
          root["container_integrity_progress"].value = math.min(1, spaceship.integrity_stress_container / spaceship.integrity_limit)
        else
          --root["container_integrity"].caption="Structural Stress (Containers): NA (Invalid containment)."
          root["container_integrity"].caption={"space-exploration.spaceship-structural-stress-container-invalid"}
          root["container_integrity_progress"].value = 0
        end
      end

      if game.tick % 60 == 0 then
        spaceship.distance_to_destination = Spaceship.get_distance_to_destination(spaceship)
        spaceship.distance_to_destination_tick = game.tick
      end
      if spaceship.distance_to_destination and spaceship.speed then
        if spaceship.speed == 0 then
          if not spaceship.max_speed or spaceship.max_speed == 0 then
            --root["travel-time"].caption = "Travel time: Unknown. Test max speed for estimate."
            root["travel-time"].caption = {"space-exploration.spaceship-travel-time-unknown"}
          else
            --root["travel-time"].caption = "Travel time: "..
            --  Util.seconds_to_clock(spaceship.distance_to_destination / ((spaceship.max_speed or 1) * Spaceship.travel_speed_multiplier) / 60)
            --  .. "s at max speed"
            root["travel-time"].caption = {"space-exploration.spaceship-travel-time-max", Util.seconds_to_clock(spaceship.distance_to_destination / ((spaceship.max_speed or 1) * Spaceship.travel_speed_multiplier) / 60)}
          end
        else
          root["travel-time"].caption = {"space-exploration.spaceship-travel-time-current", Util.seconds_to_clock(spaceship.distance_to_destination / ((spaceship.speed or 1) * Spaceship.travel_speed_multiplier) / 60)}
        end
      else
        root["travel-time"].caption = {"space-exploration.spaceship-travel-time-current", 0}
      end

      if (game.tick + 30) % 60 == 0 and root["closest-location"] then
        local closest = Zone.find_nearest_zone(
        spaceship.space_distortion,
        spaceship.stellar_position,
        spaceship.star_gravity_well,
        spaceship.planet_gravity_well)
        --root["closest-location"].caption="Closest Location: "..closest.name
        root["closest-location"].caption = {"space-exploration.spaceship-closest-location", closest.name}
      end


      if spaceship.space_distortion > 0 then
        --root["anomaly-distance"].caption = "Spacial Distortion: " .. string.format("%.2f", spaceship.space_distortion * Zone.travel_cost_space_distortion)
        root["anomaly-distance"].caption = {"space-exploration.spaceship-location-spatial-distortion", string.format("%.2f", spaceship.space_distortion * Zone.travel_cost_space_distortion)}
      else
        root["anomaly-distance"].caption = ""
      end
      if spaceship.space_distortion > 0.05 then
        root["stellar-x"].caption = ""
        root["stellar-y"].caption = ""
        root["star-gravity"].caption = ""
        root["planet-gravity"].caption = ""
      else
        --root["stellar-x"].caption = "Quadrant X: " .. string.format("%.2f", spaceship.stellar_position.x * Zone.travel_cost_interstellar)
        --root["stellar-y"].caption = "Quadrant Y: " .. string.format("%.2f", spaceship.stellar_position.y * Zone.travel_cost_interstellar)
        root["stellar-x"].caption = {"space-exploration.spaceship-location-stellar-x", string.format("%.2f", spaceship.stellar_position.x * Zone.travel_cost_interstellar)}
        root["stellar-y"].caption = {"space-exploration.spaceship-location-stellar-y", string.format("%.2f", spaceship.stellar_position.y * Zone.travel_cost_interstellar)}
        if spaceship.star_gravity_well > 0 then
          --root["star-gravity"].caption = "Star gravity well: " .. string.format("%.2f", spaceship.star_gravity_well * Zone.travel_cost_star_gravity)
          root["star-gravity"].caption = {"space-exploration.spaceship-location-star-gravity-well", string.format("%.2f", spaceship.star_gravity_well * Zone.travel_cost_star_gravity)}
        else
          root["star-gravity"].caption = ""
        end
        if spaceship.planet_gravity_well > 0 then
          --root["planet-gravity"].caption = "Planet gravity well: " .. string.format("%.2f", spaceship.planet_gravity_well * Zone.travel_cost_planet_gravity)
          root["planet-gravity"].caption = {"space-exploration.spaceship-location-planet-gravity-well", string.format("%.2f", spaceship.planet_gravity_well * Zone.travel_cost_planet_gravity)}
        else
          root["planet-gravity"].caption = ""
        end
      end

      --if root["current-speed"] then
      --  root["current-speed"].caption="Speed: " .. string.format("%.2f", spaceship.speed or 0)
      --end

      if root["travel-status"] then
        --root["travel-status"].caption="Travel Status: " .. (spaceship.travel_message or  "")
        root["travel-status"].caption={"space-exploration.spaceship-travel-status", (spaceship.travel_message or  "")}
      end

      if root["integrity-status"] then
        --root["integrity-status"].caption="Integrity Status: "
        --  .. (spaceship.integrity_valid and "Valid: " or "Invalid: ")
        --  .. (spaceship.check_message or  "")
        if spaceship.integrity_valid then
          root["integrity-status"].caption = {"space-exploration.spaceship-integrity-status-valid", (spaceship.check_message or  "")}
        else
          root["integrity-status"].caption = {"space-exploration.spaceship-integrity-status-invalid", (spaceship.check_message or  "")}
        end
      end

      -- button modes:
      --[[
      launch when on a surface
      Anchor when near a surface the is the destination
      Stop when moving.
      Engage when in space and:
        a destination is selected
        or not near a surface
      ]]--

      local button
      if spaceship.zone_index then
        -- launch
        if not root["action-flow"]["launch"] then
          root["action-flow"].clear()
          root["action-flow"].add{ type="button", name="launch", caption={"space-exploration.spaceship-button-launch"}, style="confirm_button"}
        end
        button = root["action-flow"]["launch"]
        if spaceship.integrity_valid then
          if energy_required and spaceship.launch_energy and spaceship.launch_energy >= energy_required then
            --button.caption = "Launch"
            button.caption = {"space-exploration.spaceship-button-launch"}
            --button.tooltip = "Ready to launch"
            button.tooltip = {"space-exploration.spaceship-button-launch-tooltip"}
            button.style = "confirm_button"
          else
            --button.caption = "Launch (disabled)"
            button.caption = {"space-exploration.spaceship-button-launch-disabled"}
            --button.tooltip = "Requires fuel in booster tanks"
            button.tooltip = {"space-exploration.spaceship-button-launch-disabled-fuel-tooltip"}
            button.style = "red_confirm_button"
          end
        else
          --button.caption = "Launch (disabled)"
          button.caption = {"space-exploration.spaceship-button-launch-disabled"}
          --button.tooltip = "Requires valid integrity check"
          button.tooltip = {"space-exploration.spaceship-button-launch-disabled-integrity-tooltip"}
          button.style = "red_confirm_button"
        end

      elseif spaceship.near and
       (spaceship.destination == nil
        or (spaceship.near.type == "zone" and spaceship.destination.index == spaceship.near.index)) then
          -- anchor
          local zone = Zone.from_zone_index(spaceship.near.index)
          if not root["action-flow"]["anchor"] then
            root["action-flow"].clear()
            root["action-flow"].add{ type="button", name="anchor", caption={"space-exploration.spaceship-button-anchor"}, style="confirm_button"}
          end
          button = root["action-flow"]["anchor"]
          if playerdata.anchor_scouting_for_spaceship_index then
            --button.caption = "Confirm Anchor"
            button.caption = {"space-exploration.spaceship-button-confirm-anchor"}
            button.style = "confirm_button"
          else
            --local context = Zone.is_solid(zone) and "on" or "to"
            --button.caption = "Anchor "..context.." "..zone.name
            if Zone.is_solid(zone) then
              button.caption = {"space-exploration.spaceship-button-anchor-on", zone.name}
            else
              button.caption = {"space-exploration.spaceship-button-anchor-to", zone.name}
            end
            button.style = "confirm_button"
          end

      elseif spaceship.near and spaceship.near.type == "spaceship" and spaceship.destination
        and spaceship.destination.type == "spaceship" and spaceship.destination.index == spaceship.near.index then

          -- board
          local othership = Spaceship.from_index(spaceship.near.index)
          if not othership then
            spaceship.destination = nil
          end
          local name = othership and othership.name or "MISSING"
          if not root["action-flow"]["board"] then
            root["action-flow"].clear()
            root["action-flow"].add{ type="button", name="board", caption={"space-exploration.spaceship-button-board", name}, style="confirm_button"}
          end
          button = root["action-flow"]["board"]


      elseif spaceship.destination and not spaceship.stopped then

        if not root["action-flow"]["stop"] then
          root["action-flow"].clear()
          root["action-flow"].add{ type="button", name="stop", caption={"space-exploration.spaceship-button-stop"}, style="confirm_button"}
        end
        button = root["action-flow"]["stop"]

      else

        if not root["action-flow"]["start"] then
          root["action-flow"].clear()
          root["action-flow"].add{ type="button", name="start", caption={"space-exploration.spaceship-button-start"}, style="confirm_button"}
        end
        button = root["action-flow"]["start"]

      end

      button.style.top_margin = 10
      button.style.horizontally_stretchable  = true
      button.style.horizontal_align = "left"

      if playerdata.anchor_scouting_for_spaceship_index then
        if not root["back-flow"]["cancel_anchor_scouting"] then
          local back = root["back-flow"].add{type = "button", name = "cancel_anchor_scouting",
            caption = {"space-exploration.spaceship-button-scouting-back"}, style="back_button", tooltip={"space-exploration.spaceship-button-scouting-back-tooltip"}}
          back.style.top_margin = 10
        end
      elseif root["back-flow"]["cancel_anchor_scouting"] then
        root["back-flow"]["cancel_anchor_scouting"].destroy()
      end

    end
  end
end


function Spaceship.gui_open(player, spaceship)
  if not spaceship then
    player.print('Spaceship not found. Try replacing the console')
    return
  end
  local gui = player.gui.left
  close_own_guis(player)
  local playerdata = get_make_playerdata(player)

  local container = gui.add{ type = "frame", name = Spaceship.name_spaceship_gui_root, style="space_platform_container", direction="vertical"}


  local title_table = container.add{type="table", name="spaceship_index", column_count=2, draw_horizontal_lines=false}
  title_table.style.horizontally_stretchable = true
  title_table.style.column_alignments[1] = "left"
  title_table.style.column_alignments[2] = "right"

  -- NOTE: [Spaceship.name_spaceship_gui_root].spaceship_index.child_names()[1] gets spaceship index
  local title_frame = title_table.add{type="frame", name=spaceship.index,
    caption = {"space-exploration.simple-a-b", "[img=virtual-signal/se-spaceship] ", {"space-exploration.simple-a-b", {"space-exploration.spaceship"}, " "..spaceship.index}},
    style="informatron_title_frame"}
  title_frame.style.right_padding = -5

  local right_flow = title_table.add{type="flow", name="title_flow_right"}
  --local close = right_flow.add{type="button", name=Lifesupport.name_window_close, caption="✖", style="informatron_close_button"}
  local close = right_flow.add{type="sprite-button", name=Spaceship.name_window_close, sprite = "utility/close_white", style="informatron_close_button"}
  close.style.width = 28
  close.style.height = 28


  --[[local title_flow = container.add{ type="flow", name="spaceship_index", direction="horizontal"}
  -- NOTE: [Spaceship.name_spaceship_gui_root].spaceship_index.child_names()[1] gets spaceship index
  local title = title_flow.add{ type="label", name=spaceship.index, caption={"space-exploration.spaceship"}, style="space_platform_title"}
 ]]

  local name_flow = container.add{ type="flow", name="name-flow", direction="horizontal"}
  local name_label = name_flow.add{ type = "label", name="show-name", caption={"space-exploration.spaceship-name-the", spaceship.name}, style="space_platform_title_short"}
  local rename_button = name_flow.add{ type = "sprite-button", name="rename", sprite="utility/rename_icon_normal",
    tooltip={"space-exploration.rename-something", {"entity-name.se-spaceship-console"}}, style="space_platform_sprite_button_small"}


  container.add{ type="label", name="launch_energy", caption={"space-exploration.spaceship-launch-energy", ""}}
  local bar = container.add{ type="progressbar", name="launch_energy_progress", size = 300, value=0, style="space_platform_progressbar_fuel"}
  bar.style.horizontally_stretchable  = true

  container.add{ type="label", name="structural_integrity", caption={"space-exploration.spaceship-structural-stress-hull", ""}}
  local bar = container.add{ type="progressbar", name="structural_integrity_progress", size = 300, value=0, style="space_platform_progressbar_integrity"}
  bar.style.horizontally_stretchable  = true

  container.add{ type="label", name="container_integrity", caption={"space-exploration.spaceship-structural-stress-container"}}
  local bar = container.add{ type="progressbar", name="container_integrity_progress", size = 300, value=0, style="space_platform_progressbar_integrity"}
  bar.style.horizontally_stretchable  = true

  container.add{ type="button", name="start-integrity-check", caption={"space-exploration.spaceship-button-start-integrity-check"}}

  local integrity_status = container.add{ type="label", name="integrity-status", caption=""}
  integrity_status.style.width = 300
  integrity_status.style.single_line = false

  local space_distortion = container.add{ type="label", name="anomaly-distance", caption=""}
  space_distortion.style.width = 300
  space_distortion.style.single_line = false

  local stellar_x = container.add{ type="label", name="stellar-x", caption=""}
  stellar_x.style.width = 300
  stellar_x.style.single_line = false

  local stellar_y = container.add{ type="label", name="stellar-y", caption=""}
  stellar_y.style.width = 300
  stellar_y.style.single_line = false

  local star_gravity = container.add{ type="label", name="star-gravity", caption=""}
  star_gravity.style.width = 300
  star_gravity.style.single_line = false

  local planet_gravity = container.add{ type="label", name="planet-gravity", caption=""}
  planet_gravity.style.width = 300
  planet_gravity.style.single_line = false

  --local current_speed = container.add{ type="label", name="current-speed", caption="Speed: "}
  --current_speed.style.width = 300
  --current_speed.style.single_line = false

  local closest_location = container.add{ type="label", name="closest-location", caption=""}
  closest_location.style.width = 300
  closest_location.style.single_line = false

  container.add{ type="label", name="destination-label", caption={"space-exploration.spaceship-heading-destination"}, style="space_platform_title"}

  container.add{type="checkbox", name="list-zones-alphabetical", caption={"space-exploration.list-destinations-alphabetically"}, state=playerdata.zones_alphabetical and true or false}

  local filter_container = container.add{ type="flow", name="filter_flow", direction="horizontal"}
  local filter_field = filter_container.add{ type="textfield", name="filter_list"}
  filter_field.style.width = 275
  local filter_button = filter_container.add{ type = "sprite-button", name="clear_filter", sprite="utility/search_icon", tooltip={"space-exploration.clear-filter"},}
  filter_button.style.left_margin = 5
  filter_button.style.width = 28
  filter_button.style.height = 28

  local destination_zone = Spaceship.get_destination_zone(spaceship)
  if not destination_zone then destination_zone = Zone.from_zone_index(spaceship.zone_index) end
  if not destination_zone then destination_zone = Zone.find_nearest_zone(
    spaceship.space_distortion,
    spaceship.stellar_position,
    spaceship.star_gravity_well,
    spaceship.planet_gravity_well)
  end
  local list, selected_index, values = Zone.dropdown_list_zone_destinations(spaceship.force_name, destination_zone, playerdata.zones_alphabetical)
  local zones_dropdown = container.add{ type="drop-down", name="spaceship-list-zones", items=list, selected_index=selected_index}
  zones_dropdown.style.horizontally_stretchable  = true
  player_set_dropdown_values(player, "spaceship-list-zones", values)

  container.add{ type="label", name="travel-time", caption=""}

  local travel_status = container.add{ type="label", name="travel-status", caption=""}
  travel_status.style.width = 300
  travel_status.style.single_line = false

  spaceship.distance_to_destination = Spaceship.get_distance_to_destination(spaceship)

  container.add{ type="flow", name="action-flow", direction="horizontal"}

  container.add{ type="flow", name="back-flow", direction="horizontal"}

  Spaceship.gui_update(player)

end

function Spaceship.on_gui_opened(event)
  local player = game.players[event.player_index]
  if event.entity and event.entity.valid and event.entity.name == Spaceship.name_spaceship_console then
    Spaceship.gui_open(player, Spaceship.from_entity(event.entity))
    player.opened = nil
  else
    -- the trick here is opeining the craft menu to cancel the other menu, then exiting the craft menu
    -- means that pressing e exits the custom gui
    if player.opened_gui_type and player.opened_gui_type ~= defines.gui_type.none then
      if player.gui.left[Spaceship.name_spaceship_gui_root] then
          if player.opened_self then
            player.opened = nil
          end
          Spaceship.gui_close(player)
      end
    end
  end
end
Event.addListener(defines.events.on_gui_opened, Spaceship.on_gui_opened)


function Spaceship.get_make_console_output(console)
  local output = console.surface.find_entity(Spaceship.name_spaceship_console_output, util.vectors_add(console.position, Spaceship.console_output_offset))
  if output then return output end
  console.connect_neighbour({wire = defines.wire_type.red, target_entity = console, source_circuit_id = 1, target_circuit_id = 2 })
  console.connect_neighbour({wire = defines.wire_type.green, target_entity = console, source_circuit_id = 1, target_circuit_id = 2 })
  output = console.surface.create_entity{
    name = Spaceship.name_spaceship_console_output,
    position = util.vectors_add(console.position, Spaceship.console_output_offset),
    force = console.force
  }
  --output.connect_neighbour({wire = defines.wire_type.red, target_entity = console, target_circuit_id = 1 })
  --output.connect_neighbour({wire = defines.wire_type.green, target_entity = console, target_circuit_id = 1 })
  return output
end

function Spaceship.on_entity_created(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if not entity then return end
  if entity.type == "entity-ghost" or entity.type == "tile-ghost" then return end

  local surface = entity.surface

  local spaceship = Spaceship.from_own_surface_index(entity.surface.index)
  for _, name in pairs(Spaceship.names_engines) do
    if entity.name == name then
      if spaceship and spaceship.is_moving then
        entity.active = true
        spaceship.engines = spaceship.engines or {}
        table.insert(spaceship.engines, entity)
      else
        entity.active = false
      end
    end
  end
  if entity.name == Spaceship.name_spaceship_console then
    global.spaceships = global.spaceships or {}
    local console = entity

    if spaceship then
      if not (spaceship.console and spaceship.console.valid) then
        spaceship.console = entity
        spaceship.console_output = nil

        if event.player_index and game.players[event.player_index] then
          Spaceship.gui_open(game.players[event.player_index], spaceship)
        end

        Spaceship.start_integrity_check(spaceship, 0.1)
      end
    else
      local zone = Zone.from_surface(entity.surface)
      if not zone then
        entity.surface.create_entity{
          name = "item-on-ground",
          position = entity.position,
          ["item-entity"] = {name = Spaceship.name_spaceship_console, count = 1}
        }
        entity.destroy()
        game.print({"space-exploration.construction-denied-se-surface"})
        return
      end
      local fn = entity.force.name

      local spaceship_index = global.next_spaceship_index or 1
      global.next_spaceship_index = spaceship_index + 1

      local available_names = {}
      for _, name in pairs(Spaceship.names) do
        local found = false
        for _, spaceship in pairs(global.spaceships) do
          if name == spaceship.name then
            found = true
            break
          end
        end
        if not found then
          table.insert(available_names, name)
        end
      end

      local name = "Spaceship " .. spaceship_index
      if #available_names > 0 then
        name = available_names[math.random(#available_names)]
      end

      local spaceship = {
        type = "spaceship",
        index = spaceship_index,
        valid = true,
        force_name = fn,
        unit_number = entity.unit_number,
        console = entity,
        name = name,
        zone_index = zone.index, -- this is dynamic and can be nil
        speed = 1,
        destination_zone_index = zone.index,
        space_distortion = Zone.get_space_distortion(zone),
        stellar_position = Zone.get_stellar_position(zone),
        star_gravity_well = Zone.get_star_gravity_well(zone),
        planet_gravity_well = Zone.get_planet_gravity_well(zone),
      }
      global.spaceships[spaceship_index] = spaceship

      Spaceship.start_integrity_check(spaceship, 0.1)

      if event.player_index and game.players[event.player_index] then
        Spaceship.gui_open(game.players[event.player_index], spaceship)
      end
    end
  end
  if entity.name == Spaceship.name_spaceship_clamp_place then
    -- find spaceship at tile

    local direction = (entity.direction == defines.direction.east or entity.direction == defines.direction.west ) and defines.direction.west or defines.direction.east

    local check_positions = {}
    if direction == defines.direction.west then
      table.insert(check_positions, util.vectors_add(entity.position, {x=0, y=-1})) -- top right over
      table.insert(check_positions, util.vectors_add(entity.position, {x=0, y=0})) -- bottom right behind
    else
      table.insert(check_positions, util.vectors_add(entity.position, {x=-1, y=-1})) -- top left over
      table.insert(check_positions, util.vectors_add(entity.position, {x=-1, y=0})) -- bottom left behind
    end

    local space_tiles = 0
    for _, pos in pairs(check_positions) do
      if tile_is_space(surface.get_tile(pos)) then
        space_tiles = space_tiles + 1
        Spaceship.flash_tile(surface, pos, {r=255,g=0,b=0, a = 0.25}, 10)
      end
    end
    if space_tiles >= 1 then
      cancel_entity_creation(entity, event.player_index, "Back cannot be on Empty space")
      return
    end

    local keep = entity.surface.create_entity{
      name = Spaceship.name_spaceship_clamp_keep,
      position = entity.position,
      force = entity.force,
      direction = direction
    }
    entity.destroy()
    keep.rotatable = false

    local id = Spaceship.find_unique_clamp_id(direction, keep.surface, keep)
    local comb = keep.get_or_create_control_behavior()
    if direction == defines.direction.west then
      comb.set_signal(1, {signal={type="virtual", name=mod_prefix.."anchor-using-left-clamp"}, count=id})
    else
      comb.set_signal(1, {signal={type="virtual", name=mod_prefix.."anchor-using-right-clamp"}, count=id})
    end
  end
  if spaceship then
    Spaceship.check_integrity_stress(spaceship)
  end
end
Event.addListener(defines.events.on_built_entity, Spaceship.on_entity_created)
Event.addListener(defines.events.on_robot_built_entity, Spaceship.on_entity_created)
Event.addListener(defines.events.script_raised_built, Spaceship.on_entity_created)
Event.addListener(defines.events.script_raised_revive, Spaceship.on_entity_created)

function Spaceship.find_unique_clamp_id(direction, surface, exclude)
  local entities = surface.find_entities_filtered{name=Spaceship.name_spaceship_clamp_keep}
  local used_ids = {}
  for _, entity in pairs(entities) do
    if entity ~= exclude then
      if entity.direction == direction then
        local value = 0
        local comb = entity.get_or_create_control_behavior()
        local signal = comb.get_signal(1)
        if signal then value = signal.count end
        used_ids[value] = value
      end
    end
  end
  local i = 1
  while used_ids[i] do
    i = i + 1
  end
  return i
end

function Spaceship.validate_clamp_signal(entity)
  -- make sure it still has the correct signal.
  local value = 1
  local comb = entity.get_or_create_control_behavior()
  local signal = comb.get_signal(1)
  if signal then value = signal.count end
  if entity.direction == defines.direction.west then
    comb.set_signal(1, {signal={type="virtual", name=mod_prefix.."anchor-using-left-clamp"}, count=value})
  else
    comb.set_signal(1, {signal={type="virtual", name=mod_prefix.."anchor-using-right-clamp"}, count=value})
  end
end

function Spaceship.on_gui_closed(event)
  if event.entity and event.entity.valid and event.entity.name == Spaceship.name_spaceship_clamp_keep then
    Spaceship.validate_clamp_signal(event.entity)
  end
end
Event.addListener(defines.events.on_gui_closed, Spaceship.on_gui_closed)

function Spaceship.on_entity_settings_pasted(event)
  if event.destination  and event.destination .valid and event.destination .name == Spaceship.name_spaceship_clamp_keep then
    Spaceship.validate_clamp_signal(event.destination)
  end
end
Event.addListener(defines.events.on_entity_settings_pasted, Spaceship.on_entity_settings_pasted)

function Spaceship.on_entity_damaged(event)
  if event.cause and event.cause.valid and event.cause.type == "character" and event.entity and event.entity.valid then
    if Util.table_contains(Spaceship.all_targetables, event.entity.name) then
      -- a character hit a particle.
      -- particles are resistant to personal laser defences and other types that don't scale the same way as turrets.
      local character = event.cause
      local damage_type = event.damage_type.name
      local damage_effectiveness = 0.25
      local equipment_damage_types = {}
      if character.grid then
        for _, equipment in pairs(character.grid.equipment) do
          if equipment.type == "active-defense-equipment" and equipment.prototype.attack_parameters.ammo_type and equipment.prototype.attack_parameters.ammo_type.action then
            local damage_types = Util.find_damage_types_from_trigger_items(equipment.prototype.attack_parameters.ammo_type.action)
            if damage_types[damage_type] then
              damage_effectiveness = 0.05
            end
          end
        end
      end
      local final_damage = math.min(event.entity.prototype.max_health, event.final_damage_amount)
      if event.entity.health > 0 then
        event.entity.health = event.entity.health + final_damage * (1 - damage_effectiveness)
      else
        if math.random() < (final_damage * (1 - damage_effectiveness) / event.entity.prototype.max_health) / 20 then
          -- destroy?
        else
          event.entity.health = event.entity.health + final_damage * (1 - damage_effectiveness)
        end
      end
    end
  end
end
Event.addListener(defines.events.on_entity_damaged, Spaceship.on_entity_damaged)


function Spaceship.on_built_tile(event)
  local surface = game.surfaces[event.surface_index]
  if surface and string.find(surface.name, "spaceship-") then
    local spaceship = Spaceship.from_own_surface_index(surface.index)
    Spaceship.check_integrity_stress(spaceship)
    Spaceship.start_integrity_check(spaceship)
  end
end
Event.addListener(defines.events.on_player_built_tile, Spaceship.on_built_tile)
Event.addListener(defines.events.on_player_mined_tile, Spaceship.on_built_tile)

function Spaceship.on_built_tile(event)
  local surface = game.surfaces[event.surface_index]
  if surface and string.find(surface.name, "spaceship-") then
    local spaceship = Spaceship.from_own_surface_index(surface.index)
    Spaceship.check_integrity_stress(spaceship)
    Spaceship.start_integrity_check(spaceship)
  end
end
Event.addListener(defines.events.on_player_built_tile, Spaceship.on_built_tile)
Event.addListener(defines.events.on_player_mined_tile, Spaceship.on_built_tile)

function Spaceship.on_removed_tile(event)
  local surface
  if event.player_index and game.players[event.player_index] and game.players[event.player_index].connected then
    surface = game.players[event.player_index].surface
  end
  if event.robot and event.robot.valid then
    surface = event.robot.surface
  end
  if surface and string.find(surface.name, "spaceship-") then
    local spaceship = Spaceship.from_own_surface_index(surface.index)
    Spaceship.check_integrity_stress(spaceship)
    Spaceship.start_integrity_check(spaceship)
  end
end
Event.addListener(defines.events.on_robot_mined_tile, Spaceship.on_removed_tile)
Event.addListener(defines.events.on_player_mined_tile, Spaceship.on_removed_tile)

function Spaceship.on_removed_entity(event)
  if event.entity and event.entity.valid then
    if event.entity.name == Spaceship.name_spaceship_console then
      local outputs = event.entity.surface.find_entities_filtered{name = Spaceship.name_spaceship_console_output, area = util.position_to_area(event.entity.position, 2)}
      for _, output in pairs(outputs) do
        output.destroy()
      end
    elseif event.entity.surface and Util.table_contains(Spaceship.names_spaceship_bulkheads, event.entity.name) then
      if string.find(event.entity.surface.name, "spaceship-") then
        local spaceship = Spaceship.from_own_surface_index(event.entity.surface.index)
        spaceship.speed = spaceship.speed * 0.9
        Spaceship.check_integrity_stress(spaceship)
        Spaceship.start_integrity_check(spaceship)
      end
    end
  end
end
Event.addListener(defines.events.on_entity_died, Spaceship.on_removed_entity)
Event.addListener(defines.events.on_robot_mined_entity, Spaceship.on_removed_entity)
Event.addListener(defines.events.on_player_mined_entity, Spaceship.on_removed_entity)
Event.addListener(defines.events.script_raised_destroy, Spaceship.on_removed_entity)

function Spaceship.get_distance_to_destination(spaceship)
  if (not spaceship.destination) or Spaceship.is_near_destination(spaceship) then
    return 0
  end

  local target_zone = Spaceship.get_destination_zone(spaceship)
  if target_zone then

    local destination_space_distorion = Zone.get_space_distortion(target_zone)
    local destination_stellar_position = Zone.get_stellar_position(target_zone)
    local destination_star_gravity_well = Zone.get_star_gravity_well(target_zone)
    local destination_planet_gravity_well = Zone.get_planet_gravity_well(target_zone)

    local distortion_distance = 0
    local interstellar_distance = 0
    local star_gravity_distance = 0
    local planet_gravity_distance = 0

    distortion_distance = math.abs(spaceship.space_distortion - destination_space_distorion)

    interstellar_distance = Util.vectors_delta_length(spaceship.stellar_position, destination_stellar_position)
    if distortion_distance == 1 then
      interstellar_distance = 0
    end
    if interstellar_distance == 0 then
      -- same solar system
      star_gravity_distance = math.abs(spaceship.star_gravity_well - destination_star_gravity_well)
    else
      star_gravity_distance = spaceship.star_gravity_well + destination_star_gravity_well
    end

    if star_gravity_distance == 0 then
      -- same solar system
      planet_gravity_distance = math.abs(spaceship.planet_gravity_well - destination_planet_gravity_well)
    else
      planet_gravity_distance = spaceship.planet_gravity_well + destination_planet_gravity_well
    end

    return distortion_distance * Zone.travel_cost_space_distortion
      + interstellar_distance * Zone.travel_cost_interstellar
      + star_gravity_distance * Zone.travel_cost_star_gravity
      + planet_gravity_distance * Zone.travel_cost_planet_gravity

  end

end

function Spaceship.find_own_surface_engines(spaceship)
  spaceship.engines = nil
  local surface = Spaceship.get_own_surface(spaceship)
  if surface then
    spaceship.engines = surface.find_entities_filtered{name = Spaceship.names_engines}
  end
end


function Spaceship.activate_engines(spaceship, probability)
  Spaceship.find_own_surface_engines(spaceship)
  if spaceship.engines then
    for _, engine in pairs(spaceship.engines) do
      engine.active = true
    end
  end
end

function Spaceship.deactivate_engines(spaceship, probability)
  Spaceship.find_own_surface_engines(spaceship)
  if spaceship.engines then
    for _, engine in pairs(spaceship.engines) do
      engine.active = false
    end
  end
end


function Spaceship.add_as_particle(spaceship, entity, particle_template)
  if spaceship and entity then
    if not particle_template then particle_template = Spaceship.particles["rock-small"] end
    spaceship.particles = spaceship.particles or {}

    local particle = table.deepcopy(particle_template)
    particle.valid = true
    table.insert(spaceship.particles, particle)
  end
end

function Spaceship.on_trigger_created_entity(event)
  if event.entity and event.entity.valid and event.entity.name == mod_prefix.."trigger-movable-debris" then
    local surface = event.entity.surface
    local spaceship = Spaceship.from_own_surface_index(surface.index)
    if spaceship then
      local entities = surface.find_entities_filtered{type = "simple-entity", area = Util.position_to_area(event.entity.position, 0.5)}
      for _, entity in pairs(entities) do
        if string.find(entity.name, "meteor") then
          Spaceship.add_as_particle(spaceship, entity, Spaceship.particles["rock-large"])
        else
          Spaceship.add_as_particle(spaceship, entity, Spaceship.particles["rock-small"])
        end
      end
    end
  end
end
Event.addListener(defines.events.on_trigger_created_entity, Spaceship.on_trigger_created_entity)

function Spaceship.surface_tick(spaceship)
  -- actions that apply to maintaining a spaceship surface
  spaceship.speed = spaceship.speed or 0
  local surface = Spaceship.get_own_surface(spaceship)
  if spaceship.speed > 1 then
    surface.wind_orientation = 0.5
  end

  surface.wind_speed = 0.01 + 0.005 * math.pow(spaceship.speed / Spaceship.speed_taper, Spaceship.partical_speed_power) * Spaceship.speed_taper

  if spaceship.particles then
    for _, particle in pairs(spaceship.particles) do

      if not (particle.graphic and particle.graphic.valid) then -- killed or mined
        particle.valid = false
      elseif particle.graphic.position.y > spaceship.known_bounds.right_bottom.y + Spaceship.particle_spawn_range + 32 then -- out of range
        particle.valid = false
      end

      if particle.projectile and particle.projectile.valid == false then -- projectile was there but detonated
        particle.valid = false
      end

      if particle.targetable and particle.targetable.valid == false then -- projectile detonated
        particle.valid = false
      end


      if not particle.valid then
        if particle.graphic and particle.graphic.valid then
          particle.graphic.destroy()
          particle.graphic = nil
        end
        if particle.projectile and particle.projectile.valid then
          particle.projectile.destroy()
          particle.projectile = nil
        end
        if particle.targetable and particle.targetable.valid then
          particle.targetable.destroy()
          particle.targetable = nil
        end
        spaceship.particles[_] = nil

      else -- particle is still valid

         local position = particle.graphic.position
         position.y = position.y + particle.speed * math.pow(spaceship.speed / Spaceship.speed_taper, Spaceship.partical_speed_power) * Spaceship.speed_taper

         if spaceship.speed > 0.001 then

            particle.graphic.teleport(position)

            if particle.projectile then
              particle.projectile.teleport(position)
            elseif particle.projectile_name then
              particle.projectile = surface.create_entity{
                name = particle.projectile_name,
                position = position,
                speed = 0.01,
                target = {x = position.x, y = position.y + 100},
                force="enemy"
              }
            end

            if particle.targetable then
              particle.targetable.teleport(position)
            elseif particle.targetable_name then
              particle.targetable = surface.create_entity{
                name = particle.targetable_name,
                position = position,
                target = {x = position.x, y = position.y + 100},
                force="enemy"
              }
            end

            if particle.targetable and particle.destroys_floor then
              -- destroy floor
              local x = math.floor(position.x)
              local y = math.floor(position.y)
              if spaceship.known_tiles[x] and spaceship.known_tiles[x][y] then

                spaceship.known_tiles[x][y] = nil

                local tile = surface.get_tile(x, y)
                local tile_name = tile.name
                if tile_name ~= name_space_tile then

                  particle.targetable.damage(50, "neutral", "explosion") -- damage the particle

                  local entities = surface.find_entities_filtered{ -- destroy entities on the floor
                    area = util.tile_to_area({x=x,y=y}, margin),
                    collision_mask = {space_collision_layer, "object-layer", "resource-layer"}
                  }
                  for _, entity in pairs(entities) do
                    if entity and entity.valid then entity.die() end
                  end

                  surface.set_tiles(
                    {{name=name_space_tile, position = {x,y}}},
                    false, -- corect tiles
                    true, -- remove_colliding_entities
                    true, -- remove_colliding_decoratives
                    true -- raise_event
                  )

                  if Util.table_contains(Spaceship.names_spaceship_floors, tile_name) then
                    -- make blueprint for the tile.
                    surface.create_entity{name = "tile-ghost", inner_name = tile_name, force = spaceship.force_name, position = {x=x,y=y}}
                  end

                  Spaceship.start_integrity_check(spaceship)

                end
              end
            end

         else
           if particle.projectile and particle.projectile.valid then
             particle.projectile.destroy()
             particle.projectile = nil
           end
           if particle.targetable and particle.targetable.valid then
             particle.targetable.destroy()
             particle.targetable = nil
           end
         end

      end

    end
  end

end


function Spaceship.set_light(spaceship, surface)

    -- expect 15 is the max, 10 + 5 planets but reduced start position
    local light_percent = Zone.get_solar(spaceship)

    surface.freeze_daytime = true

    if light_percent >= 0.5 then
      surface.daytime = 0.35 -- half light
      surface.solar_power_multiplier = Zone.solar_multiplier * light_percent * 2 -- x2 compensate for half light
    else
      surface.daytime = 0.45 - 0.2 * light_percent
      surface.solar_power_multiplier = Zone.solar_multiplier -- x2 compensate for half light max
      -- light_percent of 1 would be 0.35 (half-light),
      -- light_percent of 0 would be 0.45 (dark)
    end

end

function Spaceship.move_to_destination(spaceship)
  if not spaceship.destination then return end

  --Log.trace(game.tick .. " moving to destination.")
  -- move away from current zone
  if spaceship.near and not Spaceship.is_near_destination(spaceship) then
    --Log.trace(game.tick .. "Leaving zone.")
    spaceship.near = nil
    -- close any scouting views
    for _, player in pairs(game.connected_players) do
      local playerdata = get_make_playerdata(player)
      if playerdata.anchor_scouting_for_spaceship_index == spaceship.index then
        Spaceship.stop_anchor_scouting(player)
        player.print("Cannot anchor, spaceship has departed for a different destination.")
      end
    end
  end

  local target_zone = Spaceship.get_destination_zone(spaceship)
  if not target_zone then
    spaceship.destination = nil
    spaceship.travel_message = "No destination."
    Log.trace("Spaceship destination invalid")
    return
  end

  local ship_surface = Spaceship.get_own_surface(spaceship)

  -- mid-flight validation
  if not spaceship.tile_count or (game.tick % 60 == 0) then
    spaceship.tile_count = ship_surface.count_tiles_filtered{name = Spaceship.names_spaceship_floors}
  end

  if not spaceship.bulkhead_count or ((game.tick + 30) % 60 == 0) then
    spaceship.bulkhead_count = ship_surface.count_entities_filtered{name = Spaceship.names_spaceship_bulkheads}
  end

  local target_size = spaceship.tile_count - spaceship.bulkhead_count / 2
  local mass_estimate = Spaceship.minimum_mass + target_size

  if spaceship.engines then
    for _, engine in pairs(spaceship.engines) do
      if engine and engine.valid then
        if engine.active and engine.is_crafting() then
          for _, engine_proto in pairs(Spaceship.engines) do
            if engine.name == engine_proto.name then
              spaceship.speed = spaceship.speed + engine_proto.thrust * (engine.energy / engine_proto.max_energy) / mass_estimate
              * (Spaceship.speed_taper / (Spaceship.speed_taper + spaceship.speed))
            end
          end
        end
      else
        spaceship.engines[_] = nil
      end
    end
  end

  -- space_drag from imperfect vacuum
  spaceship.speed = spaceship.speed * (1 - Spaceship.space_drag) + Spaceship.minimum_impulse
  spaceship.max_speed = math.max(spaceship.speed, spaceship.max_speed or 0)

  -- floating characters
  if remote.interfaces["jetpack"] and remote.interfaces["jetpack"]["get_jetpacks"] then
    local jetpacks = remote.call("jetpack", "get_jetpacks", {surface_index = spaceship.own_surface_index})
    for _, jetpack in pairs(jetpacks) do
      jetpack.velocity.y = jetpack.velocity.y +
        0.000005 * math.pow(spaceship.speed / Spaceship.speed_taper, Spaceship.partical_speed_power) * Spaceship.speed_taper
      if remote.interfaces["jetpack"]["set_velocity"] then
        remote.call("jetpack", "set_velocity", {unit_number = jetpack.unit_number, velocity = jetpack.velocity})
      end
    end
  end

  -- spawn particles based on speed.
  spaceship.particles = spaceship.particles or {}

  local function spawn_particles_speed_size(particle_template)
    if spaceship.speed > (particle_template.min_speed or 0)
     and spaceship.integrity_stress > (particle_template.min_size or 0) then

      local spawn_particles_quota = target_size * spaceship.speed / 60 * particle_template.multiplier
      local spawn_particles_whole = math.floor(spawn_particles_quota)
      local spawn_particles_chance = spawn_particles_quota - spawn_particles_whole
      if math.random() <= spawn_particles_chance then
        spawn_particles_whole = spawn_particles_whole + 1
      end

      if spawn_particles_whole > 0 then
        local x_min = spaceship.known_bounds.left_top.x - Spaceship.particle_spawn_range
        local x_max = spaceship.known_bounds.right_bottom.x + Spaceship.particle_spawn_range
        local spawn_y = spaceship.known_bounds.left_top.y - Spaceship.particle_spawn_range - 10

        for i = 1, spawn_particles_whole do
          local spawn_x = x_min + math.random() * (x_max - x_min)
          local particle = table.deepcopy(particle_template)
          particle.valid = true
          particle.graphic = ship_surface.create_entity{
            name = particle_template.graphic_name,
            position = {x = spawn_x, y = spawn_y},
          }
          table.insert(spaceship.particles, particle)
        end
      end
    end
  end
  for _, particle_template in pairs(Spaceship.particles) do
    spawn_particles_speed_size(particle_template)
  end

  -- step towards destination
  local travel_speed = spaceship.speed * Spaceship.travel_speed_multiplier
  local destination_space_distorion = Zone.get_space_distortion(target_zone)
  local destination_stellar_position = Zone.get_stellar_position(target_zone)
  local destination_star_gravity_well = Zone.get_star_gravity_well(target_zone)
  local destination_planet_gravity_well = Zone.get_planet_gravity_well(target_zone)

  if destination_space_distorion > 0 then -- target is anomaly
    if spaceship.planet_gravity_well > 0 then
      spaceship.planet_gravity_well = math.max(0, spaceship.planet_gravity_well - travel_speed / Zone.travel_cost_planet_gravity)
      spaceship.travel_message = {"space-exploration.spaceship-travel-message-exiting-planet-gravity"}
    elseif spaceship.star_gravity_well > 0 then
      spaceship.star_gravity_well = math.max(0, spaceship.star_gravity_well - travel_speed / Zone.travel_cost_star_gravity)
      spaceship.travel_message = {"space-exploration.spaceship-travel-message-exiting-star-gravity"}
    else -- can enter distortion
      local delta_space_distortion = destination_space_distorion - spaceship.space_distortion
      if delta_space_distortion == 0 then
        spaceship.near = table.deepcopy(spaceship.destination)
        spaceship.stopped = true
      else
        local space_distortion_travel = travel_speed / Zone.travel_cost_space_distortion
        -- step towards destination
        spaceship.space_distortion = spaceship.space_distortion
          + math.min(math.max(delta_space_distortion, -space_distortion_travel), space_distortion_travel)
        spaceship.travel_message = {"space-exploration.spaceship-travel-message-spatial-distortions"}
      end
    end
  elseif spaceship.space_distortion == 1 then
    spaceship.stellar_position = table.deepcopy(destination_stellar_position)
    spaceship.space_distortion = 1 - travel_speed / Zone.travel_cost_space_distortion
    spaceship.travel_message = {"space-exploration.spaceship-travel-message-spatial-distortions"}
  elseif spaceship.space_distortion > 0 then
    spaceship.space_distortion = spaceship.space_distortion - travel_speed / Zone.travel_cost_space_distortion
    spaceship.travel_message = {"space-exploration.spaceship-travel-message-spatial-distortions"}
  else -- conventional travel
    local interstellar_distance = Util.vectors_delta_length(spaceship.stellar_position, destination_stellar_position)
    if interstellar_distance == 0 then -- same system
      spaceship.near_star = Zone.get_star_from_child(target_zone)
      if spaceship.star_gravity_well == destination_star_gravity_well then -- same planet system
        if spaceship.planet_gravity_well == destination_planet_gravity_well then -- we're here
          spaceship.near = table.deepcopy(spaceship.destination)
          spaceship.stopped = true
        else
          local delta_planet_gravity = destination_planet_gravity_well - spaceship.planet_gravity_well
          local planet_gravity_travel = travel_speed / Zone.travel_cost_planet_gravity
          spaceship.planet_gravity_well = spaceship.planet_gravity_well
            + math.min(math.max(delta_planet_gravity, -planet_gravity_travel), planet_gravity_travel)
          spaceship.travel_message = {"space-exploration.spaceship-travel-message-navigating-planet-gravity"}
        end
      else
        if spaceship.planet_gravity_well > 0 then
          spaceship.planet_gravity_well = math.max(0, spaceship.planet_gravity_well - travel_speed / Zone.travel_cost_planet_gravity)
          spaceship.travel_message = {"space-exploration.spaceship-travel-message-exiting-planet-gravity"}
        else
          local delta_star_gravity = destination_star_gravity_well - spaceship.star_gravity_well
          local star_gravity_travel = travel_speed / Zone.travel_cost_star_gravity
          spaceship.star_gravity_well = spaceship.star_gravity_well
            + math.min(math.max(delta_star_gravity, -star_gravity_travel), star_gravity_travel)
          spaceship.travel_message = {"space-exploration.spaceship-travel-message-exiting-star-gravity"}
        end
      end
    else -- different systems
      if spaceship.planet_gravity_well > 0 then
        spaceship.planet_gravity_well = math.max(0, spaceship.planet_gravity_well - travel_speed / Zone.travel_cost_planet_gravity)
        spaceship.travel_message = {"space-exploration.spaceship-travel-message-exiting-planet-gravity"}
      elseif spaceship.star_gravity_well > 0 then
        spaceship.star_gravity_well = math.max(0, spaceship.star_gravity_well - travel_speed / Zone.travel_cost_star_gravity)
        spaceship.travel_message = {"space-exploration.spaceship-travel-message-exiting-star-gravity"}
      else
        spaceship.stellar_position = Util.move_to(spaceship.stellar_position, destination_stellar_position,
          travel_speed / Zone.travel_cost_interstellar)
        spaceship.travel_message = {"space-exploration.spaceship-travel-message-navigating-interstellar"}
      end
    end
  end

  Spaceship.set_light(spaceship, ship_surface)

end


function Spaceship.spaceship_tick(spaceship)
  if not spaceship.console and spaceship.console.valid then
    spaceship.check_message= {"space-exploration.spaceship-check-message-no-console"}
    spaceship.integrity_valid = false
  end

  if spaceship.own_surface_index or (spaceship.console and spaceship.console.valid) then
    -- integrity check
    if spaceship.is_doing_check then
      if spaceship.own_surface_index and spaceship.known_floor_tiles then
        -- need to tick faster on bigger ships
        for i = 0, math.ceil(spaceship.known_floor_tiles / 1000) do
          -- tick once for each 1000 tiles
          if spaceship.is_doing_check then
            Spaceship.integrity_check_tick(spaceship)
          end
        end
      else
        Spaceship.integrity_check_tick(spaceship)
      end
    elseif game.tick % (Spaceship.integrity_pulse_interval) == 0 and spaceship.console and spaceship.console.valid and spaceship.console.energy > 0 then
        Spaceship.start_integrity_check(spaceship)
    end

    if spaceship.console and spaceship.console.valid and (game.tick % 60) == 0 then
      -- read signals
      local red = spaceship.console.get_circuit_network(defines.wire_type.red)
      local green = spaceship.console.get_circuit_network(defines.wire_type.green)

      -- set speed
      spaceship.target_speed = nil
      local signal_target_speed =  util.signal_from_wires(red, green, Spaceship.signal_for_speed)
      if signal_target_speed > 0 then
        spaceship.target_speed = signal_target_speed + 0.5
      elseif signal_target_speed < 0 then
        spaceship.target_speed = 0
      end

      -- set destination
      for signal_name, type in pairs(Zone.signal_to_zone_type) do
        local value = util.signal_from_wires(red, green, {type = "virtual", name = signal_name})
        if value > 0 then
          local zone = Zone.from_zone_index(value)
          if zone and zone.type == type then
            if Zone.is_visible_to_force(zone, spaceship.force_name) or global.debug_view_all_zones then
              spaceship.destination = { type = "zone", index = value }
              break
            end
          end
        end
      end
      -- TODO: allow spacwhip as destination

      -- launch
      if not spaceship.own_surface_index then
        if (red and red.get_signal(Spaceship.signal_for_launch) > 0)
          or (green and green.get_signal(Spaceship.signal_for_launch) > 0) then
            spaceship.is_launching = true
            spaceship.is_landing = false
            Spaceship.start_integrity_check(spaceship)
        end
      end

      if spaceship.own_surface_index
       and spaceship.destination
       and spaceship.destination.type == "zone"
       and Spaceship.is_near_destination(spaceship) then
        local using_left = util.signal_from_wires(red, green, Spaceship.signal_for_anchor_using_left)
        local to_right = util.signal_from_wires(red, green, Spaceship.signal_for_anchor_to_right)
        local using_right = util.signal_from_wires(red, green, Spaceship.signal_for_anchor_using_right)
        local to_left = util.signal_from_wires(red, green, Spaceship.signal_for_anchor_to_left)

        if (using_left ~= 0 and to_right ~= 0) or (using_right ~= 0 and to_left ~= 0) then
          local spaceship_surface = spaceship.console.surface
          local destination_surface = Zone.get_make_surface(Zone.from_zone_index(spaceship.destination.index))
          local spaceship_clamps = spaceship_surface.find_entities_filtered{name=Spaceship.name_spaceship_clamp_keep}
          local destination_clamps = destination_surface.find_entities_filtered{name=Spaceship.name_spaceship_clamp_keep}
          if using_left ~= 0 and to_right ~= 0 then
            local spaceship_clamp
            for _, s_clamp in pairs(spaceship_clamps) do
              if s_clamp.direction == defines.direction.west then
                local comb = s_clamp.get_or_create_control_behavior()
                local signal = comb.get_signal(1)
                if signal and signal.count == using_left then
                  spaceship_clamp = s_clamp
                  break
                end
              end
            end
            local destination_clamp
            if spaceship_clamp then
              for _, d_clamp in pairs(destination_clamps) do
                if d_clamp.direction == defines.direction.east then
                  local comb = d_clamp.get_or_create_control_behavior()
                  local signal = comb.get_signal(1)
                  if signal and signal.count == to_right then
                    destination_clamp = d_clamp
                    break
                  end
                end
              end
            end
            if destination_clamp and spaceship_clamp then
              -- try to land based on the relative offsets
              local position = {
                x = -1 * spaceship_clamp.position.x + 2,
                y = -1 * spaceship_clamp.position.y
              }
              position = util.vectors_add(position, destination_clamp.position)

              Spaceship.land_at_position(spaceship, position, true)
              return --?
            end
          end
          if using_right ~= 0 and to_left ~= 0 then
            local spaceship_clamp
            for _, s_clamp in pairs(spaceship_clamps) do
              if s_clamp.direction == defines.direction.east then
                local comb = s_clamp.get_or_create_control_behavior()
                local signal = comb.get_signal(1)
                if signal and signal.count == using_right then
                  spaceship_clamp = s_clamp
                  break
                end
              end
            end
            local destination_clamp
            if spaceship_clamp then
              for _, d_clamp in pairs(destination_clamps) do
                if d_clamp.direction == defines.direction.west then
                  local comb = d_clamp.get_or_create_control_behavior()
                  local signal = comb.get_signal(1)
                  if signal and signal.count == to_left then
                    destination_clamp = d_clamp
                    break
                  end
                end
              end
            end
            if destination_clamp and spaceship_clamp then
              -- try to land based on the relative offsets
              local position = {
                x = -1 * spaceship_clamp.position.x - 2,
                y = -1 * spaceship_clamp.position.y
              }
              position = util.vectors_add(position, destination_clamp.position)

              Spaceship.land_at_position(spaceship, position, true)
              return --?
            end
          end
        end
      end

    end

    if spaceship.own_surface_index then
      -- space upkeep
      Spaceship.surface_tick(spaceship)

      if spaceship.target_speed and spaceship.is_moving == false and spaceship.stopped then
        spaceship.stopped = false
      end

      -- navigation
      if spaceship.integrity_valid
        and spaceship.destination
        and not spaceship.stopped
        and not Spaceship.is_near_destination(spaceship) then
          -- wants to move and can move
          if not spaceship.is_moving then
            spaceship.is_moving = true
            Spaceship.activate_engines(spaceship)
            Spaceship.start_integrity_check(spaceship)
          end

          if (game.tick % 6) == 0 then
            if spaceship.target_speed and spaceship.is_moving and spaceship.engines then
              if spaceship.speed > spaceship.target_speed then
                for _, engine in pairs(spaceship.engines) do
                  if engine.valid and math.random() < 1/table_size(spaceship.engines) then
                    engine.active = false
                  end
                end
              else
                for _, engine in pairs(spaceship.engines) do
                  if engine.valid and math.random() < 1/table_size(spaceship.engines) then
                    engine.active = true
                  end
                end
              end
            end
          end

          Spaceship.move_to_destination(spaceship)
      else
        -- can't move
        if spaceship.is_moving then
          spaceship.is_moving = false
          Spaceship.deactivate_engines(spaceship)
        end
        if Spaceship.is_near_destination(spaceship) then
          spaceship.speed = 0
          spaceship.travel_message = {"space-exploration.spaceship-travel-message-at-destination"}
        end
        if spaceship.speed > 1 then
          spaceship.speed = spaceship.speed * (1 - Spaceship.space_drag)
        elseif spaceship.speed > 0 then
          spaceship.speed = 0
        end
      end
    end


  else
    Spaceship.destroy(spaceship)
    return
  end

  if game.tick % 60 == 0 then
    Spaceship.update_output_combinator(spaceship)
  end

end

function Spaceship.update_output_combinator(spaceship)

  if not spaceship.console and spaceship.console.valid then return end
  if not (spaceship.console_output and spaceship.console_output.valid) then
    spaceship.console_output = Spaceship.get_make_console_output(spaceship.console)
  end
  if spaceship.console_output and spaceship.console_output.valid then
    local ctrl = spaceship.console_output.get_or_create_control_behavior()

    local slot = 1
    -- Spaceship ID
    ctrl.set_signal(slot, {signal=Spaceship.signal_for_own_spaceship_id, count=spaceship.index})
    slot = slot + 1
    -- Speed
    if spaceship.is_moving and spaceship.speed > 0 then
      ctrl.set_signal(slot, {signal=Spaceship.signal_for_speed, count=math.max(1, spaceship.speed)})
    elseif spaceship.own_surface_index then
      ctrl.set_signal(slot, {signal=Spaceship.signal_for_speed, count=-1}) -- stopped
    else
      ctrl.set_signal(slot, {signal=Spaceship.signal_for_speed, count=-2}) -- anchored
    end
    slot = slot + 1

    -- Distance
    if (not spaceship.distance_to_destination_tick) or spaceship.distance_to_destination_tick == game.tick then
      spaceship.distance_to_destination = Spaceship.get_distance_to_destination(spaceship)
      spaceship.distance_to_destination_tick = game.tick
    end

    if spaceship.destination and Spaceship.is_near_destination(spaceship) then
      ctrl.set_signal(slot, {signal=Spaceship.signal_for_distance, count=-1})
    elseif spaceship.destination and Spaceship.is_at_destination(spaceship)  then
      ctrl.set_signal(slot, {signal=Spaceship.signal_for_distance, count=-2})
    elseif spaceship.distance_to_destination and spaceship.distance_to_destination > 0 then
      ctrl.set_signal(slot, {signal=Spaceship.signal_for_distance, count=math.max(1, spaceship.distance_to_destination)})
    else --no destination
      ctrl.set_signal(slot, {signal=Spaceship.signal_for_distance, count=-3})
    end
    slot = slot + 1

    -- Destination
    if spaceship.destination then
      if spaceship.destination.type == "spaceship" then
        ctrl.set_signal(slot, {signal=Spaceship.signal_for_destination_spaceship, count=spaceship.destination.index})
      elseif spaceship.destination.type == "zone" then
        local zone = Spaceship.get_destination_zone(spaceship)
        local signal_name = Zone.get_signal_name(zone)
        ctrl.set_signal(slot, {signal={type="virtual", name=signal_name}, count=zone.index})
      else
        ctrl.set_signal(slot, {signal=Spaceship.signal_for_destination_spaceship, count=0})
      end
    else
      ctrl.set_signal(slot, {signal=Spaceship.signal_for_destination_spaceship, count=0})
    end
    slot = slot + 1

  end

end


function Spaceship.on_tick(event)
  if global.spaceships then
    for _, spaceship in pairs(global.spaceships) do
      Spaceship.spaceship_tick(spaceship)
    end
  end
  for _, player in pairs(game.connected_players) do
    local playerdata = get_make_playerdata(player)
    if playerdata and playerdata.anchor_scouting_for_spaceship_index then
      Spaceship.anchor_scouting_tick(player, Spaceship.from_index(playerdata.anchor_scouting_for_spaceship_index))
    end
    Spaceship.gui_update(player)
  end
end
Event.addListener(defines.events.on_tick, Spaceship.on_tick)

--[[
function Spaceship.on_chunk_generated(event)
  local area = event.area
  local surface = event.surface
  local spaceship = Spaceship.from_own_surface_index(surface.index)
  if spaceship then
    area.right_bottom.x = area.right_bottom.x + 0.99
    area.right_bottom.y = area.right_bottom.y + 0.99
    entities = surface.find_entities_filtered{
      area = area
    }
    for _, entity in pairs(entities) do -- rocks
      entity.destroy()
    end
    local bad_tiles = surface.find_tiles_filtered{name={name_asteroid_tile, "out-of-map"}}
    local set_tiles = {}
    for _, tile in pairs(bad_tiles) do
      table.insert(set_tiles, {position = tile.position, name=name_space_tile})
      surface.set_hidden_tile(tile.position, name_space_tile)
    end
    surface.set_tiles(set_tiles)
  end
end
Event.addListener(defines.events.on_chunk_generated, Spaceship.on_chunk_generated)
]]--

function Spaceship.flash_tile(surface, position, color, time)
  local a = (color.a or 1)
  rendering.draw_rectangle{
    color = {r = color.r * a, g = color.g * a, b = color.b * a, a = a},
    filled = true,
    left_top = position,
    right_bottom = {(position.x or position[1])+1, (position.y or position[2])+1},
    surface = surface,
    time_to_live = time
  }
end

function Spaceship.calculate_integrity_stress(spaceship, area)

  -- use all tiles
  local surface = Spaceship.get_own_surface(spaceship)
  if not surface then surface = spaceship.console.surface end

  if not area then --- whole surface
    spaceship.tile_count = surface.count_tiles_filtered{name = Spaceship.names_spaceship_floors}
    spaceship.wall_count = surface.count_entities_filtered{name = Spaceship.names_spaceship_walls}
  else
    spaceship.tile_count = spaceship.known_floor_tiles + spaceship.known_bulkhead_tiles
    spaceship.wall_count = 0
    local walls = surface.find_entities_filtered{name = Spaceship.names_spaceship_walls}
    for _, wall in pairs(walls) do
      local tile_pos = Util.position_to_tile(wall.position)
      if spaceship.known_tiles[tile_pos.x] and spaceship.known_tiles[tile_pos.x][tile_pos.y] == Spaceship.tile_status.bulkhead_console_connected  then
        spaceship.wall_count = spaceship.wall_count + 1
      end
    end
  end

  spaceship.container_slot_count = 0

  local containers = surface.find_entities_filtered{ type = {"container", "logistic-container", "car"}, area = area}

  for _, container in pairs(containers) do
    local tile_pos = Util.position_to_tile(container.position)
    if area == nil or (spaceship.known_tiles[tile_pos.x] and spaceship.known_tiles[tile_pos.x][tile_pos.y] == Spaceship.tile_status.floor_console_connected) then
      if container.type == "car" then
        spaceship.container_slot_count = spaceship.container_slot_count + container.prototype.get_inventory_size(defines.inventory.car_trunk)
      else
        spaceship.container_slot_count = spaceship.container_slot_count + container.prototype.get_inventory_size(defines.inventory.chest)
      end
    end
  end

  spaceship.container_fluid_capacity = 0

  local containers = surface.find_entities_filtered{type = {"storage-tank"}}
  for _, container in pairs(containers) do
    local mult = string.find(container.name, "booster", 1, true) and 0.5 or 1
    local tile_pos = Util.position_to_tile(container.position)
    if area == nil or (spaceship.known_tiles[tile_pos.x] and spaceship.known_tiles[tile_pos.x][tile_pos.y] == Spaceship.tile_status.floor_console_connected) then
      if container.fluidbox and #container.fluidbox > 0 then
        local i = 1
        for i = 1, #container.fluidbox do
          spaceship.container_fluid_capacity = spaceship.container_fluid_capacity + mult * container.fluidbox.get_capacity(i)
        end
      end
    end
  end
  -- container slot is 0.5 or 24 for a normal container 4800 ish items. Cost is 24
  -- container can caryy 48 * 10 barrels = 24k fluid
  -- storage tank is 5, 25k fluids = 250 effective items. Cost is 12.5 (50% discount)
  -- booster tanks cost50% less
  spaceship.integrity_stress_structure = spaceship.tile_count - spaceship.wall_count / 2
  spaceship.integrity_stress_container = spaceship.container_slot_count/2 + spaceship.container_fluid_capacity / 2000
  spaceship.integrity_stress = math.max(spaceship.integrity_stress_structure, spaceship.integrity_stress_container)
  if spaceship.integrity_stress > spaceship.integrity_limit then
    spaceship.integrity_valid = false
    spaceship.check_message = {"space-exploration.spaceship-check-message-failed-stress"}
  end

end

function Spaceship.check_integrity_stress(spaceship)
  spaceship.integrity_limit = Spaceship.get_integrity_limit(game.forces[spaceship.force_name])
  if spaceship.own_surface_index then
    -- use all tiles
    Spaceship.calculate_integrity_stress(spaceship, nil) -- whole area
  elseif not (spaceship.console and spaceship.console.valid) then
    spaceship.integrity_valid = false
    spaceship.check_message= {"space-exploration.spaceship-check-message-no-console"}
  elseif not spaceship.integrity_valid then
    -- already invalid
  elseif not spaceship.known_bounds then
    spaceship.integrity_valid = false
    spaceship.check_message= {"space-exploration.spaceship-check-message-failed-unknown-bounds"}
  elseif spaceship.integrity_valid and spaceship.known_bounds and spaceship.known_tiles then
    Spaceship.calculate_integrity_stress(spaceship, spaceship.known_bounds) -- limited area

    --[[ TODO: use improved know tiles approach
    and spaceship.known_tile_count and spaceship.known_wall_count then
    spaceship.integrity_stress = spaceship.known_tile_count - spaceship.known_wall_count / 2
    if spaceship.integrity_stress > spaceship.integrity_limit then
      spaceship.integrity_valid = false
      spaceship.check_message = "Fail: Structural integrity stress exceeds technology limit."
    end
    ]]--
  end

end

function Spaceship.start_integrity_check(spaceship, alpha)
  if alpha then
    spaceship.check_flash_alpha = alpha
  end
  spaceship.is_doing_check = true
end

function Spaceship.stop_integrity_check(spaceship)
  spaceship.check_flash_alpha = nil
  spaceship.is_doing_check = nil
  spaceship.check_stage = nil
  spaceship.pending_tiles = nil
  if spaceship.integrity_valid and spaceship.check_tiles then
    -- success
    spaceship.known_tiles = table.deepcopy(spaceship.check_tiles)
    spaceship.check_tiles = nil

    -- get the average for surface transfer
    local min_x = nil
    local max_x = nil
    local min_y = nil
    local max_y = nil
    local floor_tiles = 0
    local bulkhead_tiles = 0
    for x, x_tiles in pairs(spaceship.known_tiles) do
      if min_x == nil or x < min_x then min_x = x end
      if max_x == nil or x > max_x then max_x = x end
      for y, status in pairs(x_tiles) do
        if status == Spaceship.tile_status.floor_console_connected
          or status == Spaceship.tile_status.bulkhead_console_connected then
            if min_y == nil or y < min_y then min_y = y end
            if max_y == nil or y > max_y then max_y = y end
            if status == Spaceship.tile_status.floor_console_connected then
              floor_tiles = floor_tiles + 1
            else
              bulkhead_tiles = bulkhead_tiles + 1
            end
        end
      end
    end
    max_x = max_x + 1 -- whole tile
    max_y = max_y + 1 -- whole tile
    spaceship.known_floor_tiles = floor_tiles
    spaceship.known_bulkhead_tiles = bulkhead_tiles
    spaceship.known_bounds = {left_top = {x = min_x, y = min_y}, right_bottom={x = max_x, y = max_y}}
    spaceship.known_tiles_average_x = math.floor((min_x + max_x)/2)
    spaceship.known_tiles_average_y = math.floor((min_y + max_y)/2)

    if spaceship.own_surface_index then
      Spaceship.find_own_surface_engines(spaceship)
    end
  else
    spaceship.integrity_valid = false
    spaceship.check_tiles = nil
    spaceship.check_message = {"space-exploration.spaceship-check-message-failed-empty"}
  end

  --spaceship.check_message = nil
  if spaceship.console and spaceship.console.valid then
    --spaceship.console.force.print("Spaceship integrity check complete.")
  end

  Spaceship.check_integrity_stress(spaceship)

  if spaceship.is_launching then
    Spaceship.launch(spaceship)
  end
end

function Spaceship.integrity_check_tick(spaceship)
  if not(spaceship.console and spaceship.console.valid) then
    spaceship.check_message= {"space-exploration.spaceship-check-message-no-console"}
    spaceship.integrity_valid = false
    Spaceship.stop_integrity_check(spaceship)
    return
  end

  local surface = spaceship.console.surface
  if not (spaceship.check_stage and spaceship.check_tiles and spaceship.pending_tiles) then
    local start_tile = surface.get_tile(spaceship.console.position)
    if Spaceship.is_floor(start_tile.name) then
      Spaceship.check_message = nil
      Spaceship.is_doing_check = true
      -- floor tiles is a 2d array x then y
      spaceship.check_tiles = {}
      spaceship.check_tiles[start_tile.position.x] = {}
      spaceship.check_tiles[start_tile.position.x][start_tile.position.y] = Spaceship.tile_status.floor
      spaceship.pending_tiles = {}
      spaceship.pending_tiles[start_tile.position.x] = {}
      spaceship.pending_tiles[start_tile.position.x][start_tile.position.y] = true
      spaceship.check_stage = "floor-connectivity"
      spaceship.check_message= {"space-exploration.spaceship-check-message-checking-console-floor"}
    else
      spaceship.check_message= {"space-exploration.spaceship-check-message-failed-console-floor"}
      spaceship.integrity_valid = false
      Spaceship.stop_integrity_check(spaceship)
      return
    end
  end
  if not (spaceship.check_tiles and spaceship.pending_tiles) then return end

  local alpha = spaceship.check_flash_alpha or 0.05

  -- do a round of checking
  -- check_tiles. List of tiles to check this tick.

  -- pending_tiles should always exists in check_tiles
  -- it basically justs keeps a lst of which ones to search

  local next_pending_tiles = {}
  local changed = false

  if spaceship.check_stage == "floor-connectivity" then
    for x, x_tiles in pairs(spaceship.pending_tiles) do
      for y, yes in pairs(x_tiles) do
        if spaceship.check_tiles[x][y] == Spaceship.tile_status.floor
          or spaceship.check_tiles[x][y] == Spaceship.tile_status.bulkhead then
          for d = 1, 4 do -- 4 way direction
              local cx = x + (d == 2 and 1 or (d == 4 and -1 or 0))
              local cy = y + (d == 1 and -1 or (d == 3 and 1 or 0))
              if not (spaceship.check_tiles[cx] and spaceship.check_tiles[cx][cy]) then -- unknown tile
                changed = true
                local tile = surface.get_tile({cx, cy})
                local wall_count = surface.count_entities_filtered{
                  area = Util.position_to_area({x = cx + 0.5, y = cy + 0.5}, 0.4),
                  name = Spaceship.names_spaceship_bulkheads
                }
                if Spaceship.is_floor(tile.name) then
                  spaceship.check_tiles[cx] = spaceship.check_tiles[cx] or {}
                  if wall_count > 0 then
                    spaceship.check_tiles[cx][cy] = Spaceship.tile_status.bulkhead
                    Spaceship.flash_tile(surface, {cx, cy}, {r = 0, g = 0, b = 1, a = alpha}, 5)
                  else
                    spaceship.check_tiles[cx][cy] = Spaceship.tile_status.floor
                    Spaceship.flash_tile(surface, {cx, cy}, {r = 0, g = 1, b = 0, a = alpha}, 5)
                  end
                  next_pending_tiles[cx] = next_pending_tiles[cx] or {}
                  next_pending_tiles[cx][cy] = true
                else
                  spaceship.check_tiles[cx] = spaceship.check_tiles[cx] or {}
                  if wall_count > 0 then
                    local clamps = surface.count_entities_filtered{
                      area = Util.position_to_area({x = cx + 0.5, y = cy + 0.5}, 0.4),
                      name = Spaceship.name_spaceship_clamp_keep
                    }
                    if clamps > 0 then
                      -- if it is a clamp sticking out of the craft treat it as exterior,
                      -- otherwise it is treated as unstaeble bulkhead and takes damage
                      spaceship.check_tiles[cx][cy] = Spaceship.tile_status.exterior
                      Spaceship.flash_tile(surface, {cx, cy}, {r = 1, g = 0, b = 1, a = alpha}, 5)
                    else
                      spaceship.check_tiles[cx][cy] = Spaceship.tile_status.bulkhead_exterior
                      Spaceship.flash_tile(surface, {cx, cy}, {r = 1, g = 0, b = 0, a = alpha}, 5)
                    end
                  else
                    spaceship.check_tiles[cx][cy] = Spaceship.tile_status.exterior
                    Spaceship.flash_tile(surface, {cx, cy}, {r = 1, g = 0, b = 1, a = alpha}, 5)
                  end
                end
              end
          end
        end
      end
    end
    if changed == false then
      -- all connected tiles have been found
      -- if in space and if moving detach disconnected tiles
      if spaceship.is_moving then
        local surface = Spaceship.get_own_surface(spaceship)
        if surface then
          local set_tiles = {}
          local all_tiles = surface.find_tiles_filtered{name=Spaceship.names_spaceship_floors}
          for _, tile in pairs(all_tiles) do
            if not (spaceship.check_tiles[tile.position.x] and spaceship.check_tiles[tile.position.x][tile.position.y]) then
              local stack = tile.prototype.items_to_place_this[1]
              table.insert(set_tiles, {name = name_space_tile, position = tile.position, ghost_name = tile.name, stack = stack})
              Spaceship.flash_tile(surface, tile.position, {r = 1, g = 0, b = 0, a = alpha}, 120)
            end
          end
          if #set_tiles > 0 then
            --surface.set_tiles(set_tiles)
            for _, tile in pairs(set_tiles) do
              if Util.table_contains(Spaceship.names_spaceship_floors, tile.ghost_name) then
                surface.create_entity{name = "tile-ghost", inner_name = tile.ghost_name, force = spaceship.force_name, position=tile.position}
              end
            end
          end
        end
      end

      changed = true
      spaceship.check_stage = "containment"
      spaceship.check_message = {"space-exploration.spaceship-check-message-checking-containment"}
      for x, x_tiles in pairs(spaceship.check_tiles) do
        for y, status in pairs(x_tiles) do
          if status == Spaceship.tile_status.exterior
            or status == Spaceship.tile_status.bulkhead_exterior then
            next_pending_tiles[x] = next_pending_tiles[x] or {}
            next_pending_tiles[x][y] = true
          end
        end
      end

    end
  elseif spaceship.check_stage == "containment" then
    for x, x_tiles in pairs(spaceship.pending_tiles) do
      for y, yes in pairs(x_tiles) do
        if spaceship.check_tiles[x][y] == Spaceship.tile_status.exterior
         or spaceship.check_tiles[x][y] == Spaceship.tile_status.bulkhead_exterior
         or spaceship.check_tiles[x][y] == Spaceship.tile_status.floor_exterior then
          for cx = x-1, x+1 do
            for cy = y-1, y+1 do
              if spaceship.check_tiles[cx] and spaceship.check_tiles[cx][cy]
               and spaceship.check_tiles[cx][cy] == Spaceship.tile_status.floor then
                spaceship.check_tiles[cx][cy] = Spaceship.tile_status.floor_exterior
                changed = true
                next_pending_tiles[cx] = next_pending_tiles[cx] or {}
                next_pending_tiles[cx][cy] = true
                Spaceship.flash_tile(surface, {cx, cy}, {r = 1, g = 1, b = 0, a = alpha}, 30)
              end
            end
          end
        end
      end
    end
    if changed == false then
      changed = true
      -- convert non-exterior floor to interior
      for x, x_tiles in pairs(spaceship.check_tiles) do
        for y, status in pairs(x_tiles) do
          if status == Spaceship.tile_status.floor then
            spaceship.check_tiles[x][y] = Spaceship.tile_status.floor_interior
            Spaceship.flash_tile(surface, {x, y}, {r = 0, g = 0, b = 1, a = alpha}, 5)
          end
        end
      end
      local console_tile_x = math.floor(spaceship.console.position.x)
      local console_tile_y = math.floor(spaceship.console.position.y)
      if spaceship.check_tiles and spaceship.check_tiles[console_tile_x] and spaceship.check_tiles[console_tile_x][console_tile_y] == Spaceship.tile_status.floor_interior then
        spaceship.check_tiles[console_tile_x][console_tile_y] = Spaceship.tile_status.floor_console_connected
        next_pending_tiles[console_tile_x] = {}
        next_pending_tiles[console_tile_x][console_tile_y] = true
        spaceship.check_stage = "console-connectivity"
        spaceship.check_message = {"space-exploration.spaceship-check-message-checking-connectivity"}
      else
        for x, x_tiles in pairs(spaceship.check_tiles) do
          for y, status in pairs(x_tiles) do
            if status == Spaceship.tile_status.exterior
            or status == Spaceship.tile_status.bulkhead_exterior then
              Spaceship.flash_tile(surface, {x, y}, {r = 1, g = 0, b = 0, a = alpha}, 120)
            end
          end
        end
        spaceship.integrity_valid = false
        spaceship.check_message =  {"space-exploration.spaceship-check-message-failed-containment"}
        return Spaceship.stop_integrity_check(spaceship)
      end
    end
  elseif spaceship.check_stage == "console-connectivity" then
    for x, x_tiles in pairs(spaceship.pending_tiles) do
      for y, yes in pairs(x_tiles) do
        if spaceship.check_tiles[x][y] == Spaceship.tile_status.floor_console_connected
         or spaceship.check_tiles[x][y] == Spaceship.tile_status.bulkhead_console_connected then

         for d = 1, 4 do -- 4 way direction
              local cx = x + (d == 2 and 1 or (d == 4 and -1 or 0))
              local cy = y + (d == 1 and -1 or (d == 3 and 1 or 0))
              if spaceship.check_tiles[cx] and spaceship.check_tiles[cx][cy] and
               (spaceship.check_tiles[cx][cy] == Spaceship.tile_status.floor_interior
               or spaceship.check_tiles[cx][cy] == Spaceship.tile_status.bulkhead) then
                if spaceship.check_tiles[cx][cy] == Spaceship.tile_status.floor_interior then
                   spaceship.check_tiles[cx][cy] = Spaceship.tile_status.floor_console_connected
                else
                   spaceship.check_tiles[cx][cy] = Spaceship.tile_status.bulkhead_console_connected
                end
                Spaceship.flash_tile(surface, {cx, cy}, {r = 0, g = 1, b = 1, a = alpha}, 5)
                changed = true
                next_pending_tiles[cx] = next_pending_tiles[cx] or {}
                next_pending_tiles[cx][cy] = true
              end
          end
        end
      end
    end
    if changed == false then
      -- completed the check

      spaceship.check_message = {"space-exploration.spaceship-check-message-passed"}
      spaceship.integrity_valid = true
      local set_tiles = {}
      local reset = false
      for x, x_tiles in pairs(spaceship.check_tiles) do
        for y, status in pairs(x_tiles) do
          if not (status == Spaceship.tile_status.floor_console_connected
              or status == Spaceship.tile_status.bulkhead_console_connected
              or status == Spaceship.tile_status.exterior) then
              spaceship.check_message = {"space-exploration.spaceship-check-message-unstable"}
              Spaceship.flash_tile(surface, {x, y}, {r = 1, g = 0, b = 0, a = alpha}, 120)
              -- detatch
              if spaceship.own_surface_index and spaceship.is_moving then
                local support = 1 -- it will count self
                for cx = x-1, x+1 do
                  for cy = y-1, y+1 do
                    if spaceship.check_tiles[cx] and spaceship.check_tiles[cx][cy] then
                      if spaceship.check_tiles[cx][cy] ~= Spaceship.tile_status.exterior then
                        support = support + 1
                        if spaceship.check_tiles[cx][cy] == Spaceship.bulkhead_console_connected then
                          support = support + 2
                        end
                      end
                    end
                  end
                end
                if support <= 6 then -- has a chance to be removed
                  reset = true
                  if support - math.random(2) <= 4 then
                    local entities = surface.find_entities({{x,y}, {x+1,y+1}})
                    local remove = true
                    for _, entity in pairs(entities) do
                      if entity and entity.valid and entity.type ~= "character" and entity.health then
                        entity.damage(150, "neutral", "explosion")
                        remove = false
                      end
                    end
                    if remove then
                      local tile = surface.get_tile(x,y)
                      table.insert(set_tiles, {name = name_space_tile, ghost_name=tile.name, position = {x,y}})
                    end
                  end
                end
              end
          end
        end
      end
      if #set_tiles > 0 then
        spaceship.check_message = {"space-exploration.spaceship-check-message-valid-but-disconnecting"}
        surface.print({"space-exploration.spaceship-warning-sections-disconnecting"})
        surface.set_tiles(set_tiles)
        for _, tile in pairs(set_tiles) do
          if Util.table_contains(Spaceship.names_spaceship_floors, tile.ghost_name) then
            surface.create_entity{name = "tile-ghost", inner_name = tile.ghost_name, force = spaceship.force_name, position=tile.position}
          end
        end
      end

      Spaceship.stop_integrity_check(spaceship)

      if reset then
        Spaceship.start_integrity_check(spaceship)
        return
      else
        Spaceship.get_launch_energy(spaceship)
        return
      end
    end

  end

  if changed then
    spaceship.pending_tiles = next_pending_tiles
  else
    spaceship.integrity_valid = false
    spaceship.check_message = {"space-exploration.spaceship-check-message-did-not-complete"}
    return Spaceship.stop_integrity_check(spaceship)
  end
end

function Spaceship.on_init(event)
    global.spaceships = {}
end
Event.addListener("on_init", Spaceship.on_init, true)

return Spaceship
