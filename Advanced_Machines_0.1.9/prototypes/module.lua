data:extend({
  
  --Speed
  {
    type = "module",
    name = "speed-module-4",
    icon = "__Advanced_Machines__/graphics/icons/modules/speed-module-4.png",
	icon_size = 32,
    subgroup = "a-speed",
    category = "speed",
    tier = 4,
    order = "a[speed]-d[speed-module-4]",
    stack_size = 50,
    default_request_amount = 10,
    effect = { speed = {bonus = 0.75}, consumption = {bonus = 0.85}}
  },
  {
    type = "module",
    name = "speed-module-5",
    icon = "__Advanced_Machines__/graphics/icons/modules/speed-module-5.png",
	icon_size = 32,
    subgroup = "a-speed",
    category = "speed",
    tier = 4,
    order = "a[speed]-e[speed-module-5]",
    stack_size = 50,
    default_request_amount = 10,
    effect = { speed = {bonus = 1.0}, consumption = {bonus = 1.0}}
  },
  --Efficiency
  {
    type = "module",
    name = "effectivity-module-4",
    icon = "__Advanced_Machines__/graphics/icons/modules/effectivity-module-4.png",
	icon_size = 32,
    subgroup = "a-effectivity",
    category = "effectivity",
    tier = 4,
    order = "c[effectivity]-d[effectivity-module-4]",
    stack_size = 50,
    default_request_amount = 10,
    effect = { consumption = {bonus = -0.75}}
  },
  {
    type = "module",
    name = "effectivity-module-5",
    icon = "__Advanced_Machines__/graphics/icons/modules/effectivity-module-5.png",
	icon_size = 32,
    subgroup = "a-effectivity",
    category = "effectivity",
    tier = 5,
    order = "c[effectivity]-e[effectivity-module-5]",
    stack_size = 50,
    default_request_amount = 10,
    effect = { consumption = {bonus = -1.0}}
  },
  --Productivity
  {
    type = "module",
    name = "productivity-module-4",
    icon = "__Advanced_Machines__/graphics/icons/modules/productivity-module-4.png",
	icon_size = 32,
    subgroup = "a-productivity",
    category = "productivity",
    tier = 4,
    order = "c[productivity]-d[productivity-module-4]",
    stack_size = 50,
    default_request_amount = 10,
    effect = { productivity = {bonus = 0.15}, consumption = {bonus = 1.0}, pollution = {bonus = 0.125}, speed = {bonus = -0.15}},
    limitation = productivity_module_limitation(),
    limitation_message_key = "production-module-usable-only-on-intermediates"
  },
  {
    type = "module",
    name = "productivity-module-5",
    icon = "__Advanced_Machines__/graphics/icons/modules/productivity-module-5.png",
	icon_size = 32,
    subgroup = "a-productivity",
    category = "productivity",
    tier = 5,
    order = "c[productivity]-e[productivity-module-5]",
    stack_size = 50,
    default_request_amount = 10,
    effect = { productivity = {bonus = 0.25}, consumption = {bonus = 1.25}, pollution = {bonus = 0.15}, speed = {bonus = -0.15}},
	limitation = productivity_module_limitation(),
    limitation_message_key = "production-module-usable-only-on-intermediates"
  },
  --Pure Speed
  
  --Efficent Productivity
  
  --Fast Productivity
  
  --God
  
})
  data.raw.item["beacon"].subgroup = "a-beacon"
  data.raw.module["speed-module"].subgroup = "a-speed"
  data.raw.module["speed-module-2"].subgroup = "a-speed"
  data.raw.module["speed-module-3"].subgroup = "a-speed"
  data.raw.module["effectivity-module"].subgroup = "a-effectivity"
  data.raw.module["effectivity-module-2"].subgroup = "a-effectivity"
  data.raw.module["effectivity-module-3"].subgroup = "a-effectivity"
  data.raw.module["productivity-module"].subgroup = "a-productivity"
  data.raw.module["productivity-module-2"].subgroup = "a-productivity"
  data.raw.module["productivity-module-3"].subgroup = "a-productivity"