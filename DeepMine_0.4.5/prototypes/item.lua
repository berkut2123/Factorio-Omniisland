data:extend({
  {
    type = "item",
    name = "deep-mine",
    icon = "__DeepMine__/graphics/icons/deep-mine.png",
    icon_size = 32,
    subgroup = "extraction-machine",
    order = "a[items]-m[deep-mine]",
    place_result = "deep-mine",
    stack_size = 20
  },
  {
    type = "item",
    name = "deep-mine-2",
    icon = "__DeepMine__/graphics/icons/deep-mine-2.png",
    icon_size = 32,
    subgroup = "extraction-machine",
    order = "a[items]-n[deep-mine-2]",
    place_result = "deep-mine-2",
    stack_size = 20
  },
  -- hidden productivity modules matching infinite mining productivity tech bonus size
  {
    type = "module",
    name = "deep-mine-prod-module",
    icon = "__core__/graphics/empty.png",
    icon_size = 1,
    flags = { "hidden" },
    subgroup = "module",
    category = "productivity",
    tier = 0,
    stack_size = 1,
    effect = { productivity = {bonus = 0.1}} -- productivity step size is 10% we use as many as actual force mining-bonus requires
  },
})