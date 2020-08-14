local data_util = require("data_util")
local Shared = require("shared")
local noise = require("noise");
local tne = noise.to_noise_expression;
resource_autoplace = require("prototypes/resource_autoplace_overrides") -- make sure there were not changed

local resource_controls = {}

for _, resource in pairs(data.raw.resource) do

  -- no infinte versions of otherwise existing resources
  if string.find(resource.name, "infinite", 1, true)
   or string.find(resource.name, "unlimited", 1, true)
   or string.find(resource.name, "endless", 1, true)
   then
    log("Resource detected as infinite: " .. resource.name)
    resource.autoplace = nil
  end

  -- no resources without controls
  if resource.autoplace == nil or not resource.autoplace.control then
    log("Resource has no control: " .. resource.name)
    resource.autoplace = nil
  else
    log("Resource has control: " .. resource.name .. ": " .. resource.autoplace.control)
  end

  if resource.autoplace and not data_util.table_contains(Shared.resources_with_shared_controls, resource.name) then
    if resource_controls[resource.autoplace.control] then
      -- resources MUST have thier own control - critical for surface resource difference
      -- actually in cases where there are multiple sub-types of a resource sharing the same control is acceptable, example: ground water and lithia water.
      -- it would not be useful to have a planet with just ground water as a resource
      resource.autoplace = nil
      log("Resource control already occupied: " .. resource.name)
    else
      resource_controls[resource.autoplace.control] = "taken"
    end
  end

  if resource.autoplace == nil then
    log("Resource cannot place: " .. resource.name)
  else
    log("Resource can place: " .. resource.name)
  end

  --[[if not (resource.category == "basic-fluid" and resource.minable and resource.minable.results
    and #resource.minable.results == 1 and resource.minable.results[1] and resource.minable.results[1].type == "fluid") then
    -- no endless non-fluids
    resource.infinite = false
    resource.minimum = nil
    resource.normal = nil
    resource.maximum = nil
  end]]--

  if resource.minable and resource.minable.results then
    for _, result in ipairs(resource.minable.results) do
        if result and result.type ~= "fluid" then
            -- no endless non-fluids
            resource.infinite = false
            resource.minimum = nil
            resource.normal = nil
            resource.maximum = nil
        end
    end
  end

  -- the prevent overlapping (blocks a differnet resource or makes weird halos)
  if resource.autoplace then
    local tile_restriction = resource.autoplace.tile_restriction
    local resource_setting = se_resources[resource.name] or {}
    resource_setting.name = resource.name

    -- apply defaults
    resource_setting.order = resource_setting.order or "z-"..resource.name
    if resource_setting.has_starting_area_placement == nil then resource_setting.has_starting_area_placement = true end
    resource_setting.base_density = resource_setting.base_density or 5
    resource_setting.regular_rq_factor_multiplier = resource_setting.regular_rq_factor_multiplier or 1.1
    resource_setting.starting_rq_factor_multiplier = resource_setting.starting_rq_factor_multiplier or 1

    if resource.collision_box[1][1] < -0.5 then
      -- based on crude oil
      resource_setting.base_spots_per_km2 = resource_setting.base_spots_per_km2 or 1.8
      if not resource_setting.random_probability then
        resource_setting.random_probability = 1/48
        resource_setting.random_spot_size_minimum = resource_setting.random_spot_size_minimum or 1
        resource_setting.random_spot_size_maximum = resource_setting.random_spot_size_maximum or 1 -- don't randomize spot size
        resource_setting.additional_richness = resource_setting.additional_richness or 220000 -- this increases the total everywhere, so base_density needs to be decreased to compensate
      end
      if resource_setting.has_starting_area_placement == nil then resource_setting.has_starting_area_placement = false end
    else
      if resource_setting.has_starting_area_placement == nil then resource_setting.has_starting_area_placement = true end
    end

    resource.autoplace = resource_autoplace.resource_autoplace_settings(resource_setting)

    resource.autoplace.tile_restriction = tile_restriction
  end

end
data.raw.resource["crude-oil"].resource_patch_search_radius = 32 -- was 12
