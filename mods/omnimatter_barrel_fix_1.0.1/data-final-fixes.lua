
require("barrel")
require("constants");

if mods["omnimatter"] then
    AddBarrelItemAndRecipesForList(kOmnimatterFluids)

    if mods["angelsrefining"] then
        AddBarrelItemAndRecipesForList(kOmnimatterAngelsRefiningFluids)
    end
end

if mods["omnimatter_crystal"] then
    AddBarrelItemAndRecipesForList(kOmnimatterCrystalsFluids)

    -- Collect all fluid names that end in "-omnide-solution".
    local search_string = "-omnide-solution"
    function GetOmnideSolutionFluids()
        local solution_names = {}
        for _, fluid in pairs(data.raw.fluid) do
            if fluid.name:sub(-#search_string) == search_string then
                table.insert(solution_names, fluid.name)
            end
        end
        return solution_names
    end
    AddBarrelItemAndRecipesForList(GetOmnideSolutionFluids())
end
