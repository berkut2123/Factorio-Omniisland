local DeliveryCannon = {}

--[[
Delivery cannons are very dumb so that should make the code simple.
Check the structure once every 10s.
If there is a product, and there is energy, remove the product and enrgy.
Make a projectile in the target zone.
At the peoper time, check to see if there is a delivery chest at the location.
  If there is try to insert the item.
  If not the cause an explosion at the target site.
]]

DeliveryCannon.name_delivery_cannon = mod_prefix.."delivery-cannon"
DeliveryCannon.name_delivery_cannon_energy_interface = mod_prefix.."delivery-cannon-energy-interface"
DeliveryCannon.name_delivery_cannon_settings = mod_prefix.."delivery-cannon-settings"
DeliveryCannon.name_delivery_cannon_beam = mod_prefix.."delivery-cannon-beam"
DeliveryCannon.name_delivery_cannon_beam_offset = {x = -0.5, y = -5}

DeliveryCannon.name_delivery_cannon_chest = mod_prefix.."delivery-cannon-chest"

DeliveryCannon.name_delivery_cannon_capsule = mod_prefix.."delivery-cannon-capsule"
DeliveryCannon.name_delivery_cannon_capsule_projectile = mod_prefix.."delivery-cannon-capsule-projectile"
DeliveryCannon.name_delivery_cannon_capsule_shadow = mod_prefix.."delivery-cannon-capsule-shadow"
DeliveryCannon.name_delivery_cannon_capsule_explosion = mod_prefix.."delivery-cannon-capsule-explosion"

DeliveryCannon.name_delivery_cannon_targeter = mod_prefix.."delivery-cannon-targeter"
DeliveryCannon.name_target_activity_type = "delivery-cannon-target"

DeliveryCannon.capsule_fall_altitude = 100
DeliveryCannon.capsule_fall_time = 2 * 60
DeliveryCannon.energy_per_delta_v = 50000

DeliveryCannon.name_delivery_cannon_gui_root = mod_prefix.."delivery-cannon"

function DeliveryCannon.from_unit_number (unit_number)
  unit_number = tonumber(unit_number)
  -- NOTE: only suppors container as the entity
  return global.delivery_cannons[unit_number]
end

function DeliveryCannon.from_entity (entity)
  if not(entity and entity.valid) then
    Log.trace("DeliveryCannon.from_entity: invalid entity")
    return
  end
  -- NOTE: only suppors container as the entity
  return DeliveryCannon.from_unit_number(entity.unit_number)
end

function DeliveryCannon.get_energy_cost(origin, destination)
  if origin and destination then
    return DeliveryCannon.energy_per_delta_v * (Zone.get_launch_delta_v(origin) + Zone.get_travel_delta_v(origin, destination))
  end
end

function DeliveryCannon.gui_close (player)
  if player.gui.left[DeliveryCannon.name_delivery_cannon_gui_root] then
    player.gui.left[DeliveryCannon.name_delivery_cannon_gui_root].destroy()
  end
end

function DeliveryCannon.get_coordinate(struct)
  if struct.destination and struct.destination.coordinate then
    return struct.destination.coordinate
  end
  return struct.main.position
end

