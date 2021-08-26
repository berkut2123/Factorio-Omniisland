local data_util = require("data-util")

-- make all walls more more durable
for _, wall in pairs(data.raw.wall) do
    wall.resistances = wall.resistances or {}

    local resistance_updated = false
    for _, resistance in ipairs(wall.resistances) do
        if resistance.type == "impact" then
            resistance_updated = true
            resistance.percent = 100 - ((100 - (resistance.percent or 0)) / 2)
            resistance.decrease = (resistance.decrease or 0) + 100
        end
    end
    if not resistance_updated then
        table.insert(wall.resistances, { type = "impact", percent = 50, decrease=100 })
    end
end
