-- Bob's mod electronics texture override :
-- check if an icon is currenctly being used, if that's the case it is overriden.
if settings.startup["replace-electronics"].value == true then

	if data.raw.item["wooden-board"]  then 
		data.raw.item["wooden-board"].icon = "__bobmods_gfxtweak__/graphics/icons/electronics/wooden-board.png" 
		data.raw.item["wooden-board"].icon_size = 32 end 
	if data.raw.item["phenolic-board"]  then 
		data.raw.item["phenolic-board"].icon = "__bobmods_gfxtweak__/graphics/icons/electronics/phenolic-board.png" 
		data.raw.item["phenolic-board"].icon_size = 32 end 
	if data.raw.item["fibreglass-board"]  then 
		data.raw.item["fibreglass-board"].icon = "__bobmods_gfxtweak__/graphics/icons/electronics/fibreglass-board.png" 
		data.raw.item["fibreglass-board"].icon_size = 32 end 
	if data.raw.item["basic-circuit-board"]  then 
		data.raw.item["basic-circuit-board"].icon = "__bobmods_gfxtweak__/graphics/icons/electronics/basic-circuit-board.png" 
		data.raw.item["basic-circuit-board"].icon_size = 32 end 
	if data.raw.item["circuit-board"]  then 
		data.raw.item["circuit-board"].icon = "__bobmods_gfxtweak__/graphics/icons/electronics/circuit-board.png" 
		data.raw.item["circuit-board"].icon_size = 32 end 
	if data.raw.item["superior-circuit-board"]  then 
		data.raw.item["superior-circuit-board"].icon = "__bobmods_gfxtweak__/graphics/icons/electronics/superior-circuit-board.png" 
		data.raw.item["superior-circuit-board"].icon_size = 32 end 
	if data.raw.item["multi-layer-circuit-board"]  then 
		data.raw.item["multi-layer-circuit-board"].icon = "__bobmods_gfxtweak__/graphics/icons/electronics/multi-layer-circuit-board.png" 
		data.raw.item["multi-layer-circuit-board"].icon_size = 32 end
	if data.raw.item["electronic-circuit"]  then 
		data.raw.item["electronic-circuit"].icon = "__bobmods_gfxtweak__/graphics/icons/electronics/basic-electronic-circuit-board.png" 
		data.raw.item["electronic-circuit"].icon_size = 32 end 
	if data.raw.item["advanced-circuit"]  then 
		data.raw.item["advanced-circuit"].icon = "__bobmods_gfxtweak__/graphics/icons/electronics/electronic-circuit-board.png" 
		data.raw.item["advanced-circuit"].icon_size = 32 end 
	if data.raw.item["processing-unit"]  then 
		data.raw.item["processing-unit"].icon = "__bobmods_gfxtweak__/graphics/icons/electronics/electronic-logic-board.png" 
		data.raw.item["processing-unit"].icon_size = 32 end 
	if data.raw.item["advanced-processing-unit"]  then 
		data.raw.item["advanced-processing-unit"].icon = "__bobmods_gfxtweak__/graphics/icons/electronics/electronic-processing-board.png" 
		data.raw.item["advanced-processing-unit"].icon_size = 32 end 
	
