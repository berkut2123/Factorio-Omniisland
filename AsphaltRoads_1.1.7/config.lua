local AR_config = {}

-- This value modifies the bonus speed the player will experience if they walk on this tiles
AR_config.asphalt_walking_speed_modifier = 1.5 -- refined concrete: 1.5

-- This value modifies the vehicle friction: Lower values increase acceleration and top-speed. This affects wheeled vehicles the most.
AR_config.asphalt_vehicle_speed_modifier = 0.5 -- refined concrete: 0.8 

AR_config.asphalt_mining_speed = 0.1 -- refined concrete: 0.1 

-- Set this values ingame in Setting/Mods/AsphaltRoads/Startup
AR_config.use_BioIndustries_items = settings.startup["AR-use-items-from-bioindustries"].value
AR_config.use_WoodGasification_items = settings.startup["AR-use-items-from-woodgasification"].value
AR_config.asphalt_stack_size = settings.startup["AR-asphalt-stack-size"].value
AR_config.enable_basic_tiles = settings.startup["AR-enable-basic-marking-tiles"].value
AR_config.enable_cl_hazard_marking = settings.startup["AR-enable-colored-hazard-marking"].value
AR_config.enable_w_single_line_marking = settings.startup["AR-enable-white-single-lines"].value
AR_config.enable_w_double_line_marking = settings.startup["AR-enable-white-double-lines"].value
AR_config.enable_y_single_line_marking = settings.startup["AR-enable-yellow-single-lines"].value
AR_config.enable_y_double_line_marking = settings.startup["AR-enable-yellow-double-lines"].value
 
-- The following values represent the minimap colours of asphalt tiles:
AR_config.asphalt_colour =                 {r=34, g=31, b=28}

AR_config.asphalt_colour_marking_white =   {r=60, g=60, b=60}

AR_config.asphalt_colour_marking_yellow =  {r=60, g=60, b=40}

AR_config.asphalt_colour_marking_blue =    {r=40, g=40, b=49}

AR_config.asphalt_colour_marking_red =     {r=49, g=40, b=40}

AR_config.asphalt_colour_marking_green =   {r=40, g=49, b=40}

-- layer of all asphalt tiles except those with diagonal lines
AR_config.asphalt_base_layer = 60 

-- layer of diagonal line tiles
AR_config.asphalt_priority_layer = AR_config.asphalt_base_layer + 1

return AR_config