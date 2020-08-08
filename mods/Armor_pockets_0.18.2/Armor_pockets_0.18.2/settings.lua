local slots = {
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10"
}
local multiplier = {
  "2",
  "2.5",
  "3",
  "3.5",
  "4",
  "4.5",
  "5",
  "5.5",
  "6",
  "6.5",
  "7",
  "7.5",
  "8",
  "8.5",
  "9",
  "9.5",
  "10"
}

data:extend({
    {
      type = "string-setting",
      name = "armor_pockets_slot_amount",
      setting_type = "startup",
      default_value = "2",
      allowed_values = slots,
      order = "a",
    },
    {
      type = "bool-setting",
      name = "armor_pocket_mk2",
      setting_type = "startup",
      default_value = false,
      order = "b",
    },
	{
      type = "string-setting",
      name = "armor_pockets_mk2_mult",
      setting_type = "startup",
      default_value = "5",
      allowed_values = multiplier,
      order = "c",
	},
    {
      type = "bool-setting",
      name = "small_night_vision",
      setting_type = "startup",
      default_value = false,
      order = "d",
    }
})