end
-- Bob's mod warfare texture override :
if settings.startup["replace-warfare"].value == true then
--items icon override
	if data.raw.item["acid-bullet"]  then data.raw.item["acid-bullet"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/acid-bullet.png" end
	if data.raw.ammo["acid-bullet-magazine"]  then data.raw.ammo["acid-bullet-magazine"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/acid-bullet-magazine.png" end
	if data.raw.item["acid-bullet-projectile"]  then data.raw.item["acid-bullet-projectile"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/acid-bullet-projectile.png" end
	if data.raw.item["ap-bullet"]  then data.raw.item["ap-bullet"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/ap-bullet.png" end
	if data.raw.ammo["ap-bullet-magazine"]  then data.raw.ammo["ap-bullet-magazine"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/ap-bullet-magazine.png" end
	if data.raw.item["ap-bullet-projectile"]  then data.raw.item["ap-bullet-projectile"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/ap-bullet-projectile.png" end
	if data.raw.item["bullet"]  then data.raw.item["bullet"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/bullet.png" end
	if data.raw.item["bullet-casing"]  then data.raw.item["bullet-casing"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/bullet-casing.png" end
	if data.raw.ammo["bullet-magazine"]  then data.raw.ammo["bullet-magazine"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/bullet-magazine.png" end
	if data.raw.item["bullet-projectile"]  then data.raw.item["bullet-projectile"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/bullet-projectile.png" end
	if data.raw.item["electric-bullet"]  then data.raw.item["electric-bullet"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/electric-bullet.png" end
	if data.raw.ammo["electric-bullet-magazine"]  then data.raw.ammo["electric-bullet-magazine"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/electric-bullet-magazine.png" end
	if data.raw.item["electric-bullet-projectile"]  then data.raw.item["electric-bullet-projectile"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/electric-bullet-projectile.png" end
	if data.raw.item["flame-bullet"]  then data.raw.item["flame-bullet"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/flame-bullet.png" end
	if data.raw.ammo["flame-bullet-magazine"]  then data.raw.ammo["flame-bullet-magazine"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/flame-bullet-magazine.png" end
	if data.raw.item["flame-bullet-projectile"]  then data.raw.item["flame-bullet-projectile"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/flame-bullet-projectile.png" end
	if data.raw.item["he-bullet"]  then data.raw.item["he-bullet"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/he-bullet.png" end
	if data.raw.ammo["he-bullet-magazine"]  then data.raw.ammo["he-bullet-magazine"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/he-bullet-magazine.png" end
	if data.raw.item["he-bullet-projectile"]  then data.raw.item["he-bullet-projectile"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/he-bullet-projectile.png" end
	if data.raw.item["poison-bullet"]  then data.raw.item["poison-bullet"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/poison-bullet.png" end
	if data.raw.ammo["poison-bullet-magazine"]  then data.raw.ammo["poison-bullet-magazine"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/poison-bullet-magazine.png" end
	if data.raw.item["poison-bullet-projectile"]  then data.raw.item["poison-bullet-projectile"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/poison-bullet-projectile.png" end
	if data.raw.item["shotgun-shell-casing"]  then data.raw.item["shotgun-shell-casing"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-shell-casing.png" end
	if data.raw.ammo["shotgun-acid-shell"]  then data.raw.ammo["shotgun-acid-shell"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-acid-shell.png" end
	if data.raw.ammo["shotgun-ap-shell"]  then data.raw.ammo["shotgun-ap-shell"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-ap-shell.png" end
	if data.raw.ammo["shotgun-electric-shell"]  then data.raw.ammo["shotgun-electric-shell"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-electric-shell.png" end
	if data.raw.ammo["shotgun-explosive-shell"]  then data.raw.ammo["shotgun-explosive-shell"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-explosive-shell.png" end
	if data.raw.ammo["shotgun-flame-shell"]  then data.raw.ammo["shotgun-flame-shell"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-flame-shell.png" end
	if data.raw.ammo["shotgun-poison-shell"]  then data.raw.ammo["shotgun-poison-shell"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-poison-shell.png" end
	if data.raw.ammo["better-shotgun-shell"]  then data.raw.ammo["better-shotgun-shell"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-shell.png" end
	-- research icons override
	if settings.startup["replace-research-icons"].value == true then

		if data.raw.technology["bob-bullets"] then data.raw.technology["bob-bullets"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/bullet-magazine.png" end
		if data.raw.technology["bob-ap-bullets"] then data.raw.technology["bob-ap-bullets"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/ap-bullet-magazine.png" end
		if data.raw.technology["bob-electric-bullets"] then data.raw.technology["bob-electric-bullets"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/electric-bullet-magazine.png" end
		if data.raw.technology["bob-he-bullets"] then data.raw.technology["bob-he-bullets"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/he-bullet-magazine.png" end
		if data.raw.technology["bob-flame-bullets"] then data.raw.technology["bob-flame-bullets"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/flame-bullet-magazine.png" end
		if data.raw.technology["bob-acid-bullets"] then data.raw.technology["bob-acid-bullets"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/acid-bullet-magazine.png" end
		if data.raw.technology["bob-poison-bullets"] then data.raw.technology["bob-poison-bullets"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/poison-bullet-magazine.png" end
		if data.raw.technology["bob-shotgun-shells"] then data.raw.technology["bob-shotgun-shells"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-shell.png" end
		if data.raw.technology["bob-shotgun-ap-shells"] then data.raw.technology["bob-shotgun-ap-shells"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-ap-shell.png" end
		if data.raw.technology["bob-shotgun-electric-shells"] then data.raw.technology["bob-shotgun-electric-shells"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-electric-shell.png" end
		if data.raw.technology["bob-shotgun-explosive-shells"] then data.raw.technology["bob-shotgun-explosive-shells"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-explosive-shell.png" end
		if data.raw.technology["bob-shotgun-flame-shells"] then data.raw.technology["bob-shotgun-flame-shells"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-flame-shell.png" end
		if data.raw.technology["bob-shotgun-acid-shells"] then data.raw.technology["bob-shotgun-acid-shells"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-acid-shell.png" end
		if data.raw.technology["bob-shotgun-poison-shells"] then data.raw.technology["bob-shotgun-poison-shells"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-poison-shell.png" end
		
	end
		
end

--[[ WIP
if settings.startup["replace-modules"].value == true then

	if data.raw.module["speed-module"]  then 
		data.raw.module["speed-module"].icon = "__bobmods_gfxtweak__/graphics/icons/modules/speed-module-1.png" 
		data.raw.module["speed-module"].icon_size = 128 end 
	if data.raw.module["speed-module-2"]  then 
		data.raw.module["speed-module-2"].icon = "__bobmods_gfxtweak__/graphics/icons/modules/speed-module-2.png" 
		data.raw.module["speed-module-2"].icon_size = 128 end
	if data.raw.module["speed-module-3"]  then 
		data.raw.module["speed-module-3"].icon = "__bobmods_gfxtweak__/graphics/icons/modules/speed-module-3.png" 
		data.raw.module["speed-module-3"].icon_size = 128 end
	if data.raw.module["speed-module-4"]  then 
		data.raw.module["speed-module-4"].icon = "__bobmods_gfxtweak__/graphics/icons/modules/speed-module-4.png" 
		data.raw.module["speed-module-4"].icon_size = 128 end
	if data.raw.module["speed-module-5"]  then 
		data.raw.module["speed-module-5"].icon = "__bobmods_gfxtweak__/graphics/icons/modules/speed-module-5.png" 
		data.raw.module["speed-module-5"].icon_size = 128 end
	if data.raw.module["speed-module-6"]  then 
		data.raw.module["speed-module-6"].icon = "__bobmods_gfxtweak__/graphics/icons/modules/speed-module-6.png" 
		data.raw.module["speed-module-6"].icon_size = 128 end
	if data.raw.module["speed-module-7"]  then 
		data.raw.module["speed-module-7"].icon = "__bobmods_gfxtweak__/graphics/icons/modules/speed-module-7.png" 
		data.raw.module["speed-module-7"].icon_size = 128 end
	if data.raw.module["speed-module-8"]  then 
		data.raw.module["speed-module-8"].icon = "__bobmods_gfxtweak__/graphics/icons/modules/speed-module-8.png" 
		data.raw.module["speed-module-8"].icon_size = 128 end
		
	--	data.raw.module["effectivity-module-2"].icon_size = 32 
	

end
]]--

-- Bob's mod logistics texture override :
-- Author Note: this was removed because current bobmods has the same robots and in higher quality, so it was pointless to keep it
-- for some reasons if you still need em, you can download the pictures from 0.16 builds or lower and uncomment the following
-- section to put them back, but really you shouldn't.
--[=====[ 
if settings.startup["replace-logistics"].value == true then

	function robot_animated_idle_construction(filename)
	return 
	{
		  filename = filename,
		  priority = "high",
		  line_length = 16,
		  width = 32,
		  height = 36,
		  frame_count = 1,
		  shift = {0, -0.15625},
		  direction_count = 16
	}
	end

	function robot_animated_idle_logi(filename)
	return 
	{
		  filename = filename,
		  priority = "high",
		  line_length = 16,
		  width = 41,
		  height = 42,
		  frame_count = 1,
		  shift = {0.015625, -0.09375},
		  direction_count = 16,
		  y = 42
	}
	end
	function robot_animated_idle_with_cargo_logi(filename)
	return
    {
      filename = filename,
      priority = "high",
      line_length = 16,
      width = 41,
      height = 42,
      frame_count = 1,
      shift = {0.015625, -0.09375},
      direction_count = 16
    }
	end
	
	function robot_animated_in_motion_construction(filename)
	return
	{
		  filename = filename,
		  priority = "high",
		  line_length = 16,
		  width = 32,
		  height = 36,
		  frame_count = 1,
		  shift = {0, -0.15625},
		  direction_count = 16,
		  y = 36
	}
	end

	function robot_animated_in_motion_logi(filename)
	return
	{
		  filename = filename,
		  priority = "high",
		  line_length = 16,
		  width = 41,
		  height = 42,
		  frame_count = 1,
		  shift = {0.015625, -0.09375},
		  direction_count = 16,
		  y = 126
	}
	end

	function robot_animated_in_motion_with_cargo_logi(filename)
	return
	{
		  filename = filename,
		  priority = "high",
		  line_length = 16,
		  width = 41,
		  height = 42,
		  frame_count = 1,
		  shift = {0.015625, -0.09375},
		  direction_count = 16,
		  y = 84
	}
	end


	function robot_animated_working_construction(filename)
	return
	{
		  filename = filename,
		  priority = "high",
		  line_length = 2,
		  width = 28,
		  height = 36,
		  frame_count = 2,
		  shift = {0, -0.15625},
		  direction_count = 16,
		  animation_speed = 0.3,
	}
	end
		
	shadow_idle_construction =
	{
		  filename = "__base__/graphics/entity/construction-robot/construction-robot-shadow.png",
		  priority = "high",
		  line_length = 16,
		  width = 50,
		  height = 24,
		  frame_count = 1,
		  shift = {1.09375, 0.59375},
		  direction_count = 16
	}

	shadow_in_motion_construction =
	{
		  filename = "__base__/graphics/entity/construction-robot/construction-robot-shadow.png",
		  priority = "high",
		  line_length = 16,
		  width = 50,
		  height = 24,
		  frame_count = 1,
		  shift = {1.09375, 0.59375},
		  direction_count = 16
	}

	shadow_working_construction =
		{
		  stripes = util.multiplystripes(2,
		  {
			{
			  filename = "__base__/graphics/entity/construction-robot/construction-robot-shadow.png",
			  width_in_frames = 16,
			  height_in_frames = 1,
			}
		  }),
		  priority = "high",
		  width = 50,
		  height = 24,
		  frame_count = 2,
		  shift = {1.09375, 0.59375},
		  direction_count = 16
		}
		
	shadow_idle_logi =
	{
		  filename = "__base__/graphics/entity/logistic-robot/logistic-robot-shadow.png",
		  priority = "high",
		  line_length = 16,
		  width = 59,
		  height = 23,
		  frame_count = 1,
		  shift = {0.96875, 0.609375},
		  direction_count = 16,
		  y = 23
	}
	shadow_idle_with_cargo_logi =
	{
		  filename = "__base__/graphics/entity/logistic-robot/logistic-robot-shadow.png",
		  priority = "high",
		  line_length = 16,
		  width = 59,
		  height = 23,
		  frame_count = 1,
		  shift = {0.96875, 0.609375},
		  direction_count = 16
	}
	shadow_in_motion_logi =
	{
		  filename = "__base__/graphics/entity/logistic-robot/logistic-robot-shadow.png",
		  priority = "high",
		  line_length = 16,
		  width = 59,
		  height = 23,
		  frame_count = 1,
		  shift = {0.96875, 0.609375},
		  direction_count = 16,
		  y = 23
	}
	shadow_in_motion_with_cargo_logi =
	{
		  filename = "__base__/graphics/entity/logistic-robot/logistic-robot-shadow.png",
		  priority = "high",
		  line_length = 16,
		  width = 59,
		  height = 23,
		  frame_count = 1,
		  shift = {0.96875, 0.609375},
		  direction_count = 16
	}

	if  data.raw.item["bob-construction-robot-2"] then
			data.raw.item["bob-construction-robot-2"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/construction-robot-2.png"
			data.raw["construction-robot"]["bob-construction-robot-2"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/construction-robot-2.png"
			data.raw["construction-robot"]["bob-construction-robot-2"].idle = robot_animated_idle_construction("__bobmods_gfxtweak__/graphics/entity/construction-robot-2.png")
			data.raw["construction-robot"]["bob-construction-robot-2"].in_motion = robot_animated_in_motion_construction("__bobmods_gfxtweak__/graphics/entity/construction-robot-2.png")
			data.raw["construction-robot"]["bob-construction-robot-2"].working = robot_animated_working_construction("__bobmods_gfxtweak__/graphics/entity/construction-robot-working-2.png")
			data.raw["construction-robot"]["bob-construction-robot-2"].shadow_idle = shadow_idle_construction;
			data.raw["construction-robot"]["bob-construction-robot-2"].shadow_in_motion = shadow_in_motion_construction;
			data.raw["construction-robot"]["bob-construction-robot-2"].shadow_working = shadow_working_construction;
		end
	
	if  data.raw.item["bob-construction-robot-3"] then
			data.raw.item["bob-construction-robot-3"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/construction-robot-3.png"
			data.raw["construction-robot"]["bob-construction-robot-3"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/construction-robot-3.png"
			data.raw["construction-robot"]["bob-construction-robot-3"].idle = robot_animated_idle_construction("__bobmods_gfxtweak__/graphics/entity/construction-robot-3.png")
			data.raw["construction-robot"]["bob-construction-robot-3"].in_motion = robot_animated_in_motion_construction("__bobmods_gfxtweak__/graphics/entity/construction-robot-3.png")
			data.raw["construction-robot"]["bob-construction-robot-3"].working = robot_animated_working_construction("__bobmods_gfxtweak__/graphics/entity/construction-robot-working-3.png")
			data.raw["construction-robot"]["bob-construction-robot-3"].shadow_idle = shadow_idle_construction;
			data.raw["construction-robot"]["bob-construction-robot-3"].shadow_in_motion = shadow_in_motion_construction;
			data.raw["construction-robot"]["bob-construction-robot-3"].shadow_working = shadow_working_construction;
		end
	
	if  data.raw.item["bob-construction-robot-4"] then
			data.raw.item["bob-construction-robot-4"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/construction-robot-4.png"
			data.raw["construction-robot"]["bob-construction-robot-4"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/construction-robot-4.png"
			data.raw["construction-robot"]["bob-construction-robot-4"].idle = robot_animated_idle_construction("__bobmods_gfxtweak__/graphics/entity/construction-robot-4.png")
			data.raw["construction-robot"]["bob-construction-robot-4"].in_motion = robot_animated_in_motion_construction("__bobmods_gfxtweak__/graphics/entity/construction-robot-4.png")
			data.raw["construction-robot"]["bob-construction-robot-4"].working = robot_animated_working_construction("__bobmods_gfxtweak__/graphics/entity/construction-robot-working-4.png")
			data.raw["construction-robot"]["bob-construction-robot-4"].shadow_idle = shadow_idle_construction;
			data.raw["construction-robot"]["bob-construction-robot-4"].shadow_in_motion = shadow_in_motion_construction;
			data.raw["construction-robot"]["bob-construction-robot-4"].shadow_working = shadow_working_construction;
		end
		
	if  data.raw.item["bob-logistic-robot-2"] then
			data.raw.item["bob-logistic-robot-2"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/logistic-robot-2.png"
			data.raw["logistic-robot"]["bob-logistic-robot-2"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/logistic-robot-2.png"
			data.raw["logistic-robot"]["bob-logistic-robot-2"].idle = robot_animated_idle_logi("__bobmods_gfxtweak__/graphics/entity/logistic-robot-2.png")
			data.raw["logistic-robot"]["bob-logistic-robot-2"].idle_with_cargo = robot_animated_idle_with_cargo_logi("__bobmods_gfxtweak__/graphics/entity/logistic-robot-2.png")
			data.raw["logistic-robot"]["bob-logistic-robot-2"].in_motion = robot_animated_in_motion_logi("__bobmods_gfxtweak__/graphics/entity/logistic-robot-2.png")
			data.raw["logistic-robot"]["bob-logistic-robot-2"].in_motion_with_cargo = robot_animated_in_motion_with_cargo_logi("__bobmods_gfxtweak__/graphics/entity/logistic-robot-2.png")
			data.raw["logistic-robot"]["bob-logistic-robot-2"].shadow_idle = shadow_idle_logi;
			data.raw["logistic-robot"]["bob-logistic-robot-2"].shadow_idle_with_cargo = shadow_idle_with_cargo_logi;
			data.raw["logistic-robot"]["bob-logistic-robot-2"].shadow_in_motion = shadow_in_motion_logi;
			data.raw["logistic-robot"]["bob-logistic-robot-2"].shadow_in_motion_with_cargo = shadow_in_motion_with_cargo_logi;
		end
		
	if  data.raw.item["bob-logistic-robot-3"] then
			data.raw.item["bob-logistic-robot-3"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/logistic-robot-3.png"
			data.raw["logistic-robot"]["bob-logistic-robot-3"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/logistic-robot-3.png"
			data.raw["logistic-robot"]["bob-logistic-robot-3"].idle = robot_animated_idle_logi("__bobmods_gfxtweak__/graphics/entity/logistic-robot-3.png")
			data.raw["logistic-robot"]["bob-logistic-robot-3"].idle_with_cargo = robot_animated_idle_with_cargo_logi("__bobmods_gfxtweak__/graphics/entity/logistic-robot-3.png")
			data.raw["logistic-robot"]["bob-logistic-robot-3"].in_motion = robot_animated_in_motion_logi("__bobmods_gfxtweak__/graphics/entity/logistic-robot-3.png")
			data.raw["logistic-robot"]["bob-logistic-robot-3"].in_motion_with_cargo = robot_animated_in_motion_with_cargo_logi("__bobmods_gfxtweak__/graphics/entity/logistic-robot-3.png")
			data.raw["logistic-robot"]["bob-logistic-robot-3"].shadow_idle = shadow_idle_logi;
			data.raw["logistic-robot"]["bob-logistic-robot-3"].shadow_idle_with_cargo = shadow_idle_with_cargo_logi;
			data.raw["logistic-robot"]["bob-logistic-robot-3"].shadow_in_motion = shadow_in_motion_logi;
			data.raw["logistic-robot"]["bob-logistic-robot-3"].shadow_in_motion_with_cargo = shadow_in_motion_with_cargo_logi;
		end
	
	if  data.raw.item["bob-logistic-robot-4"] then
			data.raw.item["bob-logistic-robot-4"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/logistic-robot-4.png"
			data.raw["logistic-robot"]["bob-logistic-robot-4"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/logistic-robot-4.png"
			data.raw["logistic-robot"]["bob-logistic-robot-4"].idle = robot_animated_idle_logi("__bobmods_gfxtweak__/graphics/entity/logistic-robot-4.png")
			data.raw["logistic-robot"]["bob-logistic-robot-4"].idle_with_cargo = robot_animated_idle_with_cargo_logi("__bobmods_gfxtweak__/graphics/entity/logistic-robot-4.png")
			data.raw["logistic-robot"]["bob-logistic-robot-4"].in_motion = robot_animated_in_motion_logi("__bobmods_gfxtweak__/graphics/entity/logistic-robot-4.png")
			data.raw["logistic-robot"]["bob-logistic-robot-4"].in_motion_with_cargo = robot_animated_in_motion_with_cargo_logi("__bobmods_gfxtweak__/graphics/entity/logistic-robot-4.png")
			data.raw["logistic-robot"]["bob-logistic-robot-4"].shadow_idle = shadow_idle_logi;
			data.raw["logistic-robot"]["bob-logistic-robot-4"].shadow_idle_with_cargo = shadow_idle_with_cargo_logi;
			data.raw["logistic-robot"]["bob-logistic-robot-4"].shadow_in_motion = shadow_in_motion_logi;
			data.raw["logistic-robot"]["bob-logistic-robot-4"].shadow_in_motion_with_cargo = shadow_in_motion_with_cargo_logi;
		end
		
	if data.raw.technology["bob-robots-1"] then 
		data.raw.technology["bob-robots-1"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/robotics-1.png" 
		data.raw.technology["bob-robots-1"].icon_size = 128
		end
		
	if data.raw.technology["bob-robots-2"] then 
		data.raw.technology["bob-robots-2"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/robotics-2.png" 
		data.raw.technology["bob-robots-2"].icon_size = 128
		end
		
	if data.raw.technology["bob-robots-3"] then 
		data.raw.technology["bob-robots-3"].icon = "__bobmods_gfxtweak__/graphics/icons/logistics/robotics-3.png" 
		data.raw.technology["bob-robots-3"].icon_size = 128
		end
	
end

--]=====] 


--if data.raw.item["tech-1"]  then data.raw.item["tech-1"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/tech-1.png" end
--if data.raw.item["tech-2"]  then data.raw.item["tech-2"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/tech-2.png" end
--if data.raw.item["tech-3"]  then data.raw.item["tech-3"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/tech-3.png" end
--if data.raw.item["shotgun-1"]  then data.raw.item["shotgun-1"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-1.png" end
--if data.raw.item["shotgun-2"]  then data.raw.item["shotgun-2"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-2.png" end
--if data.raw.item["shotgun-3"]  then data.raw.item["shotgun-3"].icon = "__bobmods_gfxtweak__/graphics/icons/warfare/shotgun-3.png" end

--[[
-- Simple and dirty JS for adding new icons :
		var items = [
			"stuff-1",
			"stuff-2",
			"stuff-3"
		];
		var text = "";
		var icondirectory = "\"__bobmods_gfxtweak__/graphics/icons/mod/";
		for (i = 0; i < items.length; i++) { 
			text += "if data.raw.item[\"" + items[i] + "\"]  then data.raw.item[\"" + items[i] + "\"].icon = " + icondirectory + items[i] + ".png\" end" +  "<br>";
		}

		document.write(text);
--]]