function DeliveryCannon.prep(struct)

  if not (
    struct.main and struct.main.valid
    and struct.energy_interface and struct.energy_interface.valid
    and struct.settings and struct.settings.valid ) then
    DeliveryCannon.destroy(struct)
    return false
  end

  struct.energy = struct.energy_interface.energy

  local product_inv = struct.main.get_output_inventory()
  local contents = product_inv.get_contents()
  struct.payload_name = nil
  struct.payload_count = 0
  for name, count in pairs(contents) do -- should only be 1
    struct.payload_name = name
    struct.payload_count = count
  end

  if not (struct.destination and struct.destination.zone) then
    struct.required_energy = nil
  end

  if (struct.destination and struct.destination.zone) then
    if not struct.required_energy then
      struct.required_energy = DeliveryCannon.get_energy_cost(struct.zone, struct.destination.zone)
    end
    if struct.required_energy and struct.energy >= struct.required_energy then
      if struct.payload_count > 0 then
        -- FIRE

        local target_zone = struct.destination.zone
        local target_surface = Zone.get_make_surface(target_zone)
        local target_position = DeliveryCannon.get_coordinate(struct)

        local recipe = struct.main.get_recipe()
        local stack = nil
        for _, ingredient in pairs(recipe.ingredients) do
          if ingredient.name ~= DeliveryCannon.name_delivery_cannon_capsule then
            stack = ingredient
            stack.count = stack.amount or stack.count
          end
        end
        if not stack then error("Delivery Cannon tried to fire invalid stack") end
        product_inv.remove({name=struct.payload_name, count=1})
        struct.energy_interface.energy = struct.energy_interface.energy - struct.required_energy

        global.delivery_cannon_payloads = global.delivery_cannon_payloads or {}
        local payload = {
          stack = stack,
          target_zone = target_zone,
          target_position = target_position,
          force_name = struct.force_name,
          eta = game.tick + DeliveryCannon.capsule_fall_time
        }
        table.insert(global.delivery_cannon_payloads, payload)
        struct.main.surface.create_entity{
          name = DeliveryCannon.name_delivery_cannon_beam,
          position = Util.vectors_add(struct.main.position, DeliveryCannon.name_delivery_cannon_beam_offset ),
          target = Util.vectors_add(struct.main.position, {x = 0, y = -100})
        }

        projectile_start_position = Util.vectors_add(target_position, {x = 0, y = -DeliveryCannon.capsule_fall_altitude})
        shadow_start_position = Util.vectors_add(target_position, {x = DeliveryCannon.capsule_fall_altitude, y = 0})
        target_surface.create_entity{
          name = DeliveryCannon.name_delivery_cannon_capsule_projectile,
          position = projectile_start_position,
          target = target_position,
          force = struct.force_name,
          speed = DeliveryCannon.capsule_fall_altitude/DeliveryCannon.capsule_fall_time
        }
        target_surface.create_entity{
          name = DeliveryCannon.name_delivery_cannon_capsule_shadow,
          position = shadow_start_position,
          target = target_position,
          force = struct.force_name,
          speed = DeliveryCannon.capsule_fall_altitude/DeliveryCannon.capsule_fall_time
        }
        target_surface.request_to_generate_chunks(projectile_start_position)
        target_surface.request_to_generate_chunks(shadow_start_position)
        target_surface.request_to_generate_chunks(target_position)

      end
    end
  end

  return true

end

function DeliveryCannon.gui_update(player)
  local root = player.gui.left[DeliveryCannon.name_delivery_cannon_gui_root]
  if (root and root.unit_number) then
    local struct = DeliveryCannon.from_unit_number(root.unit_number.children_names[1])
    if struct then
      local valid = DeliveryCannon.prep(struct)
      if valid then
        local format_energy = function(energy)
          return string.format("%.2f",energy/1000000) .. "MJ"
        end
        if root["energy"] then
          root["energy"].caption={
            "space-exploration.delivery_cannon_label_energy",
            format_energy(struct.energy_interface.energy) .. " / " .. (struct.required_energy and format_energy(struct.required_energy) or "?")
          }
          root["energy_progress"].value = struct.required_energy and ((struct.energy or 0) / struct.required_energy) or 0
        end

        if root["payload"] then
          root["payload"].caption={
            "space-exploration.delivery_cannon_label_payload",
            struct.payload_name and (game.item_prototypes[struct.payload_name].localised_name) or "Empty"
          }
        end

        if root.destination_location_table and root.destination_location_table.destination_location_coordinates then
          local coordinate = DeliveryCannon.get_coordinate(struct)
          root.destination_location_table.destination_location_coordinates.caption = "X:"..coordinate.x .. "  Y:"..coordinate.y
        end
      end
    end
  end
