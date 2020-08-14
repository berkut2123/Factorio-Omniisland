require("prototypes.items")
require("prototypes.recipes")
require("prototypes.technology")


if settings.startup["nuclear-fuel-geiger-tick"].value then
  data.raw["reactor"]["nuclear-reactor"].working_sound =
  {
    sound =
    {
      {
        filename = "__Nuclear Fuel__/sound/reactor-active.ogg",
        volume = 0.8
      }
    }
  }
end