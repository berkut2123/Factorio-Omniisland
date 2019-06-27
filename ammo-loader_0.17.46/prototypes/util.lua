local util = {}

function util.deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == "table" then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[util.deepcopy(orig_key)] = util.deepcopy(orig_value)
        end
        setmetatable(copy, util.deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
function util.writeToObj(obj, args)
    for key, value in pairs(args) do
        if (type(value) == "table") then
            local objVal = obj[key]
            if (not objVal) then
                obj[key] = value
            else -- and (type(value) == "table") then
                util.writeToObj(obj[key], value)
            end
        else
            obj[key] = value
        end
    end
    return obj
end

function util.modifiedEnt(entObj, args, overwrite)
    local newObj = util.deepcopy(entObj)
    util.writeToObj(newObj, args)
    if (overwrite) then
        for key, val in pairs(overwrite) do
            newObj[key] = val
        end
    end
    return newObj
end

util.filePath = function(name, type)
    local base = "__ammo-loader__/graphics/"
    local newBase = base .. type .. "/"
    local path = newBase .. name .. ".png"
    return path
end

-- util.invisIcon = "__ammo-loader__/graphics/empty.png"
-- util.invisPic = {
--     filename = "__ammo-loader__/graphics/empty.png",
--     priority = "low",
--     width = 1,
--     height = 1,
--     hr_version = {
--         filename = "__ammo-loader__/graphics/empty.png",
--         priority = "low",
--         width = 1,
--         height = 1,
--         scale = 0.25
--     }
-- }
util.invisPic = {
    filename = "__core__/graphics/empty.png",
    priority = "very-low",
    width = 1,
    height = 1,
    frame_count = 1,
    shift = {0, 0},
    hr_version = {
        filename = "__core__/graphics/empty.png",
        priority = "very-low",
        width = 1,
        height = 1,
        frame_count = 1,
        shift = {0, 0},
        scale = 0.0
    }
}
util.invisIcon = "__core__/graphics/empty.png"

return util
