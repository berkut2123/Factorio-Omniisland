local crafting = settings.startup["load-furn-crafting-speed"].value

for k=1,5 do
	local v = "0"..k
	if mods["Squeak Through"] then
		data.raw["assembling-machine"]["furnace-pro-"..v].collision_box = {{-2.5, -2.5}, {2.5, 2.5}}
	end
end

-- Creates 10x versions of each recipe from selected categories
require("__Load-Furn__.prototypes.furnaces.recipesFix")
if settings.startup["load-furn-legacy"].value == true then

local function itemGroups()
	for _,v in pairs(table.deepcopy(data.raw["item-group"])) do
		v.localised_name = v.localised_name or {"item-group-name." ..v.name}
		v.name = v.name .. "-AdvFurn"
		if v.type == "item-group" and string.find(v.name, "-AdvFurn") then
			if v.icon or v.icons then
				if v.icon_size == 64 then
					if v.icon then
					v.icons = {	{icon = v.icon},
								{icon = "__Load-Furn__/graphics/icons/logo64.png"}
							}
					v.icon = nil
					elseif v.icons then
					v.icons = v.icons
					end
				elseif v.icon_size == 128 then
					if v.icon then
					v.icons = {	{icon = v.icon},
								{icon = "__Load-Furn__/graphics/icons/logo128.png"}
							}
					v.icon = nil
					elseif v.icons then
					v.icons = v.icons
					end
				end
			end
		end
		v.order = v.order --"y" .. v.order
		data:extend({v})
	end
	for _,v in pairs(table.deepcopy(data.raw["item-subgroup"])) do
		v.localised_name = v.localised_name or {"item-group-name." ..v.name}
		v.name = v.name .. "-AdvFurn"
		v.group = v.group .. "-AdvFurn"
		data:extend({v})
	end
end
itemGroups()

-- Снять ограничение модулей производительности
for _, recipeM in pairs (data.raw["recipe"]) do
	local cat_list1 = table.deepcopy(data.raw["assembling-machine"]["furnace-pro-01"]		["crafting_categories"])
	local cat = recipeM.category or "crafting"
	if inlist(cat, cat_list1) then
	recipe = table.deepcopy(recipeM)
		for _, modul in pairs (data.raw["module"]) do
			if modul.effect.productivity and modul.limitation ~= nil then
				if mods["extendedangels"] then
					local recipeList={
						"pellet-tungsten-smelting",
						"tungsten-carbide",
						"tungsten-carbide-2",
						"copper-tungsten-alloy"
					}
					for _,recipeLt in pairs(recipeList) do
						data.raw.recipe[recipeLt]=nil
						for j,limit in pairs(modul.limitation) do
							if limit == recipeLt then
								table.remove(modul.limitation,j)
								break
							end
						end
					end
				end
				table.insert(modul.limitation, recipe.name)
			end
		end
	end
end
end

if settings.startup["load-furn-legacy"].value == false then

local function round(x, n)
    n = math.pow(10, n or 0) -- любое число, кроме нуля, возведенное в нулевую степень, будет равно единице
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end -- Округляем до самого низкого целого значения, иначе до самого высокого
    return x / n
end
local belts = {} -- Массив скоростей конвеера
local beltspeeds = {} -- Массив скоростей конвеера
for k,v in pairs(data.raw["transport-belt"]) do -- Подставить на места k,v - номера в массиве, значение - всех значений data.raw["transport-belt"].
	table.insert(belts, v.speed)
end
table.sort(belts) -- Отсортировать таблицу beltspeeds по значениям в порядке возрастания.

for k,v in pairs(belts) do
	--log("LEEL belts " .. k .. ", speed = " .. v)
	local target = 1
	local k = 1
	while target <= 10 do
		if belts[k] == belts[k+1] then
			belts[k+1] = nil
		end
		k = k + 1
		target = target + 1
	end
	table.insert(beltspeeds, v)
end

table.sort(beltspeeds) -- Отсортировать таблицу beltspeeds по значениям в порядке возрастания.

for k,v in pairs(beltspeeds) do -- Подставить на места k,v - номера в массиве, значение всех значений beltspeeds[].
	log("LEEL beltspeeds " .. k .. ", speed = " .. v) -- Вывод в лог текущего элемента цикла beltspeeds.