end



function DeliveryCannon.gui_open(player, struct)
  if not struct then
    Log.trace('DeliveryCannon.gui_open struct not found')
    return
  end
  local gui = player.gui.left
  close_own_guis(player)
  local playerdata = get_make_playerdata(player)

  local container = gui.add{ type = "frame", name = DeliveryCannon.name_delivery_cannon_gui_root, style="space_platform_container", direction="vertical"}

  local title_flow = container.add{ type="flow", name="unit_number", direction="horizontal"}
  -- NOTE: [DeliveryCannon.name_delivery_cannon_gui_root].unit_number.child_names()[1] gets unit number
  local title = title_flow.add{ type="label", name=struct.unit_number, caption={"entity-name." .. DeliveryCannon.name_delivery_cannon}, style="space_platform_title"}

  local bar

  container.add{ type="label", name="energy", caption="Energy: "}
  bar = container.add{ type="progressbar", name="energy_progress", size = 300, value=0, style="space_platform_progressbar_capsule"}
  bar.style.horizontally_stretchable  = true

  container.add{ type="label", name="payload", caption="Payload: "}


  container.add{ type="label", name="destination-label", caption="Destination:"}
  container.add{type="checkbox", name="list-zones-alphabetical", caption="List destinations alphabetically", state=playerdata.zones_alphabetical and true or false}

  local filter_container = container.add{ type="flow", name="filter_flow", direction="horizontal"}
  local filter_field = filter_container.add{ type="textfield", name="filter_list"}
  filter_field.style.width = 275
  local filter_button = filter_container.add{ type = "sprite-button", name="clear_filter", sprite="utility/search_icon",
    tooltip={"space-exploration.clear-filter"},}
  filter_button.style.left_margin = 5
  filter_button.style.width = 28
  filter_button.style.height = 28

  local destination_zone = struct.destination.zone
  local star = nil
  if struct.zone.type == "star" then
    star = struct.zone
  elseif struct.zone.parent and struct.zone.parent.type == "star" then
    star = struct.zone.parent
  elseif struct.zone.parent and struct.zone.parent.parent and struct.zone.parent.parent.type == "star" then
    star = struct.zone.parent.parent
  else
    star = Zone.find_nearest_star(struct.zone.stellar_position)
  end

  local list, selected_index, values = Zone.dropdown_list_zone_destinations(
    struct.force_name,
    destination_zone,
    playerdata.zones_alphabetical,
    nil,
    {list = "None", value = {type = "none"}}, -- wildcard
    star
  )
  if selected_index == 1 then selected_index = 2 end
  local zones_dropdown = container.add{ type="drop-down", name="delivery-cannon-list-zones", items=list, selected_index=selected_index or 2}
  zones_dropdown.style.horizontally_stretchable  = true
  player_set_dropdown_values(player, "delivery-cannon-list-zones", values)

  container.add{ type="label", name="destination-location-label", caption="Destination Position:"}

  local destination_location_table = container.add{type="table", name="destination_location_table", column_count=2, draw_horizontal_lines=false}
  destination_location_table.style.horizontally_stretchable = true
  destination_location_table.style.column_alignments[1] = "left" -- title, search, zone list table
  destination_location_table.style.column_alignments[2] = "right" -- starmap, close, selected zone info

  destination_location_table.add{ type="sprite-button", name="destination_location_button",
    sprite="item/artillery-targeting-remote", tooltip = "Choose coordinates"}
  destination_location_table.destination_location_button.style.right_margin = 10
  destination_location_table.add{ type="label", name="destination_location_coordinates", caption=""}

  DeliveryCannon.gui_update(player)

end

