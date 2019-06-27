local mod_name = '__ShowUnconnected__'

local name = 'no-energy'


data:extend ({
  {
    type = "simple-entity",
    name = name,
    icon = mod_name.."/icon/"..name..".png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    subgroup = "wrecks",
    order = "n-c",
    max_health = 1,
    collision_mask = {},
    collision_box = {{-.5, -.5}, {.5, .5}},
    selection_box = {{-.5, -.5}, {.5, .5}},
    render_layer = "object",   
    picture =
      {
        filename = mod_name.."/entity/"..name..".png",
        width = 64,
        height= 64
      }
  }

})