local tile_layer_correction = {}

-- shift every tile layer with a layer that is greater or equal to "base_layer" by "offset"
function tile_layer_correction.shift_tile_layer(base_layer, offset)
    for k,tileset in pairs(data.raw["tile"]) do
        if tileset.shift_layer_if_asphald_roads_is_present ~= false and tileset.layer >= base_layer then 
            data.raw["tile"][tileset.name].layer = tileset.layer + offset
        end
    end
end

return tile_layer_correction
