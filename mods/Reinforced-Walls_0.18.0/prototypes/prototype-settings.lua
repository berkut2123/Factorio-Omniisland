local prototypeSettings = {}



--------------------------------------------------------------------------------
-- Reinforced                                                                 --
--------------------------------------------------------------------------------
prototypeSettings["reinforced-wall"] =
{
  ["wall-tint"] =
  {
    r = 150/255,
    g = 150/255,
    b = 200/255,
    a = 255/255,
  },

  ["resistance-modifiers"] =
  {
    ["health"               ] = 2                           ,
    ["repair_speed_modifier"] = nil                         ,

    ["physical"             ] = {decrease = 0, percent = 20},
    ["impact"               ] = nil                         ,
    ["explosion"            ] = nil                         ,
    ["fire"                 ] = nil                         ,
    ["acid"                 ] = nil                         ,
    ["laser"                ] = nil                         ,

    ["attack_reaction"      ] = nil                         ,
  },
}
prototypeSettings["reinforced-gate"] = util.table.deepcopy(prototypeSettings["reinforced-wall"])



--------------------------------------------------------------------------------
-- Acid resist                                                                --
--------------------------------------------------------------------------------
prototypeSettings["acid-resist-wall"] =
{
  ["wall-tint"] =
  {
    r = 200/255,
    g = 200/255,
    b = 150/255,
    a = 255/255,
  },

  ["resistance-modifiers"] =
  {
    ["health"               ] = 2                           ,
    ["repair_speed_modifier"] = nil                         ,

    ["physical"             ] = {decrease = 0, percent = 30},
    ["impact"               ] = nil                         ,
    ["explosion"            ] = nil                         ,
    ["fire"                 ] = nil                         ,
    ["acid"                 ] = {decrease = 0, percent = 60},
    ["laser"                ] = nil                         ,

    ["attack_reaction"      ] = nil                         ,
  },
}
prototypeSettings["acid-resist-gate"] = util.table.deepcopy(prototypeSettings["acid-resist-wall"])



--------------------------------------------------------------------------------
-- Damage reflect                                                             --
--------------------------------------------------------------------------------
prototypeSettings["damage-reflect-wall"] =
{
  ["wall-tint"] =
  {
    r = 200/255,
    g = 150/255,
    b = 150/255,
    a = 255/255,
  },

  ["resistance-modifiers"] =
  {
    ["health"               ] = 2                           ,
    ["repair_speed_modifier"] = nil                         ,

    ["physical"             ] = {decrease = 0, percent = 30},
    ["impact"               ] = nil                         ,
    ["explosion"            ] = nil                         ,
    ["fire"                 ] = nil                         ,
    ["acid"                 ] = {decrease = 0, percent = 60},
    ["laser"                ] = nil                         ,

    ["attack_reaction"      ] = {
                                  {
                                    range = 2,
                                    --damage_type = "laser",
                                    reaction_modifier = 0.1,
                                    action =
                                    {
                                      type = "direct",
                                      action_delivery =
                                      {
                                        type = "instant",
                                        target_effects =
                                        {
                                          type = "damage",
                                          damage = { amount = 0.5, type = "laser" },
                                        },
                                      },
                                    },
                                  },
                                },
  },
}
prototypeSettings["damage-reflect-gate"] = util.table.deepcopy(prototypeSettings["damage-reflect-wall"])



return prototypeSettings
