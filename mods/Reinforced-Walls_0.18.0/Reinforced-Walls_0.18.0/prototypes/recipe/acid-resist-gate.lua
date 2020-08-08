--------------------------------------------------------------------------------
-- Acid resist gate                                                           --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "recipe",
    name = "acid-resist-gate",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"reinforced-gate", 1 },
      {"plastic-bar"    , 10},
    },
    result = "acid-resist-gate",
    requester_paste_multiplier = 10
  },
}
