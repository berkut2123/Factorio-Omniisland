local signals_increment_current = 0;
local signals_increment_order = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","v","w","x","y","z","z-a", "z-b"}
function signals_increment()
  signals_increment_current = signals_increment_current + 1
  return "a-" .. signals_increment_order[signals_increment_current]
end
data:extend(
{
  {
    type = "item-subgroup",
    name = "virtual-signal-death",
    group = "signals",
    order = "1",
  },
  {
    type = "virtual-signal",
    name = "signal-deathnotice",
    icon = "__DeathNotice__/graphics/signal/signal_deathnotice.png",
    icon_size = 128,
    subgroup = "virtual-signal-death",
    order = ""..signals_increment()
  },
})
