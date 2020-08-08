local Landingpad = {}

-- constants
Landingpad.name_rocket_landing_pad = mod_prefix.."rocket-landing-pad"
Landingpad.name_rocket_landing_pad_settings = mod_prefix.."rocket-landing-pad-settings"
Landingpad.name_rocket_landing_pad_gui_root = mod_prefix.."rocket-landing-pad-gui"
Landingpad.name_window_close = "landingpad_close_button"

function Landingpad.from_unit_number (unit_number)
  unit_number = tonumber(unit_number)
  -- NOTE: only suppors container as the entity
  if global.rocket_landing_pads[unit_number] then
    return global.rocket_landing_pads[unit_number]
  else
    Log.trace("Landingpad.from_unit_number: invalid unit_number: " .. unit_number)
  end
end

function Landingpad.from_entity (entity)
  if not(entity and entity.valid) then
    Log.trace("Landingpad.from_entity: invalid entity")
    return
  end
  -- NOTE: only suppors container as the entity
  return Landingpad.from_unit_number(entity.unit_number)
end


-- returns the available struct
function Landingpad.get_force_landing_pads_availability(force_name, landing_pad_name)

  local empty_landing_pads = {}
  local filled_landing_pads = {}
  local blocked_landing_pads = {}

  if global.forces[force_name] and global.forces[force_name].rocket_landing_pad_names and global.forces[force_name].rocket_landing_pad_names[landing_pad_name] then
    local landing_pads = global.forces[force_name].rocket_landing_pad_names[landing_pad_name]

    for _, landing_pad in pairs(landing_pads) do
      if landing_pad.container and landing_pad.container.valid then
        if landing_pad.inbound_rocket then
          table.insert(blocked_landing_pads, landing_pad)
        elseif landing_pad.container.get_inventory(defines.inventory.chest).is_empty() then
          table.insert(empty_landing_pads, landing_pad)
        else
          table.insert(filled_landing_pads, landing_pad)
        end
      else
        Landingpad.destroy(landing_pad)
      end
    end

  end

  return {
    empty_landing_pads = empty_landing_pads,
    filled_landing_pads = filled_landing_pads,
    blocked_landing_pads = blocked_landing_pads,
  }

end

-- returns the available struct
function Landingpad.get_zone_landing_pads_availability(force_name, zone, landing_pad_name)

  local empty_landing_pads = {}
  local filled_landing_pads = {}
  local blocked_landing_pads = {}

  local zone_assets = Zone.get_force_assets(force_name, zone.index)
  if zone_assets.rocket_landing_pad_names and zone_assets.rocket_landing_pad_names[landing_pad_name] then
    local landing_pads = zone_assets.rocket_landing_pad_names[landing_pad_name]


    for _, landing_pad in pairs(landing_pads) do
      if landing_pad.container and landing_pad.container.valid then
        if landing_pad.inbound_rocket then
          table.insert(blocked_landing_pads, landing_pad)
        elseif landing_pad.container.get_inventory(defines.inventory.chest).is_empty() then
          table.insert(empty_landing_pads, landing_pad)
        else
          table.insert(filled_landing_pads, landing_pad)
        end
      else
        Landingpad.destroy(landing_pad)
      end
    end

  end

  return {
    empty_landing_pads = empty_landing_pads,
    filled_landing_pads = filled_landing_pads,
    blocked_landing_pads = blocked_landing_pads,
  }

end

function Landingpad.gui_close (player)
  if player.gui.left[Landingpad.name_rocket_landing_pad_gui_root] then
    player.gui.left[Landingpad.name_rocket_landing_pad_gui_root].destroy()
  end
end

