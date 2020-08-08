require("prototypes.entity")
require("prototypes.item")
require("prototypes.recipe")
require("prototypes.technology")
local util = require "util"
-- require("prototypes.FuelLoaderChest")

-- local startEnabled = settings.startup["ammo_loader_bypass_research"].value
-- data.raw.recipe["ammo-loader-chest"].enabled = startEnabled
-- data.raw.recipe["fuel-loader-chest"].enabled = startEnabled
-- data.raw.recipe["ammo-loader-storage-loader-chest"].enabled = startEnabled
-- data.raw.recipe["logistic-requester-loader-chest"].enabled = false

local chest = table.deepcopy(data.raw["container"]["ammo-loader-chest"])
chest.icon = "__ammo-loader__/graphics/icon/chest.png" -- иконка
chest.icon_size = 64 -- размер иконки
chest.picture = {
    -- графика
    layers = {
        {
            filename = "__ammo-loader__/graphics/entity/ammo_albedo.png",
            priority = "extra-high",
            width = 150,
            height = 150,
            shift = util.by_pixel(0, -4),
            scale = 0.4
        },
        {
            filename = "__ammo-loader__/graphics/entity/ammo_shadow.png",
            priority = "extra-high",
            width = 150,
            height = 150,
            shift = util.by_pixel(13, -2),
            scale = 0.4,
            draw_as_shadow = true
        },
        {
            filename = "__ammo-loader__/graphics/entity/ammo_ao.png",
            width = 150,
            height = 150,
            shift = util.by_pixel(0, -4),
            scale = 0.4
        }
    }
}
data:extend({chest})

local chestIt = table.deepcopy(data.raw["item"]["ammo-loader-chest"])
chestIt.icon = "__ammo-loader__/graphics/icon/chest.png" -- иконка
chestIt.icon_size = 64 -- размер иконки
data:extend({chestIt})

data.raw["technology"]["ammo-loader-tech-loader-chest"].icon_size = 128
data.raw["technology"]["ammo-loader-tech-loader-chest"].icon = "__ammo-loader__/graphics/icon/technology.png"

--========================СУНДУК ЗАПРОСА=========================--

local chestreq = table.deepcopy(data.raw["logistic-container"]["ammo-loader-chest-requester"])
chestreq.icon = "__ammo-loader__/graphics/icon/chest_b.png" -- иконка
chestreq.icon_size = 64 -- размер иконки
chestreq.animation = {
    -- графика
    layers = {
        {
            filename = "__ammo-loader__/graphics/entity/ammo_albedo_b.png",
            priority = "extra-high",
            width = 150,
            height = 150,
            shift = util.by_pixel(0, -4),
            scale = 0.4
        },
        {
            filename = "__ammo-loader__/graphics/entity/ammo_shadow.png",
            priority = "extra-high",
            width = 150,
            height = 150,
            shift = util.by_pixel(13, -2),
            scale = 0.4,
            draw_as_shadow = true
        },
        {
            filename = "__ammo-loader__/graphics/entity/ammo_ao.png",
            width = 150,
            height = 150,
            shift = util.by_pixel(0, -4),
            scale = 0.4
        }
    }
}
data:extend({chestreq})

local chestreqIt = table.deepcopy(data.raw["item"]["ammo-loader-chest-requester"])
chestreqIt.icon = "__ammo-loader__/graphics/icon/chest_b.png" -- иконка
chestreqIt.icon_size = 64 -- размер иконки
data:extend({chestreqIt})

data.raw["technology"]["ammo-loader-tech-requester-chest"].icon_size = 128
data.raw["technology"]["ammo-loader-tech-requester-chest"].icon = "__ammo-loader__/graphics/icon/technology.png"

--========================СУНДУК ХРАНЕНИЯ=========================--

