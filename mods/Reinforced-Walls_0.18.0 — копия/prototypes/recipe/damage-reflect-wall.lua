--------------------------------------------------------------------------------
-- Damage reflect wall                                                        --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "recipe",
    name = "damage-reflect-wall",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
       {"acid-resist-wall", 1},
       {"defender-capsule", 1},
    },
    result = "damage-reflect-wall",
    requester_paste_multiplier = 10
  },
}
