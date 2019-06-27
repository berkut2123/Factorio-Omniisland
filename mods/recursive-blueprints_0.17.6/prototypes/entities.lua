local deployer = table.deepcopy(data.raw["container"]["steel-chest"])
deployer.name = "blueprint-deployer"
deployer.icon = "__recursive-blueprints__/graphics/blueprint-deployer-icon.png"
deployer.icon_size = 32
deployer.icons = nil
deployer.minable.result = "blueprint-deployer"
deployer.inventory_size = 1
deployer.picture.layers = {
  {
    filename = "__recursive-blueprints__/graphics/blueprint-deployer.png",
    priority = "extra-high",
    width = 32,
    height = 36,
    shift = util.by_pixel(0, -2),
    hr_version = {
      filename = "__recursive-blueprints__/graphics/hr-blueprint-deployer.png",
      priority = "extra-high",
      width = 66,
      height = 72,
      shift = util.by_pixel(0, -2.5),
      scale = 0.5,
    }
  },
  {
    filename = "__base__/graphics/entity/roboport/roboport-base-animation.png",
    width = 42,
    height = 31,
    hr_version = {
        filename = "__base__/graphics/entity/roboport/hr-roboport-base-animation.png",
        width = 83,
        height = 59,
        priority = "medium",
        scale = 0.5,
        shift = util.by_pixel(0.25, -17),
    },
    priority = "medium",
    shift = util.by_pixel(0, -17.5),
  },
  {
    filename = "__base__/graphics/entity/logistic-chest/logistic-chest-shadow.png",
    priority = "extra-high",
    width = 48,
    height = 24,
    shift = util.by_pixel(8.5, 5.5),
    draw_as_shadow = true,
    hr_version =
    {
      filename = "__base__/graphics/entity/logistic-chest/hr-logistic-chest-shadow.png",
      priority = "extra-high",
      width = 96,
      height = 44,
      repeat_count = 7,
      shift = util.by_pixel(8.5, 5),
      draw_as_shadow = true,
      scale = 0.5
    }
  }
}
data:extend{deployer}
