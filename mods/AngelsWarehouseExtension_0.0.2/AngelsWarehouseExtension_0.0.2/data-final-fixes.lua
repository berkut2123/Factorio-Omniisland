if mods["angelsaddons-warehouses"] then
	data.raw.container["angels-warehouse"].inventory_size = 1800
	data.raw["logistic-container"]["angels-warehouse-passive-provider"].inventory_size = 1800
	data.raw["logistic-container"]["angels-warehouse-active-provider"].inventory_size = 1800
	data.raw["logistic-container"]["angels-warehouse-storage"].inventory_size = 2000
	data.raw["logistic-container"]["angels-warehouse-requester"].inventory_size = 1800
	data.raw["logistic-container"]["angels-warehouse-buffer"].inventory_size = 1800
end

if mods["angelsaddons-pressuretanks"] then
	data.raw["storage-tank"]["angels-pressure-tank-1"]["fluid_box"].base_area = 5000
end

if mods["Warehousing"] then
	data.raw.container["warehouse-basic"].fast_replaceable_group = "angels-warehouse"
	data.raw["logistic-container"]["warehouse-active-provider"].fast_replaceable_group = "angels-warehouse"
	data.raw["logistic-container"]["warehouse-passive-provider"].fast_replaceable_group = "angels-warehouse"
	data.raw["logistic-container"]["warehouse-storage"].fast_replaceable_group = "angels-warehouse"
	data.raw["logistic-container"]["warehouse-buffer"].fast_replaceable_group = "angels-warehouse"
	data.raw["logistic-container"]["warehouse-requester"].fast_replaceable_group = "angels-warehouse"
end