function DeliveryCannon.on_gui_click(event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]
  root = gui_element_or_parent(element, DeliveryCannon.name_delivery_cannon_gui_root)
  if not (root and root.unit_number) then return end
  struct = DeliveryCannon.from_unit_number(root.unit_number.children_names[1])
  if not struct then return end
  if element.name == "delivery-cannon-list-zones" then

    local value = player_get_dropdown_value(player, element.name, element.selected_index)
    if type(value) == "table" then
      if value.type == "zone" then
        local zone_index = value.index
        local zone = Zone.from_zone_index(zone_index)
        if zone then
          struct.destination.zone = zone
          struct.required_energy = DeliveryCannon.get_energy_cost(struct.zone, struct.destination.zone)
          Log.trace("set destination to location: " .. zone.name )
        else
          struct.destination.zone = nil
          struct.required_energy = nil
        end
      else
        struct.destination.zone = nil
        struct.required_energy = nil
      end
      DeliveryCannon.gui_update(player)
    else
      DeliveryCannon.gui_close(player)
      Log.trace("Error: Non-table value ")
    end
  elseif element.name == "clear_filter" then
    element.parent.filter_list.text = ""
    DeliveryCannon.gui_update_destinations_list(player)
  elseif element.name == "destination_location_button" then
    local playerdata = get_make_playerdata(player)
    RemoteView.start(player, struct.destination.zone)
    player.teleport(DeliveryCannon.get_coordinate(struct))
    playerdata.remote_view_activity = {
      type = DeliveryCannon.name_target_activity_type,
      struct = struct
    }
    player.cursor_stack.set_stack({name = DeliveryCannon.name_delivery_cannon_targeter, count = 1})
  end
end
Event.addListener(defines.events.on_gui_click, DeliveryCannon.on_gui_click)
Event.addListener(defines.events.on_gui_selection_state_changed, DeliveryCannon.on_gui_click)

function DeliveryCannon.gui_update_destinations_list(player)
  local playerdata = get_make_playerdata(player)
  local root = player.gui.left[DeliveryCannon.name_delivery_cannon_gui_root]
  if root then

    local filter = nil
    if root.filter_flow and root.filter_flow.filter_list then
      filter = string.trim(root.filter_flow.filter_list.text)
      if filter == "" then
        filter = nil
      end
    end

    -- update the list
    local destination_zone = struct.destination.zone
    local star = nil
    if struct.zone.type == "star" then
      star = struct.zone
    elseif struct.zone.parent and struct.zone.parent.type == "star" then
      star = struct.zone.parent
    elseif struct.zone.parent and struct.zone.parent.parent and struct.zone.parent.parent.type == "star" then
      star = struct.zone.parent.parent
    else
      star = Zone.find_nearest_star(struct.zone.stellar_position)
    end

    local list, selected_index, values = Zone.dropdown_list_zone_destinations(
      struct.force_name,
      destination_zone,
      playerdata.zones_alphabetical,
      filter,
      {list = "None", value = {type = "none"}}, -- wildcard
      star
    )
    if selected_index == 1 then selected_index = 2 end
    root["delivery-cannon-list-zones"].items = list
    root["delivery-cannon-list-zones"].selected_index = selected_index or 2
    player_set_dropdown_values(player, "delivery-cannon-list-zones", values)

  end
end

function DeliveryCannon.on_gui_checked_state_changed(event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]
  local root = gui_element_or_parent(element, DeliveryCannon.name_delivery_cannon_gui_root)
  if not (root and root.unit_number) then return end
  struct = DeliveryCannon.from_unit_number(root.unit_number.children_names[1])
  if not struct then return end
  if element.name == "list-zones-alphabetical" then
    local playerdata = get_make_playerdata(player)
    playerdata.zones_alphabetical = element.state
    DeliveryCannon.gui_update_destinations_list(player)
  end
end
Event.addListener(defines.events.on_gui_checked_state_changed, DeliveryCannon.on_gui_checked_state_changed)

function DeliveryCannon.on_gui_text_changed(event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]
  local root = gui_element_or_parent(element, DeliveryCannon.name_delivery_cannon_gui_root)
  if root then -- remote view
    if element.name == "filter_list" then
      DeliveryCannon.gui_update_destinations_list(player)
    end
  end
