require("prototypes.compat.omnimatter_energy.data-final-fixes")

--Disable Mineralized-Water crystallization
RecGen:import("sb-water-mineralized-crystallization"):
	setEnabled(false):
	noTech():
	extend()

if mods["omnimatter_wood"] then
	--Move wood recipes behind last startup tech
    local lasttech
    if data.raw.item["energy-science-pack"] then
        lasttech = "energy-science-pack"
    else
        lasttech = omni.sea.tech4
    end
    omni.lib.add_unlock_recipe(lasttech, "wood-omnitraction")
    omni.lib.add_unlock_recipe(lasttech, "wasteMutation")
end

--Final non-energy compat
if not mods["omnimatter_energy"] then
	--Move the Basic Extraction (and water-omnitraction)research behind the tutorial ones
	omni.lib.add_prerequisite("omnitech-base-impure-extraction", omni.sea.tech4)

	-- Remove the fuel value of Omnite and crushed Omnite without omni energy
	local remfuel = {
		"omnite",
		"crushed-omnite",
	}

	for _,entity in pairs(remfuel) do
		data.raw.item[entity].fuel_category = nil
		data.raw.item[entity].fuel_value = nil
	end
end