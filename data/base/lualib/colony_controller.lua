local locations = require(mod_name .. ".lualib.locations")
local math2d = require 'math2d'

local colony_controller = {}
local colony_controller_data =
{
  fast_mode = false,
  colonies = {},
  spawn_points = {},
}

local explosion = function(surface,position)
  local types = {'blood-explosion-small'}
  local random_type = types[math.random(1,#types)]
  surface.create_entity({
    name=random_type,
    position=position,
    speed=10,
    source=position,
    target=position,
    })
end

local decorate = function(surface,position)
  local types = {'lichen'}
  local random_type = types[math.random(1,#types)]
  surface.create_decoratives({
    check_collision = false,
    decoratives = {
    {
      name=random_type,
      position=position,
      amount=1
    }
    }})
end

local box_collides_with_existing_colonies = function(box)
  for _, colony in pairs(colony_controller_data.colonies) do
    if math2d.bounding_box.collides_with(box,colony.area) then
      return true
    end
  end
  return false
end

local breed_spawner = function(colony)
  local position = colony.surface.find_non_colliding_position_in_box("rocket-silo",colony.area,1,true)
  --TODO: change to bounding box when api is updated
  if position and colony.next_build == nil then
    local box = math2d.bounding_box.create_from_centre(position,3)
    colony.next_build = {
      entity_to_build = "biter-spawner",
      cost = 5*15,
      contributed = 0,
      position = position,
      damage_box = box,
      debug_box_id = rendering.draw_rectangle({
        left_top = box.left_top,
        right_bottom = box.right_bottom,
        color = {r=1,b=0,g=0.5,a=1},
        forces = {game.forces.player},
        surface = colony.surface,
      })
    }
    rendering.set_visible(colony.next_build.debug_box_id,campaign_debug_mode)
  end
  if campaign_debug_mode then
    print("queued a spawner to be built")
  end
  return colony.next_build
end

local breed_worm = function(colony)
  local position = colony.surface.find_non_colliding_position_in_box("biter-spawner",colony.area,1,true)
  --TODO:change to bounding box when api is updated
  if position and colony.next_build == nil then
    local box = math2d.bounding_box.create_from_centre(position,2)
    colony.next_build = {
      entity_to_build = "small-worm-turret",
      cost = 3*15,
      contributed = 0,
      position = position,
      damage_box = box,
      debug_box_id = rendering.draw_rectangle({
        left_top = box.left_top,
        right_bottom = box.right_bottom,
        color = { r = 1, b = 0.5, g = 0, a = 1 },
        forces = { game.forces.player },
        surface = colony.surface,
      })
    }
    rendering.set_visible(colony.next_build.debug_box_id,campaign_debug_mode)
  end
  if campaign_debug_mode then
    print("queued a worm to be built")
  end
  return colony.next_build
end

local find_biter_for_reinforcement = function(colony)
  --first check for any biters in the colony area
    local biters = colony.surface.find_entities_filtered({
      name = {'small-biter','medium-biter','large-biter'},
      force=colony.force,
      area=colony.area
    })
  if #biters > 0 then
    return biters[math.random(1,#biters)]
  end

  if #biters == 0 and colony.reinforcements == false then
    return nil
  end

  local spawners = colony.surface.find_entities_filtered({name={'biter-spawner','spitter-spawner'},force=colony.force})
  local closest_spawner_with_units = {entity=nil,dist=999999}


  --if colony is set on a spawn point, then just make free biters
  if colony_controller_data.spawn_points[colony.name] then
    local free_pos = colony.surface.find_non_colliding_position_in_box("small-biter",colony.area,2)
    return colony.surface.create_entity({force=colony.force,name='small-biter',position=free_pos})
  end

  for _, spawner in pairs(spawners) do
    if #spawner.units > 0 then
      local this_distance = math2d.position.distance(math2d.bounding_box.get_centre(colony.area),spawner.position)
      if this_distance < closest_spawner_with_units.dist then
        closest_spawner_with_units.entity = spawner
        closest_spawner_with_units.dist = this_distance
      end
    end
  end

  for _, spawner in pairs(colony_controller_data.spawn_points) do
    local this_distance = math2d.position.distance(math2d.bounding_box.get_centre(colony.area),spawner.centre)
    if this_distance < closest_spawner_with_units.dist then
      local free_pos = colony.surface.find_non_colliding_position_in_box("small-biter",spawner.area,2)
      return colony.surface.create_entity({force=colony.force,name='small-biter',position=free_pos})
    end
  end

  if closest_spawner_with_units.entity then
    if campaign_debug_mode then
      print('found biter to send')
    end
    return closest_spawner_with_units.entity.units[math.random(1,#closest_spawner_with_units.entity.units)]
  end
  return nil
end

local check_colony_for_reinforcement_requirements = function(colony)
  local biters = colony.surface.find_entities_filtered({
      name = {'small-biter','medium-biter','large-biter'},
      force=colony.force,
      area=colony.area
    })

  if #biters > 0 then
    colony.populated = true
    colony.biter_sent = false
    colony.next_update = game.ticks_played + 60 + math.random(1,10)
  else
    colony.next_update = game.ticks_played + 1600 + math.random(1,10)
    local biter = find_biter_for_reinforcement(colony)
    if biter then
      colony_controller.send_to_area(biter,colony.area,16000)
      if campaign_debug_mode then
        print('sent biter')

      end
      colony.next_update = game.ticks_played + 1600
      colony.biter_sent = true
    else
      if campaign_debug_mode then
        print('no biters on the entire map')

      end
      colony.next_update = game.ticks_played + 1600
    end
  end


end

local plan_colony = function(colony)
  local spawners = colony.surface.find_entities_filtered({name='biter-spawner',force=colony.force,area=colony.area})
  local worms = colony.surface.find_entities_filtered({name='small-worm-turret',force=game.forces['enemy'],area=colony.area})

  if #spawners == 0 and colony.max_spawners > 0 then
    breed_spawner(colony)
    colony.next_update = game.ticks_played + 60 + math.random(1,10)
  elseif #spawners < colony.max_spawners and #worms < colony.max_worms and math.random() < 0.5 then
    breed_worm(colony)
    colony.next_update = game.ticks_played + 300 + math.random(1,10)
  elseif #spawners < colony.max_spawners then
    breed_spawner(colony)
    colony.next_update = game.ticks_played + 300 + math.random(1,10)
  elseif #worms < colony.max_worms then
    breed_worm(colony)
    colony.next_update = game.ticks_played + 300 + math.random(1,10)
  else
    --nest complete
    if campaign_debug_mode then
      print("returning false due to colony complete")

    end
    colony.next_update = game.ticks_played + 1600 + math.random(1,10)
    return false
  end

  return true
end

local reposition_biters_in_area = function(colony,area)
  local biters = colony.surface.find_entities_filtered({
    name = {'small-biter','medium-biter','large-biter','small-spitter','medium-spitter','large-spitter'},
    area = area,
  })
  for _, biter in pairs(biters) do
    local new_location = colony.surface.find_non_colliding_position_in_box(biter.name,colony.area,1)
    biter.teleport(new_location)
    print("teleported a biter")
  end
end

local breed_colony = function(colony)

  if colony.next_build == nil then
    if campaign_debug_mode then
      print("from breed, plan")

    end
    return plan_colony(colony)
  end
  if campaign_debug_mode then
    print("deal with next build")

  end
  local biters = colony.surface.find_entities_filtered({name='small-biter',force=colony.force,area=colony.area})
  if #biters > 0 and colony.next_build then
    for _, biter in pairs(biters) do
      if math.random() < 0.2 then
        decorate(colony.surface,biter.position)
      end
    end
    local builders = colony.surface.find_entities_filtered({
      name='small-biter',
      force=colony.force,
      area=colony.next_build.damage_box
    })
    if #builders > 0 then
      --kill the biter and contribute its HP to the construction project
      colony.next_build.contributed = colony.next_build.contributed + builders[1].health
      decorate(colony.surface,builders[1].position)
      explosion(colony.surface,builders[1].position)
      builders[1].die()
      if colony.next_build.contributed >= colony.next_build.cost then
        local ent = colony.surface.create_entity({
          name=colony.next_build.entity_to_build,
          position=colony.next_build.position,
          force=colony.force
        })
        if ent.name == 'small-worm-turret' then
          ent.force = game.forces['enemy']
        end
        for dx = -5, 5 do
          for dy = -5, 5 do
            if math.random() < 0.3 then
              explosion(colony.surface,{x=colony.next_build.position.x+dx,y=colony.next_build.position.y+dy})
              decorate(colony.surface,{x=colony.next_build.position.x+dx,y=colony.next_build.position.y+dy})
            end
          end
        end
        reposition_biters_in_area(colony,ent.bounding_box)
        if campaign_debug_mode then
          print("a new "..colony.next_build.entity_to_build.." has been bred")
        end
        rendering.destroy(colony.next_build.debug_box_id)
        colony.next_build = nil
        colony.next_update = game.ticks_played + 1200 + math.random(1,10)
      else
        if campaign_debug_mode then
          print("biter sacrificed itself for the nest. Construction completion: "..
            string.format("%02d/%02d",colony.next_build.contributed,colony.next_build.cost))
        end
        colony.next_update = game.ticks_played + 100 + math.random(1,10)
      end
    else
      --send a biter to the build area
      local random_builder = math.random(1,#biters)
      biters[random_builder].set_command({
        type = defines.command.compound,
        structure_type = defines.compound_command.return_last,
        commands = {
          {
            type = defines.command.go_to_location,
            destination = colony.next_build.position,
            radius = 0.1,
          },
          {
            type = defines.command.stop,
          }
        }
      })
      if campaign_debug_mode then
        print("sent a local biter to build zone")
      end
      colony.next_update = game.ticks_played + 600 + math.random(1,10)
    end
  elseif #biters == 0 then
    --pick a random biter on the surface to come here
    colony.populated = false
    colony.sent_biter = false
    colony.next_update = game.ticks_played + 1600 + math.random(1,10)
  end
end

local colonize_command = function(data)
  local player = game.players[data.player_index]
  if data.parameter == nil then
    player.print("this command requires a parameter :area_name:")
    return false
  end

  local area_name = data.parameter
  local area = locations.get_area(area_name)
  if area then
    local spawners_per_nest = math.random(2,5)
    local worms_per_nest = math.random(1,10)
    player.print("Added new colony to area: "..area_name)
    colony_controller.register(area_name,area,spawners_per_nest,worms_per_nest)
  else
    player.print("no area called "..data.parameter)
  end
end
if campaign_debug_mode then
    commands.add_command("colonize","Test the colonization", colonize_command)
end

colony_controller.is_populated = function(name)
  return colony_controller_data.colonies[name] and colony_controller_data.colonies[name].populated
end

colony_controller.send_to_area = function(biter,area,wait_time)
  local destination = biter.surface.find_non_colliding_position_in_box(biter.name,area,1)
  biter.release_from_spawner()
  biter.ai_settings.allow_try_return_to_spawner = false
  biter.set_command({
    type = defines.command.compound,
    structure_type = defines.compound_command.return_last,
    commands = {
      {
        type = defines.command.go_to_location,
        destination = destination,
        distraction = defines.distraction.none,
        radius = 1,
      },
      {
        type = defines.command.wander,
        radius = 1,
        distraction = defines.distraction.by_damage,
        ticks_to_wait = wait_time,
      },
    }
  })
end

colony_controller.register = function(name,max_spawners,max_worms,force,disable_reinforcements)
  max_spawners = max_spawners or 0
  max_worms = max_worms or 0
  force = force or 'enemy'
  disable_reinforcements = disable_reinforcements or false
  local area = locations.get_area(name)
  local surface = locations.get_main_surface()
  assert(area,"colony_controller.register: attempted to register colony with invalid area name "..name)
  assert(box_collides_with_existing_colonies(area)==false,
    "colony_controller.register: new colony "..name.." overlaps existing colony")
  assert(colony_controller_data.colonies[name] == nil,
    "colony_controller.register: attempted to create colony "..name.." twice in same area")

  local new_colony =  {
    name = name,
    surface = surface,
    area = area,
    next_update = 0,
    populated = false,
    biter_sent = false,
    force = game.forces[force],
    max_spawners = max_spawners,
    max_worms = max_worms,
    next_build = nil,
    reinforcements = not disable_reinforcements,
    debug_box_id = rendering.draw_rectangle({
      left_top = area.left_top,
      right_bottom = area.right_bottom,
      color = {r=1,b=1,g=1,a=1},
      forces = {game.forces.player},
      surface = surface,
    })
  }
  colony_controller_data.colonies[name] = new_colony

  rendering.set_visible(new_colony.debug_box_id,false)
  if campaign_debug_mode then
    print("colony_controller.register: successfully registered: "..name)
    print(serpent.block(new_colony))
    rendering.set_visible(new_colony.debug_box_id,true)
  end

  plan_colony(new_colony)
  return new_colony
end

colony_controller.deregister = function(name)
  if colony_controller_data.colonies[name] then
    rendering.destroy(colony_controller_data.colonies[name].debug_box_id)
    colony_controller_data.colonies[name] = nil
    return true
  end
  return false
end

colony_controller.update = function()
  local update_interval
  if colony_controller_data.fast_mode then
    update_interval = 20
  else
    update_interval = 160
  end

  if game.ticks_played % update_interval == 0 then
    for _, colony in pairs(colony_controller_data.colonies) do
      if colony.next_update < game.ticks_played and colony.populated then

        if campaign_debug_mode then
          print("breeding biter colony "..colony.name)
        end
        breed_colony(colony)
        if colony_controller_data.fast_mode then
          colony.next_update = game.ticks_played + update_interval
        end
      elseif colony.populated == false and colony.next_update < game.ticks_played then
        if campaign_debug_mode then
          print("checking reinforcements for colony: "..colony.name)

        end
        check_colony_for_reinforcement_requirements(colony)
        if colony_controller_data.fast_mode then
          colony.next_update = game.ticks_played + update_interval - 1
        end
      end
    end
  end
end

colony_controller.register_spawn_area = function(spawn_name)
  local area = locations.get_area(spawn_name)
  assert(area,"colony_controller.register_spawn_point: attempted to register spawn with invalid area name "..spawn_name)
  colony_controller_data.spawn_points[spawn_name] = {
    centre = math2d.bounding_box.get_centre(area),
    area = area,
    name = spawn_name,
  }
end

colony_controller.deregister_spawn_area = function(spawn_name)
  if colony_controller_data.spawn_points[spawn_name] then
    colony_controller_data.spawn_points[spawn_name] = nil
  end
end

colony_controller.set_fast_mode = function(value)
  colony_controller_data.fast_mode = value
end

colony_controller.init = function()
  global.colony_controller_data = colony_controller_data
end

colony_controller.on_load = function()
  colony_controller_data = global.colony_controller_data or colony_controller_data
end

colony_controller.exists = function(colony_name)
  if colony_controller_data.colonies[colony_name] then
    return true
  end
  return false
end

colony_controller.migrate = function()
  if global.CAMPAIGNS_VERSION < 4 then
    global.colony_controller_data =
    {
      fast_mode = false,
      colonies = {},
      spawn_points = {},
    }
    colony_controller_data = global.colony_controller_data
  end
end

colony_controller.events = {
  [defines.events.on_tick] = colony_controller.update,
}

return colony_controller