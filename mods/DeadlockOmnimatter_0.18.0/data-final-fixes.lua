local itemTable =
{
	{"omnite", 1},
	{"crushed-omnite", 2},
	{"pulverized-omnite", 2}
}

if deadlock_stacking then
	for _, item in pairs(itemTable) do
		if data.raw.item[item[1]] then
			deadlock_stacking.create(item[1], "__DeadlockOmnimatter__/graphics/"..item[1].."-stack.png", "deadlock-stacking-"..item[2], 32)
		end
	end
end

if deadlock_crating then
	for _, item in pairs(itemTable) do
		if data.raw.item[item[1]] then
			deadlock_crating.create(item[1], "deadlock-crating-"..item[2])
		end
	end
end