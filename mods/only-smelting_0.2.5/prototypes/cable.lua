require("functions")

angelsmods.functions.OV.remove_unlock("advanced-electronics-3", "gilded-copper-cable")

if recipe("gilded-copper-cable") then
recipe("gilded-copper-cable").enabled = false
--data.raw.recipe["gilded-copper-cable"]=nil
end

if smeltingcable.value == true then
	angelsmods.functions.OV.remove_unlock("electronics", "tinned-copper-cable")
	if recipe("tinned-copper-cable") then
	--data.raw.recipe["tinned-copper-cable"]=nil
	recipe("tinned-copper-cable").enabled = false
	end
	if recipe("copper-cable") then
	recipe("copper-cable").enabled = false
	end
	--add_technology_unlock("electronics", "tin-cablespc")
	
	angelsmods.functions.OV.remove_unlock("angels-gold-smelting-1", "angels-wire-gold")
	if recipe("angels-wire-gold") then
	recipe("angels-wire-gold").enabled = false
	end
	
	angelsmods.functions.OV.remove_unlock("angels-platinum-smelting-1", "basic-platinated-copper-wire")
	if recipe("basic-platinated-copper-wire") then
	recipe("basic-platinated-copper-wire").enabled = false
	end
	
	angelsmods.functions.OV.remove_unlock("angels-silver-smelting-1", "basic-silvered-copper-wire")
	if recipe("basic-silvered-copper-wire") then
	recipe("basic-silvered-copper-wire").enabled = false
	end
	
	angelsmods.functions.OV.remove_unlock("angels-tin-smelting-1", "basic-tinned-copper-wire")
	if recipe("tinned-copper-cable") then
	add_technology_unlock("angels-tin-smelting-1", "tin-cablespc")
	if recipe("basic-tinned-copper-wire") then
	recipe("basic-tinned-copper-wire").enabled = false
	end
	end
end