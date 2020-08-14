--------------------------------------------------------------------------------
-- Reinforced wall                                                            --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "recipe",
    name = "reinforced-wall",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"stone-wall", 2},
      {"concrete"  , 5},
      {"iron-stick", 5},
    },
    result = "reinforced-wall",
    requester_paste_multiplier = 10
  },
}
