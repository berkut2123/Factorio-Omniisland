local function format(amount, append_suffix) -- util.format_number
  local suffix = ""
  if append_suffix then
    local suffix_list =
      {
        ["T"] = 1000000000000,
        ["B"] = 1000000000,
        ["M"] = 1000000,
        ["k"] = 1000
      }
    for letter, limit in pairs (suffix_list) do
      if math.abs(amount) >= limit then
        amount = math.floor(amount/(limit/10))/10
        suffix = letter
        break
      end
    end
  end
  local formatted, k = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted..suffix
end

--------------------------------------------------------------------------------


local function get_entity(surface, name)
    return surface.find_entities_filtered({name=name})[1]
end

local function set_text(surface, position, value)
    surface.create_entity{
        name = "power-combinator-text",
        position = position,
        force = "player",
        text = {
            "power-combinator-simulation-text-signal",
            value.signal.name,
            format(value.count,true),
        },
    }
end

-------------------------------------------------------------------------------

local function loop()
    local surface = game.surfaces[1]
    local chest   = get_entity(surface, "logistic-chest-storage")
    local control = get_entity(surface, "power-combinator").get_control_behavior()
    control.set_signal(1, {count=0, signal={type="virtual", name="power-factor"}})
    script.on_nth_tick(30, function ()
        set_text(surface, {-6.9, 0.1}, control.get_signal(2))
        set_text(surface, {-6.9, 0.6}, control.get_signal(4))
        set_text(surface, {-4.9, 0.1}, control.get_signal(3))
        set_text(surface, {-4.9, 0.6}, control.get_signal(5))
    end)
    script.on_nth_tick(900, function ()
        local radar = get_entity(surface, "radar")
        if not radar then return end
        local position = radar.position
        radar.die()
        script.on_nth_tick(60, function ()
            script.on_nth_tick(60, nil)
            surface.create_entity{
                name = "entity-ghost",
                inner_name = "radar",
                position = position,
                force = "player",
            }
            chest.insert{
                name = "radar",
                count = 1,
            }
        end)
    end)
end



local T = 10
local STEPS = {
    {
        name = "power-combinator",
        position = {-2, 0},
        force = "player",
        raise_built = true,
    },
    {
        name = "infinity-pipe",
        position = {5,-6},
        force = "player",
    },
    {
        name = "radar",
        position = {5,2},
        force = "player",
    },
    {
        name = "steam-turbine",
        position = {5,-3},
        force = "player",
    },
}


local function stop() -- animation
    script.on_nth_tick(T, nil)
    local surface = game.surfaces[1]
    local pipe = get_entity(surface, "infinity-pipe")
    pipe.set_infinity_pipe_filter{
        name = "steam",
        percentage = 1,
        temperature = 500,
        mode = "exactly",
    }
    return loop()
end

local function step() -- animation
    local surface = game.surfaces[1]
    global.count = #STEPS
    script.on_nth_tick(T, function ()
        surface.create_entity(STEPS[global.count])
        global.count = global.count - 1
        if global.count == 0 then return stop() end
    end)
end


local function start() -- animation
    local surface = game.surfaces[1]
    global.count = 3
    script.on_nth_tick(T, function ()
        global.count = global.count - 1
        if global.count == 2 then return end -- skip here
        if global.count == 0 then return step() end
        surface.create_entity{
            name = "small-electric-pole",
            position = {global.count * 7 - 4, 0},
            force = "player",
        }
    end)
end


local function init()
    local surface = game.surfaces[1]
    local roboport = surface.create_entity{
        name = "roboport",
        position = {20,1},
        force = "player",
    }
    roboport.insert{
        name = "construction-robot",
        count = 1,
    }
    surface.create_entity{
        name = "logistic-chest-storage",
        position = {21,-2},
        force = "player",
    }
    surface.create_entity{
        name = "electric-energy-interface",
        position = {22,-2},
        force = "player",
    }
    start()
end


-------------------------------------------------------------------------------


init()