end
Event.addListener(defines.events.on_gui_text_changed, DeliveryCannon.on_gui_text_changed)


function DeliveryCannon.on_entity_created(event)  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end

  if not entity then return end
  if entity.name == DeliveryCannon.name_delivery_cannon then

    local force_name = entity.force.name

    local zone = Zone.from_surface(entity.surface)

    if not zone then
      return cancel_entity_creation(entity, event.player_index, "Invalid launch location")
    end

    local struct = {
      type = DeliveryCannon.name_delivery_cannon,
      valid = true,
      force_name = force_name,
      unit_number = entity.unit_number,
      main = entity,
      rocket_sections = 0,
      crew_capsules = 0,
      launch_trigger = "none",
      lua_fuel = 0,
      total_fuel = 0,
      zone = zone,
      destination = {
        zone = nil
      },
      launch_status = -1
    }

    global.delivery_cannons[entity.unit_number] = struct
    Log.trace("DeliveryCannon: struct added")

    -- spawn energy interface
    struct.energy_interface = entity.surface.create_entity{
      name = DeliveryCannon.name_delivery_cannon_energy_interface,
      force = entity.force,
      position = {entity.position.x, entity.position.y}}
    struct.energy_interface.destructible = false

    -- spawn settings
    struct.settings = entity.surface.create_entity{
      name = DeliveryCannon.name_delivery_cannon_settings,
      force = entity.force,
      position = {entity.position.x, entity.position.y}}
    struct.settings.destructible = false

    if event.player_index and game.players[event.player_index] and game.players[event.player_index].connected then
      DeliveryCannon.gui_open(game.players[event.player_index], struct)
    end
  end
end
Event.addListener(defines.events.on_built_entity, DeliveryCannon.on_entity_created)
Event.addListener(defines.events.on_robot_built_entity, DeliveryCannon.on_entity_created)
Event.addListener(defines.events.script_raised_built, DeliveryCannon.on_entity_created)
Event.addListener(defines.events.script_raised_revive, DeliveryCannon.on_entity_created)


function DeliveryCannon.get_struct_type_table(struct)
  local zone_assets = Zone.get_force_assets(struct.force_name, struct.zone.index)
  if struct.type == DeliveryCannon.name_delivery_cannon then
    zone_assets.delivery_cannons = zone_assets.delivery_cannons or {}
    return zone_assets.delivery_cannons
  end
end

function DeliveryCannon.remove_struct_from_table(struct)
  local type_table = DeliveryCannon.get_struct_type_table(struct)
  if not type_table[struct.unit_number] then return end
  type_table[struct.unit_number] = nil
  local count_remaining = 0
  for _, remaining in pairs(type_table[struct.unit_number]) do
    count_remaining = count_remaining + 1
  end
  if count_remaining == 0 then
    type_table[struct.unit_number] = nil
  end
end

function DeliveryCannon.destroy_sub(struct, key)
  if struct[key] and struct[key].valid then
    struct[key].destroy()
    struct[key] = nil
  end
end

function DeliveryCannon.destroy(struct, player_index)
  if not struct then
    Log.trace("struct_destroy: no struct")
    return
  end

  struct.valid = false

  DeliveryCannon.destroy_sub(struct, 'main')
  DeliveryCannon.destroy_sub(struct, 'energy_interface')
  DeliveryCannon.destroy_sub(struct, 'settings')

  DeliveryCannon.remove_struct_from_table(struct)
  global.delivery_cannons[struct.unit_number] = nil

  -- if a player has this gui open then close it
  local gui_name = DeliveryCannon.name_delivery_cannon_gui_root
  for _, player in pairs(game.connected_players) do
    if player.gui.left[gui_name]
      and player.gui.left[gui_name].unit_number.children_names[1] == ""..struct.unit_number
    then
      player.gui.left[gui_name].destroy()
    end
  end


end

