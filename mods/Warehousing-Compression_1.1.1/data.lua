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
