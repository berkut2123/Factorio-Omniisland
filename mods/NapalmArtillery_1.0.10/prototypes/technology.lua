data:extend({
   {
      type = "technology",
      name = "napalm-artillery-shell-tech",
      icon = "__NapalmArtillery__/graphics/tech-napalm-shell.png",
      icon_size = 256,
      icon_mipmaps = 4,
      effects =
      {
         {
            type = "unlock-recipe",
            recipe = "napalm-artillery-shell"
         },
      },
      prerequisites = {"artillery"},
      unit =
      {
         count = 700,
         ingredients =
         {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 2},
            {"utility-science-pack",1},
            {"space-science-pack",1}
         },
         time = 20
      },
      order = "e-k-d",
      enabled="true",
   }
})