--------------------------------------------------------------------------------
-- Reinforced gate                                                            --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "recipe",
    name = "reinforced-gate",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"gate"      , 2},
      {"concrete"  , 10},
      {"iron-stick", 10},
    },
    result = "reinforced-gate",
    requester_paste_multiplier = 10
  },
}