function Landingpad.gui_update(player)
  local root = player.gui.left[Landingpad.name_rocket_landing_pad_gui_root]
  if root then
    local struct = Landingpad.from_unit_number(root.unit_number.children_names[1])
    if struct then
      if not (struct.container and struct.container.valid) then
        Landingpad.destroy(struct)
      else
        local inv = struct.container.get_inventory(defines.inventory.chest)
        local inv_used = count_inventory_slots_used(inv)

        root["cargo_capacity"].caption="Cargo: " .. math.min(inv_used, #inv) .. " / " .. #inv
        root["cargo_capacity_progress"].value=math.min(inv_used, #inv) / #inv

        local message = ""
        if inv_used > 0 then
          message = "Unloading required before next payload"
        else
          message = "Ready for next payload"
        end
        if struct.inbound_rocket then
          message = "Rocket Inbound"
        end
        root["status"].caption="Status: " .. message
      end
    end
  end
end

function Landingpad.gui_open(player, landing_pad)
  if not landing_pad then
    Log.trace('landing_pad not found')
    return
  end
  local struct = landing_pad
  local gui = player.gui.left
  close_own_guis(player)

  local container = gui.add{ type = "frame", name = Landingpad.name_rocket_landing_pad_gui_root, style="space_platform_container", direction="vertical"}

  local title_table = container.add{type="table", name="unit_number", column_count=2, draw_horizontal_lines=false}
  title_table.style.horizontally_stretchable = true
  title_table.style.column_alignments[1] = "left"
  title_table.style.column_alignments[2] = "right"

  -- NOTE: [Landingpad.name_rocket_landing_pad_gui_root].unit_number.child_names()[1] gets unit number
  local title_frame = title_table.add{type="frame", name=struct.unit_number,
    caption = {"space-exploration.simple-a-b", "[img=entity/"..Landingpad.name_rocket_landing_pad.."] ", {"entity-name." .. Landingpad.name_rocket_landing_pad}},
    style="informatron_title_frame"}
  title_frame.style.right_padding = -5

  local right_flow = title_table.add{type="flow", name="title_flow_right"}
  --local close = right_flow.add{type="button", name=Lifesupport.name_window_close, caption="✖", style="informatron_close_button"}
  local close = right_flow.add{type="sprite-button", name=Landingpad.name_window_close, sprite = "utility/close_white", style="informatron_close_button"}
  close.style.width = 28
  close.style.height = 28

  --local title_flow = container.add{ type="flow", name="unit_number", direction="horizontal"}
  -- NOTE: [Landingpad.name_rocket_landing_pad_gui_root].unit_number.child_names()[1] gets unit number
  --local title = title_flow.add{ type="label", name=struct.unit_number, caption={"entity-name." .. Landingpad.name_rocket_landing_pad}, style="space_platform_title"}

  local name_flow = container.add{ type="flow", name="name-flow", direction="horizontal"}
  local name_label = name_flow.add{ type = "label", name="show-name", caption=struct.name, style="space_platform_title_short"}
  local rename_button = name_flow.add{ type = "sprite-button", name="rename", sprite="utility/rename_icon_normal", tooltip={"space-exploration.rename-something", {"entity-name.rocket-landing-pad"}}, style="space_platform_sprite_button_small"}

  container.add{ type="label", name="cargo_capacity", caption="Cargo: "}
  local bar = container.add{ type="progressbar", name="cargo_capacity_progress", size = 300, value=0, style="space_platform_progressbar_cargo"}
  bar.style.horizontally_stretchable  = true

  container.add{ type="label", name="status", caption="Status: "}

  Landingpad.gui_update(player)

end

function Landingpad.on_gui_click(event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]
  root = gui_element_or_parent(element, Landingpad.name_rocket_landing_pad_gui_root)
  if not root then return end
  struct = Landingpad.from_unit_number(root.unit_number.children_names[1])
  if not struct then return end

  if element.name == "rename" then

    local name_flow = element.parent
    element.destroy()
    name_flow["show-name"].destroy()
    local name_label = name_flow.add{ type = "textfield", name="write-name", text=struct.name, style="space_platform_textfield_short"}
    local rename_button = name_flow.add{ type = "sprite-button", name="rename-confirm", sprite="utility/enter",
      tooltip={"space-exploration.rename-something", {"entity-name.rocket-landing-pad"}}, style="space_platform_sprite_button_small"}

  elseif element.name == "rename-confirm" then

    local name_flow = element.parent
    element.destroy()
    local new_name = string.trim(name_flow["write-name"].text)
    if newname ~= "" and new_name ~= struct.name then
      --do change name stuff
      Landingpad.rename(struct, new_name)
    end
    name_flow["write-name"].destroy()
    local name_label = name_flow.add{ type = "label", name="show-name", caption=struct.name, style="space_platform_title_short"}
    local rename_button = name_flow.add{ type = "sprite-button", name="rename", sprite="utility/rename_icon_normal",
      tooltip={"space-exploration.rename-something", {"entity-name.rocket-landing-pad"}}, style="space_platform_sprite_button_small"}
  elseif element.name == Landingpad.name_window_close then
    Landingpad.gui_close(player)
  end
end
Event.addListener(defines.events.on_gui_click, Landingpad.on_gui_click)

function Landingpad.on_entity_created(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if not entity then return end
  if entity.name == Landingpad.name_rocket_landing_pad then
    local zone = Zone.from_surface(entity.surface)
    if not zone then
      return cancel_entity_creation(entity, event.player_index, "Invalid landing pad location")
    end
    local fn = entity.force.name

    local default_name = zone.name .. " Landing Pad"

    local struct = {
      type = Landingpad.name_rocket_landing_pad,
      valid = true,
      force_name = fn,
      unit_number = entity.unit_number,
      container = entity,
      name = default_name,
      zone = zone
    }
    global.rocket_landing_pads = global.rocket_landing_pads or {}
    global.rocket_landing_pads[entity.unit_number] = struct

    Landingpad.name(struct) -- assigns to zone_assets

    -- spawn settings
    struct.settings = entity.surface.create_entity{
      name = Landingpad.name_rocket_landing_pad_settings,
      force = entity.force,
      position = {entity.position.x, entity.position.y}}
    struct.settings.destructible = false

    if event.player_index and game.players[event.player_index] and game.players[event.player_index].connected then
      Landingpad.gui_open(game.players[event.player_index], struct)
    end
  end
end
Event.addListener(defines.events.on_built_entity, Landingpad.on_entity_created)
Event.addListener(defines.events.on_robot_built_entity, Landingpad.on_entity_created)
Event.addListener(defines.events.script_raised_built, Landingpad.on_entity_created)
Event.addListener(defines.events.script_raised_revive, Landingpad.on_entity_created)

function Landingpad.remove_struct_from_tables(struct)

  -- force
  local force_data = global.forces[struct.force_name]
  force_data.rocket_landing_pad_names = force_data.rocket_landing_pad_names or {}
  local force_type_table = force_data.rocket_landing_pad_names

  if not force_type_table[struct.name] then return end
  force_type_table[struct.name][struct.unit_number] = nil
  local count_remaining = 0
  for _, remaining in pairs(force_type_table[struct.name]) do
    count_remaining = count_remaining + 1
  end
  if count_remaining == 0 then
    force_type_table[struct.name] = nil
  end

  -- zone
  local zone_assets = Zone.get_force_assets(struct.force_name, struct.zone.index)
  zone_assets.rocket_landing_pad_names = zone_assets.rocket_landing_pad_names or {}
  local zone_type_table = zone_assets.rocket_landing_pad_names

  if not zone_type_table[struct.name] then return end
  zone_type_table[struct.name][struct.unit_number] = nil
  local count_remaining = 0
  for _, remaining in pairs(zone_type_table[struct.name]) do
    count_remaining = count_remaining + 1
  end
  if count_remaining == 0 then
    zone_type_table[struct.name] = nil
  end

end

function Landingpad.destroy_sub(struct, key)
  if struct[key] and struct[key].valid then
    struct[key].destroy()
    struct[key] = nil
  end
end

function Landingpad.destroy(struct)
  if not struct then
    Log.trace("Landingpad.destroy: no struct")
    return
  end
  struct.valid = false
  Landingpad.destroy_sub(struct, 'container')
  Landingpad.destroy_sub(struct, 'settings')

  Landingpad.remove_struct_from_tables(struct)
  global.rocket_landing_pads[struct.unit_number] = nil

  -- if a player has this gui open then close it
  local gui_name = Landingpad.name_rocket_landing_pad_gui_root
  for _, player in pairs(game.connected_players) do
    if player.gui.left[gui_name] and player.gui.left[gui_name].unit_number.children_names[1] == (""..struct.unit_number) then
        player.gui.left[gui_name].destroy()
      end
  end
end

function Landingpad.name(struct, new_name)
    struct.name = (new_name or struct.name)

    -- force
    local force_data = global.forces[struct.force_name]
    force_data.rocket_landing_pad_names = force_data.rocket_landing_pad_names or {}
    local force_type_table = force_data.rocket_landing_pad_names

    force_type_table[struct.name] = force_type_table[struct.name] or {}
    force_type_table[struct.name][struct.unit_number] = struct

    local zone_assets = Zone.get_force_assets(struct.force_name, struct.zone.index)
    zone_assets.rocket_landing_pad_names = zone_assets.rocket_landing_pad_names or {}
    local zone_type_table = zone_assets.rocket_landing_pad_names

    zone_type_table[struct.name] = zone_type_table[struct.name] or {}
    zone_type_table[struct.name][struct.unit_number] = struct
end

function Landingpad.rename(struct, new_name)
    local old_name = struct.name
    Landingpad.remove_struct_from_tables(struct)
    Landingpad.name(struct, new_name)
end

function Landingpad.dropdown_list_zone_landing_pad_names(force_name, zone, current)
  local selected_index
  local list = {} -- names with optional [count]
  local values = {} -- raw names
  table.insert(list, "None - General vicinity")
  table.insert(values, "") -- not sure if nil would work

  if zone and zone.type ~= "spaceship" then
    local zone_assets = Zone.get_force_assets(force_name, zone.index)
    for name, sites in pairs(zone_assets["rocket_landing_pad_names"]) do
      local count = 0
      for _, struct in pairs(sites) do
        count = count + 1
      end
      if count == 1 then
        table.insert(list, name)
        table.insert(values, name)
        if name == current then selected_index = #list end
      elseif count > 1 then
        table.insert(list, name .. " ["..count.."]")
        table.insert(values, name)
        if name == current then selected_index = #list end
      end
    end
  end
  return list, (selected_index or 1), values
end

function Landingpad.dropdown_list_force_landing_pad_names(force_name, current)
  local selected_index
  local list = {} -- names with optional [count]
  local values = {} -- raw names
  table.insert(list, "None - Cannot launch")
  table.insert(values, "") -- not sure if nil would work

  local force_data = global.forces[force_name]
  if force_data.rocket_landing_pad_names then
    for name, sites in pairs(force_data.rocket_landing_pad_names) do
      local count = 0
      for _, struct in pairs(sites) do
        count = count + 1
      end
      if count == 1 then
        table.insert(list, name)
        table.insert(values, name)
        if name == current then selected_index = #list end
      elseif count > 1 then
        table.insert(list, name .. " ["..count.."]")
        table.insert(values, name)
        if name == current then selected_index = #list end
      end
    end
  end
  return list, (selected_index or 1), values
end

function Landingpad.on_entity_removed(event)
  local entity = event.entity
  if entity and entity.valid and entity.name == Landingpad.name_rocket_landing_pad then
    Landingpad.destroy(Landingpad.from_entity(entity))
  end
end
Event.addListener(defines.events.on_entity_died, Landingpad.on_entity_removed)
Event.addListener(defines.events.on_robot_mined_entity, Landingpad.on_entity_removed)
Event.addListener(defines.events.on_player_mined_entity, Landingpad.on_entity_removed)
Event.addListener(defines.events.script_raised_destroy, Landingpad.on_entity_removed)


function Landingpad.on_gui_opened(event)
  local player = game.players[event.player_index]
  if event.entity and event.entity.valid and event.entity.name == Landingpad.name_rocket_landing_pad then
    Landingpad.gui_open(player, Landingpad.from_entity(event.entity))
  else
    -- the trick here is opeining the craft menu to cancel the other menu, then exiting the craft menu
    -- means that pressing e exits the custom gui
    if event.gui_type and event.gui_type ~= defines.gui_type.none then
      if player.gui.left[Landingpad.name_rocket_landing_pad_gui_root] then
          if player.opened_self then
            player.opened = nil
          end
          Landingpad.gui_close(player)
      end
    end
  end
end
Event.addListener(defines.events.on_gui_opened, Landingpad.on_gui_opened)

function Landingpad.on_tick(struct)
  if game.tick % 60 == 0 then
    for _, player in pairs(game.connected_players) do
      Landingpad.gui_update(player)
    end
  end
end
Event.addListener(defines.events.on_tick, Landingpad.on_tick)

function Landingpad.on_init(event)
  global.rocket_landing_pads = {} -- all landing pads sorted by struct[unit_unumber]
end
Event.addListener("on_init", Landingpad.on_init, true)

return Landingpad