local cheststor = table.deepcopy(data.raw["logistic-container"]["ammo-loader-chest-storage"])
cheststor.icon = "__ammo-loader__/graphics/icon/chest_y.png" -- иконка
cheststor.icon_size = 64 -- размер иконки
cheststor.animation = {
    -- графика
    layers = {
        {
            filename = "__ammo-loader__/graphics/entity/ammo_albedo_y.png",
            priority = "extra-high",
            width = 150,
            height = 150,
            shift = util.by_pixel(0, -4),
            scale = 0.4
        },
        {
            filename = "__ammo-loader__/graphics/entity/ammo_shadow.png",
            priority = "extra-high",
            width = 150,
            height = 150,
            shift = util.by_pixel(13, -2),
            scale = 0.4,
            draw_as_shadow = true
        },
        {
            filename = "__ammo-loader__/graphics/entity/ammo_ao.png",
            width = 150,
            height = 150,
            shift = util.by_pixel(0, -4),
            scale = 0.4
        }
    }
}
data:extend({cheststor})

local cheststorIt = table.deepcopy(data.raw["item"]["ammo-loader-chest-storage"])
cheststorIt.icon = "__ammo-loader__/graphics/icon/chest_y.png" -- иконка
cheststorIt.icon_size = 64 -- размер иконки
data:extend({cheststorIt})

data.raw["technology"]["ammo-loader-tech-requester-chest"].icon_size = 128
data.raw["technology"]["ammo-loader-tech-requester-chest"].icon = "__ammo-loader__/graphics/icon/technology.png"

--========================СУНДУК ПАССИВНОГО СНАБЖЕНИЯ=========================--

local chestpassiv = table.deepcopy(data.raw["logistic-container"]["ammo-loader-chest-passive-provider"])
chestpassiv.icon = "__ammo-loader__/graphics/icon/chest_r.png" -- иконка
chestpassiv.icon_size = 64 -- размер иконки
chestpassiv.animation = {
    -- графика
    layers = {
        {
            filename = "__ammo-loader__/graphics/entity/ammo_albedo_r.png",
            priority = "extra-high",
            width = 150,
            height = 150,
            shift = util.by_pixel(0, -4),
            scale = 0.4
        },
        {
            filename = "__ammo-loader__/graphics/entity/ammo_shadow.png",
            priority = "extra-high",
            width = 150,
            height = 150,
            shift = util.by_pixel(13, -2),
            scale = 0.4,
            draw_as_shadow = true
        },
        {
            filename = "__ammo-loader__/graphics/entity/ammo_ao.png",
            width = 150,
            height = 150,
            shift = util.by_pixel(0, -4),
            scale = 0.4
        }
    }
}
data:extend({chestpassiv})

local chestpassivIt = table.deepcopy(data.raw["item"]["ammo-loader-chest-passive-provider"])
chestpassivIt.icon = "__ammo-loader__/graphics/icon/chest_r.png" -- иконка
chestpassivIt.icon_size = 64 -- размер иконки
data:extend({chestpassivIt})

--========================ТЕХНОЛОГИИ=========================--
--НА НИХ МОЖНО ВООБЩЕ ОДНУ КАРТИНКУ
--ЗАПРАВКА ТРАНСПОРТА
data.raw["technology"]["ammo-loader-tech-vehicles"].icon_size = 128
data.raw["technology"]["ammo-loader-tech-vehicles"].icon = "__ammo-loader__/graphics/icon/technology.png"
--ЗАПРАВКА ТОПЛИВОМ
data.raw["technology"]["ammo-loader-tech-burners"].icon_size = 128
data.raw["technology"]["ammo-loader-tech-burners"].icon = "__ammo-loader__/graphics/icon/technology.png"
--ЗАРЯДКА АРТИЛЕРИЙ
data.raw["technology"]["ammo-loader-tech-artillery"].icon_size = 128
data.raw["technology"]["ammo-loader-tech-artillery"].icon = "__ammo-loader__/graphics/icon/technology.png"
--КАКОЕ - ТО ОБНОВЛЕНИЕ
data.raw["technology"]["ammo-loader-tech-upgrade"].icon_size = 128
data.raw["technology"]["ammo-loader-tech-upgrade"].icon = "__ammo-loader__/graphics/icon/technology.png"
--ВОЗВРАТ ПРЕДМЕТОВ
data.raw["technology"]["ammo-loader-tech-return-items"].icon_size = 128
data.raw["technology"]["ammo-loader-tech-return-items"].icon = "__ammo-loader__/graphics/icon/technology.png"
