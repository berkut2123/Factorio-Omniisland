local waves = {}

--[[
VALID SPAWNS
spawn-west
spawn-east
spawn-north
spawn-south

VALID TARGETS
iron-production-targets
crash-packup-targets
pond-iron-targets
pond-copper-targets
pond-stone-targets
iron-south-targets
copper-south-targets
coal-north-targets
iron-north-targets
second-base-area

VALID RALLY POINTS
north-west-canyon-rally
south-west-canyon-rally
south-east-canyon-rally
north-east-canyon-rally
north-crash-rally
south-crash-rally
south-shallows-rally
canyon-middle-rally

]]

waves['demo'] = {
  name = 'demo',
  --costs can be an integer or a table. If a table is provided then the modifiers are checked.
  --1 is roughly 100% of factory production
  --1.2 is is ok for very slow increase in stockpiled ammo
  --2.5 is easy for a me(abregado) to stabilize
  -- values higher than 20 are useful to keep a steady attack, which will only defeat completely empty turret lines
  cost = {
    minimum = 100,
    maximum = 200,
    },
  -- Each modifier is calculated and returns a number between 0 and 1. The average of all modifiers is used to determine the
  -- actual cost.
  modifiers = {
    {
      name = 'ten_minutes',
      weight = 1
    },
  },
  wave = 1,
  vector = {
    {
      spawn = {'spawn-west'},
      rally = {'north-crash-rally'},--rally points must be valid ScriptPosition names
      target = {'crash-packup-targets'},--targets must be a valid ScriptArea names
      target_types = {'burner-mining-drill','stone-furnace','gun-turret'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=1,min=1,max=50},
      }
    }
  }
}

waves['packup'] = {
  name = 'packup',
  cost = {
    minimum = 5,
    maximum = 40,
  },
  modifiers = {
    {
      name = "ten_minutes",
      weight = 1
    },
  },
  wave = 5,
  vector = {
    {
      spawn = {'spawn-west'},
      rally = {'north-crash-rally'},
      target = {'starting-area'},
      target_types = {'burner-mining-drill','stone-furnace','burner-inserter','small-electric-pole','assembling-machine-1'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=1,min=5,max=5},
      }
    }
  }
}

waves['pistol'] = {
  name = 'pistol',
  cost = {
    minimum = 83,
    maximum = 200
    },
  modifiers = {
    {
      name = "ten_minutes",
      weight = 1
    },
  },
  wave = 1,
  vector = {
    {
      spawn = {'spawn-west'},
      rally = {'canyon-middle-rally'},
      target = {'pond-iron-targets'},
      target_types = {'burner-mining-drill','electric-mining-drill','stone-furnace','small-electric-pole'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=1,min=1,max=50},
      }
    }
  }
}

waves['one-turret-one-vector'] = {
  name = 'one-turret-one-vector',
  cost = {
    minimum = 2.5,
    maximum = 5
  },
  modifiers = {
    {
      name = 'ten_minutes',
      weight = 1
    },
  },
  wave = {
    minimum = 2,
    maximum = 15,
  },
  vector = {
    {
      spawn = {'spawn-west'},
      rally = {'canyon-middle-rally'},
      target = {'pond-iron-targets'},
      target_types = {'electric-mining-drill','burner-mining-drill','stone-furnace'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=1,min=1,max=50},
      }
    },
    {
      spawn = {'spawn-west'},
      rally = {'canyon-middle-rally'},
      target = {'pond-iron-targets'},
      target_types = {'gun-turret'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=1,min=1,max=50},
      }
    },
  }
}

waves['fortify-1'] = {
  name = 'fortify',
  cost = {
    minimum = 5,
    maximum = 83
  },
  modifiers = {
    {
      name = 'ten_minutes',
      weight = 1
    },
  },
  wave = {
    minimum = 3,
    maximum = 8
    },
  vector = {
    {
      spawn = {'spawn-west'},
      rally = {'canyon-middle-rally'},
      target = {'pond-iron-targets','pond-stone-targets'},
      target_types = {'burner-mining-drill','electric-mining-drill','stone-furnace','small-electric-pole'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=1,min=1,max=24},
      }
    }
  }
}

waves['fortify-2'] = table.deepcopy(waves['fortify-1'])
waves['fortify-2'].wave = {minimum = 9,maximum = 13}
waves['fortify-3'] = table.deepcopy(waves['fortify-1'])
waves['fortify-3'].wave = {minimum = 13,maximum = 20}
waves['fortify-4'] = table.deepcopy(waves['fortify-1'])
waves['fortify-4'].wave = 24

