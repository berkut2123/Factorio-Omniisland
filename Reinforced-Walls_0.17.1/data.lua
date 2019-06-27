
for _,tierType in pairs{
  "stone"         , -- vanilla tier MUST be first
  "reinforced"    ,
  "acid-resist"   ,
  "damage-reflect",
} do

  for _,entityType in pairs{
    "wall"        , -- walls MUST be first
    "gate"        ,
  } do

    for _,protoType in pairs{
      "item"      , -- item MUST be before entity
      "entity"    ,
      "recipe"    ,
      "technology",
    } do

      require ("prototypes/" .. protoType .. "/" .. tierType .. "-" .. entityType)

    end
  end
end
