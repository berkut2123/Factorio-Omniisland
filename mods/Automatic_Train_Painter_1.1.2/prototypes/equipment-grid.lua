gridw = settings.startup["loc-eqpm-grid-w"].value
gridh = settings.startup["loc-eqpm-grid-h"].value

data:extend({
    {
        type = "equipment-category",
        name = "atp-eqcat"
    },
    {
        type = "equipment-grid",
        name = "atp-equipment-grid",
        width = gridw,
        height = gridh,
        equipment_categories = {"atp-eqcat"}
    },
})