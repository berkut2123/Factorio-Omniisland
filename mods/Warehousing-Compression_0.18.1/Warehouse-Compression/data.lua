non_logistic_tint = { r = 255, g = 255, b = 255, a = 0.05 }
active_tint = { r = 140, g = 0, b = 210, a = 0.05 }
passive_tint = { r = 255, g = 0, b = 0, a = 0.05 }
storage_tint = { r = 255, g = 255, b = 0, a = 0.05 }
buffer_tint = { r = 0, g = 255, b = 0, a = 0.05 }
requester_tint = { r = 0, g = 0, b = 255, a = 0.05 }

research_tint = { r = 0, g = 0, b = 0, a = 1 }

require("prototypes.item")
require("prototypes.recipe")
require("prototypes.entity")
require("prototypes.technology")

data.raw.recipe["storehouse-basic"].subgroup = "warehousing"
data.raw.recipe["storehouse-active-provider"].subgroup = "logistic-warehousing"
data.raw.recipe["storehouse-buffer"].subgroup = "logistic-warehousing"
data.raw.recipe["storehouse-passive-provider"].subgroup = "logistic-warehousing"
data.raw.recipe["storehouse-requester"].subgroup = "logistic-warehousing"
data.raw.recipe["storehouse-storage"].subgroup = "logistic-warehousing"
data.raw.recipe["storehouse-basic"].order = "a-a"
data.raw.recipe["storehouse-active-provider"].order = "a"
data.raw.recipe["storehouse-buffer"].order = "a"
data.raw.recipe["storehouse-passive-provider"].order = "a"
data.raw.recipe["storehouse-requester"].order = "a"
data.raw.recipe["storehouse-storage"].order = "a"

data.raw.recipe["warehouse-basic"].subgroup = "warehousing"
data.raw.recipe["warehouse-active-provider"].subgroup = "logistic-warehousing"
data.raw.recipe["warehouse-buffer"].subgroup = "logistic-warehousing"
data.raw.recipe["warehouse-passive-provider"].subgroup = "logistic-warehousing"
data.raw.recipe["warehouse-requester"].subgroup = "logistic-warehousing"
data.raw.recipe["warehouse-storage"].subgroup = "logistic-warehousing"
data.raw.recipe["warehouse-basic"].order = "b-a"
data.raw.recipe["warehouse-active-provider"].order = "a"
data.raw.recipe["warehouse-buffer"].order = "a"
data.raw.recipe["warehouse-passive-provider"].order = "a"
data.raw.recipe["warehouse-requester"].order = "a"
data.raw.recipe["warehouse-storage"].order = "a"