function DeliveryCannon.on_entity_removed(event)
  local entity = event.entity
  if entity and entity.valid and entity.name == DeliveryCannon.name_delivery_cannon then
    DeliveryCannon.destroy(DeliveryCannon.from_entity(entity), event.player_index )
  end
end
Event.addListener(defines.events.on_entity_died, DeliveryCannon.on_entity_removed)
Event.addListener(defines.events.on_robot_mined_entity, DeliveryCannon.on_entity_removed)
Event.addListener(defines.events.on_player_mined_entity, DeliveryCannon.on_entity_removed)
Event.addListener(defines.events.script_raised_destroy, DeliveryCannon.on_entity_removed)

function DeliveryCannon.on_gui_opened(event)
  local player = game.players[event.player_index]
  if event.entity and event.entity.valid and event.entity.name == DeliveryCannon.name_delivery_cannon then
    DeliveryCannon.gui_open(player, DeliveryCannon.from_entity(event.entity))
  else
    DeliveryCannon.gui_close(player)
  end
end
Event.addListener(defines.events.on_gui_opened, DeliveryCannon.on_gui_opened)



function DeliveryCannon.on_tick(struct)
  for _, struct in pairs(global.delivery_cannons) do
    if (game.tick + struct.unit_number) % 60 == 0 then
      DeliveryCannon.prep(struct)
    end
  end
  if game.tick % 60 == 0 then
    for _, player in pairs(game.connected_players) do
      DeliveryCannon.gui_update(player)
    end
  end
  if global.delivery_cannon_payloads then
    for i = #global.delivery_cannon_payloads, 1, -1 do
      local dcp = global.delivery_cannon_payloads[i]
      if dcp then
        if game.tick >= dcp.eta then
          local surface = Zone.get_make_surface(dcp.target_zone)
          local spill = dcp.stack.count
          local chest = surface.find_entity(DeliveryCannon.name_delivery_cannon_chest, dcp.target_position)
          if chest then
            spill = spill - chest.insert(dcp.stack)
          end
          if spill > 0 then
            surface.create_entity{
              name = DeliveryCannon.name_delivery_cannon_capsule_explosion,
              position = dcp.target_position,
              force = dcp.force_name
            }
            if dcp.stack.name == "explosives" then -- double damage
              surface.create_entity{
                name = DeliveryCannon.name_delivery_cannon_capsule_explosion,
                position = dcp.target_position,
                force = dcp.force_name
              }
            end
            local spill_stack = table.deepcopy(dcp.stack)
            spill_stack.count = math.ceil(spill/4)
            surface.spill_item_stack(dcp.target_position, spill_stack, true, dcp.force_name, true)
          end
          table.remove(global.delivery_cannon_payloads, i)
        end
      end
    end
  end
end
Event.addListener(defines.events.on_tick, DeliveryCannon.on_tick)

function DeliveryCannon.on_player_selected_area(event)
  if (event.item == DeliveryCannon.name_delivery_cannon_targeter) then
    local player = game.players[event.player_index]
    local playerdata = get_make_playerdata(player)
    if playerdata.remote_view_activity and playerdata.remote_view_activity.type == DeliveryCannon.name_target_activity_type then
      local struct = playerdata.remote_view_activity.struct
      if struct.main and struct.main.valid then
        struct.destination.coordinate = {
          x = (event.area.left_top.x + event.area.right_bottom.x) / 2,
          y = (event.area.left_top.y + event.area.right_bottom.y) / 2
        }
        player.print({"space-exploration.delivery-cannon-coordinates-set", math.floor(struct.destination.coordinate.x), math.floor(struct.destination.coordinate.y)})
        --RemoteView.stop(player)
      end
    end
  end
end
Event.addListener(defines.events.on_player_selected_area, DeliveryCannon.on_player_selected_area)

function DeliveryCannon.on_init(event)
    global.delivery_cannons = {}
end
Event.addListener("on_init", DeliveryCannon.on_init, true)

return DeliveryCannon
