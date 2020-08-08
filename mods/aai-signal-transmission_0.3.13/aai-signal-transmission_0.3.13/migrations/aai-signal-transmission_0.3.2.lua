for _, force_list in pairs(global.channels) do
    for index, pole in pairs(force_list) do
        if not pole.valid then
            force_list[index] = nil
        end
    end
end
