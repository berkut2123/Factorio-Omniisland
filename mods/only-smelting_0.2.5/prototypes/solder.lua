require("functions")

if smeltingsolder.value == true then
angelsmods.functions.OV.remove_unlock("electronics", "solder")
angelsmods.functions.OV.remove_unlock("alloy-processing-2", "solder-alloy")
angelsmods.functions.OV.remove_unlock("electronics", "solder-alloy-lead")

if recipe("solder") then
recipe("solder").enabled = false
end
if recipe("solder-alloy") then
recipe("solder-alloy").enabled = false
end
if recipe("solder-alloy-lead") then
recipe("solder-alloy-lead").enabled = false
end

if recipe("angels-solder-mixture") then
recipe("angels-solder-mixture").enabled = false
end
if recipe("tinned-copper-cable") then
angelsmods.functions.OV.remove_unlock("angels-solder-smelting-basic", "angels-solder-mixture")
add_technology_unlock("angels-solder-smelting-basic", "angels-solder-mixture-sp")
--add_technology_unlock("angels-lead-smelting-1", "lead-ingotspc")
--add_technology_unlock("angels-tin-smelting-1", "tin-ingotspc")
end
end