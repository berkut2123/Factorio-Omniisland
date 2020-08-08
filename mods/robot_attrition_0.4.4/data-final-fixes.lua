local base_bot_speed = 0.06
for _, bot in pairs(data.raw["logistic-robot"]) do
    if bot.speed > base_bot_speed then
      bot.speed = math.pow(bot.speed / base_bot_speed, 0.9) * base_bot_speed
    end
end
