local inventory_tab = {}

local gui = require("lib.gui")
local util = require("scripts.util")

local constants = require("constants")

local pane_heights = {
  provided = 6,
  requested = 3,
  in_transit = 3
}

local bit32_btest = bit32.btest
local string_find = string.find
local string_gsub = string.gsub
local string_lower = string.lower

gui.add_templates{
  inventory = {
    slot_table_with_label = function(name, rows)
      rows = rows or 4
      return {type = "flow", style_mods = {vertical_spacing = 7, top_padding = 3}, direction = "vertical", children = {
        {type = "label", style = "caption_label", caption = {"ltnm-gui."..string_gsub(name, "_", "-")}},
        {type = "frame", style = "deep_frame_in_shallow_frame", save_as = "inventory."..name.."_frame", children = {
          {type = "scroll-pane", style = "ltnm_slot_table_scroll_pane", style_mods = {height = rows*40}, children = {
            {
              type = "table",
              style = "ltnm_inventory_slot_table",
              column_count = 10,
              save_as = "inventory."..name.."_table"
            }
          }}
        }}
      }}
    end,
    label_with_value = function(name, label_caption, value)
      return {type = "flow", style_mods = {left_margin = 2, right_margin = 2}, children = {
        {
          type = "label",
          style = "bold_label",
          caption = {"", label_caption, ":"},
          save_as = "inventory.info_pane."..name.."_label"
        },
        {template = "pushers.horizontal"},
        {type = "label", caption = value, save_as = "inventory.info_pane."..name.."_value"}
      }}
    end,
    small_slot_table_with_label = function(parent, materials, translations)
      local elems = gui.build(parent, {
        {type = "flow", direction = "vertical", children = {
          {type = "flow", style_mods = {width = 336}, direction = "vertical", save_as = "labels_flow"},
          {
            type = "flow",
            style_mods = {margin = 0, padding = 0, horizontal_align = "center", horizontally_stretchable = true},
            children = {
              {type = "frame", style = "deep_frame_in_shallow_frame", children = {
                {type = "scroll-pane", style = "ltnm_material_location_slot_table_scroll_pane", children = {
                  {type = "table", style = "ltnm_materials_in_location_slot_table", column_count = 9, save_as = "table"}
                }}
              }}
            }
          }
        }}
      })
      -- populate materials
      local table_add = elems.table.add
      local i = 0
      for _, t in ipairs(materials) do
        local style = "ltnm_small_slot_button_"..t[1]
        for name, count in pairs(t[2]) do
          i = i + 1
          table_add{
            type = "sprite-button",
            name = "ltnm_view_material__"..i,
            style = style, sprite = string_gsub(name, ",", "/"),
            number = count,
            tooltip = translations[name].."\n"..util.comma_value(count)
          }
        end
      end
      return elems
    end
  }
}

gui.add_handlers{
  inventory = {
    search = {
      name_textfield = {
        on_gui_text_changed = function(e)
          local player_table = global.players[e.player_index]
          local gui_data = player_table.gui.main.inventory
          gui_data.search.query = e.text
          inventory_tab.update(game.get_player(e.player_index), player_table, {inventory = true})
        end
      },
      network_id_textfield = {
        on_gui_text_changed = function(e)
          local player_table = global.players[e.player_index]
          local gui_data = player_table.gui.main.inventory
          local input = tonumber(e.text) or -1
          gui_data.search.network_id = input
          inventory_tab.update(game.get_player(e.player_index), player_table, {inventory = true})
        end
      }
    }
  }
}