waves['survive'] = {
  name = 'survive',
  cost = {
    minimum = 1.1,
    maximum = 2.5,
  },
  modifiers = {
    {
      name = "get_final_research_progress",
      weight = 1
    },
  },
  wave = {
    minimum = 7,
    maximum = 38
    },
  vector = {
    {
      spawn = {'spawn-west'},
      rally = {'canyon-middle-rally'},
      target = {'pond-iron-targets','pond-stone-targets'},
      target_types = {'gun-turret','burner-mining-drill','stone-furnace','electric-mining-drill'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=0.5,min=1,max=50},
      }
    },
    {
      spawn = {'spawn-west'},
      rally = {'north-crash-rally'},
      target = {'defend-1'},
      target_types = {'gun-turret'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=0.5,min=1,max=50},
      }
    },
    {
      spawn = {'spawn-east'},
      rally = {'south-east-canyon-rally','north-east-canyon-rally',nil},
      target = {'defend-2'},
      target_types = {'gun-turret'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=0.5,min=1,max=10},
      }
    },
    {
      spawn = {'spawn-east'},
      rally = {'south-east-canyon-rally','north-east-canyon-rally',nil},
      target = {'pond-copper-targets','pond-stone-targets'},
      target_types = {'burner-mining-drill','stone-furnace','electric-mining-drill','small-electric-pole'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=0.5,min=1,max=10},
      }
    },
    {
      spawn = {'spawn-north'},
      rally = {'north-east-canyon-rally','north-west-canyon-rally'},
      target = {'second-base-area'},
      target_types = {'burner-mining-drill','stone-furnace','electric-mining-drill','small-electric-pole'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=0.5,min=1,max=10},
      }
    },
  }
}

waves['survive-1'] = table.deepcopy(waves['survive'])
waves['survive-1'].wave = {minimum = 3,maximum = 9}

waves['survive-2'] = table.deepcopy(waves['survive'])
waves['survive-2'].wave = {minimum = 9,maximum = 15}

waves['survive-3'] = table.deepcopy(waves['survive'])
waves['survive-3'].wave = {minimum = 15,maximum = 22}

waves['survive-4'] = table.deepcopy(waves['survive'])
waves['survive-4'].wave = {minimum = 22,maximum = 38}

table.remove(waves['survive'].vector,3)
table.remove(waves['survive'].vector,4)
table.remove(waves['survive'].vector,5)



waves['freeplay'] = {
  name = 'freeplay',
  cost = 7,
  wave = {
    minimum = 3,
    maximum = 15,
  },
  vector = {
    {
      spawn = {'spawn-west'},
      rally = {'canyon-middle-rally'},
      target = {'pond-iron-targets','pond-stone-targets'},
      target_types = {'gun-turret','burner-mining-drill','stone-furnace','electric-mining-drill'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=1,min=1,max=50},
      }
    },
    {
      spawn = {'spawn-west'},
      rally = {'north-crash-rally'},
      target = {'defend-1'},
      target_types = {'gun-turret'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=1,min=1,max=50},
      }
    },
    {
      spawn = {'spawn-east'},
      rally = {'south-east-canyon-rally','north-east-canyon-rally',nil},
      target = {'defend-2'},
      target_types = {'gun-turret'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=1,min=1,max=50},
      }
    },
    {
      spawn = {'spawn-east'},
      rally = {'south-east-canyon-rally','north-east-canyon-rally',nil},
      target = {'pond-copper-targets','pond-stone-targets'},
      target_types = {'burner-mining-drill','stone-furnace','electric-mining-drill','small-electric-pole'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=1,min=1,max=50},
      }
    },
    {
      spawn = {'spawn-north'},
      rally = {'north-east-canyon-rally','north-west-canyon-rally'},
      target = {'second-base-area'},
      target_types = {'burner-mining-drill','stone-furnace','electric-mining-drill','small-electric-pole'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=1,min=1,max=50},
      }
    },
    {
      spawn = {'spawn-south'},
      rally = {'south-east-canyon-rally','south-west-canyon-rally'},
      target = {'second-base-area'},
      target_types = {'burner-mining-drill','stone-furnace','electric-mining-drill','small-electric-pole'},
      mission = 'attack',
      allowed_biter_types = {
        {name='small-biter',modifier=1,min=1,max=50},
      }
    },
  }
}

return waves
