local data_util = require("data_util")

local characters = {"character", "character-jetpack"}
for _, character in pairs(characters) do
  table.insert(data.raw.character[character]["crafting_categories"], "hand-hard-recycling")

  data.raw.character[character].collision_box = {{-0.15, -0.15},{0.15,0.15}}
  data.raw.character[character].healing_per_tick = 0.001
end
