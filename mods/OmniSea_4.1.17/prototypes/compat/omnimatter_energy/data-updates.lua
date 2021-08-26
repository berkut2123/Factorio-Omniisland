if mods["omnimatter_energy"] then

    -----------------
    ---Tech  fixes---
    -----------------
    --remove tech4 as prereq from all techs, if techs have no other prereqs then set auto sp as prereq
    local ignore_tech = {
        "omnitech-base-impure-extraction",
        "omnitech-simple-automation",
        "gun-turret",
        "stone-wall",
        "steel-processing"
    }
    for _,tech in pairs(data.raw.technology) do
        if not omni.lib.is_in_table(tech.name, ignore_tech) then
            if omni.lib.is_in_table(omni.sea.tech4, tech.prerequisites) then
                omni.lib.replace_prerequisite(tech.name, omni.sea.tech4, omni.sea.autosp)
            end
            -- if (not tech.prerequisites) or (not next(tech.prerequisites)) then
            --     omni.lib.add_prerequisite(tech.name, omni.sea.autosp)
            -- end
        end
    end

    --Energy adds automation-science-pack as prereq for everything electricity related without prereqs, remove that from sb-startup-1 to avoid loops
    omni.lib.remove_prerequisite("sb-startup1", omni.sea.autosp)

    ------------------------
    ---Edit Startup Techs---
    ------------------------

    --Edit startup 2 -->omnicium plate
    data.raw.tool["sb-algae-brown-tool"].icon = nil
    data.raw.tool["sb-algae-brown-tool"].icon_size = nil
    data.raw.tool["sb-algae-brown-tool"].icons = data.raw.item["omnicium-plate"].icons
    data.raw.tool["sb-algae-brown-tool"].localised_name = {"item-name.omnicium-plate"}
    data.raw.tool["sb-algae-brown-tool"].localised_description = {"tool-description.omnicium"}
    data.raw.technology["sb-startup2"].icon = nil
    data.raw.technology["sb-startup2"].icon_size = nil
    data.raw.technology["sb-startup2"].icons = data.raw.item["omnicium-plate"].icons
    data.raw.technology["sb-startup2"].localised_name = {"technology-name.getting_omnicium"}
    data.raw.technology["sb-startup2"].localised_description = {"technology-description.getting_omnicium"}

    --Edit startup 3 -->omnitor
    data.raw.tool["sb-basic-circuit-board-tool"].icon = nil
    data.raw.tool["sb-basic-circuit-board-tool"].icon_size = nil
    data.raw.tool["sb-basic-circuit-board-tool"].icons = data.raw.item["omnitor"].icons
    data.raw.tool["sb-basic-circuit-board-tool"].localised_name = {"item-name.omnitor"}
    data.raw.tool["sb-basic-circuit-board-tool"].localised_description = {"tool-description.omnitor"}
    data.raw.technology["sb-startup3"].icon = nil
    data.raw.technology["sb-startup3"].icon_size = nil
    data.raw.technology["sb-startup3"].icons = data.raw.item["omnitor"].icons
    data.raw.technology["sb-startup3"].localised_name = {"technology-name.getting_omnitor"}
    data.raw.technology["sb-startup3"].localised_description = {"technology-description.getting_omnitor"}

    --Edit startup 4 -->lab, unlocks energy sp
    data.raw.tool["sb-lab-tool"].icon = "__omnimatter_energy__/graphics/icons/omnitor-lab.png"
    data.raw.tool["sb-lab-tool"].icon_size = 32
    data.raw.tool["sb-lab-tool"].localised_name = {"entity-name.omnitor-lab"}
    data.raw.tool["sb-lab-tool"].localised_description = {"tool-description.omnitor_lab"}
    data.raw.technology["sb-startup4"].icon = "__OmniSea__/graphics/technology/omnitor-lab-tech.png"
    data.raw.technology["sb-startup4"].localised_name = {"technology-name.getting_omnitor_lab"}
    data.raw.technology["sb-startup4"].localised_description = {"technology-description.getting_omnitor_lab"}


    -------------------------------
    ---Startup tech unlock fixes---
    -------------------------------
    --move energy science back to startup 4
    omni.lib.add_unlock_recipe(omni.sea.tech4, "energy-science-pack")
    omni.lib.remove_unlock_recipe(omni.sea.tech4, "automation-science-pack")

    --Fix auto sp and lab unlocks
    omni.lib.add_unlock_recipe(omni.sea.autosp, "automation-science-pack")
    omni.lib.add_unlock_recipe("omnitech-anbaric-lab", "lab")

    --Readd autosp to automation
    omni.lib.add_science_pack("automation", "automation-science-pack")

    --Add omni-tablet as red sp unlock
    omni.lib.add_unlock_recipe(omni.sea.tech4, "omni-tablet")

    

    --Lets first make sure that all recipe unlocks get moved to other techs
    --(need to add them back to energy´s techs since SB removes them)
    --startup2
    omni.lib.remove_unlock_recipe("sb-startup2","basic-circuit-board")
    omni.lib.add_unlock_recipe("omnitech-anbaricity","basic-circuit-board")
    omni.lib.remove_unlock_recipe("sb-startup2","copper-cable")
    omni.lib.add_unlock_recipe("omnitech-anbaricity","copper-cable")

    --startup3
    omni.lib.remove_unlock_recipe("sb-startup3","basic-transport-belt")
    omni.lib.add_unlock_recipe("logistics-0", "basic-transport-belt")
    omni.lib.remove_unlock_recipe("sb-startup3","inserter")
    omni.lib.add_unlock_recipe("omnitech-anbaric-inserter", "inserter")
    omni.lib.add_unlock_recipe("sb-startup3","omnitor-lab")
    omni.lib.remove_unlock_recipe("sb-startup3", "lab")

    --startup4
    omni.lib.remove_unlock_recipe(omni.sea.tech4, "omnitor-lab")
    omni.lib.remove_unlock_recipe(omni.sea.tech4, "electric-mining-drill")
    omni.lib.remove_unlock_recipe(omni.sea.tech4, "boiler")
    omni.lib.remove_unlock_recipe(omni.sea.tech4, "steam-engine")
    omni.lib.remove_unlock_recipe(omni.sea.tech4, "radar")
    omni.lib.add_unlock_recipe("omnitech-anbaricity", "radar")

    --Add omnicium recipes to startup1
    omni.lib.add_unlock_recipe("sb-startup1","omnicium-plate-pure")
    omni.lib.add_unlock_recipe("sb-startup1","omnicium-plate-mix")

    --Add omnitor recipes as unlocks for startup 2
    omni.lib.add_unlock_recipe("sb-startup2","omnitor")

    -------------------------------------------------------
    ---New Algae Tech before anbaricity to unlock boards---
    -------------------------------------------------------
    --Create a new tech for algae farm + simple algae processing behind anbaricity
    omni.lib.remove_unlock_recipe("sb-startup1","algae-farm")
    omni.lib.remove_unlock_recipe("sb-startup1","algae-green-simple")

    TechGen:import("bio-processing-brown"):
        setName("algae-farm"):
        setPrereq("omnitech-simple-automation"):
        setPacks({{"energy-science-pack", 1}}):
        setCost(15):
        nullUnlocks():
        addUnlocks("algae-farm","algae-green-simple"):
        setLocName({"recipe-name.algae-green-simple"}):
        extend()

    --Fix techs around that
    omni.lib.replace_prerequisite("bio-paper-1","sb-startup2","algae-farm")
    omni.lib.replace_prerequisite("bio-wood-processing","sb-startup2","algae-farm")
    omni.lib.add_prerequisite("omnitech-anbaricity", "bio-paper-1")
    data.raw.technology["bio-paper-1"].unit.ingredients = {{type = "item", name = "energy-science-pack", amount = 1}}
    data.raw.technology["bio-paper-1"].unit.count = 15
    data.raw.technology["bio-wood-processing"].unit.ingredients = {{type = "item", name = "energy-science-pack", amount = 1}}
    data.raw.technology["bio-wood-processing"].unit.count = 15
    omni.lib.set_prerequisite("sb-startup3", "sb-startup2")

    --Add auto SP to new SB techs that miss it
    omni.lib.add_science_pack("bio-wood-processing-2", "automation-science-pack")
    omni.lib.add_science_pack("omnitech-steam-power", "automation-science-pack")
    omni.lib.add_science_pack("basic-chemistry", "automation-science-pack")
    omni.lib.add_science_pack("angels-sulfur-processing-1", "automation-science-pack")
    omni.lib.add_science_pack("slag-processing-1", "automation-science-pack")
    omni.lib.add_science_pack("water-washing-1", "automation-science-pack")

    --Add an omni tablet to the paper wooden board recipe
    omni.lib.add_recipe_ingredient("wooden-board-paper", "omni-tablet")

    --Random tech fixes
    omni.lib.add_prerequisite(omni.lib.get_tech_name("yellow-filter-inserter"), "omnitech-burner-filter")
    omni.lib.remove_prerequisite("logistics", "logistics-0")
    omni.lib.add_prerequisite("omnitech-base-impure-extraction", omni.sea.tech4)

    --Enable early omnite bricks again (SB moves them to a tech?)
    omni.lib.remove_unlock_recipe(omni.sea.tech4, "early-omnite-brick")
    omni.lib.enable_recipe("early-omnite-brick")

    ---------------
    ---SCT FIXES---
    ---------------
    if mods["ScienceCostTweakerM"] then
        --SCT adds a split Lab+SP tech, copy both for the automation SP and SCT lab and edit the old ones since they have all unlocks
        --Recreate the anbaric lab tech (doesnt exist with SCT) by deepcopying SCT lab and lock it behind anbaricity
        --Copy
        TechGen:import("sct-lab-t1"):
            setName("omnitech-anbaric-lab"):
            setUpgrade(false):
            setPrereq("sb-startup3"):
            nullUnlocks():
            addUnlocks("omnitor-lab"):
            setIcons(omni.lib.icon.of("omnitor-lab","item")):
            extend()
        data.raw.technology["omnitech-anbaric-lab"].localised_name = {"technology-name.getting_omnitor_lab"}
        data.raw.technology["omnitech-anbaric-lab"].localised_description = {"technology-description.getting_omnitor_lab"}

        --Now set parameters for the old tech
        TechGen:import("sct-lab-t1"):
            setUpgrade(false):
            setPrereq("omnitech-anbaric-electronics"):
            setPacks({{"energy-science-pack", 1}}):
            setCost(45):
            extend()

        --Copy
        TechGen:import("sct-automation-science-pack"):
            setName("energy-science-pack"):
            setUpgrade(false):
            setPrereq("omnitech-anbaric-lab"):
            removeUnlocks("omnitor-lab", "automation-science-pack", "sct-t1-ironcore", "sct-t1-magnet-coils"):
            setIcons(omni.lib.icon.of("energy-science-pack", "item")):
            extend()

        --Now set parameters for the old tech
        TechGen:import("sct-automation-science-pack"):
            setUpgrade(false):
            setPrereq("sct-lab-t1"):
            nullUnlocks():
            addUnlocks("sct-automation-science-pack"):
            setPacks({{"energy-science-pack", 1}}):
            setCost(45):
            extend()

        

        ----Unlock sct lab tech with the omnitor lab
        data.raw.technology["energy-science-pack"].unit = {count = 1, ingredients = {{"sb-lab-tool", 1}}, time = 5}

        --Move some thing sbehind autosp again
        omni.lib.add_prerequisite("ore-crushing", omni.sea.autosp)
        omni.lib.add_prerequisite("omnitech-steam-power", omni.sea.autosp)

        --Move some stuff that SCT messes up back to energy sp
        omni.lib.replace_prerequisite("omnitech-simple-automation", "sct-automation-science-pack", "energy-science-pack")

        omni.lib.remove_prerequisite("omnitech-base-impure-extraction", omni.sea.autosp)
        omni.lib.remove_prerequisite("omnitech-base-impure-extraction", omni.sea.tech4)
        omni.lib.add_prerequisite("omnitech-base-impure-extraction", "energy-science-pack")

        --Add energy SP to new SB techs that miss it
        omni.lib.add_science_pack("bio-wood-processing-2", "energy-science-pack")
        omni.lib.add_science_pack("basic-chemistry", "energy-science-pack")
        omni.lib.add_science_pack("angels-sulfur-processing-1", "energy-science-pack")
        omni.lib.add_science_pack("slag-processing-1", "energy-science-pack")
        omni.lib.add_science_pack("water-washing-1", "energy-science-pack")
    end
end