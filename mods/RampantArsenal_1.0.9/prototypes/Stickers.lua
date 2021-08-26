local stickers = {}

local stickerUtils = require("utils/StickerUtils")

local makeSticker = stickerUtils.makeSticker

function stickers.enable()

    makeSticker(
        {
            name = "small-toxic",
            duration = 120,
            spreadRadius = 5,
            tint = {r=0.5,g=0,b=0.5,a=0.8},
            movementModifier = 0.95,
            damagePerTick = { type = "poison", amount = 15 }
        }
    )

    makeSticker(
        {
            name = "bullet-toxic",
            duration = 80,
            spreadRadius = 5,
            tint = {r=0.5,g=0,b=0.5,a=0.8},
            movementModifier = 0.95,
            damagePerTick = { type = "poison", amount = 5 }
        }
    )


    makeSticker(
        {
            name = "small-fire",
            duration = 120,
            spreadRadius = 5,
            movementModifier = 1,
            damagePerTick = { type = "fire", amount = 4 }
        }
    )


    makeSticker(
        {
            name = "toxic",
            duration = 240,
            spreadRadius = 5,
            tint = {r=0.5,g=0,b=0.5,a=0.8},
            movementModifier = 0.92,
            damagePerTick = { type = "poison", amount = 17 }
        }
    )

    makeSticker(
        {
            name = "paralysis",
            duration = 60,
            spreadRadius = 0,
            tint = {r=0,g=0,b=0.8,a=0.8},
            movementModifier = 0
        }
    )

    makeSticker(
        {
            name = "bullet-slow",
            duration = 180,
            spreadRadius = 0,
            tint = {r=0,g=0.8,b=0.8,a=0.8},
            movementModifier = 0.85
        }
    )

    makeSticker(
        {
            name = "lite-slow",
            duration = 180,
            spreadRadius = 0,
            tint = {r=0,g=0.8,b=0.8,a=0.8},
            movementModifier = 0.7
        }
    )

    makeSticker(
        {
            name = "big-paralysis",
            duration = 50,
            spreadRadius = 0,
            tint = {r=0,g=0,b=0.8,a=0.8},
            movementModifier = 0
        }
    )

    makeSticker(
        {
            name = "big-toxic",
            duration = 360,
            spreadRadius = 5,
            tint = {r=0.5,g=0,b=0.5,a=0.8},
            movementModifier = 0.87,
            damagePerTick = { type = "poison", amount = 20 }
        }
    )

    makeSticker({
            name = "speed-boost",
            duration = 60 * 60 * 1,
            movementModifier = 1.4,
            tint = {r=0,g=0.6,b=0.6,a=0.8},
            spreadRadius = 0
    })

end

return stickers
