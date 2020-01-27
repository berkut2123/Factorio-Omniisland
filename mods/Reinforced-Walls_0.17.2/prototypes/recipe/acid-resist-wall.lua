--------------------------------------------------------------------------------
-- Acid resist wall                                                           --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "recipe",
    name = "acid-resist-wall",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"reinforced-wall", 1},
      {"plastic-bar"    , 5},
    },
    result = "acid-resist-wall",
    requester_paste_multiplier = 10
  },
}
