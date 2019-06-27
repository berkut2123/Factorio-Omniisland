data:extend({
  {
    type = "recipe",
    name = "fusion-reactor-equipment-mk2",
	normal =
    {
      enabled = "false",
	  ingredients = {{"fusion-reactor-equipment", 2}, {"effectivity-module", 5}},
      result = "fusion-reactor-equipment-mk2",
    },
    expensive =
    {
      enabled = "false",
	  ingredients = {{"fusion-reactor-equipment", 2}, {"effectivity-module", 5}},
      result = "fusion-reactor-equipment-mk2",
    }
  },
  {
    type = "recipe",
    name = "fusion-reactor-equipment-mk3",
	normal =
    {
      enabled = "false",
	  ingredients = {{"fusion-reactor-equipment-mk2", 1}, {"productivity-module-2", 5}},
      result = "fusion-reactor-equipment-mk3",
    },
    expensive =
    {
      enabled = "false",
	  ingredients = {{"fusion-reactor-equipment-mk2", 1}, {"productivity-module-2", 5}},
      result = "fusion-reactor-equipment-mk3",
    }
  },
  {
    type = "recipe",
    name = "fusion-reactor-equipment-mk4",
	normal =
    {
      enabled = "false",
	  ingredients = {{"fusion-reactor-equipment-mk3", 1}, {"speed-module-3", 5}},
      result = "fusion-reactor-equipment-mk4",
    },
    expensive =
    {
      enabled = "false",
	  ingredients = {{"fusion-reactor-equipment-mk3", 1}, {"speed-module-3", 5}},
      result = "fusion-reactor-equipment-mk4",
    }
  },
  {
    type = "recipe",
    name = "fusion-reactor-equipment-mk5",
	normal =
    {
      enabled = "false",
	  ingredients = {{"fusion-reactor-equipment-mk4", 1}, {"speed-module-3", 3}, {"productivity-module-3", 3}, {"effectivity-module", 3}},
      result = "fusion-reactor-equipment-mk5",
    },
    expensive =
    {
      enabled = "false",
	  ingredients = {{"fusion-reactor-equipment-mk4", 1}, {"speed-module-3", 3}, {"productivity-module-3", 3}, {"effectivity-module", 3}},
      result = "fusion-reactor-equipment-mk5",
    }
  },
  {
    type = "recipe",
    name = "fusion-reactor-equipment-mk6",
	normal =
    {
      enabled = "false",
	  ingredients = {{"fusion-reactor-equipment-mk5", 1}, {"speed-module-3", 5}, {"productivity-module-3", 5}, {"effectivity-module", 5}},
      result = "fusion-reactor-equipment-mk6",
    },
    expensive =
    {
      enabled = "false",
	  ingredients = {{"fusion-reactor-equipment-mk5", 1}, {"speed-module-3", 10}, {"productivity-module-3", 10}, {"effectivity-module", 10}},
      result = "fusion-reactor-equipment-mk6",
    }
  },
  })