end

	if ((#beltspeeds - 1) % 4 == 0) and (#beltspeeds >= 5) then -- Если остаток от деления beltspeeds - 1 равен нулю и количество элементов в beltspeeds больше 5.
		log("LEEL the belt number is part of que " .. (#beltspeeds - 1) / 4 .. " is d value.") -- То количество печей возможно сделать с одинаковым количеством промежутков между уровнями.

		local multiplier = (#beltspeeds - 1) / 4 -- Промежуток между уровнями - множитель прогрессии = Количество элементов beltspeeds - 1 разделить на 4.
		local furnace = 1 -- Переменная печи, начинаем отсчёт от первой.
		local target = 1 -- Целевой конвеер - к которому будет приравниваться печь из переменной выше. Начинаем с первого.
		while target <= 5 do -- До тех пор, пока целевой конвеер меньше или равен 5.
			data.raw["assembling-machine"]["furnace-pro-0".. target].crafting_speed = ((beltspeeds	[furnace]*480)*3.2)/crafting -- Задаём скорость печи.
			furnace = furnace + multiplier -- Указываем номер следующей печи.
			target = target + 1 -- Указываем, что один конвеер уже был назначен.
		end

	elseif #beltspeeds < 5 then -- В другом случае если количество элементов в beltspeeds менее 5.
		log("LEEL less belts than furnaces! " .. #beltspeeds .. " is less than 5, my lord!") --Выводим, что у нас менее пяти конвееров в лог.
		local furnace = 1 -- Переменная печи, начинаем отсчёт от первой.
		local afterlast = 1 -- Cчётчик, насколько мы далеко ушли выше последнего конвеера.
		while furnace <= 5 do -- До тех пор, пока печь меньше или равно 5.
			if furnace <= #beltspeeds then -- Если номер печи менее или равен последнему элементу beltspeeds
				data.raw["assembling-machine"]["furnace-pro-0".. furnace].crafting_speed = ((beltspeeds	[furnace]*480)*3.2)/crafting -- Задаём значение скорости конвеера.
				furnace = furnace + 1 -- Увеличиваем счётчик печи на 1.
			else
				afterlast = afterlast + 1 -- Увеличиваем счётчик значения выше последнего конвеера.
				data.raw["assembling-machine"]["furnace-pro-0".. furnace].crafting_speed = ((beltspeeds	[#beltspeeds]*afterlast*480)*3.2)/crafting -- Умножаем скорость последней созданной печи на значение после последней и создаём новую печь с этой скоростью.
				furnace = furnace + 1 -- Увеличиваем счётчик печи.
			end
		end

	elseif #beltspeeds > 5 and (#beltspeeds - 1) % 4 ~= 0 then -- В другом случае, если значений в beltspeeds больше 5 и остаток от деления суммы элементов beltspeeds - 1 на 4 не равно нулю.
		log("LEEL more than 5 belts, but d = " .. (#beltspeeds - 1) / 4 .. " is not on que.") -- Выводим сообщение в лог, что невозможно расположить печи с одинаковым промежутком.
		multiplier = round((#beltspeeds - 1) / 4, 0) -- Вычисляем средний промежуток между печами с помощью функции до верхнего натурального целого значения.
		local furnace = 1 -- Значение печи, начинаем с единицы.
		local target = 1 -- Целевой конвеер - который нужно присвоить печи.
		while target <= 4 do -- До тех пор, пока целевое значение меньше или равно 4.
			data.raw["assembling-machine"]["furnace-pro-0".. target].crafting_speed = ((beltspeeds	[furnace]*480)*3.2)/crafting -- Присваиваем печи из furnace скорость из значения элемента beltspeeds под номером furnace.
			furnace = furnace + multiplier -- Повышаем счётчик.
			target = target + 1 -- Повышаем целевой счётчик, т.к. одна печь была создана.
		end
		data.raw["assembling-machine"]["furnace-pro-05"].crafting_speed = ((beltspeeds[#beltspeeds]	*480)*3.2)/crafting  -- Устанавливаем значение пятой печи после выхода из цикла - равное самому последнему значению конвеера.
	end

end