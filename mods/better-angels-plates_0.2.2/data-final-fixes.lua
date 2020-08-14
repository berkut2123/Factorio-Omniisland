-- if data.raw.item["copper-plate"] then
--     data.raw.item["copper-plate"].icon = nil;
--     data.raw.item["copper-plate"].icon_size = nil;
--     data.raw.item["copper-plate"].icon_mipmaps = nil;
--     data.raw.item["copper-plate"].pictures = nil;
--     data.raw.item["copper-plate"].icons = {
--         {icon = "__better-angels-plates__/graphics/plate-copper.png",
--          icon_size = 64, icon_mipmaps = 4}
--     }
-- end

local items = {
    {"copper-plate", "plate-copper"},
    {"iron-plate", "plate-iron"},
    {"steel-plate", "plate-steel"},
    {"aluminium-plate", "plate-aluminium"},
    {"titanium-plate", "plate-titanium"},
    {"tin-plate", "plate-tin"},
    {"tungsten-plate", "plate-tungsten"},
    {"zinc-plate", "plate-zinc"},
    {"lead-plate", "plate-lead"},
    {"nickel-plate", "plate-nickel"},
    {"invar-alloy", "plate-invar"},
    {"cobalt-steel-alloy", "plate-cobalt-steel"},
    {"nitinol-alloy", "plate-nitinol"}
}

for _, item in pairs(items) do
    if data.raw.item[item[1]] then
        data.raw.item[item[1]].icon = nil;
        data.raw.item[item[1]].icon_size = nil;
        data.raw.item[item[1]].icon_mipmaps = nil;
        data.raw.item[item[1]].pictures = nil;
        data.raw.item[item[1]].icons = {
            {icon = "__better-angels-plates__/graphics/"..item[2]..".png",
             icon_size = 64, icon_mipmaps = 4}
        }
    end
end