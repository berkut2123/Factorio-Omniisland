data:extend({
  {
    type = "bool-setting",
    name = "omnimatter-infinite",
    setting_type = "startup",
    default_value = false,
    order = "aa"
  },
  {
    type = "bool-setting",
    name = "omnimatter-infinite-omnic-acid",
    setting_type = "startup",
    default_value = true,
    order = "ab"
  },
  {
    type = "double-setting",
    name = "omnimatter-beginner-multiplier",
    setting_type = "startup",
    default_value = 1,
    maximum_value = 5,
    minimum_value = 0.20,
    per_user = false,
    order = "ac"
  },
  {
    type = "int-setting",
    name = "omnimatter-max-tier",
    setting_type = "startup",
    default_value = 5,
    maximum_value = 8,
    minimum_value = 3,
    per_user = false,
    order = "ad"
  },
  {
    type = "int-setting",
    name = "omnimatter-pure-lvl-per-tier",
    setting_type = "startup",
    default_value = 2,
    maximum_value = 6,
    minimum_value = 1,
    per_user = false,
    order = "ae"
  },
  {
    type = "int-setting",
    name = "omnimatter-impure-lvls",
    setting_type = "startup",
    default_value = 3,
    maximum_value = 6,
    minimum_value = 2,
    per_user = false,
    order = "af"
  },
  {
    type = "int-setting",
    name = "omnimatter-fluid-lvl",
    setting_type = "startup",
    default_value = 6,
    maximum_value = 10,
    minimum_value = 2,
    per_user = false,
    order = "ag"
  },
  {
    type = "int-setting",
    name = "omnimatter-fluid-lvl-per-tier",
    setting_type = "startup",
    default_value = 2,
    maximum_value = 3,
    minimum_value = 1,
    per_user = false,
    order = "ah"
  },
  {
    type = "double-setting",
    name = "omnimatter-pure-tech-tier-cost-increase",
    setting_type = "startup",
    default_value = 2,
    maximum_value = 5,
    minimum_value = 1.0,
    per_user = false,
    order = "ai"
  },
  {
    type = "double-setting",
    name = "omnimatter-pure-tech-level-cost-increase",
    setting_type = "startup",
    default_value = 0.3,
    maximum_value = 20,
    minimum_value = 0.0001,
    per_user = false,
    order = "aj"
  },
  {
    type = "bool-setting",
    name = "omnimatter-linear-science-packs",
    setting_type = "startup",
    default_value = false,
    per_user = false,
    order = "ak"
  },
  {
    type = "double-setting",
    name = "omnimatter-science-pack-constant",
    setting_type = "startup",
    default_value = 2,
    maximum_value = 10,
    minimum_value = 0.00,
    per_user = false,
    order = "al"
  },
  {
    type = "bool-setting",
    name = "omnimatter-rocket-locked",
    setting_type = "startup",
    default_value = true,
    per_user = false,
    order = "am"
  },
})