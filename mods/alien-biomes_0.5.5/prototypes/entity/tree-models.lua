local data_util = require("data-util")
local function index_to_letter(index, starting_at)
  return string.char(string.byte(starting_at or "a", 1) - 1 + index)
end

--[[
old variants:
01 oaktapus
02 greypine
03 ash
04 scarecrow
05 specter
06 willow
07 mangrove
08 pear
09 baobab

reflection prep:
all trunks base must line up
shrink by factor of 5
split right
]]--

local tree_types =
{
  { -- tree-01
    --addHere-tree01 -- "fir"
    type_name = "01",
    drawing_box = {{-0.9, -3}, {0.9, 0.6}},
    negate_tint = { r = 80, g = 77, b = 61 },
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__base__/graphics/entity/tree/01/tree-01-reflection.png",
          priority = "extra-high",
          width = 28,
          height = 40,
          shift = util.by_pixel(0, 70),
          y = 40 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = { -- tree-01
      { -- a
        trunk =
        {
          width = 73,
          height = 171,
          shift = util.by_pixel(0, -70),
          hr_version =
          {
            width = 140,
            height = 340,
            shift = util.by_pixel(2, -69),
            scale = 0.5
          }
        },
        stump =
        {
          width = 39,
          height = 35,
          shift = util.by_pixel(-2, -2),
          hr_version =
          {
            width = 76,
            height = 68,
            shift = util.by_pixel(-1, -1),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 163,
          height = 67,
          shift = util.by_pixel(60, -2),
          hr_version =
          {
            width = 324,
            height = 134,
            shift = util.by_pixel(61, -2),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 93,
          height = 151,
          shift = util.by_pixel(-2, -74),
          hr_version =
          {
            width = 184,
            height = 306,
            shift = util.by_pixel(-1, -74),
            scale = 0.5,
          }
        },
        normal =
        {
          width = 94,
          height = 146,
          shift = util.by_pixel(0, -76),
          hr_version =
          {
         width = 184,
         height = 290,
         shift = util.by_pixel(-0.5, -76),
            scale = 0.5
          }
        },
      },
      { -- b
        trunk =
        {
          width = 65,
          height = 165,
          shift = util.by_pixel(4, -68),
          hr_version =
          {
            width = 132,
            height = 326,
            shift = util.by_pixel(4, -66),
            scale = 0.5
          }
        },
        stump =
        {
          width = 39,
          height = 33,
          shift = util.by_pixel(-2, -2),
          hr_version =
          {
            width = 72,
            height = 66,
            shift = util.by_pixel(0, -1),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 159,
          height = 67,
          shift = util.by_pixel(62, -2),
          hr_version =
          {
            width = 312,
            height = 126,
            shift = util.by_pixel(64, 0),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 91,
          height = 157,
          shift = util.by_pixel(0, -72),
          hr_version =
          {
            width = 182,
            height = 316,
            shift = util.by_pixel(1, -72),
            scale = 0.5
          }
        },
       normal =
        {
          width = 90,
          height = 150,
          shift = util.by_pixel(2, -75),
          hr_version =
          {
           width = 180,
           height = 300,
           shift = util.by_pixel(2, -75),
            scale = 0.5
          }
        },
      },
      { -- c
        trunk =
        {
          width = 71,
          height = 167,
          shift = util.by_pixel(-6, -70),
          hr_version =
          {
            width = 136,
            height = 330,
            shift = util.by_pixel(-4, -68),
            scale = 0.5
          }
        },
        stump =
        {
          width = 39,
          height = 33,
          shift = util.by_pixel(-2, -2),
          hr_version =
          {
            width = 74,
            height = 62,
            shift = util.by_pixel(0, -1),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 155,
          height = 65,
          shift = util.by_pixel(58, 0),
          hr_version =
          {
            width = 306,
            height = 132,
            shift = util.by_pixel(59, 0),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 93,
          height = 157,
          shift = util.by_pixel(-2, -74),
          hr_version =
          {
            width = 180,
            height = 308,
            shift = util.by_pixel(0, -72),
            scale = 0.5
          }
        },
       normal =
        {
          width = 92,
          height = 154,
          shift = util.by_pixel(1, -70),
          hr_version =
          {
           width = 182,
           height = 306,
           shift = util.by_pixel(0.5, -70),
            scale = 0.5
          }
        },
      },
      { -- d
        trunk =
        {
          width = 57,
          height = 163,
          shift = util.by_pixel(0, -68),
          hr_version =
          {
            width = 108,
            height = 324,
            shift = util.by_pixel(2, -67),
            scale = 0.5
          }
        },
        stump =
        {
          width = 41,
          height = 35,
          shift = util.by_pixel(0, -4),
          hr_version =
          {
            width = 82,
            height = 68,
            shift = util.by_pixel(0, -3),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 145,
          height = 67,
          shift = util.by_pixel(58, -4),
          hr_version =
          {
            width = 288,
            height = 130,
            shift = util.by_pixel(59, -3),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 95,
          height = 153,
          shift = util.by_pixel(0, -72),
          hr_version =
          {
            width = 188,
            height = 310,
            shift = util.by_pixel(1, -72),
            scale = 0.5
          }
        },
       normal =
        {
          width = 94,
          height = 144,
          shift = util.by_pixel(2, -75),
          hr_version =
          {
           width = 188,
           height = 286,
           shift = util.by_pixel(2, -75.5),
            scale = 0.5
          }
        },
      },
      { -- e
        trunk =
        {
          width = 69,
          height = 165,
          shift = util.by_pixel(2, -68),
          hr_version =
          {
            width = 138,
            height = 324,
            shift = util.by_pixel(2, -66),
            scale = 0.5
          }
        },
        stump =
        {
          width = 39,
          height = 33,
          shift = util.by_pixel(0, -2),
          hr_version =
          {
            width = 78,
            height = 62,
            shift = util.by_pixel(0, -1),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 159,
          height = 69,
          shift = util.by_pixel(66, 0),
          hr_version =
          {
            width = 314,
            height = 136,
            shift = util.by_pixel(67, 1),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 97,
          height = 143,
          shift = util.by_pixel(2, -68),
          hr_version =
          {
            width = 190,
            height = 300,
            shift = util.by_pixel(3, -71),
            scale = 0.5
          }
        },
       normal =
        {
          width = 96,
          height = 140,
          shift = util.by_pixel(4, -68),
          hr_version =
          {
           width = 190,
           height = 280,
           shift = util.by_pixel(4, -68),
            scale = 0.5
          }
        },
      },
      { -- f
        trunk =
        {
          width = 63,
          height = 165,
          shift = util.by_pixel(-6, -66),
          hr_version =
          {
            width = 118,
            height = 326,
            shift = util.by_pixel(-4, -65),
            scale = 0.5
          }
        },
        stump =
        {
          width = 41,
          height = 37,
          shift = util.by_pixel(-2, -2),
          hr_version =
          {
            width = 76,
            height = 70,
            shift = util.by_pixel(0, -1),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 151,
          height = 71,
          shift = util.by_pixel(56, 0),
          hr_version =
          {
            width = 304,
            height = 140,
            shift = util.by_pixel(56, 1),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 97,
          height = 153,
          shift = util.by_pixel(-4, -68),
          hr_version =
          {
            width = 190,
            height = 304,
            shift = util.by_pixel(-3, -67),
            scale = 0.5
          }
        },
       normal =
        {
          width = 96,
          height = 140,
          shift = util.by_pixel(-2, -71),
          hr_version =
          {
           width = 190,
           height = 278,
           shift = util.by_pixel(-2, -71),
            scale = 0.5
          }
        },
      },
      { -- g
        trunk =
        {
          width = 71,
          height = 147,
          shift = util.by_pixel(-2, -60),
          hr_version =
          {
            width = 142,
            height = 294,
            shift = util.by_pixel(-2, -59),
            scale = 0.5
          }
        },
        stump =
        {
          width = 37,
          height = 33,
          shift = util.by_pixel(-2, -2),
          hr_version =
          {
            width = 72,
            height = 62,
            shift = util.by_pixel(-1, -1),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 127,
          height = 69,
          shift = util.by_pixel(40, -4),
          hr_version =
          {
            width = 252,
            height = 130,
            shift = util.by_pixel(41, -2),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 93,
          height = 139,
          shift = util.by_pixel(-4, -62),
          hr_version =
          {
            width = 184,
            height = 274,
            shift = util.by_pixel(-3, -61),
            scale = 0.5
          }
        },
       normal =
        {
          width = 94,
          height = 124,
          shift = util.by_pixel(-2, -62),
          hr_version =
          {
            width = 186,
            height = 248,
            shift = util.by_pixel(-2.5, -62),
            scale = 0.5
          }
        },
      },
      { -- h
        trunk =
        {
          width = 57,
          height = 151,
          shift = util.by_pixel(4, -62),
          hr_version =
          {
            width = 116,
            height = 296,
            shift = util.by_pixel(4, -60),
            scale = 0.5
          }
        },
        stump =
        {
          width = 37,
          height = 35,
          shift = util.by_pixel(-2, -4),
          hr_version =
          {
            width = 70,
            height = 64,
            shift = util.by_pixel(-1, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 135,
          height = 67,
          shift = util.by_pixel(54, -4),
          hr_version =
          {
            width = 266,
            height = 130,
            shift = util.by_pixel(55, -3),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 91,
          height = 141,
          shift = util.by_pixel(0, -64),
          hr_version =
          {
            width = 180,
            height = 282,
            shift = util.by_pixel(1, -63),
            scale = 0.5
          }
        },
       normal =
        {
          width = 92,
          height = 122,
          shift = util.by_pixel(2, -61),
          hr_version =
          {
            width = 180,
            height = 244,
            shift = util.by_pixel(1.5, -61),
            scale = 0.5
          }
        },
      },
      { -- i
        trunk =
        {
          width = 63,
          height = 123,
          shift = util.by_pixel(-2, -50),
          hr_version =
          {
            width = 120,
            height = 244,
            shift = util.by_pixel(0, -49),
            scale = 0.5
          }
        },
        stump =
        {
          width = 41,
          height = 35,
          shift = util.by_pixel(2, -6),
          hr_version =
          {
            width = 82,
            height = 68,
            shift = util.by_pixel(2, -5),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 113,
          height = 61,
          shift = util.by_pixel(50, 2),
          hr_version =
          {
            width = 228,
            height = 118,
            shift = util.by_pixel(50, 3),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 79,
          height = 115,
          shift = util.by_pixel(-4, -52),
          hr_version =
          {
            width = 152,
            height = 234,
            shift = util.by_pixel(-2, -52),
            scale = 0.5
          }
        },
       normal =
        {
          width = 78,
          height = 100,
          shift = util.by_pixel(-1, -56),
          hr_version =
          {
            width = 152,
            height = 196,
            shift = util.by_pixel(-1.5, -56.5),
            scale = 0.5
          }
        },
      },
      { -- j
        trunk =
        {
          width = 55,
          height = 127,
          shift = util.by_pixel(0, -52),
          hr_version =
          {
            width = 110,
            height = 250,
            shift = util.by_pixel(0, -50),
            scale = 0.5
          }
        },
        stump =
        {
          width = 39,
          height = 39,
          shift = util.by_pixel(2, -8),
          hr_version =
          {
            width = 74,
            height = 74,
            shift = util.by_pixel(3, -6),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 109,
          height = 53,
          shift = util.by_pixel(48, -4),
          hr_version =
          {
            width = 212,
            height = 104,
            shift = util.by_pixel(50, -3),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 67,
          height = 115,
          shift = util.by_pixel(0, -52),
          hr_version =
          {
            width = 134,
            height = 228,
            shift = util.by_pixel(0, -51),
            scale = 0.5
          }
        },
       normal =
        {
          width = 68,
          height = 98,
          shift = util.by_pixel(2, -58),
          hr_version =
          {
  	     width = 134,
  	     height = 194,
  	     shift = util.by_pixel(1.5, -58.5),
            scale = 0.5
          }
        },
      },
      { -- k
        trunk =
        {
          width = 129,
          height = 111,
          shift = util.by_pixel(10, -14),
          hr_version =
          {
            width = 258,
            height = 224,
            shift = util.by_pixel(10, -13),
            scale = 0.5
          }
        },
        stump =
        {
          width = 45,
          height = 39,
          shift = util.by_pixel(-10, 4),
          hr_version =
          {
            width = 86,
            height = 78,
            shift = util.by_pixel(-9, 4),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 129,
          height = 107,
          shift = util.by_pixel(12, -14),
          hr_version =
          {
            width = 256,
            height = 212,
            shift = util.by_pixel(13, -13),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 123,
          height = 95,
          shift = util.by_pixel(10, -16),
          hr_version =
          {
            width = 250,
            height = 206,
            shift = util.by_pixel(10, -12),
            scale = 0.5
          }
        },
       normal =
        {
          width = 94,
          height = 76,
          shift = util.by_pixel(26, -26),
          hr_version =
          {
  	     width = 186,
  	     height = 150,
  	     shift = util.by_pixel(26, -26),
            scale = 0.5
          }
        },
      },
      { -- l
        trunk =
        {
          width = 309,
          height = 59,
          shift = util.by_pixel(32, 6),
          hr_version =
          {
            width = 620,
            height = 116,
            shift = util.by_pixel(32, 7),
            scale = 0.5
          }
        },
        stump =
        {
          width = 197,
          height = 101,
          shift = util.by_pixel(88, 30),
          hr_version =
          {
            width = 396,
            height = 202,
            shift = util.by_pixel(88, 31),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 185,
          height = 49,
          shift = util.by_pixel(-30, 4),
          hr_version =
          {
            width = 366,
            height = 94,
            shift = util.by_pixel(-29, 5),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 171,
          height = 57,
          shift = util.by_pixel(-34, 0),
          hr_version =
          {
            width = 354,
            height = 114,
            shift = util.by_pixel(-31, 0),
            scale = 0.5
          }
        },
       normal =
        {
          width = 122,
          height = 56,
          shift = util.by_pixel(-52, 1),
          hr_version =
          {
            width = 240,
            height = 112,
            shift = util.by_pixel(-52.5, 1),
            scale = 0.5
          }
        },
      }
    },
  },
  { -- tree-02
    --addHere-tree02 -- "sequoia"
    type_name = "02",
    drawing_box = {{-0.9, -3.9}, {0.9, 0.6}},
    negate_tint = { r = 80, g = 77, b = 61 },
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__base__/graphics/entity/tree/02/tree-02-reflection.png",
          priority = "extra-high",
          width = 28,
          height = 40,
          shift = util.by_pixel(5, 75),
          y = 40 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = { -- tree-02
      { -- a
        trunk =
        {
          width = 82,
          height = 162,
          shift = util.by_pixel(0, -66),
          hr_version =
          {
            width = 162,
            height = 324,
            shift = util.by_pixel(1, -65),
            scale = 0.5
          }
        },
        stump =
        {
          width = 44,
          height = 34,
          shift = util.by_pixel(2, -2),
          hr_version =
          {
            width = 88,
            height = 70,
            shift = util.by_pixel(2, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 196,
          height = 64,
          shift = util.by_pixel(90, -2),
          hr_version =
          {
            width = 384,
            height = 130,
            shift = util.by_pixel(92, -2),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 96,
          height = 154,
          shift = util.by_pixel(-2, -74),
          hr_version =
          {
            width = 184,
            height = 310,
            shift = util.by_pixel(0, -74),
            scale = 0.5
          }
        },
       normal =
        {
          width = 94,
          height = 146,
          shift = util.by_pixel(1, -78),
          hr_version =
          {
  	     width = 186,
  	     height = 292,
  	     shift = util.by_pixel(0.5, -78),
            scale = 0.5
          }
        },
      },
      { -- b
        trunk =
        {
          width = 76,
          height = 142,
          shift = util.by_pixel(-4, -60),
          hr_version =
          {
            width = 150,
            height = 286,
            shift = util.by_pixel(-3, -59),
            scale = 0.5
          }
        },
        stump =
        {
          width = 38,
          height = 30,
          shift = util.by_pixel(2, -4),
          hr_version =
          {
            width = 78,
            height = 60,
            shift = util.by_pixel(2, -3),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 186,
          height = 68,
          shift = util.by_pixel(86, 0),
          hr_version =
          {
            width = 372,
            height = 134,
            shift = util.by_pixel(86, 1),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 92,
          height = 136,
          shift = util.by_pixel(-2, -62),
          hr_version =
          {
            width = 184,
            height = 274,
            shift = util.by_pixel(-2, -62),
            scale = 0.5
          }
        },
       normal =
        {
          width = 92,
          height = 132,
          shift = util.by_pixel(-1, -64),
          hr_version =
          {
  	     width = 184,
  	     height = 262,
  	     shift = util.by_pixel(-1, -64),
            scale = 0.5
          }
        },
      },
      { -- c
        trunk =
        {
          width = 72,
          height = 140,
          shift = util.by_pixel(-4, -58),
          hr_version =
          {
            width = 144,
            height = 280,
            shift = util.by_pixel(-4, -57),
            scale = 0.5
          }
        },
        stump =
        {
          width = 38,
          height = 32,
          shift = util.by_pixel(2, -4),
          hr_version =
          {
            width = 78,
            height = 60,
            shift = util.by_pixel(2, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 176,
          height = 64,
          shift = util.by_pixel(76, -2),
          hr_version =
          {
            width = 352,
            height = 128,
            shift = util.by_pixel(77, -2),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 90,
          height = 130,
          shift = util.by_pixel(-2, -62),
          hr_version =
          {
            width = 178,
            height = 264,
            shift = util.by_pixel(-1, -62),
            scale = 0.5
          }
        },
       normal =
        {
          width = 90,
          height = 124,
          shift = util.by_pixel(0, -66),
          hr_version =
          {
  	     width = 178,
  	     height = 244,
  	     shift = util.by_pixel(0, -66.5),
            scale = 0.5
          }
        },
      },
      { -- d
        trunk =
        {
          width = 72,
          height = 168,
          shift = util.by_pixel(6, -70),
          hr_version =
          {
            width = 142,
            height = 336,
            shift = util.by_pixel(7, -70),
            scale = 0.5
          }
        },
        stump =
        {
          width = 52,
          height = 40,
          shift = util.by_pixel(6, -6),
          hr_version =
          {
            width = 102,
            height = 80,
            shift = util.by_pixel(7, -6),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 200,
          height = 66,
          shift = util.by_pixel(94, -4),
          hr_version =
          {
            width = 402,
            height = 134,
            shift = util.by_pixel(94, -4),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 90,
          height = 166,
          shift = util.by_pixel(6, -76),
          hr_version =
          {
            width = 180,
            height = 330,
            shift = util.by_pixel(6, -75),
            scale = 0.5
          }
        },
       normal =
        {
          width = 90,
          height = 152,
          shift = util.by_pixel(7, -82),
          hr_version =
          {
  	     width = 180,
  	     height = 302,
  	     shift = util.by_pixel(7, -82),
            scale = 0.5
          }
        },
      },
      { -- e
        trunk =
        {
          width = 86,
          height = 144,
          shift = util.by_pixel(2, -58),
          hr_version =
          {
            width = 168,
            height = 286,
            shift = util.by_pixel(3, -57),
            scale = 0.5
          }
        },
        stump =
        {
          width = 50,
          height = 40,
          shift = util.by_pixel(8, -6),
          hr_version =
          {
            width = 100,
            height = 78,
            shift = util.by_pixel(8, -5),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 204,
          height = 70,
          shift = util.by_pixel(96, 6),
          hr_version =
          {
            width = 410,
            height = 144,
            shift = util.by_pixel(96, 6),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 98,
          height = 140,
          shift = util.by_pixel(0, -64),
          hr_version =
          {
            width = 194,
            height = 276,
            shift = util.by_pixel(1, -63),
            scale = 0.5
          }
        },
       normal =
        {
          width = 98,
          height = 138,
          shift = util.by_pixel(2, -64),
          hr_version =
          {
  	     width = 194,
  	     height = 272,
  	     shift = util.by_pixel(2, -64.5),
            scale = 0.5
          }
        },
      },
      { -- f
        trunk =
        {
          width = 74,
          height = 156,
          shift = util.by_pixel(-12, -64),
          hr_version =
          {
            width = 144,
            height = 310,
            shift = util.by_pixel(-10, -63),
            scale = 0.5
          }
        },
        stump =
        {
          width = 48,
          height = 40,
          shift = util.by_pixel(6, -6),
          hr_version =
          {
            width = 96,
            height = 78,
            shift = util.by_pixel(6, -5),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 170,
          height = 64,
          shift = util.by_pixel(76, 0),
          hr_version =
          {
            width = 344,
            height = 130,
            shift = util.by_pixel(75, 0),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 92,
          height = 150,
          shift = util.by_pixel(-10, -68),
          hr_version =
          {
            width = 184,
            height = 302,
            shift = util.by_pixel(-10, -68),
            scale = 0.5
          }
        },
       normal =
        {
          width = 92,
          height = 148,
          shift = util.by_pixel(-9, -69),
          hr_version =
          {
  	     width = 184,
  	     height = 292,
  	     shift = util.by_pixel(-9, -69.5),
            scale = 0.5
          }
        },
      },
      { -- g
        trunk =
        {
          width = 86,
          height = 140,
          shift = util.by_pixel(4, -56),
          hr_version =
          {
            width = 168,
            height = 282,
            shift = util.by_pixel(6, -56),
            scale = 0.5
          }
        },
        stump =
        {
          width = 38,
          height = 32,
          shift = util.by_pixel(0, -2),
          hr_version =
          {
            width = 78,
            height = 66,
            shift = util.by_pixel(0, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 188,
          height = 64,
          shift = util.by_pixel(86, -6),
          hr_version =
          {
            width = 384,
            height = 122,
            shift = util.by_pixel(84, -4),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 100,
          height = 136,
          shift = util.by_pixel(4, -68),
          hr_version =
          {
            width = 198,
            height = 270,
            shift = util.by_pixel(5, -67),
            scale = 0.5
          }
        },
       normal =
        {
          width = 98,
          height = 120,
          shift = util.by_pixel(6, -74),
          hr_version =
          {
  	     width = 196,
  	     height = 238,
  	     shift = util.by_pixel(6, -74.5),
            scale = 0.5
          }
        },
      },
      { -- h
        trunk =
        {
          width = 92,
          height = 124,
          shift = util.by_pixel(-10, -48),
          hr_version =
          {
            width = 182,
            height = 244,
            shift = util.by_pixel(-8, -47),
            scale = 0.5
          }
        },
        stump =
        {
          width = 38,
          height = 32,
          shift = util.by_pixel(2, -2),
          hr_version =
          {
            width = 80,
            height = 66,
            shift = util.by_pixel(1, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 154,
          height = 60,
          shift = util.by_pixel(68, 4),
          hr_version =
          {
            width = 306,
            height = 118,
            shift = util.by_pixel(69, 5),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 96,
          height = 116,
          shift = util.by_pixel(-8, -58),
          hr_version =
          {
            width = 192,
            height = 234,
            shift = util.by_pixel(-7, -58),
            scale = 0.5
          }
        },
       normal =
        {
          width = 96,
          height = 112,
          shift = util.by_pixel(-6, -60),
          hr_version =
          {
  	     width = 190,
  	     height = 220,
  	     shift = util.by_pixel(-6, -60.5),
            scale = 0.5
          }
        },
      },
      { -- i
        trunk =
        {
          width = 62,
          height = 102,
          shift = util.by_pixel(4, -38),
          hr_version =
          {
            width = 126,
            height = 206,
            shift = util.by_pixel(4, -38),
            scale = 0.5
          }
        },
        stump =
        {
          width = 44,
          height = 38,
          shift = util.by_pixel(6, -6),
          hr_version =
          {
            width = 88,
            height = 74,
            shift = util.by_pixel(7, -5),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 132,
          height = 54,
          shift = util.by_pixel(60, 0),
          hr_version =
          {
            width = 262,
            height = 110,
            shift = util.by_pixel(61, 0),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 78,
          height = 96,
          shift = util.by_pixel(2, -48),
          hr_version =
          {
            width = 152,
            height = 194,
            shift = util.by_pixel(4, -48),
            scale = 0.5
          }
        },
       normal =
        {
          width = 76,
          height = 98,
          shift = util.by_pixel(5, -47),
          hr_version =
          {
  	     width = 152,
  	     height = 194,
  	     shift = util.by_pixel(5, -47),
            scale = 0.5
          }
        },
      },
      { -- j
        trunk =
        {
          width = 64,
          height = 96,
          shift = util.by_pixel(-8, -36),
          hr_version =
          {
            width = 128,
            height = 194,
            shift = util.by_pixel(-8, -36),
            scale = 0.5
          }
        },
        stump =
        {
          width = 40,
          height = 32,
          shift = util.by_pixel(6, -4),
          hr_version =
          {
            width = 84,
            height = 66,
            shift = util.by_pixel(5, -4),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 124,
          height = 56,
          shift = util.by_pixel(54, -2),
          hr_version =
          {
            width = 248,
            height = 108,
            shift = util.by_pixel(55, -1),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 78,
          height = 100,
          shift = util.by_pixel(-8, -48),
          hr_version =
          {
            width = 152,
            height = 198,
            shift = util.by_pixel(-7, -47),
            scale = 0.5
          }
        },
       normal =
        {
          width = 78,
          height = 100,
          shift = util.by_pixel(-6, -47),
          hr_version =
          {
  	     width = 152,
  	     height = 200,
  	     shift = util.by_pixel(-6.5, -46.5),
            scale = 0.5
          }
        },
      },
      { -- k
        trunk =
        {
          width = 120,
          height = 124,
          shift = util.by_pixel(4, -20),
          hr_version =
          {
            width = 234,
            height = 244,
            shift = util.by_pixel(6, -19),
            scale = 0.5
          }
        },
        stump =
        {
          width = 70,
          height = 66,
          shift = util.by_pixel(0, 4),
          hr_version =
          {
            width = 138,
            height = 130,
            shift = util.by_pixel(1, 5),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 124,
          height = 132,
          shift = util.by_pixel(12, -20),
          hr_version =
          {
            width = 248,
            height = 262,
            shift = util.by_pixel(12, -19),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 106,
          height = 132,
          shift = util.by_pixel(14, -32),
          hr_version =
          {
            width = 216,
            height = 264,
            shift = util.by_pixel(13, -30),
            scale = 0.5
          }
        },
       normal =
        {
          width = 108,
          height = 108,
          shift = util.by_pixel(14, -41),
          hr_version =
          {
  	     width = 214,
  	     height = 212,
  	     shift = util.by_pixel(14, -41.5),
            scale = 0.5
          }
        },
      },
      { -- l
        trunk =
        {
          width = 202,
          height = 62,
          shift = util.by_pixel(-8, -8),
          hr_version =
          {
            width = 410,
            height = 122,
            shift = util.by_pixel(-9, -7),
            scale = 0.5
          }
        },
        stump =
        {
          width = 94,
          height = 48,
          shift = util.by_pixel(28, -12),
          hr_version =
          {
            width = 188,
            height = 100,
            shift = util.by_pixel(28, -12),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 208,
          height = 70,
          shift = util.by_pixel(-2, 0),
          hr_version =
          {
            width = 418,
            height = 138,
            shift = util.by_pixel(-2, 1),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 202,
          height = 80,
          shift = util.by_pixel(-12, -8),
          hr_version =
          {
            width = 404,
            height = 156,
            shift = util.by_pixel(-11, -6),
            scale = 0.5
          }
        },
       normal =
        {
          width = 154,
          height = 80,
          shift = util.by_pixel(-35, -5),
          hr_version =
          {
  	     width = 308,
  	     height = 156,
  	     shift = util.by_pixel(-35, -5.5),
            scale = 0.5
          }
        },
      }
    },
  },
  { -- tree-03
    --addHere-tree03 -- "eucalyptus"
    type_name = "03",
    drawing_box = {{-0.9, -3.7}, {0.9, 0.6}},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__base__/graphics/entity/tree/03/tree-03-reflection.png",
          priority = "extra-high",
          width = 44,
          height = 40,
          shift = util.by_pixel(10, 65),
          y = 40 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = { -- tree-03
      { -- a
        trunk = {
          width = 135,
          height = 157,
          shift = util.by_pixel(-6, -56),
          hr_version = {
            width = 264,
            height = 312,
            shift = util.by_pixel(-5, -56),
            scale = 0.5
          },
        },
        stump = {
          width = 53,
          height = 41,
          shift = util.by_pixel(0, 2),
          hr_version = {
            width = 100,
            height = 80,
            shift = util.by_pixel(1, 2),
            scale = 0.5
          },
        },
        shadow = {
          width = 153,
          height = 101,
          shift = util.by_pixel(60, -14),
          hr_version = {
            width = 300,
            height = 202,
            shift = util.by_pixel(61, -14),
            scale = 0.5
          },
        },
        leaves = {
          width = 141,
          height = 153,
          shift = util.by_pixel(-8, -74),
          hr_version = {
            width = 282,
            height = 304,
            shift = util.by_pixel(-8, -74),
            scale = 0.5
          },
        },
       normal = {
          width = 142,
          height = 136,
          shift = util.by_pixel(-8, -82),
          hr_version = {
            width = 284,
            height = 270,
            shift = util.by_pixel(-8, -82),
            scale = 0.5
          },
        },
      },
      { -- b
        trunk = {
          width = 127,
          height = 157,
          shift = util.by_pixel(20, -58),
          hr_version = {
            width = 252,
            height = 314,
            shift = util.by_pixel(20, -58),
            scale = 0.5
          },
        },
        stump = {
          width = 53,
          height = 43,
          shift = util.by_pixel(-4, 0),
          hr_version = {
            width = 106,
            height = 84,
            shift = util.by_pixel(-4, 0),
            scale = 0.5
          },
        },
        shadow = {
          width = 203,
          height = 117,
          shift = util.by_pixel(86, -12),
          hr_version = {
            width = 406,
            height = 230,
            shift = util.by_pixel(86, -11),
            scale = 0.5
          },
        },
        leaves = {
          width = 171,
          height = 137,
          shift = util.by_pixel(22, -80),
          hr_version = {
            width = 342,
            height = 272,
            shift = util.by_pixel(22, -80),
            scale = 0.5
          },
        },
       normal = {
          width = 174,
          height = 138,
          shift = util.by_pixel(23, -80),
          hr_version = {
            width = 344,
            height = 276,
            shift = util.by_pixel(22.5, -79.5),
            scale = 0.5
          },
        },
      },
      { -- c
        trunk = {
          width = 135,
          height = 125,
          shift = util.by_pixel(-10, -44),
          hr_version = {
            width = 268,
            height = 246,
            shift = util.by_pixel(-9, -43),
            scale = 0.5
          },
        },
        stump = {
          width = 51,
          height = 41,
          shift = util.by_pixel(2, -2),
          hr_version = {
            width = 98,
            height = 78,
            shift = util.by_pixel(3, -1),
            scale = 0.5
          },
        },
        shadow = {
          width = 323,
          height = 97,
          shift = util.by_pixel(-26, 8),
          hr_version = {
            width = 646,
            height = 188,
            shift = util.by_pixel(-26, 9),
            scale = 0.5
          },
        },
        leaves = {
          width = 161,
          height = 117,
          shift = util.by_pixel(-10, -48),
          hr_version = {
            width = 314,
            height = 232,
            shift = util.by_pixel(-8, -48),
            scale = 0.5
          },
        },
       normal = {
          width = 160,
          height = 118,
          shift = util.by_pixel(-8, -47),
          hr_version = {
            width = 318,
            height = 234,
            shift = util.by_pixel(-8, -47.5),
            scale = 0.5
          },
        },
      },
      { -- d
        trunk = {
          width = 73,
          height = 145,
          shift = util.by_pixel(6, -52),
          hr_version = {
            width = 142,
            height = 286,
            shift = util.by_pixel(7, -51),
            scale = 0.5
          },
        },
        stump = {
          width = 51,
          height = 41,
          shift = util.by_pixel(-6, 0),
          hr_version = {
            width = 96,
            height = 78,
            shift = util.by_pixel(-5, 1),
            scale = 0.5
          },
        },
        shadow = {
          width = 159,
          height = 79,
          shift = util.by_pixel(66, 0),
          hr_version = {
            width = 318,
            height = 156,
            shift = util.by_pixel(66, 0),
            scale = 0.5
          },
        },
        leaves = {
          width = 103,
          height = 129,
          shift = util.by_pixel(8, -68),
          hr_version = {
            width = 202,
            height = 254,
            shift = util.by_pixel(9, -67),
            scale = 0.5
          },
        },
       normal = {
          width = 102,
          height = 116,
          shift = util.by_pixel(10, -72),
          hr_version = {
            width = 202,
            height = 230,
            shift = util.by_pixel(9.5, -72.5),
            scale = 0.5
          },
        },
      },
      { -- e
        trunk = {
          width = 89,
          height = 127,
          shift = util.by_pixel(6, -48),
          hr_version = {
            width = 174,
            height = 250,
            shift = util.by_pixel(7, -47),
            scale = 0.5
          },
        },
        stump = {
          width = 51,
          height = 39,
          shift = util.by_pixel(-4, -4),
          hr_version = {
            width = 98,
            height = 74,
            shift = util.by_pixel(-3, -3),
            scale = 0.5
          },
        },
        shadow = {
          width = 167,
          height = 69,
          shift = util.by_pixel(70, 0),
          hr_version = {
            width = 330,
            height = 132,
            shift = util.by_pixel(71, 1),
            scale = 0.5
          },
        },
        leaves = {
          width = 117,
          height = 105,
          shift = util.by_pixel(8, -62),
          hr_version = {
            width = 234,
            height = 208,
            shift = util.by_pixel(8, -61),
            scale = 0.5
          },
        },
       normal = {
          width = 120,
          height = 100,
          shift = util.by_pixel(9, -64),
          hr_version = {
            width = 238,
            height = 198,
            shift = util.by_pixel(8.5, -64),
            scale = 0.5
          },
        },
      },
      { -- f
        trunk = {
          width = 79,
          height = 133,
          shift = util.by_pixel(-12, -50),
          hr_version = {
            width = 158,
            height = 262,
            shift = util.by_pixel(-12, -49),
            scale = 0.5
          },
        },
        stump = {
          width = 47,
          height = 33,
          shift = util.by_pixel(4, 0),
          hr_version = {
            width = 90,
            height = 66,
            shift = util.by_pixel(5, 0),
            scale = 0.5
          },
        },
        shadow = {
          width = 113,
          height = 73,
          shift = util.by_pixel(48, -4),
          hr_version = {
            width = 224,
            height = 142,
            shift = util.by_pixel(48, -3),
            scale = 0.5
          },
        },
        leaves = {
          width = 109,
          height = 119,
          shift = util.by_pixel(-14, -58),
          hr_version = {
            width = 214,
            height = 232,
            shift = util.by_pixel(-13, -57),
            scale = 0.5
          },
        },
       normal = {
          width = 108,
          height = 102,
          shift = util.by_pixel(-12, -63),
          hr_version = {
            width = 216,
            height = 202,
            shift = util.by_pixel(-12, -63.5),
            scale = 0.5
          },
        },
      },
      { -- g
        trunk = {
          width = 73,
          height = 123,
          shift = util.by_pixel(-10, -42),
          hr_version = {
            width = 140,
            height = 240,
            shift = util.by_pixel(-9, -41),
            scale = 0.5
          },
        },
        stump = {
          width = 45,
          height = 39,
          shift = util.by_pixel(0, 0),
          hr_version = {
            width = 88,
            height = 76,
            shift = util.by_pixel(0, 0),
            scale = 0.5
          },
        },
        shadow = {
          width = 107,
          height = 71,
          shift = util.by_pixel(44, -6),
          hr_version = {
            width = 212,
            height = 136,
            shift = util.by_pixel(44, -5),
            scale = 0.5
          },
        },
        leaves = {
          width = 95,
          height = 117,
          shift = util.by_pixel(0, -58),
          hr_version = {
            width = 188,
            height = 230,
            shift = util.by_pixel(1, -57),
            scale = 0.5
          },
        },
       normal = {
          width = 94,
          height = 96,
          shift = util.by_pixel(2, -66),
          hr_version = {
            width = 186,
            height = 188,
            shift = util.by_pixel(1.5, -66.5),
            scale = 0.5
          },
        },
      },
      { -- h
        trunk = {
          width = 87,
          height = 115,
          shift = util.by_pixel(2, -38),
          hr_version = {
            width = 174,
            height = 224,
            shift = util.by_pixel(2, -37),
            scale = 0.5
          },
        },
        stump = {
          width = 45,
          height = 41,
          shift = util.by_pixel(-2, -2),
          hr_version = {
            width = 88,
            height = 74,
            shift = util.by_pixel(-2, 0),
            scale = 0.5
          },
        },
        shadow = {
          width = 131,
          height = 69,
          shift = util.by_pixel(54, -2),
          hr_version = {
            width = 258,
            height = 132,
            shift = util.by_pixel(55, -1),
            scale = 0.5
          },
        },
        leaves = {
          width = 93,
          height = 103,
          shift = util.by_pixel(6, -44),
          hr_version = {
            width = 182,
            height = 200,
            shift = util.by_pixel(7, -43),
            scale = 0.5
          },
        },
       normal = {
          width = 94,
          height = 78,
          shift = util.by_pixel(8, -54),
          hr_version = {
            width = 186,
            height = 154,
            shift = util.by_pixel(7.5, -54),
            scale = 0.5
          },
        },
      },
      { -- i
        trunk = {
          width = 99,
          height = 101,
          shift = util.by_pixel(2, -34),
          hr_version = {
            width = 196,
            height = 202,
            shift = util.by_pixel(2, -34),
            scale = 0.5
          },
        },
        stump = {
          width = 49,
          height = 43,
          shift = util.by_pixel(0, -4),
          hr_version = {
            width = 92,
            height = 80,
            shift = util.by_pixel(1, -3),
            scale = 0.5
          },
        },
        shadow = {
          width = 109,
          height = 61,
          shift = util.by_pixel(48, 4),
          hr_version = {
            width = 218,
            height = 120,
            shift = util.by_pixel(48, 4),
            scale = 0.5
          },
        },
        leaves = {
          width = 99,
          height = 91,
          shift = util.by_pixel(-2, -42),
          hr_version = {
            width = 198,
            height = 178,
            shift = util.by_pixel(-1, -41),
            scale = 0.5
          },
        },
       normal = {
          width = 96,
          height = 68,
          shift = util.by_pixel(-3, -51),
          hr_version = {
            width = 190,
            height = 136,
            shift = util.by_pixel(-3.5, -50.5),
            scale = 0.5
          },
        },
      },
      { -- j
        trunk = {
          width = 51,
          height = 95,
          shift = util.by_pixel(6, -34),
          hr_version = {
            width = 100,
            height = 188,
            shift = util.by_pixel(6, -34),
            scale = 0.5
          },
        },
        stump = {
          width = 29,
          height = 27,
          shift = util.by_pixel(-2, 0),
          hr_version = {
            width = 58,
            height = 52,
            shift = util.by_pixel(-2, 0),
            scale = 0.5
          },
        },
        shadow = {
          width = 89,
          height = 55,
          shift = util.by_pixel(38, -2),
          hr_version = {
            width = 178,
            height = 110,
            shift = util.by_pixel(39, -2),
            scale = 0.5
          },
        },
        leaves = {
          width = 57,
          height = 85,
          shift = util.by_pixel(6, -44),
          hr_version = {
            width = 112,
            height = 166,
            shift = util.by_pixel(6, -43),
            scale = 0.5
          },
        },
       normal = {
          width = 58,
          height = 68,
          shift = util.by_pixel(7, -51),
          hr_version = {
            width = 114,
            height = 136,
            shift = util.by_pixel(6.5, -50.5),
            scale = 0.5
          },
        },
      },
      { -- k
        trunk = {
          width = 47,
          height = 69,
          shift = util.by_pixel(8, -24),
          hr_version = {
            width = 92,
            height = 134,
            shift = util.by_pixel(8, -23),
            scale = 0.5
          },
        },
        stump = {
          width = 27,
          height = 25,
          shift = util.by_pixel(-2, -2),
          hr_version = {
            width = 52,
            height = 46,
            shift = util.by_pixel(-2, -1),
            scale = 0.5
          },
        },
        shadow = {
          width = 85,
          height = 35,
          shift = util.by_pixel(38, 2),
          hr_version = {
            width = 170,
            height = 66,
            shift = util.by_pixel(38, 3),
            scale = 0.5
          },
        },
        leaves = {
          width = 69,
          height = 63,
          shift = util.by_pixel(4, -32),
          hr_version = {
            width = 140,
            height = 126,
            shift = util.by_pixel(4, -32),
            scale = 0.5
          },
        },
       normal = {
          width = 72,
          height = 54,
          shift = util.by_pixel(5, -36),
          hr_version = {
            width = 140,
            height = 104,
            shift = util.by_pixel(4.5, -36.5),
            scale = 0.5
          },
        },
      },
      { -- l
        trunk = {
          width = 59,
          height = 85,
          shift = util.by_pixel(-10, -30),
          hr_version = {
            width = 112,
            height = 166,
            shift = util.by_pixel(-9, -29),
            scale = 0.5
          },
        },
        stump = {
          width = 33,
          height = 25,
          shift = util.by_pixel(2, 0),
          hr_version = {
            width = 62,
            height = 50,
            shift = util.by_pixel(3, 0),
            scale = 0.5
          },
        },
        shadow = {
          width = 73,
          height = 47,
          shift = util.by_pixel(30, -6),
          hr_version = {
            width = 142,
            height = 90,
            shift = util.by_pixel(31, -5),
            scale = 0.5
          },
        },
        leaves = {
          width = 79,
          height = 71,
          shift = util.by_pixel(-14, -42),
          hr_version = {
            width = 154,
            height = 142,
            shift = util.by_pixel(-13, -42),
            scale = 0.5
          },
        },
       normal = {
          width = 78,
          height = 62,
          shift = util.by_pixel(-12, -46),
          hr_version = {
            width = 154,
            height = 122,
            shift = util.by_pixel(-12.5, -46),
            scale = 0.5
          },
        },
      },
    },
  },
  { -- tree-04
    --addHere-tree04 -- "mahogany"
    type_name = "04",
    drawing_box = {{-0.9, -3.9}, {0.9, 0.6}},
    negate_tint = { r = 80, g = 77, b = 61 },
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__base__/graphics/entity/tree/04/tree-04-reflection.png",
          priority = "extra-high",
          width = 32,
          height = 40,
          shift = util.by_pixel(5, 65),
          y = 40 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = { -- tree-04
      { -- a
        trunk =
        {
          width = 86,
          height = 160,
          shift = util.by_pixel(-4, -60),
          hr_version =
          {
            width = 174,
            height = 316,
            shift = util.by_pixel(-4, -58),
            scale = 0.5
          }
        },
        stump =
        {
          width = 56,
          height = 50,
          shift = util.by_pixel(2, -4),
          hr_version =
          {
            width = 112,
            height = 94,
            shift = util.by_pixel(3, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 160,
          height = 66,
          shift = util.by_pixel(64, -6),
          hr_version =
          {
            width = 318,
            height = 130,
            shift = util.by_pixel(65, -5),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 108,
          height = 154,
          shift = util.by_pixel(-4, -68),
          hr_version =
          {
            width = 216,
            height = 314,
            shift = util.by_pixel(-3, -67),
            scale = 0.5
          }
        },
       normal =
        {
          width = 110,
          height = 124,
          shift = util.by_pixel(-2, -82),
          hr_version =
          {
            width = 218,
            height = 248,
            shift = util.by_pixel(-2.5, -82),
            scale = 0.5
          }
        },
      },
      { -- b
        trunk =
        {
          width = 72,
          height = 166,
          shift = util.by_pixel(4, -60),
          hr_version =
          {
            width = 142,
            height = 334,
            shift = util.by_pixel(5, -60),
            scale = 0.5
          }
        },
        stump =
        {
          width = 60,
          height = 46,
          shift = util.by_pixel(-2, 0),
          hr_version =
          {
            width = 118,
            height = 94,
            shift = util.by_pixel(-1, 0),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 154,
          height = 78,
          shift = util.by_pixel(68, -4),
          hr_version =
          {
            width = 308,
            height = 154,
            shift = util.by_pixel(68, -3),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 92,
          height = 146,
          shift = util.by_pixel(4, -74),
          hr_version =
          {
            width = 184,
            height = 302,
            shift = util.by_pixel(4, -72),
            scale = 0.5
          }
        },
       normal =
        {
          width = 94,
          height = 124,
          shift = util.by_pixel(5, -84),
          hr_version =
          {
            width = 186,
            height = 246,
            shift = util.by_pixel(5, -84.5),
            scale = 0.5
          }
        },
      },
      { -- c
        trunk =
        {
          width = 88,
          height = 162,
          shift = util.by_pixel(4, -60),
          hr_version =
          {
            width = 176,
            height = 328,
            shift = util.by_pixel(4, -60),
            scale = 0.5
          }
        },
        stump =
        {
          width = 56,
          height = 44,
          shift = util.by_pixel(-4, 0),
          hr_version =
          {
            width = 108,
            height = 88,
            shift = util.by_pixel(-3, 0),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 158,
          height = 70,
          shift = util.by_pixel(66, 0),
          hr_version =
          {
            width = 312,
            height = 134,
            shift = util.by_pixel(67, 2),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 104,
          height = 164,
          shift = util.by_pixel(2, -66),
          hr_version =
          {
            width = 208,
            height = 324,
            shift = util.by_pixel(2, -64),
            scale = 0.5
          }
        },
       normal =
        {
          width = 106,
          height = 134,
          shift = util.by_pixel(3, -77),
          hr_version =
          {
            width = 208,
            height = 268,
            shift = util.by_pixel(2.5, -77),
            scale = 0.5
          }
        },
      },
      { -- d
        trunk =
        {
          width = 108,
          height = 132,
          shift = util.by_pixel(2, -48),
          hr_version =
          {
            width = 216,
            height = 266,
            shift = util.by_pixel(2, -48),
            scale = 0.5
          }
        },
        stump =
        {
          width = 48,
          height = 40,
          shift = util.by_pixel(0, -2),
          hr_version =
          {
            width = 96,
            height = 82,
            shift = util.by_pixel(1, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 158,
          height = 78,
          shift = util.by_pixel(70, 0),
          hr_version =
          {
            width = 320,
            height = 158,
            shift = util.by_pixel(69, 0),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 114,
          height = 148,
          shift = util.by_pixel(-6, -66),
          hr_version =
          {
            width = 230,
            height = 290,
            shift = util.by_pixel(-6, -64),
            scale = 0.5
          }
        },
       normal =
        {
          width = 116,
          height = 126,
          shift = util.by_pixel(-5, -74),
          hr_version =
          {
            width = 230,
            height = 250,
            shift = util.by_pixel(-5, -74),
            scale = 0.5
          }
        },
      },
      { -- e
        trunk =
        {
          width = 80,
          height = 164,
          shift = util.by_pixel(-10, -64),
          hr_version =
          {
            width = 158,
            height = 324,
            shift = util.by_pixel(-9, -62),
            scale = 0.5
          }
        },
        stump =
        {
          width = 52,
          height = 42,
          shift = util.by_pixel(0, -2),
          hr_version =
          {
            width = 102,
            height = 84,
            shift = util.by_pixel(1, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 138,
          height = 88,
          shift = util.by_pixel(60, -4),
          hr_version =
          {
            width = 274,
            height = 170,
            shift = util.by_pixel(61, -2),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 110,
          height = 138,
          shift = util.by_pixel(-4, -84),
          hr_version =
          {
            width = 222,
            height = 280,
            shift = util.by_pixel(-4, -84),
            scale = 0.5
          }
        },
       normal =
        {
          width = 112,
          height = 130,
          shift = util.by_pixel(-3, -88),
          hr_version =
          {
            width = 222,
            height = 256,
            shift = util.by_pixel(-3, -88.5),
            scale = 0.5
          }
        },
      },
      { -- f
        trunk =
        {
          width = 96,
          height = 164,
          shift = util.by_pixel(4, -62),
          hr_version =
          {
            width = 194,
            height = 332,
            shift = util.by_pixel(4, -62),
            scale = 0.5
          }
        },
        stump =
        {
          width = 48,
          height = 40,
          shift = util.by_pixel(-2, 0),
          hr_version =
          {
            width = 100,
            height = 84,
            shift = util.by_pixel(-2, 0),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 168,
          height = 78,
          shift = util.by_pixel(70, -4),
          hr_version =
          {
            width = 332,
            height = 156,
            shift = util.by_pixel(72, -4),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 112,
          height = 134,
          shift = util.by_pixel(10, -82),
          hr_version =
          {
            width = 224,
            height = 272,
            shift = util.by_pixel(11, -82),
            scale = 0.5
          }
        },
       normal =
        {
          width = 112,
          height = 122,
          shift = util.by_pixel(13, -87),
          hr_version =
          {
            width = 222,
            height = 244,
            shift = util.by_pixel(12.5, -87),
            scale = 0.5
          }
        },
      },
      { -- g
        trunk =
        {
          width = 92,
          height = 142,
          shift = util.by_pixel(-14, -54),
          hr_version =
          {
            width = 178,
            height = 282,
            shift = util.by_pixel(-12, -53),
            scale = 0.5
          }
        },
        stump =
        {
          width = 46,
          height = 42,
          shift = util.by_pixel(0, -4),
          hr_version =
          {
            width = 94,
            height = 86,
            shift = util.by_pixel(0, -4),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 148,
          height = 72,
          shift = util.by_pixel(56, -8),
          hr_version =
          {
            width = 296,
            height = 144,
            shift = util.by_pixel(56, -7),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 112,
          height = 130,
          shift = util.by_pixel(-12, -76),
          hr_version =
          {
            width = 222,
            height = 258,
            shift = util.by_pixel(-11, -75),
            scale = 0.5
          }
        },
       normal =
        {
          width = 112,
          height = 110,
          shift = util.by_pixel(-10, -84),
          hr_version =
          {
            width = 222,
            height = 220,
            shift = util.by_pixel(-10.5, -83.5),
            scale = 0.5
          }
        },
      },
      { -- h
        trunk =
        {
          width = 64,
          height = 144,
          shift = util.by_pixel(-2, -54),
          hr_version =
          {
            width = 128,
            height = 284,
            shift = util.by_pixel(-2, -53),
            scale = 0.5
          }
        },
        stump =
        {
          width = 48,
          height = 46,
          shift = util.by_pixel(2, -6),
          hr_version =
          {
            width = 96,
            height = 92,
            shift = util.by_pixel(2, -5),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 148,
          height = 74,
          shift = util.by_pixel(66, -8),
          hr_version =
          {
            width = 292,
            height = 152,
            shift = util.by_pixel(67, -8),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 100,
          height = 142,
          shift = util.by_pixel(8, -60),
          hr_version =
          {
            width = 202,
            height = 280,
            shift = util.by_pixel(8, -57),
            scale = 0.5
          }
        },
       normal =
        {
          width = 102,
          height = 102,
          shift = util.by_pixel(8, -76),
          hr_version =
          {
            width = 204,
            height = 202,
            shift = util.by_pixel(8.5, -76),
            scale = 0.5
          }
        },
      },
      { -- i
        trunk =
        {
          width = 48,
          height = 122,
          shift = util.by_pixel(6, -46),
          hr_version =
          {
            width = 92,
            height = 246,
            shift = util.by_pixel(7, -46),
            scale = 0.5
          }
        },
        stump =
        {
          width = 42,
          height = 34,
          shift = util.by_pixel(2, -2),
          hr_version =
          {
            width = 82,
            height = 68,
            shift = util.by_pixel(3, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 124,
          height = 66,
          shift = util.by_pixel(56, 6),
          hr_version =
          {
            width = 244,
            height = 128,
            shift = util.by_pixel(57, 7),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 70,
          height = 122,
          shift = util.by_pixel(6, -52),
          hr_version =
          {
            width = 140,
            height = 240,
            shift = util.by_pixel(6, -50),
            scale = 0.5
          }
        },
       normal =
        {
          width = 70,
          height = 104,
          shift = util.by_pixel(7, -57),
          hr_version =
          {
            width = 138,
            height = 206,
            shift = util.by_pixel(7, -57),
            scale = 0.5
          }
        },
      },
      { -- j
        trunk =
        {
          width = 48,
          height = 120,
          shift = util.by_pixel(-8, -48),
          hr_version =
          {
            width = 98,
            height = 238,
            shift = util.by_pixel(-8, -47),
            scale = 0.5
          }
        },
        stump =
        {
          width = 40,
          height = 32,
          shift = util.by_pixel(-4, -4),
          hr_version =
          {
            width = 78,
            height = 66,
            shift = util.by_pixel(-3, -4),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 116,
          height = 64,
          shift = util.by_pixel(46, -8),
          hr_version =
          {
            width = 228,
            height = 122,
            shift = util.by_pixel(47, -6),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 70,
          height = 128,
          shift = util.by_pixel(-8, -56),
          hr_version =
          {
            width = 140,
            height = 254,
            shift = util.by_pixel(-8, -55),
            scale = 0.5
          }
        },
       normal =
        {
          width = 70,
          height = 106,
          shift = util.by_pixel(-7, -65),
          hr_version =
          {
            width = 140,
            height = 210,
            shift = util.by_pixel(-7, -65),
            scale = 0.5
          }
        },
      },
      { -- k
        trunk =
        {
          width = 204,
          height = 80,
          shift = util.by_pixel(-16, -12),
          hr_version =
          {
            width = 406,
            height = 158,
            shift = util.by_pixel(-15, -11),
            scale = 0.5
          }
        },
        stump =
        {
          width = 50,
          height = 56,
          shift = util.by_pixel(18, -4),
          hr_version =
          {
            width = 104,
            height = 108,
            shift = util.by_pixel(18, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 208,
          height = 62,
          shift = util.by_pixel(-8, -8),
          hr_version =
          {
            width = 410,
            height = 124,
            shift = util.by_pixel(-6, -8),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 208,
          height = 80,
          shift = util.by_pixel(-20, -22),
          hr_version =
          {
            width = 414,
            height = 164,
            shift = util.by_pixel(-19, -19),
            scale = 0.5
          }
        },
       normal =
        {
          width = 134,
          height = 72,
          shift = util.by_pixel(-55, -22),
          hr_version =
          {
            width = 266,
            height = 144,
            shift = util.by_pixel(-55, -22),
            scale = 0.5
          }
        },
      },
      { -- l
        trunk =
        {
          width = 156,
          height = 126,
          shift = util.by_pixel(4, -4),
          hr_version =
          {
            width = 312,
            height = 250,
            shift = util.by_pixel(4, -3),
            scale = 0.5
          }
        },
        stump =
        {
          width = 56,
          height = 48,
          shift = util.by_pixel(-12, -16),
          hr_version =
          {
            width = 108,
            height = 92,
            shift = util.by_pixel(-10, -15),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 180,
          height = 126,
          shift = util.by_pixel(26, 6),
          hr_version =
          {
            width = 366,
            height = 250,
            shift = util.by_pixel(25, 7),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 156,
          height = 118,
          shift = util.by_pixel(10, 2),
          hr_version =
          {
            width = 314,
            height = 240,
            shift = util.by_pixel(10, 1),
            scale = 0.5
          }
        },
       normal =
        {
          width = 110,
          height = 94,
          shift = util.by_pixel(35, 15),
          hr_version =
          {
            width = 218,
            height = 186,
            shift = util.by_pixel(35, 15),
            scale = 0.5
          }
        },
      }
    },
  },
  { -- tree-05
    --addHere-tree05 - "maple"
    type_name = "05",
    drawing_box = {{-0.9, -3.5}, {0.9, 0.6}},
    negate_tint = { r = 80, g = 77, b = 61 },
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__base__/graphics/entity/tree/05/tree-05-reflection.png",
          priority = "extra-high",
          width = 32,
          height = 36,
          shift = util.by_pixel(5, 60),
          y = 36 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = { -- tree-05
      { -- a
        trunk = {
          width = 74,
          height = 120,
          shift = util.by_pixel(12, -44),
          hr_version = {
            width = 144,
            height = 242,
            shift = util.by_pixel(13, -45),
            scale = 0.5
          },
        },
        stump = {
          width = 46,
          height = 32,
          shift = util.by_pixel(-2, 0),
          hr_version = {
            width = 88,
            height = 64,
            shift = util.by_pixel(-1, 0),
            scale = 0.5
          },
        },
        shadow = {
          width = 160,
          height = 76,
          shift = util.by_pixel(62, -8),
          hr_version = {
            width = 322,
            height = 150,
            shift = util.by_pixel(62, -8),
            scale = 0.5
          },
        },
        leaves = {
          width = 116,
          height = 130,
          shift = util.by_pixel(6, -60),
          hr_version = {
            width = 234,
            height = 258,
            shift = util.by_pixel(5, -60),
            scale = 0.5
          },
        },
       normal = {
          width = 118,
          height = 108,
          shift = util.by_pixel(6, -71),
          hr_version = {
            width = 234,
            height = 216,
            shift = util.by_pixel(6, -71),
            scale = 0.5
          },
        },
      },
      { -- b
        trunk = {
          width = 60,
          height = 114,
          shift = util.by_pixel(0, -40),
          hr_version = {
            width = 114,
            height = 226,
            shift = util.by_pixel(1, -40),
            scale = 0.5
          },
        },
        stump = {
          width = 38,
          height = 34,
          shift = util.by_pixel(0, 0),
          hr_version = {
            width = 78,
            height = 68,
            shift = util.by_pixel(-1, 0),
            scale = 0.5
          },
        },
        shadow = {
          width = 146,
          height = 82,
          shift = util.by_pixel(58, 2),
          hr_version = {
            width = 290,
            height = 166,
            shift = util.by_pixel(58, 1),
            scale = 0.5
          },
        },
        leaves = {
          width = 112,
          height = 122,
          shift = util.by_pixel(6, -60),
          hr_version = {
            width = 222,
            height = 242,
            shift = util.by_pixel(6, -60),
            scale = 0.5
          },
        },
       normal = {
          width = 112,
          height = 106,
          shift = util.by_pixel(6, -68),
          hr_version = {
            width = 222,
            height = 212,
            shift = util.by_pixel(6, -67.5),
            scale = 0.5
          },
        },
      },
      { -- c
        trunk = {
          width = 60,
          height = 138,
          shift = util.by_pixel(-10, -54),
          hr_version = {
            width = 122,
            height = 276,
            shift = util.by_pixel(-10, -54),
            scale = 0.5
          },
        },
        stump = {
          width = 40,
          height = 34,
          shift = util.by_pixel(0, -2),
          hr_version = {
            width = 84,
            height = 64,
            shift = util.by_pixel(-1, -1),
            scale = 0.5
          },
        },
        shadow = {
          width = 136,
          height = 84,
          shift = util.by_pixel(52, 2),
          hr_version = {
            width = 272,
            height = 162,
            shift = util.by_pixel(52, 3),
            scale = 0.5
          },
        },
        leaves = {
          width = 112,
          height = 148,
          shift = util.by_pixel(-2, -66),
          hr_version = {
            width = 224,
            height = 290,
            shift = util.by_pixel(-2, -65),
            scale = 0.5
          },
        },
       normal = {
          width = 112,
          height = 128,
          shift = util.by_pixel(-2, -74),
          hr_version = {
            width = 224,
            height = 256,
            shift = util.by_pixel(-2, -74),
            scale = 0.5
          },
        },
      },
      { -- d
        trunk = {
          width = 60,
          height = 122,
          shift = util.by_pixel(4, -44),
          hr_version = {
            width = 120,
            height = 244,
            shift = util.by_pixel(4, -44),
            scale = 0.5
          },
        },
        stump = {
          width = 42,
          height = 36,
          shift = util.by_pixel(0, 0),
          hr_version = {
            width = 78,
            height = 70,
            shift = util.by_pixel(1, 0),
            scale = 0.5
          },
        },
        shadow = {
          width = 140,
          height = 84,
          shift = util.by_pixel(54, -2),
          hr_version = {
            width = 278,
            height = 168,
            shift = util.by_pixel(54, -2),
            scale = 0.5
          },
        },
        leaves = {
          width = 100,
          height = 124,
          shift = util.by_pixel(6, -60),
          hr_version = {
            width = 202,
            height = 244,
            shift = util.by_pixel(5, -59),
            scale = 0.5
          },
        },
       normal = {
          width = 100,
          height = 104,
          shift = util.by_pixel(6, -67),
          hr_version = {
            width = 200,
            height = 208,
            shift = util.by_pixel(6, -67),
            scale = 0.5
          },
        },
      },
      { -- e
        trunk = {
          width = 54,
          height = 118,
          shift = util.by_pixel(0, -44),
          hr_version = {
            width = 106,
            height = 232,
            shift = util.by_pixel(0, -43),
            scale = 0.5
          },
        },
        stump = {
          width = 40,
          height = 34,
          shift = util.by_pixel(0, -2),
          hr_version = {
            width = 80,
            height = 64,
            shift = util.by_pixel(0, -1),
            scale = 0.5
          },
        },
        shadow = {
          width = 136,
          height = 72,
          shift = util.by_pixel(52, 2),
          hr_version = {
            width = 268,
            height = 144,
            shift = util.by_pixel(53, 2),
            scale = 0.5
          },
        },
        leaves = {
          width = 118,
          height = 126,
          shift = util.by_pixel(-2, -58),
          hr_version = {
            width = 236,
            height = 250,
            shift = util.by_pixel(-2, -57),
            scale = 0.5
          },
        },
       normal = {
          width = 118,
          height = 104,
          shift = util.by_pixel(-2, -66),
          hr_version = {
            width = 236,
            height = 206,
            shift = util.by_pixel(-2, -66.5),
            scale = 0.5
          },
        },
      },
      { -- f
        trunk = {
          width = 58,
          height = 120,
          shift = util.by_pixel(-10, -44),
          hr_version = {
            width = 112,
            height = 236,
            shift = util.by_pixel(-9, -43),
            scale = 0.5
          },
        },
        stump = {
          width = 38,
          height = 36,
          shift = util.by_pixel(0, -2),
          hr_version = {
            width = 80,
            height = 68,
            shift = util.by_pixel(-1, -1),
            scale = 0.5
          },
        },
        shadow = {
          width = 136,
          height = 86,
          shift = util.by_pixel(52, -2),
          hr_version = {
            width = 272,
            height = 168,
            shift = util.by_pixel(52, -1),
            scale = 0.5
          },
        },
        leaves = {
          width = 98,
          height = 126,
          shift = util.by_pixel(-4, -54),
          hr_version = {
            width = 194,
            height = 252,
            shift = util.by_pixel(-4, -54),
            scale = 0.5
          },
        },
       normal = {
          width = 98,
          height = 106,
          shift = util.by_pixel(-3, -64),
          hr_version = {
            width = 194,
            height = 212,
            shift = util.by_pixel(-3.5, -64),
            scale = 0.5
          },
        },
      },
      { -- g
        trunk = {
          width = 44,
          height = 108,
          shift = util.by_pixel(0, -40),
          hr_version = {
            width = 86,
            height = 214,
            shift = util.by_pixel(0, -40),
            scale = 0.5
          },
        },
        stump = {
          width = 32,
          height = 40,
          shift = util.by_pixel(0, -6),
          hr_version = {
            width = 64,
            height = 74,
            shift = util.by_pixel(0, -5),
            scale = 0.5
          },
        },
        shadow = {
          width = 120,
          height = 84,
          shift = util.by_pixel(42, -6),
          hr_version = {
            width = 238,
            height = 164,
            shift = util.by_pixel(42, -5),
            scale = 0.5
          },
        },
        leaves = {
          width = 90,
          height = 112,
          shift = util.by_pixel(0, -52),
          hr_version = {
            width = 178,
            height = 220,
            shift = util.by_pixel(0, -51),
            scale = 0.5
          },
        },
       normal = {
          width = 88,
          height = 108,
          shift = util.by_pixel(1, -51),
          hr_version = {
            width = 176,
            height = 216,
            shift = util.by_pixel(1, -51),
            scale = 0.5
          },
        },
      },
      { -- h
        trunk = {
          width = 74,
          height = 108,
          shift = util.by_pixel(6, -40),
          hr_version = {
            width = 144,
            height = 212,
            shift = util.by_pixel(7, -39),
            scale = 0.5
          },
        },
        stump = {
          width = 36,
          height = 36,
          shift = util.by_pixel(0, -4),
          hr_version = {
            width = 72,
            height = 76,
            shift = util.by_pixel(0, -5),
            scale = 0.5
          },
        },
        shadow = {
          width = 134,
          height = 62,
          shift = util.by_pixel(50, 0),
          hr_version = {
            width = 270,
            height = 122,
            shift = util.by_pixel(49, 0),
            scale = 0.5
          },
        },
        leaves = {
          width = 114,
          height = 100,
          shift = util.by_pixel(6, -48),
          hr_version = {
            width = 228,
            height = 196,
            shift = util.by_pixel(6, -47),
            scale = 0.5
          },
        },
       normal = {
          width = 114,
          height = 88,
          shift = util.by_pixel(6, -51),
          hr_version = {
            width = 228,
            height = 174,
            shift = util.by_pixel(6.5, -51),
            scale = 0.5
          },
        },
      },
      { -- i
        trunk = {
          width = 34,
          height = 92,
          shift = util.by_pixel(-2, -34),
          hr_version = {
            width = 70,
            height = 184,
            shift = util.by_pixel(-3, -34),
            scale = 0.5
          },
        },
        stump = {
          width = 30,
          height = 32,
          shift = util.by_pixel(0, -4),
          hr_version = {
            width = 58,
            height = 60,
            shift = util.by_pixel(0, -3),
            scale = 0.5
          },
        },
        shadow = {
          width = 108,
          height = 62,
          shift = util.by_pixel(40, -4),
          hr_version = {
            width = 214,
            height = 118,
            shift = util.by_pixel(40, -3),
            scale = 0.5
          },
        },
        leaves = {
          width = 84,
          height = 102,
          shift = util.by_pixel(-6, -46),
          hr_version = {
            width = 166,
            height = 200,
            shift = util.by_pixel(-5, -45),
            scale = 0.5
          },
        },
       normal = {
          width = 84,
          height = 84,
          shift = util.by_pixel(-5, -53),
          hr_version = {
            width = 166,
            height = 166,
            shift = util.by_pixel(-5, -53.5),
            scale = 0.5
          },
        },
      },
      { -- j
        trunk = {
          width = 36,
          height = 84,
          shift = util.by_pixel(2, -30),
          hr_version = {
            width = 66,
            height = 162,
            shift = util.by_pixel(3, -29),
            scale = 0.5
          },
        },
        stump = {
          width = 30,
          height = 32,
          shift = util.by_pixel(0, -4),
          hr_version = {
            width = 56,
            height = 62,
            shift = util.by_pixel(1, -4),
            scale = 0.5
          },
        },
        shadow = {
          width = 98,
          height = 66,
          shift = util.by_pixel(40, 0),
          hr_version = {
            width = 192,
            height = 126,
            shift = util.by_pixel(41, 1),
            scale = 0.5
          },
        },
        leaves = {
          width = 74,
          height = 94,
          shift = util.by_pixel(0, -42),
          hr_version = {
            width = 142,
            height = 184,
            shift = util.by_pixel(1, -41),
            scale = 0.5
          },
        },
       normal = {
          width = 72,
          height = 82,
          shift = util.by_pixel(1, -45),
          hr_version = {
            width = 144,
            height = 164,
            shift = util.by_pixel(1.5, -45),
            scale = 0.5
          },
        },
      },
      { -- k
        trunk = {
          width = 140,
          height = 90,
          shift = util.by_pixel(-18, 8),
          hr_version = {
            width = 274,
            height = 176,
            shift = util.by_pixel(-17, 9),
            scale = 0.5
          },
        },
        stump = {
          width = 56,
          height = 46,
          shift = util.by_pixel(24, -14),
          hr_version = {
            width = 110,
            height = 88,
            shift = util.by_pixel(24, -13),
            scale = 0.5
          },
        },
        shadow = {
          width = 140,
          height = 80,
          shift = util.by_pixel(-14, 12),
          hr_version = {
            width = 276,
            height = 160,
            shift = util.by_pixel(-13, 12),
            scale = 0.5
          },
        },
        leaves = {
          width = 120,
          height = 84,
          shift = util.by_pixel(-30, 6),
          hr_version = {
            width = 234,
            height = 162,
            shift = util.by_pixel(-29, 7),
            scale = 0.5
          },
        },
       normal = {
          width = 86,
          height = 76,
          shift = util.by_pixel(-45, 9),
          hr_version = {
            width = 170,
            height = 152,
            shift = util.by_pixel(-45, 9.5),
            scale = 0.5
          },
        },
      },
      { -- l
        trunk = {
          width = 124,
          height = 94,
          shift = util.by_pixel(16, -22),
          hr_version = {
            width = 252,
            height = 186,
            shift = util.by_pixel(15, -22),
            scale = 0.5
          },
        },
        stump = {
          width = 54,
          height = 34,
          shift = util.by_pixel(-22, 8),
          hr_version = {
            width = 104,
            height = 70,
            shift = util.by_pixel(-21, 7),
            scale = 0.5
          },
        },
        shadow = {
          width = 128,
          height = 94,
          shift = util.by_pixel(22, -18),
          hr_version = {
            width = 258,
            height = 186,
            shift = util.by_pixel(21, -18),
            scale = 0.5
          },
        },
        leaves = {
          width = 124,
          height = 82,
          shift = util.by_pixel(16, -30),
          hr_version = {
            width = 252,
            height = 164,
            shift = util.by_pixel(15, -30),
            scale = 0.5
          },
        },
       normal = {
          width = 80,
          height = 74,
          shift = util.by_pixel(35, -34),
          hr_version = {
            width = 158,
            height = 146,
            shift = util.by_pixel(34.5, -34.5),
            scale = 0.5
          },
        },
      },
    }
  },
  { -- tree-06
    --addHere-tree06 -- "willow"
    type_name = "06",
    drawing_box = {{-0.9, -3.5}, {0.9, 0.6}},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__base__/graphics/entity/tree/06/tree-06-reflection.png",
          priority = "extra-high",
          width = 28,
          height = 32,
          shift = util.by_pixel(-5, 35),
          x = 28 * variation,
          variation_count = 1,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = { -- tree-06
      { -- a
        trunk = {
          width = 72,
          height = 134,
          shift = util.by_pixel(6, -40),
          hr_version = {
            width = 140,
            height = 268,
            shift = util.by_pixel(7, -40),
            scale = 0.5
          },
        },
        stump = {
          width = 60,
          height = 62,
          shift = util.by_pixel(0, -4),
          hr_version = {
            width = 118,
            height = 120,
            shift = util.by_pixel(0, -3),
            scale = 0.5
          },
        },
        shadow = {
          width = 170,
          height = 76,
          shift = util.by_pixel(64, 0),
          hr_version = {
            width = 338,
            height = 148,
            shift = util.by_pixel(64, 1),
            scale = 0.5
          },
        },
        leaves = {
          width = 68,
          height = 98,
          shift = util.by_pixel(10, -50),
          hr_version = {
            width = 132,
            height = 196,
            shift = util.by_pixel(11, -50),
            scale = 0.5
          },
        },
      },
      { -- b
        trunk = {
          width = 84,
          height = 124,
          shift = util.by_pixel(8, -26),
          hr_version = {
            width = 168,
            height = 248,
            shift = util.by_pixel(8, -26),
            scale = 0.5
          },
        },
        stump = {
          width = 62,
          height = 68,
          shift = util.by_pixel(0, 2),
          hr_version = {
            width = 124,
            height = 132,
            shift = util.by_pixel(0, 3),
            scale = 0.5
          },
        },
        shadow = {
          width = 174,
          height = 58,
          shift = util.by_pixel(68, 12),
          hr_version = {
            width = 352,
            height = 116,
            shift = util.by_pixel(67, 12),
            scale = 0.5
          },
        },
        leaves = {
          width = 84,
          height = 94,
          shift = util.by_pixel(10, -40),
          hr_version = {
            width = 172,
            height = 186,
            shift = util.by_pixel(9, -40),
            scale = 0.5
          },
        },
      },
      { -- c
        trunk = {
          width = 100,
          height = 106,
          shift = util.by_pixel(0, -16),
          hr_version = {
            width = 198,
            height = 208,
            shift = util.by_pixel(0, -15),
            scale = 0.5
          },
        },
        stump = {
          width = 62,
          height = 58,
          shift = util.by_pixel(-4, 8),
          hr_version = {
            width = 122,
            height = 116,
            shift = util.by_pixel(-3, 8),
            scale = 0.5
          },
        },
        shadow = {
          width = 174,
          height = 50,
          shift = util.by_pixel(66, 16),
          hr_version = {
            width = 352,
            height = 98,
            shift = util.by_pixel(65, 16),
            scale = 0.5
          },
        },
        leaves = {
          width = 92,
          height = 80,
          shift = util.by_pixel(2, -28),
          hr_version = {
            width = 178,
            height = 162,
            shift = util.by_pixel(3, -29),
            scale = 0.5
          },
        },
      },
      { -- d
        trunk = {
          width = 74,
          height = 124,
          shift = util.by_pixel(-16, -22),
          hr_version = {
            width = 148,
            height = 244,
            shift = util.by_pixel(-16, -21),
            scale = 0.5
          },
        },
        stump = {
          width = 60,
          height = 64,
          shift = util.by_pixel(-6, 8),
          hr_version = {
            width = 120,
            height = 128,
            shift = util.by_pixel(-6, 8),
            scale = 0.5
          },
        },
        shadow = {
          width = 152,
          height = 68,
          shift = util.by_pixel(44, 14),
          hr_version = {
            width = 308,
            height = 130,
            shift = util.by_pixel(43, 15),
            scale = 0.5
          },
        },
        leaves = {
          width = 74,
          height = 92,
          shift = util.by_pixel(-14, -40),
          hr_version = {
            width = 150,
            height = 180,
            shift = util.by_pixel(-15, -39),
            scale = 0.5
          },
        },
      },
      { -- e
        trunk = {
          width = 76,
          height = 134,
          shift = util.by_pixel(-14, -32),
          hr_version = {
            width = 154,
            height = 270,
            shift = util.by_pixel(-15, -33),
            scale = 0.5
          },
        },
        stump = {
          width = 64,
          height = 54,
          shift = util.by_pixel(-8, 8),
          hr_version = {
            width = 126,
            height = 106,
            shift = util.by_pixel(-8, 8),
            scale = 0.5
          },
        },
        shadow = {
          width = 124,
          height = 76,
          shift = util.by_pixel(26, 6),
          hr_version = {
            width = 248,
            height = 146,
            shift = util.by_pixel(26, 7),
            scale = 0.5
          },
        },
        leaves = {
          width = 68,
          height = 114,
          shift = util.by_pixel(-18, -48),
          hr_version = {
            width = 136,
            height = 226,
            shift = util.by_pixel(-18, -48),
            scale = 0.5
          },
        },
      },
      { -- f
        trunk = {
          width = 90,
          height = 136,
          shift = util.by_pixel(-16, -38),
          hr_version = {
            width = 184,
            height = 268,
            shift = util.by_pixel(-17, -37),
            scale = 0.5
          },
        },
        stump = {
          width = 62,
          height = 60,
          shift = util.by_pixel(-10, 0),
          hr_version = {
            width = 122,
            height = 120,
            shift = util.by_pixel(-10, 0),
            scale = 0.5
          },
        },
        shadow = {
          width = 162,
          height = 54,
          shift = util.by_pixel(42, -4),
          hr_version = {
            width = 326,
            height = 110,
            shift = util.by_pixel(42, -5),
            scale = 0.5
          },
        },
        leaves = {
          width = 88,
          height = 114,
          shift = util.by_pixel(-18, -48),
          hr_version = {
            width = 180,
            height = 230,
            shift = util.by_pixel(-19, -49),
            scale = 0.5
          },
        },
      },
      { -- g
        trunk = {
          width = 100,
          height = 132,
          shift = util.by_pixel(-10, -36),
          hr_version = {
            width = 194,
            height = 266,
            shift = util.by_pixel(-9, -36),
            scale = 0.5
          },
        },
        stump = {
          width = 64,
          height = 64,
          shift = util.by_pixel(-8, -2),
          hr_version = {
            width = 122,
            height = 126,
            shift = util.by_pixel(-7, -1),
            scale = 0.5
          },
        },
        shadow = {
          width = 180,
          height = 52,
          shift = util.by_pixel(54, -8),
          hr_version = {
            width = 354,
            height = 100,
            shift = util.by_pixel(55, -7),
            scale = 0.5
          },
        },
        leaves = {
          width = 92,
          height = 116,
          shift = util.by_pixel(-10, -48),
          hr_version = {
            width = 178,
            height = 228,
            shift = util.by_pixel(-9, -47),
            scale = 0.5
          },
        },
      },
      { -- h
        trunk = {
          width = 86,
          height = 130,
          shift = util.by_pixel(4, -36),
          hr_version = {
            width = 166,
            height = 258,
            shift = util.by_pixel(5, -36),
            scale = 0.5
          },
        },
        stump = {
          width = 66,
          height = 58,
          shift = util.by_pixel(-6, 0),
          hr_version = {
            width = 128,
            height = 114,
            shift = util.by_pixel(-5, 0),
            scale = 0.5
          },
        },
        shadow = {
          width = 160,
          height = 76,
          shift = util.by_pixel(56, -8),
          hr_version = {
            width = 320,
            height = 146,
            shift = util.by_pixel(56, -7),
            scale = 0.5
          },
        },
        leaves = {
          width = 74,
          height = 96,
          shift = util.by_pixel(12, -46),
          hr_version = {
            width = 144,
            height = 190,
            shift = util.by_pixel(13, -46),
            scale = 0.5
          },
        },
      },
      { -- i
        trunk = {
          width = 74,
          height = 118,
          shift = util.by_pixel(-14, -20),
          hr_version = {
            width = 152,
            height = 238,
            shift = util.by_pixel(-14, -21),
            scale = 0.5
          },
        },
        stump = {
          width = 70,
          height = 66,
          shift = util.by_pixel(-12, 6),
          hr_version = {
            width = 144,
            height = 126,
            shift = util.by_pixel(-12, 7),
            scale = 0.5
          },
        },
        shadow = {
          width = 116,
          height = 76,
          shift = util.by_pixel(18, 12),
          hr_version = {
            width = 228,
            height = 148,
            shift = util.by_pixel(19, 13),
            scale = 0.5
          },
        },
        leaves = {
          width = 64,
          height = 92,
          shift = util.by_pixel(-18, -36),
          hr_version = {
            width = 132,
            height = 186,
            shift = util.by_pixel(-19, -37),
            scale = 0.5
          },
        },
      },
      { -- j
        trunk = {
          width = 72,
          height = 116,
          shift = util.by_pixel(-12, -22),
          hr_version = {
            width = 142,
            height = 232,
            shift = util.by_pixel(-12, -22),
            scale = 0.5
          },
        },
        stump = {
          width = 68,
          height = 60,
          shift = util.by_pixel(-10, 6),
          hr_version = {
            width = 134,
            height = 116,
            shift = util.by_pixel(-10, 7),
            scale = 0.5
          },
        },
        shadow = {
          width = 128,
          height = 76,
          shift = util.by_pixel(26, 8),
          hr_version = {
            width = 256,
            height = 148,
            shift = util.by_pixel(26, 9),
            scale = 0.5
          },
        },
        leaves = {
          width = 66,
          height = 92,
          shift = util.by_pixel(-14, -38),
          hr_version = {
            width = 134,
            height = 182,
            shift = util.by_pixel(-15, -38),
            scale = 0.5
          },
        },
      },
    },
  },
  { -- tree-07
    --addHere-tree07 -- "Cedar"
    type_name = "07",
    drawing_box = {{-0.9, -3.5}, {0.9, 0.6}},
    negate_tint = { r = 80, g = 77, b = 61 },
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__base__/graphics/entity/tree/07/tree-07-reflection.png",
          priority = "extra-high",
          width = 40,
          height = 40,
          shift = util.by_pixel(0, 65),
          y = 40 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = { -- tree-07
      { -- a
        trunk =
        {
          width = 86,
          height = 160,
          shift = util.by_pixel(-2, -60),
          hr_version =
          {
            width = 174,
            height = 320,
            shift = util.by_pixel(-2, -60),
            scale = 0.5
          }
        },
        stump =
        {
          width = 44,
          height = 46,
          shift = util.by_pixel(0, -4),
          hr_version =
          {
            width = 88,
            height = 88,
            shift = util.by_pixel(0, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 174,
          height = 98,
          shift = util.by_pixel(64, -12),
          hr_version =
          {
            width = 350,
            height = 190,
            shift = util.by_pixel(64, -10),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 122,
          height = 166,
          shift = util.by_pixel(2, -70),
          hr_version =
          {
            width = 244,
            height = 336,
            shift = util.by_pixel(2, -67),
            scale = 0.5
          }
        },
       normal =
        {
          width = 124,
          height = 146,
          shift = util.by_pixel(3, -78),
          hr_version =
          {
            width = 246,
            height = 290,
            shift = util.by_pixel(2.5, -78.5),
            scale = 0.5
          }
        },
      },
      { -- b
        trunk =
        {
          width = 88,
          height = 152,
          shift = util.by_pixel(10, -58),
          hr_version =
          {
            width = 178,
            height = 306,
            shift = util.by_pixel(10, -58),
            scale = 0.5
          }
        },
        stump =
        {
          width = 50,
          height = 44,
          shift = util.by_pixel(0, -4),
          hr_version =
          {
            width = 100,
            height = 86,
            shift = util.by_pixel(0, -3),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 184,
          height = 90,
          shift = util.by_pixel(70, -4),
          hr_version =
          {
            width = 368,
            height = 178,
            shift = util.by_pixel(71, -3),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 142,
          height = 148,
          shift = util.by_pixel(8, -62),
          hr_version =
          {
            width = 280,
            height = 296,
            shift = util.by_pixel(9, -62),
            scale = 0.5
          }
        },
       normal =
        {
          width = 142,
          height = 126,
          shift = util.by_pixel(10, -72),
          hr_version =
          {
            width = 282,
            height = 250,
            shift = util.by_pixel(9.5, -72),
            scale = 0.5
          }
        },
      },
      { -- c
        trunk =
        {
          width = 90,
          height = 152,
          shift = util.by_pixel(-10, -58),
          hr_version =
          {
            width = 180,
            height = 300,
            shift = util.by_pixel(-10, -57),
            scale = 0.5
          }
        },
        stump =
        {
          width = 48,
          height = 44,
          shift = util.by_pixel(0, -4),
          hr_version =
          {
            width = 98,
            height = 82,
            shift = util.by_pixel(1, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 144,
          height = 86,
          shift = util.by_pixel(46, -2),
          hr_version =
          {
            width = 284,
            height = 174,
            shift = util.by_pixel(47, -2),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 136,
          height = 162,
          shift = util.by_pixel(-16, -68),
          hr_version =
          {
            width = 270,
            height = 324,
            shift = util.by_pixel(-15, -68),
            scale = 0.5
          }
        },
       normal =
        {
          width = 136,
          height = 152,
          shift = util.by_pixel(-14, -71),
          hr_version =
          {
            width = 270,
            height = 304,
            shift = util.by_pixel(-14, -71),
            scale = 0.5
          }
        },
      },
      { -- d
        trunk =
        {
          width = 86,
          height = 134,
          shift = util.by_pixel(-2, -50),
          hr_version =
          {
            width = 172,
            height = 268,
            shift = util.by_pixel(-2, -49),
            scale = 0.5
          }
        },
        stump =
        {
          width = 42,
          height = 38,
          shift = util.by_pixel(0, -2),
          hr_version =
          {
            width = 84,
            height = 76,
            shift = util.by_pixel(0, -1),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 148,
          height = 88,
          shift = util.by_pixel(66, 0),
          hr_version =
          {
            width = 290,
            height = 172,
            shift = util.by_pixel(68, 1),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 114,
          height = 142,
          shift = util.by_pixel(0, -68),
          hr_version =
          {
            width = 230,
            height = 290,
            shift = util.by_pixel(0, -66),
            scale = 0.5
          }
        },
       normal =
        {
          width = 116,
          height = 124,
          shift = util.by_pixel(1, -77),
          hr_version =
          {
            width = 232,
            height = 248,
            shift = util.by_pixel(1, -76.5),
            scale = 0.5
          }
        },
      },
      { -- e
        trunk =
        {
          width = 102,
          height = 144,
          shift = util.by_pixel(0, -54),
          hr_version =
          {
            width = 204,
            height = 286,
            shift = util.by_pixel(0, -53),
            scale = 0.5
          }
        },
        stump =
        {
          width = 44,
          height = 40,
          shift = util.by_pixel(0, -2),
          hr_version =
          {
            width = 88,
            height = 78,
            shift = util.by_pixel(1, -1),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 160,
          height = 84,
          shift = util.by_pixel(68, -2),
          hr_version =
          {
            width = 318,
            height = 166,
            shift = util.by_pixel(69, -1),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 122,
          height = 146,
          shift = util.by_pixel(2, -64),
          hr_version =
          {
            width = 244,
            height = 292,
            shift = util.by_pixel(3, -63),
            scale = 0.5
          }
        },
       normal =
        {
          width = 122,
          height = 120,
          shift = util.by_pixel(4, -75),
          hr_version =
          {
            width = 242,
            height = 238,
            shift = util.by_pixel(4, -75.5),
            scale = 0.5
          }
        },
      },
      { -- f
        trunk =
        {
          width = 100,
          height = 140,
          shift = util.by_pixel(-4, -54),
          hr_version =
          {
            width = 196,
            height = 280,
            shift = util.by_pixel(-3, -53),
            scale = 0.5
          }
        },
        stump =
        {
          width = 40,
          height = 36,
          shift = util.by_pixel(0, -2),
          hr_version =
          {
            width = 82,
            height = 76,
            shift = util.by_pixel(0, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 136,
          height = 96,
          shift = util.by_pixel(56, -6),
          hr_version =
          {
            width = 270,
            height = 188,
            shift = util.by_pixel(57, -5),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 128,
          height = 140,
          shift = util.by_pixel(-6, -74),
          hr_version =
          {
            width = 256,
            height = 282,
            shift = util.by_pixel(-5, -74),
            scale = 0.5
          }
        },
       normal =
        {
          width = 128,
          height = 132,
          shift = util.by_pixel(-4, -77),
          hr_version =
          {
            width = 254,
            height = 264,
            shift = util.by_pixel(-4, -77),
            scale = 0.5
          }
        },
      },
      { -- g
        trunk =
        {
          width = 90,
          height = 110,
          shift = util.by_pixel(8, -40),
          hr_version =
          {
            width = 180,
            height = 218,
            shift = util.by_pixel(8, -39),
            scale = 0.5
          }
        },
        stump =
        {
          width = 42,
          height = 34,
          shift = util.by_pixel(0, -2),
          hr_version =
          {
            width = 86,
            height = 72,
            shift = util.by_pixel(0, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 136,
          height = 76,
          shift = util.by_pixel(58, -2),
          hr_version =
          {
            width = 266,
            height = 154,
            shift = util.by_pixel(60, -2),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 110,
          height = 128,
          shift = util.by_pixel(10, -54),
          hr_version =
          {
            width = 222,
            height = 258,
            shift = util.by_pixel(10, -54),
            scale = 0.5
          }
        },
       normal =
        {
          width = 112,
          height = 112,
          shift = util.by_pixel(11, -61),
          hr_version =
          {
            width = 222,
            height = 222,
            shift = util.by_pixel(10.5, -61),
            scale = 0.5
          }
        },
      },
      { -- h
        trunk =
        {
          width = 86,
          height = 126,
          shift = util.by_pixel(-12, -44),
          hr_version =
          {
            width = 166,
            height = 246,
            shift = util.by_pixel(-10, -42),
            scale = 0.5
          }
        },
        stump =
        {
          width = 40,
          height = 40,
          shift = util.by_pixel(0, -2),
          hr_version =
          {
            width = 84,
            height = 76,
            shift = util.by_pixel(0, 0),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 146,
          height = 74,
          shift = util.by_pixel(46, 0),
          hr_version =
          {
            width = 288,
            height = 146,
            shift = util.by_pixel(47, 1),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 114,
          height = 116,
          shift = util.by_pixel(-10, -56),
          hr_version =
          {
            width = 228,
            height = 242,
            shift = util.by_pixel(-10, -53),
            scale = 0.5
          }
        },
       normal =
        {
          width = 114,
          height = 110,
          shift = util.by_pixel(-9, -57),
          hr_version =
          {
            width = 226,
            height = 218,
            shift = util.by_pixel(-9, -57.5),
            scale = 0.5
          }
        },
      },
      { -- i
        trunk =
        {
          width = 72,
          height = 102,
          shift = util.by_pixel(0, -36),
          hr_version =
          {
            width = 142,
            height = 204,
            shift = util.by_pixel(1, -35),
            scale = 0.5
          }
        },
        stump =
        {
          width = 40,
          height = 38,
          shift = util.by_pixel(2, -4),
          hr_version =
          {
            width = 80,
            height = 72,
            shift = util.by_pixel(2, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 114,
          height = 72,
          shift = util.by_pixel(46, -2),
          hr_version =
          {
            width = 222,
            height = 140,
            shift = util.by_pixel(48, -1),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 92,
          height = 110,
          shift = util.by_pixel(-2, -56),
          hr_version =
          {
            width = 182,
            height = 218,
            shift = util.by_pixel(-1, -54),
            scale = 0.5
          }
        },
       normal =
        {
          width = 92,
          height = 104,
          shift = util.by_pixel(-1, -56),
          hr_version =
          {
            width = 184,
            height = 206,
            shift = util.by_pixel(-0.5, -56.5),
            scale = 0.5
          }
        },
      },
      { -- j
        trunk =
        {
          width = 76,
          height = 98,
          shift = util.by_pixel(-2, -34),
          hr_version =
          {
            width = 154,
            height = 198,
            shift = util.by_pixel(-2, -34),
            scale = 0.5
          }
        },
        stump =
        {
          width = 40,
          height = 40,
          shift = util.by_pixel(0, -6),
          hr_version =
          {
            width = 80,
            height = 80,
            shift = util.by_pixel(1, -5),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 130,
          height = 62,
          shift = util.by_pixel(52, 0),
          hr_version =
          {
            width = 258,
            height = 126,
            shift = util.by_pixel(53, 0),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 100,
          height = 98,
          shift = util.by_pixel(2, -44),
          hr_version =
          {
            width = 200,
            height = 200,
            shift = util.by_pixel(2, -44),
            scale = 0.5
          }
        },
       normal =
        {
          width = 102,
          height = 86,
          shift = util.by_pixel(2, -50),
          hr_version =
          {
            width = 202,
            height = 170,
            shift = util.by_pixel(2, -50.5),
            scale = 0.5
          }
        },
      },
      { -- k
        trunk =
        {
          width = 114,
          height = 136,
          shift = util.by_pixel(2, -22),
          hr_version =
          {
            width = 226,
            height = 274,
            shift = util.by_pixel(3, -22),
            scale = 0.5
          }
        },
        stump =
        {
          width = 62,
          height = 48,
          shift = util.by_pixel(-10, 10),
          hr_version =
          {
            width = 120,
            height = 96,
            shift = util.by_pixel(-9, 11),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 132,
          height = 114,
          shift = util.by_pixel(20, -14),
          hr_version =
          {
            width = 264,
            height = 230,
            shift = util.by_pixel(20, -14),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 100,
          height = 100,
          shift = util.by_pixel(16, -44),
          hr_version =
          {
            width = 204,
            height = 198,
            shift = util.by_pixel(15, -43),
            scale = 0.5
          }
        },
       normal =
        {
          width = 102,
          height = 92,
          shift = util.by_pixel(16, -47),
          hr_version =
          {
            width = 204,
            height = 184,
            shift = util.by_pixel(16, -46.5),
            scale = 0.5
          }
        },
      },
      { -- l
        trunk =
        {
          width = 160,
          height = 62,
          shift = util.by_pixel(-28, 4),
          hr_version =
          {
            width = 314,
            height = 124,
            shift = util.by_pixel(-26, 4),
            scale = 0.5
          }
        },
        stump =
        {
          width = 54,
          height = 46,
          shift = util.by_pixel(2, -2),
          hr_version =
          {
            width = 104,
            height = 94,
            shift = util.by_pixel(3, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 176,
          height = 80,
          shift = util.by_pixel(-24, 14),
          hr_version =
          {
            width = 354,
            height = 156,
            shift = util.by_pixel(-24, 15),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 164,
          height = 72,
          shift = util.by_pixel(-32, 2),
          hr_version =
          {
            width = 328,
            height = 144,
            shift = util.by_pixel(-31, 3),
            scale = 0.5
          }
        },
       normal =
        {
          width = 122,
          height = 74,
          shift = util.by_pixel(-51, 4),
          hr_version =
          {
            width = 242,
            height = 146,
            shift = util.by_pixel(-51, 3.5),
            scale = 0.5
          }
        },
      }
    },
  },
  { -- tree-08
    --addHere-tree08 -- "beech"
    type_name = "08",
    drawing_box = {{-0.9, -3}, {0.9, 0.6}},
    negate_tint = { r = 80, g = 77, b = 61 },
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__base__/graphics/entity/tree/08/tree-08-reflection.png",
          priority = "extra-high",
          width = 36,
          height = 40,
          shift = util.by_pixel(0, 75),
          y = 40 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = { -- tree-08
      { -- a
        trunk =
        {
          width = 106,
          height = 142,
          shift = util.by_pixel(-6, -58),
          hr_version =
          {
            width = 210,
            height = 286,
            shift = util.by_pixel(-5, -58),
            scale = 0.5
          }
        },
        stump =
        {
          width = 40,
          height = 34,
          shift = util.by_pixel(2, -4),
          hr_version =
          {
            width = 76,
            height = 70,
            shift = util.by_pixel(3, -4),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 156,
          height = 110,
          shift = util.by_pixel(70, 2),
          hr_version =
          {
            width = 310,
            height = 222,
            shift = util.by_pixel(71, 2),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 130,
          height = 142,
          shift = util.by_pixel(-6, -78),
          hr_version =
          {
            width = 262,
            height = 282,
            shift = util.by_pixel(-6, -77),
            scale = 0.5
          }
        },
       normal =
        {
          width = 130,
          height = 112,
          shift = util.by_pixel(-5, -91),
          hr_version =
          {
            width = 260,
            height = 222,
            shift = util.by_pixel(-5, -91),
            scale = 0.5
          }
        },
      },
      { -- b
        trunk =
        {
          width = 120,
          height = 138,
          shift = util.by_pixel(-4, -56),
          hr_version =
          {
            width = 238,
            height = 276,
            shift = util.by_pixel(-3, -55),
            scale = 0.5
          }
        },
        stump =
        {
          width = 40,
          height = 36,
          shift = util.by_pixel(0, -4),
          hr_version =
          {
            width = 76,
            height = 68,
            shift = util.by_pixel(1, -3),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 162,
          height = 90,
          shift = util.by_pixel(76, -6),
          hr_version =
          {
            width = 322,
            height = 178,
            shift = util.by_pixel(77, -5),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 162,
          height = 154,
          shift = util.by_pixel(-4, -72),
          hr_version =
          {
            width = 322,
            height = 306,
            shift = util.by_pixel(-3, -70),
            scale = 0.5
          }
        },
       normal =
        {
          width = 162,
          height = 104,
          shift = util.by_pixel(-2, -95),
          hr_version =
          {
            width = 322,
            height = 206,
            shift = util.by_pixel(-2, -95),
            scale = 0.5
          }
        },
      },
      { -- c
        trunk =
        {
          width = 106,
          height = 152,
          shift = util.by_pixel(2, -64),
          hr_version =
          {
            width = 210,
            height = 300,
            shift = util.by_pixel(3, -63),
            scale = 0.5
          }
        },
        stump =
        {
          width = 38,
          height = 36,
          shift = util.by_pixel(0, -6),
          hr_version =
          {
            width = 72,
            height = 66,
            shift = util.by_pixel(1, -4),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 166,
          height = 114,
          shift = util.by_pixel(70, -2),
          hr_version =
          {
            width = 326,
            height = 228,
            shift = util.by_pixel(72, -2),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 126,
          height = 146,
          shift = util.by_pixel(6, -84),
          hr_version =
          {
            width = 252,
            height = 294,
            shift = util.by_pixel(6, -83),
            scale = 0.5
          }
        },
       normal =
        {
          width = 128,
          height = 130,
          shift = util.by_pixel(7, -90),
          hr_version =
          {
            width = 254,
            height = 260,
            shift = util.by_pixel(6.5, -90),
            scale = 0.5
          }
        },
      },
      { -- d
        trunk =
        {
          width = 84,
          height = 114,
          shift = util.by_pixel(0, -46),
          hr_version =
          {
            width = 166,
            height = 228,
            shift = util.by_pixel(1, -45),
            scale = 0.5
          }
        },
        stump =
        {
          width = 36,
          height = 36,
          shift = util.by_pixel(4, -6),
          hr_version =
          {
            width = 74,
            height = 68,
            shift = util.by_pixel(4, -5),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 138,
          height = 86,
          shift = util.by_pixel(70, 6),
          hr_version =
          {
            width = 274,
            height = 170,
            shift = util.by_pixel(71, 7),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 110,
          height = 110,
          shift = util.by_pixel(-2, -74),
          hr_version =
          {
            width = 214,
            height = 220,
            shift = util.by_pixel(0, -73),
            scale = 0.5
          }
        },
       normal =
        {
          width = 108,
          height = 92,
          shift = util.by_pixel(0, -82),
          hr_version =
          {
            width = 216,
            height = 182,
            shift = util.by_pixel(0.5, -82),
            scale = 0.5
          }
        },
      },
      { -- e
        trunk =
        {
          width = 86,
          height = 122,
          shift = util.by_pixel(-8, -50),
          hr_version =
          {
            width = 172,
            height = 242,
            shift = util.by_pixel(-7, -49),
            scale = 0.5
          }
        },
        stump =
        {
          width = 40,
          height = 30,
          shift = util.by_pixel(2, -4),
          hr_version =
          {
            width = 76,
            height = 62,
            shift = util.by_pixel(3, -4),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 150,
          height = 76,
          shift = util.by_pixel(64, 4),
          hr_version =
          {
            width = 296,
            height = 150,
            shift = util.by_pixel(65, 5),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 118,
          height = 106,
          shift = util.by_pixel(0, -72),
          hr_version =
          {
            width = 228,
            height = 210,
            shift = util.by_pixel(2, -71),
            scale = 0.5
          }
        },
       normal =
        {
          width = 116,
          height = 84,
          shift = util.by_pixel(3, -79),
          hr_version =
          {
            width = 228,
            height = 166,
            shift = util.by_pixel(2.5, -79.5),
            scale = 0.5
          }
        },
      },
      { -- f
        trunk =
        {
          width = 84,
          height = 138,
          shift = util.by_pixel(-4, -56),
          hr_version =
          {
            width = 166,
            height = 272,
            shift = util.by_pixel(-3, -55),
            scale = 0.5
          }
        },
        stump =
        {
          width = 36,
          height = 34,
          shift = util.by_pixel(-2, -4),
          hr_version =
          {
            width = 70,
            height = 64,
            shift = util.by_pixel(-1, -3),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 138,
          height = 86,
          shift = util.by_pixel(62, -8),
          hr_version =
          {
            width = 274,
            height = 170,
            shift = util.by_pixel(63, -7),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 108,
          height = 148,
          shift = util.by_pixel(-2, -68),
          hr_version =
          {
            width = 218,
            height = 294,
            shift = util.by_pixel(-2, -67),
            scale = 0.5
          }
        },
       normal =
        {
          width = 108,
          height = 102,
          shift = util.by_pixel(-1, -90),
          hr_version =
          {
            width = 216,
            height = 200,
            shift = util.by_pixel(-1, -90.5),
            scale = 0.5
          }
        },
      },
      { -- g
        trunk =
        {
          width = 72,
          height = 112,
          shift = util.by_pixel(14, -44),
          hr_version =
          {
            width = 146,
            height = 222,
            shift = util.by_pixel(14, -43),
            scale = 0.5
          }
        },
        stump =
        {
          width = 34,
          height = 28,
          shift = util.by_pixel(2, -2),
          hr_version =
          {
            width = 68,
            height = 56,
            shift = util.by_pixel(3, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 136,
          height = 72,
          shift = util.by_pixel(64, -10),
          hr_version =
          {
            width = 272,
            height = 138,
            shift = util.by_pixel(64, -8),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 94,
          height = 96,
          shift = util.by_pixel(12, -72),
          hr_version =
          {
            width = 190,
            height = 192,
            shift = util.by_pixel(12, -71),
            scale = 0.5
          }
        },
       normal =
        {
          width = 96,
          height = 82,
          shift = util.by_pixel(12, -77),
          hr_version =
          {
            width = 192,
            height = 164,
            shift = util.by_pixel(12.5, -77),
            scale = 0.5
          }
        },
      },
      { -- h
        trunk =
        {
          width = 80,
          height = 94,
          shift = util.by_pixel(-10, -34),
          hr_version =
          {
            width = 160,
            height = 190,
            shift = util.by_pixel(-10, -34),
            scale = 0.5
          }
        },
        stump =
        {
          width = 32,
          height = 30,
          shift = util.by_pixel(-2, -2),
          hr_version =
          {
            width = 62,
            height = 58,
            shift = util.by_pixel(-1, -1),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 114,
          height = 66,
          shift = util.by_pixel(52, 6),
          hr_version =
          {
            width = 224,
            height = 128,
            shift = util.by_pixel(53, 7),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 110,
          height = 86,
          shift = util.by_pixel(-10, -54),
          hr_version =
          {
            width = 218,
            height = 174,
            shift = util.by_pixel(-9, -54),
            scale = 0.5
          }
        },
       normal =
        {
          width = 110,
          height = 78,
          shift = util.by_pixel(-8, -58),
          hr_version =
          {
            width = 218,
            height = 152,
            shift = util.by_pixel(-8.5, -58.5),
            scale = 0.5
          }
        },
      },
      { -- i
        trunk =
        {
          width = 38,
          height = 90,
          shift = util.by_pixel(-2, -34),
          hr_version =
          {
            width = 78,
            height = 176,
            shift = util.by_pixel(-2, -33),
            scale = 0.5
          }
        },
        stump =
        {
          width = 34,
          height = 34,
          shift = util.by_pixel(2, -6),
          hr_version =
          {
            width = 68,
            height = 62,
            shift = util.by_pixel(2, -4),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 94,
          height = 52,
          shift = util.by_pixel(44, -6),
          hr_version =
          {
            width = 186,
            height = 102,
            shift = util.by_pixel(45, -5),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 66,
          height = 84,
          shift = util.by_pixel(2, -60),
          hr_version =
          {
            width = 130,
            height = 168,
            shift = util.by_pixel(3, -60),
            scale = 0.5
          }
        },
       normal =
        {
          width = 64,
          height = 78,
          shift = util.by_pixel(4, -62),
          hr_version =
          {
            width = 128,
            height = 154,
            shift = util.by_pixel(4, -62.5),
            scale = 0.5
          }
        },
      },
      { -- j
        trunk =
        {
          width = 46,
          height = 90,
          shift = util.by_pixel(2, -34),
          hr_version =
          {
            width = 88,
            height = 180,
            shift = util.by_pixel(3, -33),
            scale = 0.5
          }
        },
        stump =
        {
          width = 34,
          height = 32,
          shift = util.by_pixel(2, -4),
          hr_version =
          {
            width = 64,
            height = 64,
            shift = util.by_pixel(3, -4),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 104,
          height = 50,
          shift = util.by_pixel(46, -2),
          hr_version =
          {
            width = 208,
            height = 100,
            shift = util.by_pixel(46, -2),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 82,
          height = 78,
          shift = util.by_pixel(2, -56),
          hr_version =
          {
            width = 162,
            height = 160,
            shift = util.by_pixel(3, -56),
            scale = 0.5
          }
        },
       normal =
        {
          width = 82,
          height = 74,
          shift = util.by_pixel(4, -59),
          hr_version =
          {
            width = 162,
            height = 148,
            shift = util.by_pixel(4, -58.5),
            scale = 0.5
          }
        },
      },
      { -- k
        trunk =
        {
          width = 150,
          height = 108,
          shift = util.by_pixel(-22, -24),
          hr_version =
          {
            width = 300,
            height = 218,
            shift = util.by_pixel(-22, -24),
            scale = 0.5
          }
        },
        stump =
        {
          width = 54,
          height = 38,
          shift = util.by_pixel(12, 0),
          hr_version =
          {
            width = 110,
            height = 78,
            shift = util.by_pixel(12, 0),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 160,
          height = 90,
          shift = util.by_pixel(-18, -16),
          hr_version =
          {
            width = 320,
            height = 180,
            shift = util.by_pixel(-18, -16),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 150,
          height = 120,
          shift = util.by_pixel(-38, -36),
          hr_version =
          {
            width = 308,
            height = 240,
            shift = util.by_pixel(-34, -35),
            scale = 0.5
          }
        },
       normal =
        {
          width = 92,
          height = 94,
          shift = util.by_pixel(-66, -47),
          hr_version =
          {
            width = 180,
            height = 188,
            shift = util.by_pixel(-66.5, -46.5),
            scale = 0.5
          }
        },
      },
      { -- l
        trunk =
        {
          width = 138,
          height = 102,
          shift = util.by_pixel(24, 10),
          hr_version =
          {
            width = 274,
            height = 204,
            shift = util.by_pixel(25, 10),
            scale = 0.5
          }
        },
        stump =
        {
          width = 52,
          height = 46,
          shift = util.by_pixel(-2, -2),
          hr_version =
          {
            width = 102,
            height = 92,
            shift = util.by_pixel(-1, -1),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 162,
          height = 108,
          shift = util.by_pixel(42, 24),
          hr_version =
          {
            width = 324,
            height = 216,
            shift = util.by_pixel(42, 24),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 122,
          height = 98,
          shift = util.by_pixel(48, 8),
          hr_version =
          {
            width = 246,
            height = 198,
            shift = util.by_pixel(48, 9),
            scale = 0.5
          }
        },
       normal =
        {
          width = 100,
          height = 54,
          shift = util.by_pixel(60, 28),
          hr_version =
          {
            width = 200,
            height = 108,
            shift = util.by_pixel(60, 28),
            scale = 0.5
          }
        },
      }
    },
  },
  { -- tree-09 -- "baobab"
    --addHere-tree09
    type_name = "09",
    drawing_box = {{-0.9, -3.5}, {0.9, 0.6}},
    negate_tint = { r = 128, g = 124, b = 104},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__base__/graphics/entity/tree/09/tree-09-reflection.png",
          priority = "extra-high",
          width = 44,
          height = 48,
          shift = util.by_pixel(5, 75),
          y = 48 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = { -- tree-09
      { -- a
        trunk =
        {
          width = 154,
          height = 194,
          shift = util.by_pixel(0, -68),
          hr_version =
          {
            width = 308,
            height = 392,
            shift = util.by_pixel(0, -68),
            scale = 0.5
          }
        },
        stump =
        {
          width = 90,
          height = 62,
          shift = util.by_pixel(-4, -2),
          hr_version =
          {
            width = 182,
            height = 124,
            shift = util.by_pixel(-4, -1),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 232,
          height = 106,
          shift = util.by_pixel(84, 0),
          hr_version =
          {
            width = 458,
            height = 214,
            shift = util.by_pixel(86, 0),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 174,
          height = 196,
          shift = util.by_pixel(0, -80),
          hr_version =
          {
            width = 350,
            height = 390,
            shift = util.by_pixel(0, -78),
            scale = 0.5
          }
        },
        normal =
        {
          width = 176,
          height = 148,
          shift = util.by_pixel(1, -102),
          hr_version =
          {
            width = 350,
            height = 294,
            shift = util.by_pixel(1, -102),
            scale = 0.5
          }
        },
      },
      { -- b
        trunk =
        {
          width = 146,
          height = 196,
          shift = util.by_pixel(8, -70),
          hr_version =
          {
            width = 294,
            height = 390,
            shift = util.by_pixel(8, -69),
            scale = 0.5
          }
        },
        stump =
        {
          width = 90,
          height = 64,
          shift = util.by_pixel(4, -4),
          hr_version =
          {
            width = 178,
            height = 124,
            shift = util.by_pixel(5, -2),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 186,
          height = 114,
          shift = util.by_pixel(82, 6),
          hr_version =
          {
            width = 374,
            height = 226,
            shift = util.by_pixel(82, 7),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 168,
          height = 182,
          shift = util.by_pixel(6, -88),
          hr_version =
          {
            width = 334,
            height = 368,
            shift = util.by_pixel(7, -88),
            scale = 0.5
          }
        },
       normal =
        {
          width = 168,
          height = 154,
          shift = util.by_pixel(8, -102),
          hr_version =
          {
            width = 336,
            height = 306,
            shift = util.by_pixel(8, -102),
            scale = 0.5
          }
        },
      },
      { -- c
        trunk =
        {
          width = 130,
          height = 196,
          shift = util.by_pixel(-4, -66),
          hr_version =
          {
            width = 258,
            height = 392,
            shift = util.by_pixel(-3, -65),
            scale = 0.5
          }
        },
        stump =
        {
          width = 72,
          height = 64,
          shift = util.by_pixel(-4, 0),
          hr_version =
          {
            width = 144,
            height = 128,
            shift = util.by_pixel(-3, 1),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 184,
          height = 110,
          shift = util.by_pixel(72, -4),
          hr_version =
          {
            width = 364,
            height = 222,
            shift = util.by_pixel(73, -4),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 134,
          height = 202,
          shift = util.by_pixel(2, -78),
          hr_version =
          {
            width = 266,
            height = 408,
            shift = util.by_pixel(3, -78),
            scale = 0.5
          }
        },
       normal =
        {
          width = 134,
          height = 180,
          shift = util.by_pixel(3, -89),
          hr_version =
          {
            width = 268,
            height = 356,
            shift = util.by_pixel(3.5, -89.5),
            scale = 0.5
          }
        },
      },
      { -- d
        trunk =
        {
          width = 132,
          height = 172,
          shift = util.by_pixel(4, -56),
          hr_version =
          {
            width = 264,
            height = 348,
            shift = util.by_pixel(4, -56),
            scale = 0.5
          }
        },
        stump =
        {
          width = 74,
          height = 68,
          shift = util.by_pixel(0, -4),
          hr_version =
          {
            width = 146,
            height = 140,
            shift = util.by_pixel(1, -4),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 172,
          height = 118,
          shift = util.by_pixel(80, -2),
          hr_version =
          {
            width = 344,
            height = 232,
            shift = util.by_pixel(80, -1),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 144,
          height = 152,
          shift = util.by_pixel(-2, -76),
          hr_version =
          {
            width = 284,
            height = 308,
            shift = util.by_pixel(-1, -76),
            scale = 0.5
          }
        },
       normal =
        {
          width = 142,
          height = 128,
          shift = util.by_pixel(0, -88),
          hr_version =
          {
            width = 282,
            height = 256,
            shift = util.by_pixel(0, -87.5),
            scale = 0.5
          }
        },
      },
      { -- e
        trunk =
        {
          width = 126,
          height = 138,
          shift = util.by_pixel(10, -46),
          hr_version =
          {
            width = 252,
            height = 272,
            shift = util.by_pixel(10, -44),
            scale = 0.5
          }
        },
        stump =
        {
          width = 64,
          height = 50,
          shift = util.by_pixel(-2, -2),
          hr_version =
          {
            width = 126,
            height = 100,
            shift = util.by_pixel(-1, -1),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 154,
          height = 96,
          shift = util.by_pixel(72, 12),
          hr_version =
          {
            width = 306,
            height = 190,
            shift = util.by_pixel(73, 13),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 138,
          height = 130,
          shift = util.by_pixel(12, -56),
          hr_version =
          {
            width = 280,
            height = 264,
            shift = util.by_pixel(12, -56),
            scale = 0.5
          }
        },
       normal =
        {
          width = 140,
          height = 112,
          shift = util.by_pixel(13, -65),
          hr_version =
          {
            width = 278,
            height = 224,
            shift = util.by_pixel(13, -65),
            scale = 0.5
          }
        },
      },
      { -- f
        trunk =
        {
          width = 124,
          height = 144,
          shift = util.by_pixel(-20, -48),
          hr_version =
          {
            width = 246,
            height = 286,
            shift = util.by_pixel(-19, -47),
            scale = 0.5
          }
        },
        stump =
        {
          width = 68,
          height = 48,
          shift = util.by_pixel(2, 0),
          hr_version =
          {
            width = 132,
            height = 98,
            shift = util.by_pixel(4, 0),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 142,
          height = 96,
          shift = util.by_pixel(54, 6),
          hr_version =
          {
            width = 282,
            height = 184,
            shift = util.by_pixel(55, 8),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 128,
          height = 146,
          shift = util.by_pixel(-10, -60),
          hr_version =
          {
            width = 260,
            height = 288,
            shift = util.by_pixel(-11, -58),
            scale = 0.5
          }
        },
       normal =
        {
          width = 130,
          height = 128,
          shift = util.by_pixel(-9, -66),
          hr_version =
          {
            width = 258,
            height = 254,
            shift = util.by_pixel(-9.5, -66.5),
            scale = 0.5
          }
        },
      },
      { -- g
        trunk =
        {
          width = 122,
          height = 156,
          shift = util.by_pixel(-12, -52),
          hr_version =
          {
            width = 240,
            height = 312,
            shift = util.by_pixel(-11, -52),
            scale = 0.5
          }
        },
        stump =
        {
          width = 60,
          height = 50,
          shift = util.by_pixel(0, 0),
          hr_version =
          {
            width = 126,
            height = 104,
            shift = util.by_pixel(0, 0),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 156,
          height = 90,
          shift = util.by_pixel(54, -14),
          hr_version =
          {
            width = 310,
            height = 182,
            shift = util.by_pixel(55, -14),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 134,
          height = 148,
          shift = util.by_pixel(-14, -68),
          hr_version =
          {
            width = 266,
            height = 296,
            shift = util.by_pixel(-13, -67),
            scale = 0.5
          }
        },
       normal =
        {
          width = 134,
          height = 110,
          shift = util.by_pixel(-12, -85),
          hr_version =
          {
            width = 266,
            height = 218,
            shift = util.by_pixel(-12.5, -85.5),
            scale = 0.5
          }
        },
      },
      { -- h
        trunk =
        {
          width = 128,
          height = 156,
          shift = util.by_pixel(18, -52),
          hr_version =
          {
            width = 256,
            height = 312,
            shift = util.by_pixel(18, -52),
            scale = 0.5
          }
        },
        stump =
        {
          width = 60,
          height = 50,
          shift = util.by_pixel(0, 0),
          hr_version =
          {
            width = 122,
            height = 102,
            shift = util.by_pixel(0, 1),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 150,
          height = 96,
          shift = util.by_pixel(74, -10),
          hr_version =
          {
            width = 296,
            height = 192,
            shift = util.by_pixel(75, -10),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 122,
          height = 148,
          shift = util.by_pixel(18, -66),
          hr_version =
          {
            width = 250,
            height = 292,
            shift = util.by_pixel(18, -64),
            scale = 0.5
          }
        },
       normal =
        {
          width = 120,
          height = 110,
          shift = util.by_pixel(17, -83),
          hr_version =
          {
            width = 238,
            height = 216,
            shift = util.by_pixel(17, -83.5),
            scale = 0.5
          }
        },
      }
    },
  },
  { -- tree-01
    --addHere-tree01
    type_name = "oaktapus",
    alien_biomes_texture = true,
    normals_match_leaves = true,
    drawing_box = {{-0.9, -3}, {0.9, 0.6}},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__alien-biomes__/graphics/entity/tree/oaktapus/tree-oaktapus-reflection.png",
          priority = "extra-high",
          width = 148/4,
          height = 390/10,
          shift = util.by_pixel(0, 60),
          y = 390/10 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = {
      { -- a
        trunk = {
          width = 177,
          height = 150,
          shift = util.by_pixel(29.5, -38),
          hr_version = {
            width = 354,
            height = 298,
            shift = util.by_pixel(30.5, -37.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 102,
          height = 115,
          shift = util.by_pixel(-11, -65.5),
          hr_version = {
            width = 204,
            height = 231,
            shift = util.by_pixel(-10.5, -64.75),
            scale = 0.5
          },
        },
      },
      { -- b
        trunk = {
          width = 179,
          height = 149,
          shift = util.by_pixel(49.5, -40.5),
          hr_version = {
            width = 358,
            height = 298,
            shift = util.by_pixel(50, -40),
            scale = 0.5
          },
        },
        leaves = {
          width = 89,
          height = 107,
          shift = util.by_pixel(3.5, -69.5),
          hr_version = {
            width = 178,
            height = 215,
            shift = util.by_pixel(4, -69.25),
            scale = 0.5
          },
        },
      },
      { -- c
        trunk = {
          width = 156,
          height = 146,
          shift = util.by_pixel(52, -34),
          hr_version = {
            width = 313,
            height = 291,
            shift = util.by_pixel(52.25, -33.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 94,
          height = 104,
          shift = util.by_pixel(6, -64),
          hr_version = {
            width = 190,
            height = 210,
            shift = util.by_pixel(6.5, -63.5),
            scale = 0.5
          },
        },
      },
      { -- d
        trunk = {
          width = 176,
          height = 152,
          shift = util.by_pixel(55, -35),
          hr_version = {
            width = 351,
            height = 302,
            shift = util.by_pixel(55.25, -34.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 102,
          height = 106,
          shift = util.by_pixel(12, -63),
          hr_version = {
            width = 205,
            height = 212,
            shift = util.by_pixel(12.25, -62),
            scale = 0.5
          },
        },
      },
      { -- e
        trunk = {
          width = 174,
          height = 141,
          shift = util.by_pixel(56, -35.5),
          hr_version = {
            width = 346,
            height = 281,
            shift = util.by_pixel(56.5, -34.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 105,
          height = 110,
          shift = util.by_pixel(16.5, -55),
          hr_version = {
            width = 212,
            height = 221,
            shift = util.by_pixel(17, -54.75),
            scale = 0.5
          },
        },
      },
      { -- f
        trunk = {
          width = 176,
          height = 141,
          shift = util.by_pixel(42, -22.5),
          hr_version = {
            width = 350,
            height = 280,
            shift = util.by_pixel(42.5, -22),
            scale = 0.5
          },
        },
        leaves = {
          width = 95,
          height = 101,
          shift = util.by_pixel(0.5, -46.5),
          hr_version = {
            width = 191,
            height = 203,
            shift = util.by_pixel(0.75, -45.75),
            scale = 0.5
          },
        },
      },
      { -- g
        trunk = {
          width = 164,
          height = 150,
          shift = util.by_pixel(20, -24),
          hr_version = {
            width = 328,
            height = 301,
            shift = util.by_pixel(20.5, -23.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 96,
          height = 119,
          shift = util.by_pixel(-18, -50.5),
          hr_version = {
            width = 193,
            height = 239,
            shift = util.by_pixel(-17.75, -49.75),
            scale = 0.5
          },
        },
      },
      { -- h
        trunk = {
          width = 181,
          height = 144,
          shift = util.by_pixel(26.5, -33),
          hr_version = {
            width = 360,
            height = 288,
            shift = util.by_pixel(27, -32.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 108,
          height = 108,
          shift = util.by_pixel(-20, -59),
          hr_version = {
            width = 216,
            height = 216,
            shift = util.by_pixel(-20, -59),
            scale = 0.5
          },
        },
      },
      { -- i
        trunk = {
          width = 165,
          height = 162,
          shift = util.by_pixel(41.5, -22),
          hr_version = {
            width = 329,
            height = 323,
            shift = util.by_pixel(41.75, -21.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 88,
          height = 121,
          shift = util.by_pixel(0, -47.5),
          hr_version = {
            width = 177,
            height = 244,
            shift = util.by_pixel(0.75, -47),
            scale = 0.5
          },
        },
      },
      { -- j
        trunk = {
          width = 132,
          height = 115,
          shift = util.by_pixel(35, -29.5),
          hr_version = {
            width = 264,
            height = 229,
            shift = util.by_pixel(35.5, -29.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 89,
          height = 90,
          shift = util.by_pixel(4.5, -53),
          hr_version = {
            width = 180,
            height = 179,
            shift = util.by_pixel(5, -52.25),
            scale = 0.5
          },
        },
      },
    },
  },
  { -- tree-02
    --addHere-tree02
    type_name = "greypine",
    alien_biomes_texture = true,
    normals_match_leaves = true,
    drawing_box = {{-0.9, -3.9}, {0.9, 0.6}},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__alien-biomes__/graphics/entity/tree/greypine/tree-greypine-reflection.png",
          priority = "extra-high",
          width = 132/4,
          height = 225/5,
          shift = util.by_pixel(0, 60),
          y = 225/5 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = {
      { -- a
        trunk = {
          width = 225,
          height = 169,
          shift = util.by_pixel(61.5, -46.5),
          hr_version = {
            width = 448,
            height = 340,
            shift = util.by_pixel(61.5, -47.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 95,
          height = 131,
          shift = util.by_pixel(-4.5, -70.5),
          hr_version = {
            width = 190,
            height = 261,
            shift = util.by_pixel(-4.5, -70.75),
            scale = 0.5
          },
        },
      },
      { -- b
        trunk = {
          width = 279,
          height = 193,
          shift = util.by_pixel(31.5, -43.5),
          hr_version = {
            width = 558,
            height = 385,
            shift = util.by_pixel(32, -43.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 98,
          height = 143,
          shift = util.by_pixel(-6, -70.5),
          hr_version = {
            width = 194,
            height = 285,
            shift = util.by_pixel(-6, -70.25),
            scale = 0.5
          },
        },
      },
      { -- c
        trunk = {
          width = 249,
          height = 188,
          shift = util.by_pixel(69.5, -51),
          hr_version = {
            width = 499,
            height = 377,
            shift = util.by_pixel(69.25, -50.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 106,
          height = 154,
          shift = util.by_pixel(-3, -83),
          hr_version = {
            width = 213,
            height = 309,
            shift = util.by_pixel(-3.25, -83.25),
            scale = 0.5
          },
        },
      },
      { -- d
        trunk = {
          width = 271,
          height = 187,
          shift = util.by_pixel(90.5, -50.5),
          hr_version = {
            width = 541,
            height = 374,
            shift = util.by_pixel(90.25, -51),
            scale = 0.5
          },
        },
        leaves = {
          width = 119,
          height = 154,
          shift = util.by_pixel(13.5, -70),
          hr_version = {
            width = 238,
            height = 309,
            shift = util.by_pixel(14, -70.25),
            scale = 0.5
          },
        },
      },
      { -- e
        trunk = {
          width = 256,
          height = 191,
          shift = util.by_pixel(73, -46.5),
          hr_version = {
            width = 512,
            height = 381,
            shift = util.by_pixel(73.5, -46.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 104,
          height = 144,
          shift = util.by_pixel(-3, -73),
          hr_version = {
            width = 207,
            height = 286,
            shift = util.by_pixel(-2.75, -73),
            scale = 0.5
          },
        },
      },
    },
  },
  { -- tree-03
    --addHere-tree03
    type_name = "ash",
    alien_biomes_texture = true,
    normals_match_leaves = true,
    drawing_box = {{-0.9, -3.7}, {0.9, 0.6}},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__alien-biomes__/graphics/entity/tree/ash/tree-ash-reflection.png",
          priority = "extra-high",
          width = 136/4,
          height = 287/7,
          shift = util.by_pixel(0, 60),
          y = 287/7 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = {
      { -- a
        trunk = {
          width = 243,
          height = 156,
          shift = util.by_pixel(72.5, -45),
          hr_version = {
            width = 487,
            height = 312,
            shift = util.by_pixel(72.75, -45),
            scale = 0.5
          },
        },
        leaves = {
          width = 119,
          height = 98,
          shift = util.by_pixel(12.5, -76),
          hr_version = {
            width = 237,
            height = 195,
            shift = util.by_pixel(13.25, -75.75),
            scale = 0.5
          },
        },
      },
      { -- b
        trunk = {
          width = 162,
          height = 124,
          shift = util.by_pixel(50, -39),
          hr_version = {
            width = 324,
            height = 246,
            shift = util.by_pixel(50, -39),
            scale = 0.5
          },
        },
        leaves = {
          width = 78,
          height = 72,
          shift = util.by_pixel(12, -65),
          hr_version = {
            width = 157,
            height = 144,
            shift = util.by_pixel(12.75, -65),
            scale = 0.5
          },
        },
      },
      { -- c
        trunk = {
          width = 193,
          height = 169,
          shift = util.by_pixel(59.5, -51.5),
          hr_version = {
            width = 387,
            height = 337,
            shift = util.by_pixel(59.75, -51.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 94,
          height = 88,
          shift = util.by_pixel(13, -92),
          hr_version = {
            width = 187,
            height = 178,
            shift = util.by_pixel(13.25, -91.5),
            scale = 0.5
          },
        },
      },
      { -- d
        trunk = {
          width = 236,
          height = 169,
          shift = util.by_pixel(65, -53.5),
          hr_version = {
            width = 473,
            height = 337,
            shift = util.by_pixel(64.75, -53.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 100,
          height = 83,
          shift = util.by_pixel(0, -98.5),
          hr_version = {
            width = 204,
            height = 167,
            shift = util.by_pixel(0.5, -97.75),
            scale = 0.5
          },
        },
      },
      { -- e
        trunk = {
          width = 258,
          height = 143,
          shift = util.by_pixel(59, -48.5),
          hr_version = {
            width = 516,
            height = 285,
            shift = util.by_pixel(59, -48.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 117,
          height = 83,
          shift = util.by_pixel(-7.5, -80.5),
          hr_version = {
            width = 235,
            height = 167,
            shift = util.by_pixel(-6.75, -79.75),
            scale = 0.5
          },
        },
      },
      { -- f
        trunk = {
          width = 213,
          height = 158,
          shift = util.by_pixel(48.5, -44),
          hr_version = {
            width = 427,
            height = 315,
            shift = util.by_pixel(48.75, -43.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 93,
          height = 100,
          shift = util.by_pixel(-8.5, -67),
          hr_version = {
            width = 186,
            height = 201,
            shift = util.by_pixel(-8, -66.25),
            scale = 0.5
          },
        },
      },
      { -- g
        trunk = {
          width = 176,
          height = 149,
          shift = util.by_pixel(40, -34.5),
          hr_version = {
            width = 352,
            height = 299,
            shift = util.by_pixel(40, -35.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 76,
          height = 105,
          shift = util.by_pixel(-6, -59.5),
          hr_version = {
            width = 155,
            height = 212,
            shift = util.by_pixel(-5.25, -59),
            scale = 0.5
          },
        },
      },
    },
  },
  { -- tree-04
    --addHere-tree04
    type_name = "scarecrow",
    alien_biomes_texture = true,
    normals_match_leaves = true,
    drawing_box = {{-0.9, -3.9}, {0.9, 0.6}},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__alien-biomes__/graphics/entity/tree/scarecrow/tree-scarecrow-reflection.png",
          priority = "extra-high",
          width = 132/4,
          height = 344/8,
          shift = util.by_pixel(0, 60),
          y = 344/8 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = {
      { -- a
        trunk = {
          width = 255,
          height = 170,
          shift = util.by_pixel(78.5, -50),
          hr_version = {
            width = 509,
            height = 340,
            shift = util.by_pixel(78.75, -49.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 98,
          height = 127,
          shift = util.by_pixel(0, -76.5),
          hr_version = {
            width = 197,
            height = 254,
            shift = util.by_pixel(0.25, -75.5),
            scale = 0.5
          },
        },
      },
      { -- b
        trunk = {
          width = 231,
          height = 168,
          shift = util.by_pixel(69.5, -46),
          hr_version = {
            width = 463,
            height = 336,
            shift = util.by_pixel(70.25, -45.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 105,
          height = 140,
          shift = util.by_pixel(3.5, -68),
          hr_version = {
            width = 212,
            height = 280,
            shift = util.by_pixel(4, -67.5),
            scale = 0.5
          },
        },
      },
      { -- c
        trunk = {
          width = 265,
          height = 176,
          shift = util.by_pixel(92.5, -47),
          hr_version = {
            width = 530,
            height = 353,
            shift = util.by_pixel(92.5, -47.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 99,
          height = 125,
          shift = util.by_pixel(1.5, -74.5),
          hr_version = {
            width = 197,
            height = 250,
            shift = util.by_pixel(2.25, -74.5),
            scale = 0.5
          },
        },
      },
      { -- d
        trunk = {
          width = 273,
          height = 173,
          shift = util.by_pixel(88.5, -46.5),
          hr_version = {
            width = 545,
            height = 348,
            shift = util.by_pixel(88.75, -46.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 99,
          height = 125,
          shift = util.by_pixel(-6.5, -75.5),
          hr_version = {
            width = 198,
            height = 248,
            shift = util.by_pixel(-6, -75),
            scale = 0.5
          },
        },
      },
      { -- e
        trunk = {
          width = 246,
          height = 182,
          shift = util.by_pixel(63, -51.5),
          hr_version = {
            width = 492,
            height = 365,
            shift = util.by_pixel(63.5, -50.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 108,
          height = 136,
          shift = util.by_pixel(-8, -77),
          hr_version = {
            width = 217,
            height = 273,
            shift = util.by_pixel(-7.75, -76.25),
            scale = 0.5
          },
        },
      },
      { -- f
        trunk = {
          width = 260,
          height = 190,
          shift = util.by_pixel(86, -51),
          hr_version = {
            width = 520,
            height = 380,
            shift = util.by_pixel(86.5, -51),
            scale = 0.5
          },
        },
        leaves = {
          width = 100,
          height = 122,
          shift = util.by_pixel(4, -87),
          hr_version = {
            width = 200,
            height = 246,
            shift = util.by_pixel(4, -87),
            scale = 0.5
          },
        },
      },
      { -- g
        trunk = {
          width = 260,
          height = 176,
          shift = util.by_pixel(82, -36.5),
          hr_version = {
            width = 522,
            height = 352,
            shift = util.by_pixel(82.5, -36.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 98,
          height = 116,
          shift = util.by_pixel(-1, -70),
          hr_version = {
            width = 199,
            height = 231,
            shift = util.by_pixel(-0.75, -69.75),
            scale = 0.5
          },
        },
      },
      { -- h
        trunk = {
          width = 253,
          height = 169,
          shift = util.by_pixel(76.5, -35.5),
          hr_version = {
            width = 505,
            height = 340,
            shift = util.by_pixel(77.25, -35.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 103,
          height = 122,
          shift = util.by_pixel(-0.5, -62),
          hr_version = {
            width = 206,
            height = 245,
            shift = util.by_pixel(0, -61.25),
            scale = 0.5
          },
        },
      },
    },
  },
  { -- tree-05
    --addHere-tree05
    type_name = "specter",
    alien_biomes_texture = true,
    normals_match_leaves = true,
    drawing_box = {{-0.9, -3.5}, {0.9, 0.6}},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__alien-biomes__/graphics/entity/tree/specter/tree-specter-reflection.png",
          priority = "extra-high",
          width = 156/4,
          height = 351/9,
          shift = util.by_pixel(0, 60),
          y = 351/9 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = {
      { -- a
        trunk = {
          width = 210,
          height = 142,
          shift = util.by_pixel(55, -33),
          hr_version = {
            width = 419,
            height = 284,
            shift = util.by_pixel(55.25, -33),
            scale = 0.5
          },
        },
        leaves = {
          width = 116,
          height = 118,
          shift = util.by_pixel(-3, -56),
          hr_version = {
            width = 233,
            height = 236,
            shift = util.by_pixel(-2.75, -56),
            scale = 0.5
          },
        },
      },
      { -- b
        trunk = {
          width = 198,
          height = 129,
          shift = util.by_pixel(59, -29.5),
          hr_version = {
            width = 394,
            height = 259,
            shift = util.by_pixel(59.5, -29.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 104,
          height = 115,
          shift = util.by_pixel(-2, -49.5),
          hr_version = {
            width = 210,
            height = 230,
            shift = util.by_pixel(-1.5, -49.5),
            scale = 0.5
          },
        },
      },
      { -- c
        trunk = {
          width = 187,
          height = 138,
          shift = util.by_pixel(56.5, -33),
          hr_version = {
            width = 375,
            height = 276,
            shift = util.by_pixel(56.75, -33),
            scale = 0.5
          },
        },
        leaves = {
          width = 116,
          height = 135,
          shift = util.by_pixel(7, -51.5),
          hr_version = {
            width = 232,
            height = 270,
            shift = util.by_pixel(7.5, -51),
            scale = 0.5
          },
        },
      },
      { -- d
        trunk = {
          width = 206,
          height = 138,
          shift = util.by_pixel(57, -23),
          hr_version = {
            width = 412,
            height = 275,
            shift = util.by_pixel(57, -22.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 133,
          height = 131,
          shift = util.by_pixel(2.5, -35.5),
          hr_version = {
            width = 264,
            height = 260,
            shift = util.by_pixel(3, -35.5),
            scale = 0.5
          },
        },
      },
      { -- e
        trunk = {
          width = 185,
          height = 129,
          shift = util.by_pixel(40.5, -19.5),
          hr_version = {
            width = 369,
            height = 258,
            shift = util.by_pixel(41.25, -19.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 120,
          height = 109,
          shift = util.by_pixel(-6, -39.5),
          hr_version = {
            width = 240,
            height = 216,
            shift = util.by_pixel(-6, -39.5),
            scale = 0.5
          },
        },
      },
      { -- f
        trunk = {
          width = 188,
          height = 145,
          shift = util.by_pixel(43, -36.5),
          hr_version = {
            width = 375,
            height = 291,
            shift = util.by_pixel(43.75, -36.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 125,
          height = 140,
          shift = util.by_pixel(-0.5, -51),
          hr_version = {
            width = 250,
            height = 281,
            shift = util.by_pixel(0.5, -51.25),
            scale = 0.5
          },
        },
      },
      { -- g
        trunk = {
          width = 182,
          height = 108,
          shift = util.by_pixel(54, -17),
          hr_version = {
            width = 362,
            height = 216,
            shift = util.by_pixel(54.5, -16.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 117,
          height = 100,
          shift = util.by_pixel(1.5, -33),
          hr_version = {
            width = 232,
            height = 201,
            shift = util.by_pixel(2, -33.25),
            scale = 0.5
          },
        },
      },
      { -- h
        trunk = {
          width = 164,
          height = 119,
          shift = util.by_pixel(45, -17.5),
          hr_version = {
            width = 330,
            height = 240,
            shift = util.by_pixel(45.5, -17.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 111,
          height = 112,
          shift = util.by_pixel(7.5, -36),
          hr_version = {
            width = 221,
            height = 224,
            shift = util.by_pixel(7.75, -36),
            scale = 0.5
          },
        },
      },
      { -- i
        trunk = {
          width = 175,
          height = 111,
          shift = util.by_pixel(38.5, -9.5),
          hr_version = {
            width = 352,
            height = 221,
            shift = util.by_pixel(39, -9.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 119,
          height = 110,
          shift = util.by_pixel(-1.5, -27),
          hr_version = {
            width = 238,
            height = 220,
            shift = util.by_pixel(-1, -26.5),
            scale = 0.5
          },
        },
      },
    },
  },
  { -- tree-06
    --addHere-tree06
    type_name = "willow",
    alien_biomes_texture = true,
    normals_match_leaves = true,
    drawing_box = {{-0.9, -3.5}, {0.9, 0.6}},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__alien-biomes__/graphics/entity/tree/willow/tree-willow-reflection.png",
          priority = "extra-high",
          width = 30,
          height = 35,
          shift = util.by_pixel(0, 35),
          x = 30 * variation,
          variation_count = 1,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = {
      { -- a
        trunk = {
          width = 178,
          height = 144,
          shift = util.by_pixel(60, -34),
          hr_version = {
            width = 356,
            height = 289,
            shift = util.by_pixel(59.5, -33.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 66,
          height = 97,
          shift = util.by_pixel(19, -46.5),
          hr_version = {
            width = 133,
            height = 195,
            shift = util.by_pixel(19.25, -46.75),
            scale = 0.5
          },
        },
      },
      { -- b
        trunk = {
          width = 188,
          height = 129,
          shift = util.by_pixel(61, -23.5),
          hr_version = {
            width = 375,
            height = 258,
            shift = util.by_pixel(61.25, -23),
            scale = 0.5
          },
        },
        leaves = {
          width = 85,
          height = 92,
          shift = util.by_pixel(17.5, -37),
          hr_version = {
            width = 170,
            height = 186,
            shift = util.by_pixel(18, -37),
            scale = 0.5
          },
        },
      },
      { -- c
        trunk = {
          width = 202,
          height = 107,
          shift = util.by_pixel(52, -12.5),
          hr_version = {
            width = 403,
            height = 214,
            shift = util.by_pixel(52.25, -12.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 89,
          height = 79,
          shift = util.by_pixel(11.5, -25.5),
          hr_version = {
            width = 178,
            height = 158,
            shift = util.by_pixel(11, -25.5),
            scale = 0.5
          },
        },
      },
      { -- d
        trunk = {
          width = 172,
          height = 130,
          shift = util.by_pixel(34, -17),
          hr_version = {
            width = 343,
            height = 259,
            shift = util.by_pixel(34.25, -16.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 75,
          height = 90,
          shift = util.by_pixel(-6.5, -36),
          hr_version = {
            width = 150,
            height = 178,
            shift = util.by_pixel(-6.5, -36),
            scale = 0.5
          },
        },
      },
      { -- e
        trunk = {
          width = 140,
          height = 144,
          shift = util.by_pixel(18, -28),
          hr_version = {
            width = 280,
            height = 287,
            shift = util.by_pixel(18, -28.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 68,
          height = 112,
          shift = util.by_pixel(-10, -44),
          hr_version = {
            width = 137,
            height = 224,
            shift = util.by_pixel(-10.25, -44.5),
            scale = 0.5
          },
        },
      },
      { -- f
        trunk = {
          width = 186,
          height = 136,
          shift = util.by_pixel(31, -36),
          hr_version = {
            width = 371,
            height = 272,
            shift = util.by_pixel(30.75, -36),
            scale = 0.5
          },
        },
        leaves = {
          width = 89,
          height = 114,
          shift = util.by_pixel(-10.5, -46),
          hr_version = {
            width = 177,
            height = 228,
            shift = util.by_pixel(-10.25, -45.5),
            scale = 0.5
          },
        },
      },
      { -- g
        trunk = {
          width = 202,
          height = 133,
          shift = util.by_pixel(43, -34.5),
          hr_version = {
            width = 402,
            height = 268,
            shift = util.by_pixel(43, -35),
            scale = 0.5
          },
        },
        leaves = {
          width = 89,
          height = 114,
          shift = util.by_pixel(-0.5, -44),
          hr_version = {
            width = 177,
            height = 228,
            shift = util.by_pixel(-0.75, -44),
            scale = 0.5
          },
        },
      },
      { -- h
        trunk = {
          width = 173,
          height = 129,
          shift = util.by_pixel(49.5, -34.5),
          hr_version = {
            width = 347,
            height = 258,
            shift = util.by_pixel(49.25, -34.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 71,
          height = 95,
          shift = util.by_pixel(21.5, -43.5),
          hr_version = {
            width = 143,
            height = 190,
            shift = util.by_pixel(21.25, -43),
            scale = 0.5
          },
        },
      },
      { -- i
        trunk = {
          width = 127,
          height = 129,
          shift = util.by_pixel(12.5, -14.5),
          hr_version = {
            width = 253,
            height = 259,
            shift = util.by_pixel(12.75, -14.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 65,
          height = 93,
          shift = util.by_pixel(-10.5, -33.5),
          hr_version = {
            width = 129,
            height = 185,
            shift = util.by_pixel(-10.25, -33.75),
            scale = 0.5
          },
        },
      },
      { -- j
        trunk = {
          width = 136,
          height = 126,
          shift = util.by_pixel(22, -17),
          hr_version = {
            width = 272,
            height = 253,
            shift = util.by_pixel(22, -16.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 67,
          height = 92,
          shift = util.by_pixel(-6.5, -35),
          hr_version = {
            width = 133,
            height = 182,
            shift = util.by_pixel(-6.25, -35),
            scale = 0.5
          },
        },
      },
    },
  },
  { -- tree-07
    --addHere-tree07
    type_name = "mangrove",
    alien_biomes_texture = true,
    normals_match_leaves = true,
    drawing_box = {{-0.9, -3.5}, {0.9, 0.6}},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__alien-biomes__/graphics/entity/tree/mangrove/tree-mangrove-reflection.png",
          priority = "extra-high",
          width = 140/4,
          height = 312/8,
          shift = util.by_pixel(0, 60),
          y = 312/8 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = {
      { -- a
        trunk = {
          width = 181,
          height = 122,
          shift = util.by_pixel(38.5 + 24, -21),
          hr_version = {
            width = 362,
            height = 244,
            shift = util.by_pixel(39 + 24, -20.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 402/3/2,
          height = 166/2,
          shift = util.by_pixel(-26 + 24, -42),
          hr_version = {
            width = 402/3,
            height = 166,
            shift = util.by_pixel(-26 + 24, -42),
            scale = 0.5
          },
        },
      },
      { -- b
        trunk = {
          width = 167,
          height = 120,
          shift = util.by_pixel(14.5 + 24, -36),
          hr_version = {
            width = 335,
            height = 239,
            shift = util.by_pixel(14.75 + 24, -35.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 438/3/2,
          height = 192/2,
          shift = util.by_pixel(-41 + 24, -50),
          hr_version = {
            width = 438/3,
            height = 192,
            shift = util.by_pixel(-41 + 24, -50),
            scale = 0.5
          },
        },
      },
      { -- c
        trunk = {
          width = 167,
          height = 128,
          shift = util.by_pixel(8.5 + 24, -47),
          hr_version = {
            width = 334,
            height = 256,
            shift = util.by_pixel(9 + 24, -46.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 480/3/2,
          height = 220/2,
          shift = util.by_pixel(-42 + 24, -56),
          hr_version = {
            width = 480/3,
            height = 220,
            shift = util.by_pixel(-42 + 24, -56),
            scale = 0.5
          },
        },
      },
      { -- d
        trunk = {
          width = 184,
          height = 158,
          shift = util.by_pixel(25 + 24, -48),
          hr_version = {
            width = 368,
            height = 314,
            shift = util.by_pixel(25.5 + 24, -47.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 540/3/2,
          height = 254/2,
          shift = util.by_pixel(-28 + 24, -65),
          hr_version = {
            width = 540/3,
            height = 254,
            shift = util.by_pixel(-28 + 24, -65),
            scale = 0.5
          },
        },
      },
      { -- e
        trunk = {
          width = 202,
          height = 143,
          shift = util.by_pixel(48 + 24, -55.5),
          hr_version = {
            width = 405,
            height = 286,
            shift = util.by_pixel(48.25 + 24, -54.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 450/3/2,
          height = 268/2,
          shift = util.by_pixel(-17 + 24, -61),
          hr_version = {
            width = 450/3,
            height = 268,
            shift = util.by_pixel(-17 + 24, -61),
            scale = 0.5
          },
        },
      },
      { -- f
        trunk = {
          width = 218,
          height = 135,
          shift = util.by_pixel(57 + 24, -49.5),
          hr_version = {
            width = 435,
            height = 270,
            shift = util.by_pixel(56.75 + 24, -49),
            scale = 0.5
          },
        },
        leaves = {
          width = 504/3/2,
          height = 240/2,
          shift = util.by_pixel(-3 + 24, -57),
          hr_version = {
            width = 504/3,
            height = 240,
            shift = util.by_pixel(-3 + 24, -57),
            scale = 0.5
          },
        },
      },
      { -- g
        trunk = {
          width = 213,
          height = 121,
          shift = util.by_pixel(55.5 + 24, -36.5),
          hr_version = {
            width = 426,
            height = 240,
            shift = util.by_pixel(55.5 + 24, -36),
            scale = 0.5
          },
        },
        leaves = {
          width = 480/3/2,
          height = 200/2,
          shift = util.by_pixel(-9 + 24, -46),
          hr_version = {
            width = 480/3,
            height = 200,
            shift = util.by_pixel(-9 + 24, -46),
            scale = 0.5
          },
        },
      },
      { -- h
        trunk = {
          width = 198,
          height = 121,
          shift = util.by_pixel(50 + 24, -21.5),
          hr_version = {
            width = 397,
            height = 243,
            shift = util.by_pixel(50.25 + 24, -21.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 444/3/2,
          height = 174/2,
          shift = util.by_pixel(-20 + 24, -40),
          hr_version = {
            width = 444/3,
            height = 174,
            shift = util.by_pixel(-20 + 24, -40),
            scale = 0.5
          },
        },
      },
    },
  },
  { -- tree-08
    --addHere-tree08
    type_name = "pear",
    alien_biomes_texture = true,
    normals_match_leaves = true,
    drawing_box = {{-0.9, -3}, {0.9, 0.6}},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__alien-biomes__/graphics/entity/tree/pear/tree-pear-reflection.png",
          priority = "extra-high",
          width = 116/4,
          height = 180/5,
          shift = util.by_pixel(0, 60),
          y = 180/5 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = {
      { -- a
        trunk = {
          width = 200,
          height = 140,
          shift = util.by_pixel(55, -34),
          hr_version = {
            width = 399,
            height = 279,
            shift = util.by_pixel(55.75, -33.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 94,
          height = 70,
          shift = util.by_pixel(0, -71),
          hr_version = {
            width = 188,
            height = 141,
            shift = util.by_pixel(0.5, -70.75),
            scale = 0.5
          },
        },
      },
      { -- b
        trunk = {
          width = 213,
          height = 139,
          shift = util.by_pixel(57.5, -30.5),
          hr_version = {
            width = 426,
            height = 277,
            shift = util.by_pixel(57.5, -30.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 102,
          height = 70,
          shift = util.by_pixel(2, -69),
          hr_version = {
            width = 205,
            height = 142,
            shift = util.by_pixel(2.25, -68.5),
            scale = 0.5
          },
        },
      },
      { -- c
        trunk = {
          width = 188,
          height = 136,
          shift = util.by_pixel(65, -36),
          hr_version = {
            width = 377,
            height = 271,
            shift = util.by_pixel(65.75, -35.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 76,
          height = 76,
          shift = util.by_pixel(6, -68),
          hr_version = {
            width = 152,
            height = 152,
            shift = util.by_pixel(6.5, -68),
            scale = 0.5
          },
        },
      },
      { -- d
        trunk = {
          width = 212,
          height = 134,
          shift = util.by_pixel(62, -39),
          hr_version = {
            width = 424,
            height = 267,
            shift = util.by_pixel(62.5, -38.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 93,
          height = 81,
          shift = util.by_pixel(-0.5, -69.5),
          hr_version = {
            width = 187,
            height = 162,
            shift = util.by_pixel(0.25, -68.5),
            scale = 0.5
          },
        },
      },
      { -- e
        trunk = {
          width = 208,
          height = 147,
          shift = util.by_pixel(55, -33.5),
          hr_version = {
            width = 416,
            height = 295,
            shift = util.by_pixel(55, -33.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 95,
          height = 83,
          shift = util.by_pixel(-6.5, -70.5),
          hr_version = {
            width = 189,
            height = 166,
            shift = util.by_pixel(-5.75, -70),
            scale = 0.5
          },
        },
      },
    },
  },
  { -- tree-09
    --addHere-tree09
    type_name = "baobab",
    alien_biomes_texture = true,
    normals_match_leaves = true,
    drawing_box = {{-0.9, -3.5}, {0.9, 0.6}},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__alien-biomes__/graphics/entity/tree/baobab/tree-baobab-reflection.png",
          priority = "extra-high",
          width = 148/4,
          height = 200/5,
          shift = util.by_pixel(0, 60),
          y = 200/5 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = {
      { -- a
        trunk = {
          width = 243,
          height = 170,
          shift = util.by_pixel(65.5, -37),
          hr_version = {
            width = 487,
            height = 340,
            shift = util.by_pixel(66.25, -36.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 123,
          height = 102,
          shift = util.by_pixel(4.5, -73),
          hr_version = {
            width = 244,
            height = 204,
            shift = util.by_pixel(5, -72.5),
            scale = 0.5
          },
        },
      },
      { -- b
        trunk = {
          width = 208,
          height = 150,
          shift = util.by_pixel(53, -36),
          hr_version = {
            width = 415,
            height = 300,
            shift = util.by_pixel(53.25, -35.5),
            scale = 0.5
          },
        },
        leaves = {
          width = 99,
          height = 86,
          shift = util.by_pixel(-2.5, -69),
          hr_version = {
            width = 197,
            height = 172,
            shift = util.by_pixel(-2.25, -68.5),
            scale = 0.5
          },
        },
      },
      { -- c
        trunk = {
          width = 238,
          height = 167,
          shift = util.by_pixel(56, -37.5),
          hr_version = {
            width = 476,
            height = 333,
            shift = util.by_pixel(56.5, -37.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 113,
          height = 95,
          shift = util.by_pixel(-8.5, -74.5),
          hr_version = {
            width = 225,
            height = 189,
            shift = util.by_pixel(-8.25, -73.75),
            scale = 0.5
          },
        },
      },
      { -- d
        trunk = {
          width = 169,
          height = 116,
          shift = util.by_pixel(45.5, -32),
          hr_version = {
            width = 338,
            height = 233,
            shift = util.by_pixel(46, -31.75),
            scale = 0.5
          },
        },
        leaves = {
          width = 90,
          height = 64,
          shift = util.by_pixel(4, -60),
          hr_version = {
            width = 179,
            height = 126,
            shift = util.by_pixel(4.75, -59.5),
            scale = 0.5
          },
        },
      },
      { -- e
        trunk = {
          width = 202,
          height = 157,
          shift = util.by_pixel(63, -38.5),
          hr_version = {
            width = 403,
            height = 315,
            shift = util.by_pixel(63.25, -38.25),
            scale = 0.5
          },
        },
        leaves = {
          width = 103,
          height = 103,
          shift = util.by_pixel(11.5, -67.5),
          hr_version = {
            width = 205,
            height = 206,
            shift = util.by_pixel(12.25, -67),
            scale = 0.5
          },
        },
      },
    },
  },
  { -- tree-conifer-01
    -- x positive moves image right
    -- y positive moves image down
    type_name = "conifer-01",
    alien_biomes_texture = true,
    normals_match_leaves = true,
    drawing_box = {{-1, -9}, {1, 0.8}},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__alien-biomes__/graphics/entity/tree/conifer-01/tree-conifer-01-reflection.png",
          priority = "extra-high",
          width = 180/4,
          height = 189/3,
          shift = util.by_pixel(0, 100),
          y = 189/3 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = {
      { -- a
        trunk = {
          width = 1498/5,
          height = 226,
          shift = util.by_pixel(81, -62),
          hr_version = {
            width = 1498/5*2,
            height = 226*2,
            shift = util.by_pixel(81, -62),
            scale = 0.5
          }
        },
        leaves = {
          width = 339/3,
          height = 164,
          shift = util.by_pixel(11, -84),
          hr_version = {
            width = 339/3*2,
            height = 164*2,
            shift = util.by_pixel(11, -84),
            scale = 0.5
          }
        },
      },
      { -- b
        trunk = {
          width = 540/4,
          height = 152,
          shift = util.by_pixel(18, -48),
          hr_version = {
            width = 540/4*2,
            height = 152*2,
            shift = util.by_pixel(18, -48),
            scale = 0.5
          }
        },
        leaves = {
          width = 279/3,
          height = 134,
          shift = util.by_pixel(0, -66),
          hr_version = {
            width = 279/3*2,
            height = 134*2,
            shift = util.by_pixel(0, -66),
            scale = 0.5
          }
        },
      },
      { -- c
        trunk = {
          width = 1400/4,
          height = 321,
          shift = util.by_pixel(90, -88),
          hr_version = {
            width = 1400/4*2,
            height = 321*2,
            shift = util.by_pixel(90, -88),
            scale = 0.5
          }
        },
        leaves = {
          width = 534/3,
          height = 258,
          shift = util.by_pixel(4, -123),
          hr_version = {
            width = 534/3*2,
            height = 258*2,
            shift = util.by_pixel(4, -123),
            scale = 0.5
          }
        },
      },
    },
  },
  { -- tree-palm
    -- x positive moves image right
    -- y positive moves image down
    type_name = "palm",
    alien_biomes_texture = true,
    normals_match_leaves = true,
    drawing_box = {{-0.9, -5.9}, {0.9, 0.8}},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__alien-biomes__/graphics/entity/tree/palm/tree-palm-reflection.png",
          priority = "extra-high",
          width = 116/4,
          height = 144/4,
          shift = util.by_pixel(0, 60),
          y = 144/4 * variation,
          variation_count = 4,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = {
      { -- a
        trunk =
        {
          width = 60/2,
          height = 168/2,
          shift = util.by_pixel(0, -31),
          hr_version =
          {
            width = 60,
            height = 168,
            shift = util.by_pixel(0, -31),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 976/4/2,
          height = 114/2,
          shift = util.by_pixel(58, 10),
          hr_version =
          {
            width = 976/4,
            height = 114,
            shift = util.by_pixel(58, 10),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 432/3/2,
          height = 114/2,
          shift = util.by_pixel(-2, -65),
          hr_version =
          {
            width = 432/3,
            height = 114,
            shift = util.by_pixel(-2, -65),
            scale = 0.5
          }
        }
      },
      { -- b
        trunk =
        {
          width = 64/2,
          height = 218/2,
          shift = util.by_pixel(2, -40),
          hr_version =
          {
            width = 64,
            height = 218,
            shift = util.by_pixel(2, -40),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 1000/4/2,
          height = 118/2,
          shift = util.by_pixel(58, 0),
          hr_version =
          {
            width = 1000/4,
            height = 118,
            shift = util.by_pixel(58, 0),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 546/3/2,
          height = 118/2,
          shift = util.by_pixel(-8, -92),
          hr_version =
          {
            width = 546/3,
            height = 118,
            shift = util.by_pixel(-8, -92),
            scale = 0.5
          }
        }
      },
      { -- c
        trunk =
        {
          width = 66/2,
          height = 210/2,
          shift = util.by_pixel(0, -38),
          hr_version =
          {
            width = 66,
            height = 210,
            shift = util.by_pixel(0, -38),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 1008/4/2,
          height = 124/2,
          shift = util.by_pixel(58, 0),
          hr_version =
          {
            width = 1008/4,
            height = 124,
            shift = util.by_pixel(58, 0),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 486/3/2,
          height = 124/2,
          shift = util.by_pixel(10, -92),
          hr_version =
          {
            width = 486/3,
            height = 124,
            shift = util.by_pixel(10, -92),
            scale = 0.5
          }
        }
      },
      { -- d
        trunk =
        {
          width = 78/2,
          height = 198/2,
          shift = util.by_pixel(0, -33),
          hr_version =
          {
            width = 78,
            height = 198,
            shift = util.by_pixel(0, -33),
            scale = 0.5
          }
        },
        shadow =
        {
          width = 896/4/2,
          height = 126/2,
          shift = util.by_pixel(58, -1),
          hr_version =
          {
            width = 896/4,
            height = 126,
            shift = util.by_pixel(58, -1),
            scale = 0.5
          }
        },
        leaves =
        {
          width = 486/3/2,
          height = 126/2,
          shift = util.by_pixel(-1, -85),
          hr_version =
          {
            width = 486/3,
            height = 126,
            shift = util.by_pixel(-1, -85),
            scale = 0.5
          }
        }
      },
    },
  },
  { -- tree-medusa-01
    type_name = "medusa-01",
    alien_biomes_texture = true,
    drawing_box = {{-0.9, -3.9}, {0.9, 0.6}},
    water_reflection_function = function (variation)
      return
      {
        pictures =
        {
          filename = "__alien-biomes__/graphics/entity/tree/medusa-01/tree-medusa-01-reflection.png",
          priority = "extra-high",
          width = 30,
          height = 31,
          shift = util.by_pixel(0, 35),
          x = 30 * variation,
          variation_count = 1,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false
      }
    end,
    variations = {
      { -- a
        trunk = {
          frame_count = 2,
          width = 254/2,
          height = 100,
          shift = util.by_pixel(30, -22),
          hr_version =
          {
            frame_count = 2,
            width = 254,
            height = 100*2,
            shift = util.by_pixel(30, -22),
            scale = 0.5
          }
        },
        leaves = {
          frame_count = 1,
          width = 67,
          height = 57,
          shift = util.by_pixel(0, -44),
          hr_version =
          {
            frame_count = 1,
            width = 67*2,
            height = 57*2,
            shift = util.by_pixel(0, -44),
            scale = 0.5
          }
        },
      },
      { -- b
        trunk = {
          frame_count = 2,
          width = 302/2,
          height = 110,
          shift = util.by_pixel(16, -31),
          hr_version =
          {
            frame_count = 2,
            width = 302,
            height = 110*2,
            shift = util.by_pixel(16, -31),
            scale = 0.5
          }
        },
        leaves = {
          frame_count = 1,
          width = 87,
          height = 59,
          shift = util.by_pixel(-16, -58),
          hr_version =
          {
            frame_count = 1,
            width = 87*2,
            height = 59*2,
            shift = util.by_pixel(-16, -58),
            scale = 0.5
          }
        },
      },
      { -- c
        trunk = {
          frame_count = 2,
          width = 232/2,
          height = 110,
          shift = util.by_pixel(24, -10),
          hr_version =
          {
            frame_count = 2,
            width = 232,
            height = 110*2,
            shift = util.by_pixel(24, -10),
            scale = 0.5
          }
        },
        leaves = {
          frame_count = 1,
          width = 72,
          height = 74,
          shift = util.by_pixel(2, -28),
          hr_version =
          {
            frame_count = 1,
            width = 72*2,
            height = 74*2,
            shift = util.by_pixel(2, -28),
            scale = 0.5
          }
        },
      },
      { -- d
        trunk = {
          frame_count = 2,
          width = 236/2,
          height = 110,
          shift = util.by_pixel(30, -40),
          hr_version =
          {
            frame_count = 2,
            width = 236,
            height = 110*2,
            shift = util.by_pixel(30, -40),
            scale = 0.5
          }
        },
        leaves = {
          frame_count = 1,
          width = 59,
          height = 65,
          shift = util.by_pixel(0, -62),
          hr_version =
          {
            frame_count = 1,
            width = 59*2,
            height = 65*2,
            shift = util.by_pixel(0, -62),
            scale = 0.5
          }
        },
      },
      { -- e
        trunk = {
          frame_count = 2,
          width = 200/2,
          height = 110,
          shift = util.by_pixel(28, -36),
          hr_version =
          {
            frame_count = 2,
            width = 200,
            height = 110*2,
            shift = util.by_pixel(28, -36),
            scale = 0.5
          }
        },
        leaves = {
          frame_count = 1,
          width = 65,
          height = 81,
          shift = util.by_pixel(10, -51),
          hr_version =
          {
            frame_count = 1,
            width = 65*2,
            height = 81*2,
            shift = util.by_pixel(10, -51),
            scale = 0.5
          }
        },
      },
    },
  },
}

local tree_models = {}
-- expand variations
for tree_index, tree_type in pairs(tree_types) do
  local type_name = tree_type.type_name
  local tree_variations = {}  -- expanded versions
  local i = 1
  -- lock letter
  for variation_index, variation in ipairs(tree_type.variations) do
    variation.variation_letter = index_to_letter(variation_index)
    variation.real_variation_index = variation_index
  end
  -- make sure there are at least 7 variations by duplicating earlier ones
  -- that way if more textures are added later there will be at least 7 in already generated areas
  while #tree_type.variations < 7 do
    i = i + 1
    table.insert(tree_type.variations, table.deepcopy(tree_type.variations[i]))
  end
  for variation_index, variation in ipairs(tree_type.variations) do
    local variation_letter = variation.variation_letter
    local variation_path = type_name .. "/tree-" .. type_name .. "-" .. variation_letter
    local hr_variation_path = type_name .. "/hr-tree-" .. type_name .. "-" .. variation_letter
    local path_start = tree_type.alien_biomes_texture and "__alien-biomes__" or "__base__"
    local newTree = {
      trunk =
      {
        filename = path_start.."/graphics/entity/tree/" .. variation_path .. "-trunk.png",
        flags = { "mipmap" },
        width = variation.trunk.width,
        height =  variation.trunk.height,
        frame_count = variation.trunk.frame_count or 4,
        shift = variation.trunk.shift,
        hr_version = util.table.deepcopy(variation.trunk.hr_version)
      },
      leaves =
      {
        filename = path_start.."/graphics/entity/tree/" .. variation_path .. "-leaves.png",
        flags = { "mipmap" },
        width = variation.leaves.width,
        height = variation.leaves.height,
        frame_count = variation.leaves.frame_count or 3,
        shift = variation.leaves.shift,
        hr_version = util.table.deepcopy(variation.leaves.hr_version)
      },
      leaf_generation =
      {
        type = "create-particle",
        particle_name = "leaf-particle",
        offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}},
        initial_height = 2,
        initial_height_deviation = 1,
        speed_from_center = 0.01
      },
      branch_generation =
      {
        type = "create-particle",
        particle_name = "branch-particle",
        offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}},
        initial_height = 2,
        initial_height_deviation = 2,
        speed_from_center = 0.01,
        frame_speed = 0.1,
        repeat_count = 15
      }
    }
    if newTree.trunk.hr_version then
      newTree.trunk.hr_version.filename = path_start.."/graphics/entity/tree/" .. hr_variation_path .. "-trunk.png"
      newTree.trunk.hr_version.frame_count = variation.trunk.hr_version.frame_count or 4
      newTree.trunk.hr_version.flags = { "mipmap" }
      --newTree.leaves.hr_version.scale = 0.5
    end
    if newTree.leaves.hr_version then
      newTree.leaves.hr_version.filename = path_start.."/graphics/entity/tree/" .. hr_variation_path .. "-leaves.png"
      newTree.leaves.hr_version.frame_count = variation.leaves.hr_version.frame_count or 3
      newTree.leaves.hr_version.flags = { "mipmap" }
      --newTree.leaves.hr_version.scale = 0.5
    end
    if variation.normal then
      newTree.normal =
      {
        filename = "__base__/graphics/entity/tree/" .. variation_path .. "-normal.png",
        width = variation.normal.width,
        height = variation.normal.height,
        frame_count = 3,
        shift = variation.normal.shift,
        hr_version = util.table.deepcopy(variation.normal.hr_version)
      }
      newTree.normal.hr_version.filename = "__base__/graphics/entity/tree/" .. hr_variation_path .. "-normal.png"
      newTree.normal.hr_version.frame_count = newTree.normal.frame_count
    elseif tree_type.normals_match_leaves then
      newTree.normal = table.deepcopy(newTree.leaves)
      newTree.normal.filename = path_start.."/graphics/entity/tree/" .. variation_path .. "-normal.png"
      newTree.normal.flags = nil
      if newTree.normal.hr_version then
        newTree.normal.hr_version.filename = path_start.."/graphics/entity/tree/" .. hr_variation_path .. "-normal.png"
        newTree.normal.hr_version.flags = nil
      end
    end
    if tree_type.water_reflection_function then
      newTree.water_reflection = tree_type.water_reflection_function(variation.real_variation_index - 1)
    end
    if variation.shadow then
      -- note: old trees had shadow baked into the trunk texture

      newTree.trunk.frame_count = variation.trunk.frame_count or 1
      if newTree.trunk.hr_version then newTree.trunk.hr_version.frame_count = variation.trunk.frame_count or 1 end

      newTree.trunk.frame_count = variation.trunk.frame_count or 1
      newTree.shadow = {
        draw_as_shadow = true,
        filename = path_start.."/graphics/entity/tree/" .. variation_path .. "-shadow.png",
        flags = { "mipmap", "shadow" },
        frame_count = variation.shadow.frame_count or 4,
        width = variation.shadow.width,
        height = variation.shadow.height,
        shift = variation.shadow.shift,
        disable_shadow_distortion_beginning_at_frame = 2,
      }
      if variation.shadow.hr_version then
        hr_version = {
          draw_as_shadow = true,
          filename = path_start.."/graphics/entity/tree/" .. hr_variation_path .. "-shadow.png",
          flags = { "mipmap", "shadow" },
          frame_count = variation.shadow.hr_version.frame_count or 4,
          width = variation.shadow.hr_version.width,
          height = variation.shadow.hr_version.height,
          shift = variation.shadow.hr_version.shift,
          scale = 0.5,
          disable_shadow_distortion_beginning_at_frame = 2,
        }
      end
    else
      newTree.shadow = table.deepcopy(newTree.trunk)
      newTree.shadow.draw_as_shadow = true
      newTree.shadow.flags = { "mipmap", "shadow" }
      newTree.shadow.disable_shadow_distortion_beginning_at_frame = 2
      if newTree.shadow.hr_version then
        newTree.shadow.hr_version.draw_as_shadow = true
        newTree.shadow.hr_version.flags = { "mipmap", "shadow" }
        newTree.shadow.hr_version.disable_shadow_distortion_beginning_at_frame = 2
      end
      data_util.replace_filenames_recursive(newTree.shadow, "trunk", "shadow")
    end

    tree_variations[#tree_variations + 1] = newTree
  end
  tree_type.tree_variations = tree_variations
  tree_models[type_name] = tree_type
end

return tree_models
