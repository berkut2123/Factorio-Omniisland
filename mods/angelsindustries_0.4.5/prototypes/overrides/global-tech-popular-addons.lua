local OV = angelsmods.functions.OV
--require("prototypes.overrides.industries-override-functions")
--this is where pack_replace(techname,old_p,new_p),core_replace(techname,old_c,new_c),core_tier_up(techname,core_n) functions are used
if angelsmods.industries.tech then
-------------------------------------------------------------------------------
-- WAREHOUSES -----------------------------------------------------------------
-------------------------------------------------------------------------------
if mods["Warehousing"] then
  pack_replace("warehouse-logistics-research-1","green","orange")
end

-------------------------------------------------------------------------------
-- AAI INDUSTRIES -------------------------------------------------------------
-------------------------------------------------------------------------------
if mods["aai-industry"] then
  pack_replace("electricity", "red","grey")
  pack_replace("basic-automation","red","grey")
  pack_replace("basic-logistics","red","grey")
  pack_replace("electric-lab","red","grey")
  --pack_replace("basic-logistics","datacore-logistic-1","datacore-basic")
  pack_replace("basic-fluid-handling","red","grey")
  pack_replace("automation", "red", "grey")
  pack_replace("fuel-processing", "red", "grey")
  pack_replace("electric-mining", "red", "grey")
  pack_replace("ore-crushing", "red", "grey")
  pack_replace("omnitech-water-omnitraction-1","red","grey")
  pack_replace("omnitech-water-omnitraction-2","red","grey")

  core_replace("basic-automation","processing","basic")
  core_replace("basic-automation","logistic","basic")
  core_replace("basic-logistics","logistic","basic")
  core_replace("basic-logistics","processing","basic")
  core_replace("basic-logistics","exploration","basic")
  core_replace("basic-logistics","war","basic")
  core_replace("basic-fluid-handling","processing","basic")
  core_replace("basic-fluid-handling","logistic","basic")
  core_replace("basic-fluid-handling","exploration","basic")

  OV.add_prereq("basic-automation","angels-components-mechanical-1")
  OV.set_science_pack("basic-logistics", "datacore-basic", 2)
  OV.set_science_pack("slag-processing-1", "datacore-basic", 1)
  OV.remove_science_pack("bio-wood-processing", "datacore-processing-1")
end


if mods["omnimatter"] then
  OV.add_prereq("base-impure-extraction","tech-specialised-labs")
  core_replace("basic-logistics","war","basic")
end

end