function inventory_tab.update(player, player_table, state_changes, gui_data, data, material_translations)
  gui_data = gui_data or player_table.gui.main
  data = data or global.data
  material_translations = material_translations or player_table.translations.materials

  if state_changes.inventory then
    local inventory = data.inventory
    local inventory_gui_data = gui_data.inventory
    inventory_gui_data.material_buttons = {}
    inventory_gui_data.contents = {}
    local buttons = inventory_gui_data.material_buttons
    local query = string_lower(gui_data.inventory.search.query)
    for pattern, replacement in pairs(constants.input_sanitisers) do
      query = string.gsub(query, pattern, replacement)
    end
    local network_id_query = inventory_gui_data.search.network_id
    for type, color in pairs{provided = "green", requested = "red", in_transit = "blue"} do
      -- combine contents of each matching network
      local combined_materials = {}
      for network_id, materials in pairs(inventory[type]) do
        if bit32_btest(network_id, network_id_query) then
          combined_materials = util.add_materials(materials, combined_materials)
        end
      end

      -- filter by material name
      if query ~= "" then
        for name in pairs(combined_materials) do
          if not string_find(string_lower(material_translations[name]), query) then
            combined_materials[name] = nil
          end
        end
      end

      -- add combined materials to the GUI table (also temporary)
      inventory_gui_data.contents[type] = combined_materials
      -- add to table
      local table = inventory_gui_data[type.."_table"]
      table.clear()
      local add = table.add
      local elems = {}
      local i = 0
      for name, count in pairs(combined_materials) do
        i = i + 1
        elems[name] = add{
          type = "sprite-button",
          name = "ltnm_view_material__"..i,
          style = "flib_slot_button_"..color,
          sprite = string_gsub(name, ",", "/"),
          number = count,
          tooltip = (material_translations[name] or name).."\n"..util.comma_value(count)
        }
      end
      buttons[type] = elems

      -- set frame style
      if (i / 10) > pane_heights[type] then
        inventory_gui_data[type.."_frame"].style.right_margin = 0
      else
        inventory_gui_data[type.."_frame"].style.right_margin = 12
      end
    end


    -- remove previous selection since the buttons are no longer glowing
    state_changes.inventory = (
      type(state_changes.inventory) == "boolean" and inventory_gui_data.selected or state_changes.inventory
    )
    inventory_gui_data.selected = nil

    -- update selected material
    if type(state_changes.inventory) == "string" then
      -- set selected button glow
      for _, type in ipairs{"provided", "requested", "in_transit"} do
        local buttons = inventory_gui_data.material_buttons[type]
        -- deselect previous button
        local button = buttons[inventory_gui_data.selected]
        if button then
          button.style = string_gsub(button.style.name, "flib_selected_", "flib_")
          button.enabled = true
        end
        -- select new button
        button = buttons[state_changes.inventory]
        if button then
          button.style = string_gsub(button.style.name, "flib_", "flib_selected_")
          button.enabled = false
        end
      end

      -- save selection to global
      inventory_gui_data.selected = state_changes.inventory

      -- basic material info
      local _, _, material_type, material_name = string_find(state_changes.inventory, "(.*),(.*)")
      local info_pane = inventory_gui_data.info_pane
      info_pane.icon.sprite = material_type.."/"..material_name
      info_pane.name.caption = game[material_type.."_prototypes"][material_name].localised_name

      -- material counts
      local contents = inventory_gui_data.contents
      for _, type in ipairs{"provided", "requested", "in_transit"} do
        info_pane[type.."_value"].caption = util.comma_value(contents[type][inventory_gui_data.selected] or 0)
      end

      -- set up scroll pane and locals
      local locations_pane = inventory_gui_data.locations_scroll_pane
      locations_pane.clear()
      local locations = data.material_locations[state_changes.inventory]
      if locations then
        local location_template = gui.templates.inventory.small_slot_table_with_label

        -- stations
        local stations = data.stations
        local station_ids = locations.stations
        if #station_ids > 0 then
          local label = locations_pane.add{
            type = "label",
            style = "ltnm_material_locations_label",
            caption = {"ltnm-gui.stations"}
          }
          local table = locations_pane.add{type = "table", style = "ltnm_material_locations_table", column_count = 1}
          for i = 1,#station_ids do
            local station = stations[station_ids[i]]
            if station.entity and station.entity.valid then
              if bit32_btest(station.network_id, network_id_query) then
                local materials = {}
                for mode, color in pairs{provided = "green", requested = "red"} do
                  local station_contents = station[mode]
                  if station_contents then
                    materials[#materials+1] = {color, station_contents}
                  end
                end
                local elems = location_template(
                  table,
                  materials,
                  material_translations
                )
                elems.labels_flow.add{
                  type = "label",
                  name = "ltnm_view_station__"..station_ids[i],
                  style = "ltnm_hoverable_bold_label",
                  style_mods = {horizontally_squashable = true},
                  caption = station.entity.backer_name,
                  tooltip = {"ltnm-gui.view-station-on-map"}
                }
              end
            end
          end
          if #table.children == 0 then
            label.destroy()
            table.destroy()
          end
        end

        -- trains
        local trains = data.trains
        local train_ids = locations.trains
        if #train_ids > 0 then
          local label = locations_pane.add{
            type = "label",
            style = "ltnm_material_locations_label",
            caption = {"ltnm-gui.trains"}
          }
          local table = locations_pane.add{type = "table", style = "ltnm_material_locations_table", column_count = 1}
          for i = 1,#train_ids do
            local train = trains[train_ids[i]]
            if bit32_btest(train.network_id, network_id_query) then
              local materials = {}
              if train.shipment then
                materials = {{"blue", train.shipment}}
              end
              local elems = location_template(
                table,
                materials,
                material_translations
              )
              gui.build(elems.labels_flow, {
                {type = "flow", children = {
                  {type = "label", style = "caption_label", caption={"ltnm-gui.from"}},
                  {
                    type = "label",
                    name = "ltnm_view_station__"..train.from_id,
                    style = "ltnm_hoverable_bold_label",
                    style_mods = {horizontally_squashable = true},
                    caption = train.from,
                    tooltip = {"ltnm-gui.view-station-on-map"}
                  }
                }},
                {type = "flow", children = {
                  {type = "label", style = "caption_label", caption={"ltnm-gui.to"}},
                  {
                    type = "label",
                    name = "ltnm_view_station__"..train.to_id,
                    style = "ltnm_hoverable_bold_label",
                    style_mods = {horizontally_squashable = true},
                    caption = train.to,
                    tooltip = {"ltnm-gui.view-station-on-map"}
                  }
                }}
              })
            end
          end
          if #table.children == 0 then
            label.destroy()
            table.destroy()
          end
        end
      end
    end
  end
end

inventory_tab.base_template = {
  type = "flow",
  style_mods = {horizontal_spacing = 12},
  elem_mods = {visible = false},
  save_as = "tabbed_pane.contents.inventory",
  children = {
    -- left column
    {
      type = "frame",
      style = "inside_shallow_frame",
      style_mods = {top_padding = 1},
      direction = "vertical",
      children = {
        {
          type = "flow",
          style_mods = {padding = 12, top_padding = 4, right_padding = 0},
          direction = "vertical",
          children = {
            gui.templates.inventory.slot_table_with_label("provided", pane_heights.provided),
            gui.templates.inventory.slot_table_with_label("requested", pane_heights.requested),
            gui.templates.inventory.slot_table_with_label("in_transit", pane_heights.in_transit)
          }
        }
      }
    },
    -- right column
    {type = "frame", style = "inside_shallow_frame", direction = "vertical", children = {
      -- item information
      {
        type = "frame",
        style = "ltnm_shallow_frame_in_shallow_frame",
        style_mods = {horizontally_stretchable = true, vertically_stretchable = true},
        direction = "vertical",
        children = {
          {type = "frame", style = "ltnm_item_info_toolbar_frame", direction = "vertical", children = {
            -- icon and name
            {type = "flow", style_mods = {vertical_align = "center"}, children = {
              {
                type = "sprite",
                style = "ltnm_material_icon",
                sprite = "item-group/intermediate-products",
                save_as = "inventory.info_pane.icon"
              },
              {
                type = "label",
                style = "caption_label",
                style_mods = {left_margin = 2},
                caption = {"ltnm-gui.choose-an-item"},
                save_as = "inventory.info_pane.name"
              }
            }},
            -- info
            gui.templates.inventory.label_with_value("provided", {"ltnm-gui.provided"}, 0),
            gui.templates.inventory.label_with_value("requested", {"ltnm-gui.requested"}, 0),
            gui.templates.inventory.label_with_value("in_transit", {"ltnm-gui.in-transit"}, 0)
          }},
          {
            type = "scroll-pane",
            style = "ltnm_material_locations_scroll_pane",
            style_mods = {horizontally_stretchable = true, vertically_stretchable = true},
            vertical_scroll_policy = "always",
            save_as = "inventory.locations_scroll_pane"
          }
        }
      }
    }
  }
}}

inventory_tab.search_template = {
  {
    type = "textfield",
    lose_focus_on_confirm = true,
    handlers = "inventory.search.name_textfield",
    save_as = "inventory.search.name_textfield"
  },
  {type = "label", style = "caption_label", style_mods = {left_margin = 12}, caption = {"ltnm-gui.network-id"}},
  {
    type = "textfield",
    style_mods = {width = 80},
    lose_focus_on_confirm = true,
    numeric = true,
    allow_negative = true,
    handlers = "inventory.search.network_id_textfield",
    save_as = "inventory.search.network_id_textfield"
  }
}

function inventory_tab.set_search_initial_state(player, player_table, gui_data)
  local search_gui_data = gui_data.inventory.search
  search_gui_data.name_textfield.text = search_gui_data.query
  search_gui_data.network_id_textfield.text = tostring(search_gui_data.network_id)
  search_gui_data.name_textfield.focus()
end

return inventory_tab