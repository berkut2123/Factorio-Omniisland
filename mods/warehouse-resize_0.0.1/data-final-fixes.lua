local c = data.raw["container"]
local lc = data.raw["logistic-container"]

local warehouse_size = settings.startup["warehouse-size"].value
c["warehouse-basic"].inventory_size = warehouse_size
lc["warehouse-active-provider"].inventory_size = warehouse_size
lc["warehouse-passive-provider"].inventory_size = warehouse_size
lc["warehouse-storage"].inventory_size = warehouse_size
lc["warehouse-buffer"].inventory_size = warehouse_size
lc["warehouse-requester"].inventory_size = warehouse_size

local storehouse_size = settings.startup["storehouse-size"].value
c["storehouse-basic"].inventory_size = storehouse_size
lc["storehouse-active-provider"].inventory_size = storehouse_size
lc["storehouse-passive-provider"].inventory_size = storehouse_size
lc["storehouse-storage"].inventory_size = storehouse_size
lc["storehouse-buffer"].inventory_size = storehouse_size
lc["storehouse-requester"].inventory_size = storehouse_size