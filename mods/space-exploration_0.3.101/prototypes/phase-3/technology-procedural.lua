local data_util = require("data_util")

-- Procedural tech
debug_log("Procedural tech")

local function update_tech_unit_counts(complexity, multiplier)
  if not (complexity and complexity.unit) then return end
  if complexity.unit.count then
    complexity.unit.original_count = complexity.unit.original_count or complexity.unit.count
    complexity.unit.count = math.ceil(complexity.unit.original_count * multiplier)
  end
  if complexity.unit.count_formula then
    complexity.unit.original_count_formula = complexity.unit.original_count_formula or complexity.unit.count_formula
    complexity.unit.count_formula = multiplier.."*("..complexity.unit.original_count_formula..")"
  end
end

local function update_tech_for_complexity(tech, complexity, space_flavour)
  local multiplier = 1
  if complexity >= 4 then -- would be at complexity 3 except for military
    data_util.tech_add_ingredients_with_prerequisites(tech.name, {"chemical-science-pack" })
  end
  if complexity >= 5 then
    data_util.tech_add_ingredients_with_prerequisites(tech.name, {data_util.mod_prefix .. "rocket-science-pack" })
  end
  if complexity == 6 then
    data_util.tech_add_ingredients_with_prerequisites(tech.name, { space_flavour.."-1" })
    multiplier = 0.6
  elseif complexity == 7 then
    data_util.tech_add_ingredients_with_prerequisites(tech.name, { space_flavour.."-2" })
    multiplier = 0.5
  elseif complexity == 8 then
    data_util.tech_add_ingredients_with_prerequisites(tech.name, { space_flavour.."-3" })
    multiplier = 0.4
  elseif complexity >= 9 then
    data_util.tech_add_ingredients_with_prerequisites(tech.name, { space_flavour.."-4" })
    multiplier = 0.3
  end
  if complexity >= 10 then
    data_util.tech_add_ingredients_with_prerequisites(tech.name, { data_util.mod_prefix .. "deep-space-science-pack" })
    multiplier = 0.2
  end
  if complexity >= 11 then
    data_util.tech_add_ingredients_with_prerequisites(tech.name, { "space-science-pack" })
  end

  update_tech_unit_counts(tech, multiplier)
  update_tech_unit_counts(tech.normal, multiplier)
  update_tech_unit_counts(tech.expensive, multiplier)

end
local techs_static = {}
for _, tech in pairs(data.raw.technology) do
  table.insert(techs_static, tech.name)
end

for _, tech_name in pairs(techs_static) do
  local tech = data.raw.technology[tech_name]
  if tech and string.sub(tech.name, 1, 3) ~= "se-" then
    debug_log("consider tech: " .. tech.name)
    local exclude = false
    if mods["NPUtilsTech"] and string.len(tech.name) == 3 and string.sub(tech.name, 1, 1) == "n" then
      exclude = true
    end
    if not exclude then
      for _, exclusion in pairs(se_prodecural_tech_exclusions) do
        if string.find(tech.name, exclusion, 1, true) then
          exclude = true
          break
        end
      end
    end
    if not exclude then
      -- if it already needs space science then starting complexity is 1 (space)
      -- otherwise if it requires utility/production then it is -1
      -- otherwise if it requires chemical it is -2,
      -- otherwise if it requires logistic it is -3
      -- otherwise if it requires automation it is -4
      local this_level = data_util.string_to_simple_int(tech.name)
      max_level = tech.max_level
      if this_level or max_level then
        this_level = this_level or 1
        max_level = max_level or this_level
        debug_log("tech (" .. tech.name..") level: " .. this_level)
        debug_log("tech (" .. tech.name..") max level: " .. max_level)
        local min_complexity = 4 -- pre-space
        if data_util.tech_has_ingredient (tech.name, "deep-science-pack") then
          exclude = true -- already done
        elseif data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "astronomic-science-pack-4")
          or data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "biological-science-pack-4")
          or data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "energy-science-pack-4")
          or data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "material-science-pack-4") then
            min_complexity = 9
        elseif data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "astronomic-science-pack-3")
          or data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "biological-science-pack-3")
          or data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "energy-science-pack-3")
          or data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "material-science-pack-3") then
            min_complexity = 8
        elseif data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "astronomic-science-pack-2")
          or data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "biological-science-pack-2")
          or data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "energy-science-pack-2")
          or data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "material-science-pack-2") then
            min_complexity = 7
        elseif data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "astronomic-science-pack-1")
          or data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "biological-science-pack-1")
          or data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "energy-science-pack-1")
          or data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "material-science-pack-1") then
            min_complexity = 6
        elseif data_util.tech_has_ingredient (tech.name, data_util.mod_prefix .. "rocket-science-pack") then
            min_complexity = 5
        elseif data_util.tech_has_ingredient (tech.name, "utility-science-pack")
          or data_util.tech_has_ingredient (tech.name, "production-science-pack") then
            min_complexity = 4
        elseif data_util.tech_has_ingredient (tech.name, "chemical-science-pack") then
            min_complexity = 3
        elseif data_util.tech_has_ingredient (tech.name, "logistic-science-pack") then
            min_complexity = 2
        elseif data_util.tech_has_ingredient (tech.name, "automation-science-pack") then
            min_complexity = 1
        end
        if not exclude then
          local complexity = math.max(this_level, min_complexity)
          local complexity_adjust = complexity - this_level
          debug_log("tech (" .. tech.name..") complexity_adjust: " .. complexity_adjust)
          local max_complexity = 10
          local level_of_max_complexity = max_complexity - complexity_adjust
          debug_log("tech (" .. tech.name..") level_of_max_complexity: " .. level_of_max_complexity)
          local max_level_to_make = level_of_max_complexity
          if max_level ~= "infinite" then
            max_level_to_make = math.min(max_level_to_make, max_level)
          end
          debug_log("tech (" .. tech.name..") max_level_to_make: " .. max_level_to_make)
          local space_flavour = data_util.mod_prefix .. "material-science-pack"
          if string.find(tech.name, "laser", 1, true)
          or string.find(tech.name, "energy", 1, true)
          or string.find(tech.name, "robots-speed", 1, true) then
            space_flavour = data_util.mod_prefix .. "energy-science-pack"
          end
          debug_log("tech (" .. tech.name..") space_flavour: " .. space_flavour)
          -- Update packs for this
          update_tech_for_complexity(tech, complexity, space_flavour)
          -- make new levels as required
          if max_level_to_make > this_level then
            local raw_name = data_util.remove_number_suffix(tech.name)
            debug_log("tech (" .. tech.name..") raw_name: " .. raw_name)
            for i = this_level+1, max_level_to_make do
              debug_log("tech (" .. tech.name..") try to make tech for level: " .. i.."("..raw_name.."-"..i..")")
              local new_tech = data_util.tech_split_at_level(raw_name, i)
              if new_tech then
                update_tech_for_complexity(new_tech, i+complexity_adjust, space_flavour)
                debug_log("new tech level created: " .. new_tech.name.."")
              else
                debug_log("tech (" .. tech.name..") create tech failed")
              end
            end
          else
            debug_log("tech (" .. tech.name..") no new levels needed")
          end

        end
      end
    end
  end
end
