--GFX by Arch666Angel
local b = BuildGen:create("more_compressor_tier","auto-compressor-1"):
	setStacksize(50):
	setFlags({"placeable-neutral", "placeable-player", "player-creation"}):
	setSubgroup("production-machine"):
	setIngredients({{"auto-compressor", 1}, {"advanced-circuit", 15}, {"engine-unit", 10}, {"concrete", 30}}):
	setEnergy(15):
	setModSlots(0):
	setModEffects():
	setUsage(500):
	setSpeed(50/8):
	setFurnace():
	setSize(3):
	setFluidBox("XWX.XXX.XKX"):
	setCrafting({"compression"}):
	setAnimation({
      filename = "__more_compressor_tier__/graphics/auto-compressor-sheet-1.png",
      priority = "high",
      width = 160,
      height = 160,
      frame_count = 25,
      line_length = 5,
      shift = {0.0, 0.0},
      animation_speed = 0.25
    }):extend()
	
local b = BuildGen:create("more_compressor_tier","auto-compressor-2"):
	setStacksize(50):
	setFlags({"placeable-neutral", "placeable-player", "player-creation"}):
	setSubgroup("production-machine"):
	setIngredients({{"auto-compressor-1", 1}, {"processing-unit", 5}, {"electric-engine-unit", 15}, {"refined-concrete", 50}}):
	setEnergy(25):
	setModSlots(0):
	setModEffects():
	setUsage(800):
	setSpeed(100/8):
	setFurnace():
	setSize(3):
	setFluidBox("XWX.XXX.XKX"):
	setCrafting({"compression"}):
	setAnimation({
      filename = "__more_compressor_tier__/graphics/auto-compressor-sheet-2.png",
      priority = "high",
      width = 160,
      height = 160,
      frame_count = 25,
      line_length = 5,
      shift = {0.0, 0.0},
      animation_speed = 0.25
    }):extend()
	
local b = BuildGen:create("more_compressor_tier","auto-compressor-3"):
	setStacksize(50):
	setFlags({"placeable-neutral", "placeable-player", "player-creation"}):
	setSubgroup("production-machine"):
	setIngredients({{"auto-compressor-2", 1}, {"rocket-control-unit", 5}, {"centrifuge", 1}, {"low-density-structure", 10}}):
	setEnergy(40):
	setModSlots(0):
	setModEffects():
	setUsage(1250):
	setSpeed(200/8):
	setFurnace():
	setSize(3):
	setFluidBox("XWX.XXX.XKX"):
	setCrafting({"compression"}):
	setAnimation({
      filename = "__more_compressor_tier__/graphics/auto-compressor-sheet-3.png",
      priority = "high",
      width = 160,
      height = 160,
      frame_count = 25,
      line_length = 5,
      shift = {0.0, 0.0},
      animation_speed = 0.25
    }):extend()
