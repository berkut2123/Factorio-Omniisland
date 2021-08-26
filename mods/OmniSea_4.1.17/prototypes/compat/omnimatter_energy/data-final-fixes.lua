if mods["omnimatter_energy"] then
    --Disable ks power & bobs burner gens
    omni.lib.remove_unlock_recipe(omni.sea.tech4, "burner-generator")
    omni.lib.remove_unlock_recipe(omni.sea.tech4, "bob-burner-generator")
    omni.lib.disable_recipe("burner-generator")
    omni.lib.disable_recipe("bob-burner-generator")

    --Remove anbaric mining
    omni.lib.remove_prerequisite("automation-science-pack", "omnitech-anbaric-mining")
    data.raw.technology["omnitech-anbaric-mining"] = nil
end