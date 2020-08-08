--------------------------------------------------------------------------------
-- Damage reflect gate                                                        --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "recipe",
    name = "damage-reflect-gate",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
       {"acid-resist-gate", 1},
       {"defender-capsule", 2},
    },
    result = "damage-reflect-gate",
    requester_paste_multiplier = 10
  },
}
