
game = game ---@type LuaGameScript
script = script ---@type LuaBootstrap
remote = remote ---@type LuaRemote
commands = commands ---@type LuaCommandProcessor
settings = settings ---@type LuaSettings
rcon = rcon ---@type LuaRCON
rendering = rendering ---@type LuaRendering
global=global ---@type table
log=log ---@type fun(str:LocalisedString)
localised_print=localised_print ---@type fun(str:LocalisedString)
table_size=table_size ---@type fun(table:table):int

---@class float : number

---@class double : number

---@class int : number

---@class int8 : number

---@class uint : number

---@class uint8 : number

---@class uint16 : number

---@class uint64 : number

---@class LuaAISettings If enabled, units that repeatedly fail to succeed at commands will be destroyed.
---@field allow_destroy_when_commands_fail boolean @ [Read-Write] If enabled, units that repeatedly fail to succeed at commands will be destroyed.
---@field allow_try_return_to_spawner boolean @ [Read-Write] If enabled, units that have nothing else to do will attempt to return to a spawner.
---@field do_separation boolean @ [Read-Write] If enabled, units will try to separate themselves from nearby friendly units.
---@field path_resolution_modifier int8 @ [Read-Write] The pathing resolution modifier, must be between -8 and 8.

---@class LuaAchievementPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field allowed_without_fight boolean @ [Read-only] 
---@field hidden boolean @ [Read-only] 

---@class LuaAmmoCategoryPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field bonus_gui_order string @ [Read-only] 

---@class LuaAutoplaceControlPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field richness boolean @ [Read-only] 
---@field control_order string @ [Read-only] 
---@field category string @ [Read-only] 

---@class LuaBootstrap Register a callback to be run on mod init. This is called once when a new save game is created or once when a save file is loaded that previously didn't contain the mod. This is always called before other event handlers and is meant for setting up initial values that a mod will use for its lifetime.
---@field mod_name string @ [Read-only] The name of the mod from the environment this is used in.
---@field active_mods table<string, string> @ [Read-only] The active mods versions. The keys are mod names, the values are the versions.
---@field is_game_in_debug_mode nil @ [Read-only] Is the game compiled in a debug mode. This will always return false in retail builds.
---@field object_name string @ [Read-only] This objects name.

---Register a callback to be run on mod init. This is called once when a new save game is created or once when a save file is loaded that previously didn't contain the mod. This is always called before other event handlers and is meant for setting up initial values that a mod will use for its lifetime.
---@param f fun() @The function to call. Passing nil will   unregister the handler
function LuaBootstrap.on_init(f) end

---Register a function to be run on module load. This is called every time a save file is loaded *except* for the instance when a mod is loaded into a save file that it previously wasn't part of. Additionally this is called when connecting to any other game in a multiplayer session and should never change the game state.
---@param f fun() @The function to call. Passing nil will unregister the handler
function LuaBootstrap.on_load(f) end

---Register a function to be run when mod configuration changes. This is called any time the game version changes, prototypes change, startup mod settings change, and any time mod versions change including adding or removing mods.
---@param f fun(arg0: ConfigurationChangedData) @
function LuaBootstrap.on_configuration_changed(f) end

---Register a handler to run on event or events.
---@param event defines.events | defines.events[] | defines.events | string @The events or custom-input name to invoke the handler o
---@param f fun(arg0: Event) @The handler to run. Passing nil will unregister the handler. The handler   will receive a table that contains the key name (of type defines.events) specifying the name   of the event it was called to handle, and tick that specifies when the event was created. This table will   also contain other fields, depending on the type of the event. See    the list of Factorio events for a listing of these additional fields
---@param filters Filters @The filters for this single event registration.   See  the list of event filters for a listing of these filters
function LuaBootstrap.on_event(event, f, filters) end

---Register a handler to run every nth tick(s). When the game is on tick 0 it will trigger all registered handlers.
---@param tick uint | uint[] | uint @The nth-tick(s) to invoke the handler on. Passing nil as the only parameter will unregister all nth-tick handlers
---@param f fun(arg0: NthTickEvent) @The handler to run. Passing nil will unregister the handler for the provided ticks
function LuaBootstrap.on_nth_tick(tick, f) end

---Registers an entity so that after it's destroyed on_entity_destroyed is called.
---@param entity LuaEntity @The entity to register
---@return uint64 @
function LuaBootstrap.register_on_entity_destroyed(entity) end

---Generate a new, unique event ID.
---@return uint @
function LuaBootstrap.generate_event_name() end

---
---@param event uint @The event identifier to get a handler fo
function LuaBootstrap.get_event_handler(event) end

---Gets the mod event order. type(string)
function LuaBootstrap.get_event_order() end

---Sets the filters for the given event.
---@param event uint @ID of the event to filter
---@param filters Filters @The  filters or nil to clear the filter
function LuaBootstrap.set_event_filter(event, filters) end

---Gets the filters for the given event.
---@param event uint @ID of the event to get
---@return table @
function LuaBootstrap.get_event_filter(event) end

---Raise an event. Only events generated with LuaBootstrap::generate_event_name and the following can be raised: on_console_chat on_player_crafted_item on_player_fast_transferred on_biter_base_built on_market_item_purchased script_raised_built script_raised_destroy script_raised_revive script_raised_set_tiles
---@param event uint @ID of the event to rais
---@param table table @Table with extra data. This table will be passed to the event handler
function LuaBootstrap.raise_event(event, table) end

---Raises on_console_chat
---@param table RaiseEventParameters @
function LuaBootstrap.raise_console_chat(table) end

---Raises on_player_crafted_item
---@param table RaiseEventParameters @
function LuaBootstrap.raise_player_crafted_item(table) end

---Raises on_player_fast_transferred
---@param table RaiseEventParameters @
function LuaBootstrap.raise_player_fast_transferred(table) end

---Raises on_biter_base_built
---@param table RaiseEventParameters @
function LuaBootstrap.raise_biter_base_built(table) end

---Raises on_market_item_purchased
---@param table RaiseEventParameters @
function LuaBootstrap.raise_market_item_purchased(table) end

---Raises script_raised_built
---@param table RaiseEventParameters @
function LuaBootstrap.raise_script_built(table) end

---Raises script_raised_destroy
---@param table RaiseEventParameters @
function LuaBootstrap.raise_script_destroy(table) end

---Raises script_raised_revive
---@param table RaiseEventParameters @
function LuaBootstrap.raise_script_revive(table) end

---Raises script_raised_set_tiles
---@param table RaiseEventParameters @
function LuaBootstrap.raise_script_set_tiles(table) end

---@class LuaBurner The owner of this burner energy source
---@field owner LuaEntity | LuaEquipment @ [Read-only] The owner of this burner energy source
---@field inventory LuaInventory @ [Read-only] The fuel inventory.
---@field burnt_result_inventory LuaInventory @ [Read-only] The burnt result inventory.
---@field heat double @ [Read-Write] 
---@field heat_capacity double @ [Read-only] 
---@field remaining_burning_fuel double @ [Read-Write] 
---@field currently_burning LuaItemPrototype @ [Read-Write] 
---@field fuel_categories table<string, boolean> @ [Read-only] The fuel categories this burner uses.

---@class LuaBurnerPrototype 
---@field emissions double @ [Read-only] 
---@field render_no_network_icon boolean @ [Read-only] 
---@field render_no_power_icon boolean @ [Read-only] 
---@field effectivity double @ [Read-only] 
---@field fuel_inventory_size uint @ [Read-only] 
---@field burnt_inventory_size uint @ [Read-only] 
---@field smoke SmokeSource[] @ [Read-only] The smoke sources for this burner prototype if any.
---@field light_flicker table @ [Read-only] The light flicker definition for this burner prototype if any.
---@field fuel_categories table<string, boolean> @ [Read-only] 

---@class LuaChunkIterator 

---
---@return ChunkPositionAndArea @
function LuaChunkIterator.operator__call() end

---@class LuaCircuitNetwork 
---@field entity LuaEntity @ [Read-only] 
---@field wire_type defines.wire_type @ [Read-only] 
---@field circuit_connector_id defines.circuit_connector_id @ [Read-only] 
---@field signals Signal[] @ [Read-only] 
---@field network_id uint @ [Read-only] 
---@field connected_circuit_count uint @ [Read-only] 

---
---@param signal SignalID @The signal to read
---@return int @
function LuaCircuitNetwork.get_signal(signal) end

---@class LuaCommandProcessor Add a command.
---@field commands table<string, LocalisedString> @ [Read-only] Commands registered by scripts through LuaCommandProcessor.
---@field game_commands table<string, LocalisedString> @ [Read-only] Builtin commands of the core game.
---@field object_name string @ [Read-only] This objects name.

---Add a command.
---@param name string @Name of the command (case sensitive)
---@param help LocalisedString @The localised help message
---@param func fun() @The function that will be called when this command is invoked
function LuaCommandProcessor.add_command(name, help, func) end

---Removes a registered command
---@return boolean @
function LuaCommandProcessor.remove_command() end

---@class LuaControl Get an inventory belonging to this entity. This can be either the "main" inventory or some auxiliary one, like the module slots or logistic trash slots.
---@field set_gui_arrow nil @ undefined Create an arrow which points at this entity. This is used in the tutorial. For examples, see control.lua in the campaign missions.
---@field begin_crafting uint @(optional) undefined Begins crafting the given count of the given recipe
---@field surface LuaSurface @ [Read-only] 
---@field position Position @ [Read-only] 
---@field vehicle LuaEntity @ [Read-only] 
---@field force ForceSpecification @ [Read-Write] The force of this entity. Reading will always give a LuaForce, but it is possible to assign either string or LuaForce to this attribute to change the force.
---@field selected LuaEntity @ [Read-Write] 
---@field opened LuaEntity | LuaItemStack | LuaEquipment | LuaEquipmentGrid | LuaPlayer | LuaGuiElement | defines.gui_type @ [Read-Write] 
---@field crafting_queue_size uint @ [Read-only] 
---@field walking_state table @ [Read-Write] Current walking state.
---@field riding_state RidingState @ [Read-Write] Current riding state of this car or the vehicle this player is riding in.
---@field mining_state table @(optional) [Read-Write] Current mining state.
---@field shooting_state table @ [Read-Write] Current shooting state.
---@field picking_state boolean @ [Read-Write] Current item-picking state.
---@field repair_state table @ [Read-Write] Current repair state.
---@field cursor_stack LuaItemStack @ [Read-only] 
---@field cursor_ghost ItemPrototypeSpecification @ [Read-Write] 
---@field driving boolean @ [Read-Write] 
---@field crafting_queue object[] @ [Read-only] Gets the current crafting queue items.
---@field following_robots LuaEntity[] @ [Read-only] The current combat robots following the character
---@field cheat_mode boolean @ [Read-Write] 
---@field character_crafting_speed_modifier double @ [Read-Write] 
---@field character_mining_speed_modifier double @ [Read-Write] 
---@field character_additional_mining_categories string[] @ [Read-Write] 
---@field character_running_speed_modifier double @ [Read-Write] 
---@field character_build_distance_bonus uint @ [Read-Write] 
---@field character_item_drop_distance_bonus uint @ [Read-Write] 
---@field character_reach_distance_bonus uint @ [Read-Write] 
---@field character_resource_reach_distance_bonus uint @ [Read-Write] 
---@field character_item_pickup_distance_bonus uint @ [Read-Write] 
---@field character_loot_pickup_distance_bonus uint @ [Read-Write] 
---@field character_inventory_slots_bonus uint @ [Read-Write] 
---@field character_trash_slot_count_bonus uint @ [Read-Write] 
---@field character_maximum_following_robot_count_bonus uint @ [Read-Write] 
---@field character_health_bonus float @ [Read-Write] 
---@field character_logistic_slot_count uint @ [Read-Write] 
---@field character_personal_logistic_requests_enabled boolean @ [Read-Write] 
---@field auto_trash_filters table<string, uint> @ [Read-Write] 
---@field opened_gui_type defines.gui_type @ [Read-only] 
---@field build_distance uint @ [Read-only] The build distance of this character or max uint when not a character or player connected to a character.
---@field drop_item_distance uint @ [Read-only] The item drop distance of this character or max uint when not a character or player connected to a character.
---@field reach_distance uint @ [Read-only] The reach distance of this character or max uint when not a character or player connected to a character.
---@field item_pickup_distance double @ [Read-only] The item pickup distance of this character or max double when not a character or player connected to a character.
---@field loot_pickup_distance double @ [Read-only] The loot pickup distance of this character or max double when not a character or player connected to a character.
---@field resource_reach_distance double @ [Read-only] The resource reach distance of this character or max double when not a character or player connected to a character.
---@field in_combat boolean @ [Read-only] If this character entity is in combat.
---@field character_running_speed double @ [Read-only] Gets the current movement speed of this character, including effects from exoskeletons, tiles, stickers and shooting.
---@field character_mining_progress double @ [Read-only] Gets the current mining progress between 0 and 1 of this character, or 0 if they aren't mining.

---Get an inventory belonging to this entity. This can be either the "main" inventory or some auxiliary one, like the module slots or logistic trash slots.
---@param inventory defines.inventory @
---@return LuaInventory @
function LuaControl.get_inventory(inventory) end

---Gets the main inventory for this character or player if this is a character or player.
---@return LuaInventory @
function LuaControl.get_main_inventory() end

---Can at least some items be inserted?
---@param items ItemStackSpecification @Items that would be inserted
---@return boolean @
function LuaControl.can_insert(items) end

---Insert items into this entity. This works the same way as inserters or shift-clicking: the "best" inventory is chosen automatically.
---@param items ItemStackSpecification @Items to insert
---@return uint @
function LuaControl.insert(items) end

---Removes the arrow created by set_gui_arrow.
function LuaControl.clear_gui_arrow() end

---Get the number of all or some items in this entity.
---@param item string @Prototype name of the item to count. If not specified, count all items
---@return uint @
function LuaControl.get_item_count(item) end

---Does this entity have any item inside it?
---@return boolean @
function LuaControl.has_items_inside() end

---Can a given entity be opened or accessed?
---@param entity LuaEntity @
---@return boolean @
function LuaControl.can_reach_entity(entity) end

---Remove all items from this entity.
function LuaControl.clear_items_inside() end

---Remove items from this entity.
---@param items ItemStackSpecification @Items to remove
---@return uint @
function LuaControl.remove_item(items) end

---Teleport the entity to a given position, possibly on another surface.
---@param position Position @Where to teleport to
---@param surface SurfaceSpecification @Surface to teleport to. If not given, will teleport   to the entity's current surface. Only players and cars can be teleported cross-surface
---@return boolean @
function LuaControl.teleport(position, surface) end

---Select an entity, as if by hovering the mouse above it.
---@param position Position @Position of the entity to selec
function LuaControl.update_selected_entity(position) end

---Unselect any selected entity.
function LuaControl.clear_selected_entity() end

---Disable the flashlight.
function LuaControl.disable_flashlight() end

---Enable the flashlight.
function LuaControl.enable_flashlight() end

---Is the flashlight enabled.
function LuaControl.is_flashlight_enabled() end

---Gets the count of the given recipe that can be crafted.
---@param recipe string | LuaRecipe @The recipe
---@return uint @
function LuaControl.get_craftable_count(recipe) end

---Cancels crafting the given count of the given crafting queue index
---@param options uint @The crafting queue index.count :: uint:  The count to cancel crafting
function LuaControl.cancel_crafting(options) end

---Mines the given entity as if this player (or character) mined it.
---@param entity LuaEntity @The entity to min
---@param force boolean @Forces mining the entity even if the items can't fit in the player
---@return boolean @
function LuaControl.mine_entity(entity, force) end

---Mines the given tile as if this player (or character) mined it.
---@param tile LuaTile @The tile to mine
---@return boolean @
function LuaControl.mine_tile(tile) end

---
---@return boolean @
function LuaControl.is_player() end

---Open the technology GUI and select a given technology.
---@param technology TechnologySpecification @The technology to select after opening the GUI
function LuaControl.open_technology_gui(technology) end

---Sets the personal request and trash to the given values.
---@param slot_index uint @The slot to set
---@param value PersonalLogisticParameters @
---@return boolean @
function LuaControl.set_personal_logistic_slot(slot_index, value) end

---Sets the personal request and trash to the given values.
---@param slot_index uint @The slot to get
---@return PersonalLogisticParameters @
function LuaControl.get_personal_logistic_slot(slot_index) end

---
---@param slot_index uint @The slot to clear
function LuaControl.clear_personal_logistic_slot(slot_index) end

---@class LuaControlBehavior : LuaControlBehavior The control behavior for an entity. Inserters have logistic network and circuit network behavior logic, lamps have circuit logic and so on. This is an abstract base class that concrete control behaviors inherit.
---@field type defines.control_behavior.type @ [Read-only] 
---@field entity LuaEntity @ [Read-only] 

---
---@param wire defines.wire_type @Wire color of the network connected to this entity
---@param circuit_connector defines.circuit_connector_id @The connector to get circuit network for.   Must be specified for entities with more than one circuit network connector
---@return LuaCircuitNetwork @
function LuaControlBehavior.get_circuit_network(wire, circuit_connector) end

---@class LuaAccumulatorControlBehavior : LuaControlBehavior Control behavior for accumulators.
---@field output_signal SignalID @ [Read-Write] 

---@class LuaCombinatorControlBehavior 
---@field signals_last_tick Signal[] @ [Read-only] 

---Gets the value of a specific signal sent by this combinator behavior last tick or nil if the signal didn't exist.
---@param signal SignalID @The signal to ge
---@return int @
function LuaCombinatorControlBehavior.get_signal_last_tick(signal) end

---@class LuaConstantCombinatorControlBehavior : LuaControlBehavior Control behavior for constant combinators.
---@field parameters ConstantCombinatorParameters @ [Read-Write] 
---@field enabled boolean @ [Read-Write] Turns this constant combinator on and off.
---@field signals_count uint @ [Read-only] The number of signals this constant combinator supports

---Sets the signal at the given index
---@param index uint @
---@param signal Signal @
function LuaConstantCombinatorControlBehavior.set_signal(index, signal) end

---Gets the signal at the given index. Returned Signal will not contain signal if none is set for the index.
---@param index uint @
---@return Signal @
function LuaConstantCombinatorControlBehavior.get_signal(index) end

---@class LuaContainerControlBehavior : LuaControlBehavior Control behavior for container entities.

---@class LuaGenericOnOffControlBehavior : LuaControlBehavior An abstract base class for behaviors that support switching the entity on or off based on some condition.
---@field disabled boolean @ [Read-only] 
---@field circuit_condition CircuitConditionSpecification @ [Read-Write] 
---@field logistic_condition CircuitConditionSpecification @ [Read-Write] 
---@field connect_to_logistic_network boolean @ [Read-Write] 

---@class LuaLogisticContainerControlBehavior : LuaControlBehavior Control behavior for logistic chests.
---@field circuit_mode_of_operation defines.control_behavior.logistic_container.circuit_mode_of_operation @ [Read-Write] 

---@class LuaProgrammableSpeakerControlBehavior : LuaControlBehavior Control behavior for programmable speakers.
---@field circuit_parameters ProgrammableSpeakerCircuitParameters @ [Read-Write] 
---@field circuit_condition CircuitConditionSpecification @ [Read-Write] 

---@class LuaRailChainSignalControlBehavior : LuaControlBehavior Control behavior for rail chain signals.
---@field red_signal SignalID @ [Read-Write] 
---@field orange_signal SignalID @ [Read-Write] 
---@field green_signal SignalID @ [Read-Write] 
---@field blue_signal SignalID @ [Read-Write] 

---@class LuaRailSignalControlBehavior : LuaControlBehavior Control behavior for rail signals.
---@field red_signal SignalID @ [Read-Write] 
---@field orange_signal SignalID @ [Read-Write] 
---@field green_signal SignalID @ [Read-Write] 
---@field close_signal boolean @ [Read-Write] If this will close the rail signal based off the circuit condition.
---@field read_signal boolean @ [Read-Write] If this will read the rail signal state.
---@field circuit_condition CircuitConditionSpecification @ [Read-Write] The circuit condition when controlling the signal through the circuit network.

---@class LuaRoboportControlBehavior : LuaControlBehavior Control behavior for roboports.
---@field read_logistics boolean @ [Read-Write] 
---@field read_robot_stats boolean @ [Read-Write] 
---@field available_logistic_output_signal SignalID @ [Read-Write] 
---@field total_logistic_output_signal SignalID @ [Read-Write] 
---@field available_construction_output_signal SignalID @ [Read-Write] 
---@field total_construction_output_signal SignalID @ [Read-Write] 

---@class LuaStorageTankControlBehavior : LuaControlBehavior Control behavior for storage tanks.

---@class LuaWallControlBehavior : LuaControlBehavior Control behavior for walls.
---@field circuit_condition CircuitConditionSpecification @ [Read-Write] 
---@field open_gate boolean @ [Read-Write] 
---@field read_sensor boolean @ [Read-Write] 
---@field output_signal SignalID @ [Read-Write] 

---@class LuaArithmeticCombinatorControlBehavior : LuaControlBehavior Control behavior for arithmetic combinators.
---@field parameters ArithmeticCombinatorParameters @ [Read-Write] 

---@class LuaDeciderCombinatorControlBehavior : LuaCombinatorControlBehavior Control behavior for decider combinators.
---@field parameters DeciderCombinatorParameters @ [Read-Write] 

---@class LuaInserterControlBehavior : LuaControlBehavior Control behavior for inserters.
---@field circuit_read_hand_contents boolean @ [Read-Write] 
---@field circuit_mode_of_operation defines.control_behavior.inserter.circuit_mode_of_operation @ [Read-Write] 
---@field circuit_hand_read_mode defines.control_behavior.inserter.hand_read_mode @ [Read-Write] 
---@field circuit_set_stack_size boolean @ [Read-Write] If the stack size of the inserter is set through the circuit network or not.
---@field circuit_stack_control_signal SignalID @ [Read-Write] The signal used to set the stack size of the inserter.

---@class LuaLampControlBehavior : LuaControlBehavior Control behavior for lamps.
---@field use_colors boolean @ [Read-Write] 
---@field color Color @ [Read-only] The color the lamp is showing or nil if not using any color.

---@class LuaMiningDrillControlBehavior : LuaControlBehavior Control behavior for mining drills.
---@field circuit_enable_disable boolean @ [Read-Write] 
---@field circuit_read_resources boolean @ [Read-Write] 
---@field resource_read_mode defines.control_behavior.mining_drill.resource_read_mode @ [Read-Write] 
---@field resource_read_targets LuaEntity[] @ [Read-only] 

---@class LuaTrainStopControlBehavior : LuaControlBehavior Control behavior for train stops.
---@field send_to_train boolean @ [Read-Write] 
---@field read_from_train boolean @ [Read-Write] 
---@field read_stopped_train boolean @ [Read-Write] 
---@field enable_disable boolean @ [Read-Write] 
---@field stopped_train_signal SignalID @ [Read-Write] The signal that will be sent when using the send-train-id option.

---@class LuaTransportBeltControlBehavior : LuaControlBehavior Control behavior for transport belts.
---@field enable_disable boolean @ [Read-Write] If the belt will be enabled/disabled based off the circuit network.
---@field read_contents boolean @ [Read-Write] If the belt will read the contents and send them to the circuit network.
---@field read_contents_mode defines.control_behavior.transport_belt.content_read_mode @ [Read-Write] 

---@class LuaCustomChartTag Destroys this tag.
---@field icon SignalID @ [Read-Write] 
---@field last_user LuaPlayer @ [Read-Write] The player who last edited this tag.
---@field position Position @ [Read-only] The position of this tag.
---@field text string @ [Read-Write] 
---@field tag_number uint @ [Read-only] The unique ID for this tag on this force.
---@field force LuaForce @ [Read-only] The force this tag belongs to.
---@field surface LuaSurface @ [Read-only] The surface this tag belongs to.

---Destroys this tag.
function LuaCustomChartTag.destroy() end

---@class LuaCustomInputPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field key_sequence string @ [Read-only] The default key sequence for this custom input.
---@field alternative_key_sequence string @ [Read-only] The default alternative key sequence for this custom input. nil when not defined.
---@field linked_game_control string @ [Read-only] The linked game control name or nil.
---@field consuming string @ [Read-only] The consuming type: "none" or "game-only".
---@field enabled boolean @ [Read-only] If this custom input is enabled. Disabled custom inputs exist but are not used by the game.

---@class LuaCustomTable Access an element of this custom table.
---@field bracket_operator nil @ [Read-Write] Access an element of this custom table.
---@field hash_operator uint @ [Read-only] 

---@class LuaDamagePrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field hidden boolean @ [Read-only] Whether this damage type is hidden from entity tooltips.

---@class LuaDecorativePrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field collision_box BoundingBox @ [Read-only] 
---@field collision_mask CollisionMask @ [Read-only] 
---@field collision_mask_with_flags CollisionMaskWithFlags @ [Read-only] 
---@field autoplace_specification AutoplaceSpecification @ [Read-only] Autoplace specification for this decorative prototype. nil if none.

---@class LuaElectricEnergySourcePrototype 
---@field buffer_capacity double @ [Read-only] 
---@field usage_priority string @ [Read-only] 
---@field input_flow_limit double @ [Read-only] 
---@field output_flow_limit double @ [Read-only] 
---@field drain double @ [Read-only] 
---@field emissions double @ [Read-only] 
---@field render_no_network_icon boolean @ [Read-only] 
---@field render_no_power_icon boolean @ [Read-only] 

---@class LuaEntity : LuaControl Gets the entities output inventory if it has one.
---@field order_upgrade boolean @(optional) undefined Sets the entity to be upgraded by construction robots.
---@field get_connected_rail LuaEntity @ undefined 
---@field clone LuaEntity @(optional) undefined Clones this entity.
---@field remove_fluid double @(optional) undefined Remove fluid from this entity.
---@field name string @ [Read-only] Name of the entity prototype. E.g. "inserter" or "filter-inserter".
---@field ghost_name string @ [Read-only] Name of the entity or tile contained in this ghost
---@field localised_name LocalisedString @ [Read-only] Localised name of the entity.
---@field localised_description LocalisedString @ [Read-only] 
---@field ghost_localised_name LocalisedString @ [Read-only] Localised name of the entity or tile contained in this ghost.
---@field ghost_localised_description LocalisedString @ [Read-only] 
---@field type string @ [Read-only] 
---@field ghost_type string @ [Read-only] 
---@field active boolean @ [Read-Write] Deactivating an entity will stop all its operations (car will stop moving, inserters will stop working, fish will stop moving etc).
---@field destructible boolean @ [Read-Write] When the entity is not destructible it can't be damaged.
---@field minable boolean @ [Read-Write] 
---@field rotatable boolean @ [Read-Write] When entity is not to be rotatable (inserter, transport belt etc), it can't be rotated by player using the R key.
---@field operable boolean @ [Read-Write] Player can't open gui of this entity and he can't quick insert/input stuff in to the entity when it is not operable.
---@field health float @ [Read-Write] 
---@field direction defines.direction @ [Read-Write] The current direction this entity is facing.
---@field supports_direction boolean @ [Read-only] Whether the entity has direction. When it is false for this entity, it will always return north direction when asked for.
---@field orientation float @ [Read-Write] The smooth orientation.
---@field cliff_orientation string @ [Read-only] The orientation of this cliff.
---@field amount uint @ [Read-Write] 
---@field initial_amount uint @ [Read-Write] 
---@field effectivity_modifier float @ [Read-Write] Multiplies the acceleration the vehicle can create for one unit of energy. By default is 1.
---@field consumption_modifier float @ [Read-Write] Multiplies the energy consumption.
---@field friction_modifier float @ [Read-Write] Multiplies the car friction rate.
---@field driver_is_gunner boolean @ [Read-Write] Whether the driver of this car is the gunner, if false, the passenger is the gunner.
---@field speed float @ [Read-Write] The current speed of the car or rolling stock or projectile, or current max speed of the unit. Only the speed of units, cars, and projectiles are writable.
---@field effective_speed float @ [Read-only] The current speed of a unit, taking into account any walking speed modifier given by the tile the unit is standing on.
---@field stack LuaItemStack @ [Read-only] 
---@field prototype LuaEntityPrototype @ [Read-only] 
---@field ghost_prototype LuaEntityPrototype | LuaTilePrototype @ [Read-only] 
---@field drop_position Position @ [Read-Write] Position where the entity puts its stuff.
---@field pickup_position Position @ [Read-Write] Where the inserter will pick up items from.
---@field drop_target LuaEntity @ [Read-Write] The entity this entity is putting its stuff to or nil if there is no such entity.
---@field pickup_target LuaEntity @ [Read-Write] The entity the inserter will attempt to pick up from. For example, this can be a transport belt or a storage chest.
---@field selected_gun_index uint @ [Read-Write] Index of the currently selected weapon slot of this character or car, or nil if the car doesn't have guns.
---@field energy double @ [Read-Write] Energy stored in the entity (heat in furnace, energy stored in electrical devices etc.). always 0 for entities that don't have the concept of energy stored inside.
---@field temperature double @ [Read-Write] The temperature of this entities heat energy source if this entity uses a heat energy source or nil.
---@field previous_recipe LuaRecipe @ [Read-only] The previous recipe this furnace was using or nil if the furnace had no previous recipe.
---@field held_stack LuaItemStack @ [Read-only] The item stack currently held in an inserter's hand.
---@field held_stack_position Position @ [Read-only] Current position of the inserter's "hand".
---@field train LuaTrain @ [Read-only] The train this rolling stock belongs to or nil if not rolling stock.
---@field neighbours table<string, LuaEntity> | string | LuaEntity[] | LuaEntity | LuaEntity[] | LuaEntity[] | LuaEntity | LuaEntity @ [Read-only] 
---@field belt_neighbours table<string, LuaEntity> @ [Read-only] The belt connectable neighbours of this belt connectable entity. Only entities that input to or are outputs of this entity. Does not contain the other end of an underground belt, see LuaEntity::neighbours for that. This is a dictionary with "inputs", "outputs" entries that are arrays of transport belt connectable entities, or empty tables if no entities.
---@field fluidbox LuaFluidBox @ [Read-Write] Fluidboxes of this entity.
---@field backer_name string @ [Read-Write] The name of a backer (of Factorio) assigned to a lab or train station / stop.
---@field time_to_live uint @ [Read-Write] The ticks left before a ghost, combat robot or highlight box is destroyed.
---@field color Color @ [Read-Write] The character, rolling stock, train stop, car, flying text, corpse or simple-entity-with-owner color. Returns nil if this entity doesn't use custom colors.
---@field text LocalisedString @ [Read-Write] The text of this flying-text entity.
---@field signal_state defines.signal_state @ [Read-only] The state of this rail signal.
---@field chain_signal_state defines.chain_signal_state @ [Read-only] The state of this chain signal.
---@field to_be_looted boolean @ [Read-Write] Will this entity be picked up automatically when the player walks over it?
---@field crafting_speed double @ [Read-only] The current crafting speed, including speed bonuses from modules and beacons.
---@field crafting_progress float @ [Read-Write] The current crafting progress, as a number in range [0, 1].
---@field bonus_progress double @ [Read-Write] The current productivity bonus progress, as a number in range [0, 1].
---@field productivity_bonus double @ [Read-only] The productivity bonus of this entity.
---@field pollution_bonus double @ [Read-only] The pollution bonus of this entity.
---@field speed_bonus double @ [Read-only] The speed bonus of this entity.
---@field consumption_bonus double @ [Read-only] The consumption bonus of this entity.
---@field belt_to_ground_type string @ [Read-only] "input" or "output", depending on whether this underground belt goes down or up.
---@field loader_type string @ [Read-Write] "input" or "output", depending on whether this loader puts to or gets from a container.
---@field rocket_parts uint @ [Read-Write] Number of rocket parts in the silo.
---@field logistic_network LuaLogisticNetwork @ [Read-Write] The logistic network this entity is a part of.
---@field logistic_cell LuaLogisticCell @ [Read-only] The logistic cell this entity is a part of. Will be nil if this entity is not a part of any logistic cell.
---@field item_requests table<string, uint> @ [Read-Write] 
---@field player LuaPlayer @ [Read-only] The player connected to this character or nil if none.
---@field unit_group LuaUnitGroup @ [Read-only] The unit group this unit is a member of, or nil if none.
---@field damage_dealt double @ [Read-Write] The damage dealt by this turret, artillery turret, or artillery wagon.
---@field kills uint @ [Read-Write] The number of units killed by this turret, artillery turret, or artillery wagon.
---@field last_user LuaPlayer @ [Read-Write] The player who built the entity
---@field electric_buffer_size double @ [Read-Write] The buffer size for the electric energy source or nil if the entity doesn't have an electric energy source.
---@field electric_input_flow_limit double @ [Read-only] The input flow limit for the electric energy source or nil if the entity doesn't have an electric energy source.
---@field electric_output_flow_limit double @ [Read-only] The output flow limit for the electric energy source or nil if the entity doesn't have an electric energy source.
---@field electric_drain double @ [Read-only] The electric drain for the electric energy source or nil if the entity doesn't have an electric energy source.
---@field electric_emissions double @ [Read-only] The emissions for the electric energy source or nil if the entity doesn't have an electric energy source.
---@field unit_number uint @ [Read-only] 
---@field ghost_unit_number uint @ [Read-only] The unit number of the entity contained in this ghost or nil if the entity doesn't have one.
---@field mining_progress double @ [Read-Write] The mining progress for this mining drill or nil if this isn't a mining drill.  Is a number in range [0, mining_target.prototype.mineable_properties.mining_time]
---@field bonus_mining_progress double @ [Read-Write] The bonus mining progress for this mining drill or nil if this isn't a mining drill.  Read yields a number in range [0, mining_target.prototype.mineable_properties.mining_time]
---@field power_production double @ [Read-Write] The power production specific to the ElectricEnergyInterface entity type.
---@field power_usage double @ [Read-Write] The power usage specific to the ElectricEnergyInterface entity type.
---@field bounding_box BoundingBox @ [Read-only] LuaEntityPrototype::collision_box around entity's given position and respecting the current entity orientation.
---@field secondary_bounding_box BoundingBox @ [Read-only] The secondary bounding box of this entity or nil if it doesn't have one.
---@field selection_box BoundingBox @ [Read-only] LuaEntityPrototype::selection_box around entity's given position and respecting the current entity orientation.
---@field secondary_selection_box BoundingBox @ [Read-only] The secondary selection box of this entity or nil if it doesn't have one.
---@field mining_target LuaEntity @ [Read-only] 
---@field circuit_connected_entities table @ [Read-only] Entities connected to this entity via the circuit network.
---@field circuit_connection_definitions object[] @ [Read-only] The connection definition for entities connected to this entity via the circuit network.
---@field request_slot_count uint @ [Read-only] The number of request slots this entity has.
---@field filter_slot_count uint @ [Read-only] The number of filter slots this inserter or loader has. 0 if not an inserter or loader.
---@field loader_container LuaEntity @ [Read-only] The container entity this loader is pointing at/pulling from depending on the LuaEntity::loader_type.
---@field grid LuaEquipmentGrid @ [Read-only] The equipment grid or nil if this entity doesn't have an equipment grid.
---@field graphics_variation uint8 @ [Read-Write] The graphics variation for this entity or nil if this entity doesn't use graphics variations.
---@field tree_color_index uint8 @ [Read-Write] Index of the tree color.
---@field tree_color_index_max uint8 @ [Read-only] Maximum index of the tree colors.
---@field tree_stage_index uint8 @ [Read-Write] Index of the tree stage.
---@field tree_stage_index_max uint8 @ [Read-only] Maximum index of the tree stages.
---@field burner LuaBurner @ [Read-only] The burner energy source for this entity or nil if there isn't one.
---@field shooting_target LuaEntity @ [Read-Write] The shooting target for this turret or nil.
---@field proxy_target LuaEntity @ [Read-only] The target entity for this item-request-proxy or nil
---@field stickers LuaEntity[] @ [Read-only] The sticker entities attached to this entity.
---@field sticked_to LuaEntity @ [Read-only] The entity this sticker is sticked to.
---@field parameters ProgrammableSpeakerParameters @ [Read-Write] 
---@field alert_parameters ProgrammableSpeakerAlertParameters @ [Read-Write] 
---@field electric_network_statistics LuaFlowStatistics @ [Read-only] 
---@field inserter_stack_size_override uint @ [Read-Write] Sets the stack size limit on this inserter. If the stack size is > than the force stack size limit the value is ignored.
---@field products_finished uint @ [Read-Write] The number of products this machine finished crafting in its lifetime.
---@field spawner LuaEntity @ [Read-only] The spawner associated with this unit entity or nil if the unit has no associated spawner.
---@field units LuaEntity[] @ [Read-only] The units associated with this spawner entity.
---@field power_switch_state boolean @ [Read-Write] The state of this power switch.
---@field relative_turret_orientation float @ [Read-Write] The relative orientation of the vehicle turret or nil if this entity isn't a vehicle or have a vehicle turret.
---@field effects Effects @ [Read-only] The effects being applied to this entity or nil. For beacons this is the effect the beacon is broadcasting.
---@field infinity_container_filters InfinityInventoryFilter[] @ [Read-Write] The filters for this infinity container.
---@field remove_unfiltered_items boolean @ [Read-Write] If items not included in this infinity container filters should be removed from the container.
---@field character_corpse_player_index uint @ [Read-Write] The player index associated with this character corpse.
---@field character_corpse_tick_of_death uint @ [Read-Write] The tick this character corpse died at.
---@field character_corpse_death_cause LocalisedString @ [Read-Write] The reason this character corpse character died (if any).
---@field associated_player LuaPlayer @ [Read-Write] The player this character is associated with or nil if none. When the player logs off in multiplayer all of the associated characters will be logged off with him.
---@field tick_of_last_attack uint @ [Read-Write] The last tick this character entity was attacked.
---@field tick_of_last_damage uint @ [Read-Write] The last tick this character entity was damaged.
---@field splitter_filter LuaItemPrototype @ [Read-Write] The filter for this splitter or nil if no filter is set.
---@field inserter_filter_mode string @ [Read-Write] The filter mode for this filter inserter: "whitelist", "blacklist", or nil if this inserter doesn't use filters.
---@field splitter_input_priority string @ [Read-Write] The input priority for this splitter : "left", "none", or "right".
---@field splitter_output_priority string @ [Read-Write] The output priority for this splitter : "left", "none", or "right".
---@field armed boolean @ [Read-only] If this land mine is armed.
---@field recipe_locked boolean @ [Read-Write] When locked; the recipe in this assembling machine can't be changed by the player.
---@field connected_rail LuaEntity @ [Read-only] The rail entity this train stop is connected to or nil if there is none.
---@field trains_in_block uint @ [Read-only] The number of trains in this rail block for this rail entity.
---@field timeout uint @ [Read-Write] The timeout left on this landmine in ticks.
---@field neighbour_bonus double @ [Read-only] The current total neighbour bonus of this reactor.
---@field ai_settings LuaAISettings @ [Read-only] The ai settings of this unit.
---@field highlight_box_type string @ [Read-Write] The hightlight box type of this highlight box entity.
---@field highlight_box_blink_interval uint @ [Read-Write] The blink interval of this highlight box entity. 0 indicates no blink.
---@field status defines.entity_status @ [Read-only] The status of this entity or nil if no status.
---@field enable_logistics_while_moving boolean @ [Read-Write] If equipment grid logistics are enabled while this vehicle is moving.
---@field render_player LuaPlayer @ [Read-Write] The player that this simple-entity-with-owner, simple-entity-with-force, flying-text or highlight-box is visible to or nil. Set to nil to clear.
---@field render_to_forces ForceSpecification[] @ [Read-Write] The forces that this simple-entity-with-owner, simple-entity-with-force or flying-text is visible to or nil. Set to nil to clear.
---@field pump_rail_target LuaEntity @ [Read-only] The rail target of this pump or nil.
---@field moving LuaEntity @ [Read-only] Returns true if this unit is moving.
---@field electric_network_id uint @ [Read-only] Returns the id of the electric network that this entity is connected to or nil.
---@field allow_dispatching_robots boolean @ [Read-Write] Whether this character's personal roboports are allowed to dispatch robots.
---@field auto_launch boolean @ [Read-Write] Whether this rocket silo automatically launches the rocket when cargo is inserted.
---@field energy_generated_last_tick double @ [Read-only] How much energy this generator generated in the last tick.
---@field storage_filter LuaItemPrototype @ [Read-Write] The storage filter for this logistic storage container.
---@field request_from_buffers boolean @ [Read-Write] Whether this requester chest is set to also request from buffer chests.
---@field corpse_expires boolean @ [Read-Write] Whether this corpse will ever fade away.
---@field corpse_immune_to_entity_placement boolean @ [Read-Write] If true, corpse won't be destroyed when entities are placed over it. If false, whether corpse will be removed or not depends on value of CorpsePrototype::remove_on_entity_placement.
---@field tags Tags @ [Read-Write] The tags associated with this entity ghost or nil if not an entity ghost.
---@field command Command @ [Read-only] The command given to this unit or nil is the unit has no command.
---@field distraction_command Command @ [Read-only] The distraction command given to this unit or nil is the unit currently isn't distracted.

---Gets the entities output inventory if it has one.
---@return LuaInventory @
function LuaEntity.get_output_inventory() end

---
---@return LuaInventory @
function LuaEntity.get_module_inventory() end

---The fuel inventory for this entity or nil if this entity doesn't have a fuel inventory.
---@return LuaInventory @
function LuaEntity.get_fuel_inventory() end

---The burnt result inventory for this entity or nil if this entity doesn't have a burnt result inventory.
---@return LuaInventory @
function LuaEntity.get_burnt_result_inventory() end

---Damages the entity.
---@param damage float @The amount of damage to be don
---@param force ForceSpecification @The force that will be doing the damage
---@param type string @The type of damage to be done, defaults to "impact"
---@param dealer LuaEntity @The entity to consider as the damage dealer
---@return float @
function LuaEntity.damage(damage, force, type, dealer) end

---Checks if the entity can be destroyed
---@return boolean @
function LuaEntity.can_be_destroyed() end

---Destroys the entity.
---@param opts boolean @Table with the following fields: do_cliff_correction :: boolean  (optional):  If neighbouring cliffs should be corrected. Defaults to false.raise_destroy :: boolean  (optional):  If true; defines.events.script_raised_destroy will be called
---@return boolean @
function LuaEntity.destroy(opts) end

---Give the entity a command.
---@param command Command @
function LuaEntity.set_command(command) end

---Has this unit been assigned a command?
---@return boolean @
function LuaEntity.has_command() end

---Immediately kills the entity. Doesn't care whether the entity is destroyable or damageable. Does nothing if the entity doesn't have health. Unlike LuaEntity::destroy, die will trigger on_entity_died and the entity will drop loot and corpse if it have any.
---@param force ForceSpecification @The force to attribute the kill to
---@param cause LuaEntity @The cause to attribute the kill to
---@return boolean @
function LuaEntity.die(force, cause) end

---Test whether this entity's prototype has a flag set.
---@param flag string @The flag to tes
---@return boolean @
function LuaEntity.has_flag(flag) end

---Same as LuaEntity::has_flag but targets the inner entity on a entity ghost.
---@param flag string @The flag to tes
---@return boolean @
function LuaEntity.ghost_has_flag(flag) end

---Offer a thing on the market.
---@param offer Offer @
function LuaEntity.add_market_item(offer) end

---Remove an offer from a market.
---@param offer uint @Index of offer to remove
---@return boolean @
function LuaEntity.remove_market_item(offer) end

---Get all offers in a market as an array.
---@return array of Offer @
function LuaEntity.get_market_items() end

---Removes all offers from a market.
function LuaEntity.clear_market_items() end

---Connect two devices with wire or cable.
---@param target LuaEntity | table @Wire color, either defines.wire_type.red or           defines.wire_type.green.target_entity :: LuaEntity:  The entity to connect the wire tosource_circuit_id :: uint  (optional):  Mandatory if the source entity has more than one           circuit connector.target_circuit_id :: uint  (optional):  Mandatory if the target entity has more than one           circuit connector
---@return boolean @
function LuaEntity.connect_neighbour(target) end

---Disconnect wires or cables.
---@param target defines.wire_type | LuaEntity | table @Wire colortarget_entity :: LuaEntitysource_circuit_id :: uint  (optional)target_circuit_id :: uint  (optional
function LuaEntity.disconnect_neighbour(target) end

---Sets the entity to be deconstructed by construction robots.
---@param force ForceSpecification @The force whose robots are supposed to do the deconstruction
---@param player PlayerSpecification @The player to set the last_user to if any
---@return boolean @
function LuaEntity.order_deconstruction(force, player) end

---Cancels deconstruction if it is scheduled, does nothing otherwise.
---@param force ForceSpecification @The force who did the deconstruction order
---@param player PlayerSpecification @The player to set the last_user to if any
function LuaEntity.cancel_deconstruction(force, player) end

---Is this entity marked for deconstruction?
---@return boolean @
function LuaEntity.to_be_deconstructed() end

---Cancels upgrade if it is scheduled, does nothing otherwise.
---@param force ForceSpecification @The force who did the upgrade order
---@param player PlayerSpecification @The player to set the last_user to if any
---@return boolean @
function LuaEntity.cancel_upgrade(force, player) end

---Is this entity marked for upgrade?
---@return boolean @
function LuaEntity.to_be_upgraded() end

---Get a logistic requester slot.
---@param slot uint @The slot index
---@return SimpleItemStack @
function LuaEntity.get_request_slot(slot) end

---Set a logistic requester slot.
---@param request ItemStackSpecification @What to request
---@param slot uint @The slot index
function LuaEntity.set_request_slot(request, slot) end

---Clear a logistic requester slot.
---@param slot uint @The slot index
function LuaEntity.clear_request_slot(slot) end

---
---@return boolean @
function LuaEntity.is_crafting() end

---
---@return boolean @
function LuaEntity.is_opened() end

---
---@return boolean @
function LuaEntity.is_opening() end

---
---@return boolean @
function LuaEntity.is_closed() end

---
---@return boolean @
function LuaEntity.is_closing() end

---
---@param force ForceSpecification @The force that requests the gate to be open
---@param extra_time uint @Extra ticks to stay open
function LuaEntity.request_to_open(force, extra_time) end

---
---@param force ForceSpecification @The force that requests the gate to be closed
function LuaEntity.request_to_close(force) end

---Get a transport line of a belt or belt connectable entity.
---@param index uint @Index of the requested transport line
---@return LuaTransportLine @
function LuaEntity.get_transport_line(index) end

---Get the maximum transport line index of a belt or belt connectable entity.
---@return uint @
function LuaEntity.get_max_transport_line_index() end

---
---@return boolean @
function LuaEntity.launch_rocket() end

---Revive a ghost. I.e. turn it from a ghost to a real entity or tile.
---@param opts boolean @Table with the following fields: return_item_request_proxy :: boolean  (optional):  If true the function will return item request proxy as the third parameter.raise_revive :: boolean  (optional):  If true, and an entity ghost; script_raised_revive will be called. Else if true, and a tile ghost; script_raised_set_tiles will be called
---@return dictionary string → uint @
function LuaEntity.revive(opts) end

---Revives a ghost silently.
---@param opts boolean @Table with the following fields: return_item_request_proxy :: boolean  (optional):  If true the function will return item request proxy as the third parameter.raise_revive :: boolean  (optional):  If true, and an entity ghost; script_raised_revive will be called. Else if true, and a tile ghost; script_raised_set_tiles will be called
---@return dictionary string → uint @
function LuaEntity.silent_revive(opts) end

---Get the rails that this signal is connected to.
---@return array of LuaEntity @
function LuaEntity.get_connected_rails() end

---Get the rail signal or train stop at the start/end of the rail segment this rail is in, or nil if the rail segment doesn't start/end with a signal nor a train stop.
---@param direction defines.rail_direction @The direction of travel relative to this rail
---@param in_else_out boolean @If true, gets the entity at the entrance of the rail segment, otherwise gets the entity at the exit of the rail segment
---@return LuaEntity @
function LuaEntity.get_rail_segment_entity(direction, in_else_out) end

---Get the rail at the end of the rail segment this rail is in.
---@param direction defines.rail_direction @
---@return LuaEntity @
function LuaEntity.get_rail_segment_end(direction) end

---Get the length of the rail segment this rail is in.
---@return double @
function LuaEntity.get_rail_segment_length() end

---Get a rail from each rail segment that overlaps with this rail's rail segment.
---@return array of LuaEntity @
function LuaEntity.get_rail_segment_overlaps() end

---Get the filter for a slot in an inserter or a loader.
---@param uint uint @Slot to get the filter of
---@return string @
function LuaEntity.get_filter(uint) end

---Set the filter for a slot in an inserter or a loader
---@param uint uint @Slot to set the filter of
---@param string string @Prototype name of the item to filter
function LuaEntity.set_filter(uint, string) end

---Gets the filter for this infinity container at the given index or nil if the filter index doesn't exist or is empty.
---@param index uint @The index to get
---@return InfinityInventoryFilter @
function LuaEntity.get_infinity_container_filter(index) end

---Sets the filter for this infinity container at the given index.
---@param index uint @The index to set
---@param filter InfinityInventoryFilter @The new filter or nil to clear the filter
function LuaEntity.set_infinity_container_filter(index, filter) end

---Gets the filter for this infinity pipe or nil if the filter is empty.
---@return InfinityPipeFilter @
function LuaEntity.get_infinity_pipe_filter() end

---Sets the filter for this infinity pipe.
---@param filter InfinityPipeFilter @The new filter or nil to clear the filter
function LuaEntity.set_infinity_pipe_filter(filter) end

---Gets the heat setting for this heat interface.
---@return HeatSetting @
function LuaEntity.get_heat_setting() end

---Sets the heat setting for this heat interface.
---@param filter HeatSetting @The new setting
function LuaEntity.set_heat_setting(filter) end

---Gets the control behavior of the entity (if any).
---@return LuaControlBehavior @
function LuaEntity.get_control_behavior() end

---Gets (and or creates if needed) the control behavior of the entity.
---@return LuaControlBehavior @
function LuaEntity.get_or_create_control_behavior() end

---
---@param wire defines.wire_type @Wire color of the network connected to this entity
---@param circuit_connector defines.circuit_connector_id @The connector to get circuit network for.   Must be specified for entities with more than one circuit network connector
---@return LuaCircuitNetwork @
function LuaEntity.get_circuit_network(wire, circuit_connector) end

---Read a single signal from the combined circuit networks.
---@param signal SignalID @The signal to read
---@param circuit_connector defines.circuit_connector_id @The connector to get signals for.   Must be specified for entities with more than one circuit network connector
---@return int @
function LuaEntity.get_merged_signal(signal, circuit_connector) end

---The merged circuit network signals or nil if there are no signals.
---@param circuit_connector defines.circuit_connector_id @The connector to get signals for.   Must be specified for entities with more than one circuit network connector
---@return array of Signal @
function LuaEntity.get_merged_signals(circuit_connector) end

---
---@return boolean @
function LuaEntity.supports_backer_name() end

---Copies settings from the given entity onto this entity.
---@param entity LuaEntity @
---@param by_player LuaPlayer @If provided, the copying is done 'as' this player and on_entity_settings_pasted is triggered
---@return dictionary string → uint @
function LuaEntity.copy_settings(entity, by_player) end

---Gets the LuaLogisticPoint specified by the given index or if not given returns all of the points this entity owns.
---@param defines__ogistic_member_index defines__ogistic_member_index @
---@return LuaLogisticPoint or array of LuaLogisticPoint @
function LuaEntity.get_logistic_point(defines__ogistic_member_index) end

---Plays a note with the given instrument and note.
---@param instrument uint @
---@param note uint @
---@return boolean @
function LuaEntity.play_note(instrument, note) end

---Connects the rolling stock in the given direction.
---@param direction defines.rail_direction @
---@return boolean @
function LuaEntity.connect_rolling_stock(direction) end

---Tries to disconnect this rolling stock in the given direction.
---@param direction defines.rail_direction @
---@return boolean @
function LuaEntity.disconnect_rolling_stock(direction) end

---Reconnect loader, beacon, cliff and mining drill connections to entities that might have been teleported out or in by the script. The game doesn't do this automatically as we don't want to loose performance by checking this in normal games.
function LuaEntity.update_connections() end

---Current recipe being assembled by this machine or nil if no recipe is set.
---@return LuaRecipe @
function LuaEntity.get_recipe() end

---Sets the current recipe in this assembly machine.
---@param recipe string | LuaRecipe @The new recipe or nil to clear the recipe
---@return dictionary string → uint @
function LuaEntity.set_recipe(recipe) end

---Rotates this entity as if the player rotated it
---@param options boolean @Table with the following fields: reverse :: boolean  (optional)by_player :: LuaPlayer  (optional)spill_items :: boolean  (optional):  If the player is not given should extra items be spilled or returned as a second return value from this.enable_looted :: boolean  (optional):  When true, each spilled item will be flagged with the LuaEntity::to_be_looted flag.force :: LuaForce or string  (optional):  When provided the spilled items will be marked for deconstruction by this force
---@return boolean @
function LuaEntity.rotate(options) end

---Gets the driver of this vehicle if any.
---@return LuaEntity or LuaPlayer @
function LuaEntity.get_driver() end

---Sets the driver of this vehicle.
---@param driver LuaEntity | LuaPlayer @The new driver or nil to eject the current driver if any
function LuaEntity.set_driver(driver) end

---Gets the passenger of this car if any.
---@return LuaEntity or LuaPlayer @
function LuaEntity.get_passenger() end

---Sets the passenger of this car.
---@param passenger LuaEntity | LuaPlayer @
function LuaEntity.set_passenger(passenger) end

---Returns true if this entity is connected to an electric network.
---@return boolean @
function LuaEntity.is_connected_to_electric_network() end

---The trains scheduled to stop at this train stop.
---@return array of LuaTrain @
function LuaEntity.get_train_stop_trains() end

---The train currently stopped at this train stop or nil if none.
---@return LuaTrain @
function LuaEntity.get_stopped_train() end

---Get the amount of all or some fluid in this entity.
---@param fluid string @Prototype name of the fluid to count. If not specified, count all fluids
---@return double @
function LuaEntity.get_fluid_count(fluid) end

---Get amounts of all fluids in this entity.
---@return dictionary string → double @
function LuaEntity.get_fluid_contents() end

---Insert fluid into this entity. Fluidbox is chosen automatically.
---@param fluid Fluid @Fluid to insert
---@return double @
function LuaEntity.insert_fluid(fluid) end

---Remove all fluids from this entity.
function LuaEntity.clear_fluid_inside() end

---Get the source of this beam.
---@return BeamTarget @
function LuaEntity.get_beam_source() end

---Set the source of this beam.
---@param source LuaEntity | Position @
function LuaEntity.set_beam_source(source) end

---Get the target of this beam.
---@return BeamTarget @
function LuaEntity.get_beam_target() end

---Set the target of this beam.
---@param target LuaEntity | Position @
function LuaEntity.set_beam_target(target) end

---The radius of this entity.
---@return double @
function LuaEntity.get_radius() end

---The health ratio of this entity between 1 and 0 (for full health and no health respectively).
---@return float @
function LuaEntity.get_health_ratio() end

---Creates the same smoke that is created when you place a building by hand. You can play the building sound to go with it by using LuaSurface::play_sound, eg: entity.surface.play_sound{path="entity-build/"..entity.prototype.name, position=entity.position}
function LuaEntity.create_build_effect_smoke() end

---Release the unit from the spawner which spawned it. This allows the spawner to continue spawning additional units.
function LuaEntity.release_from_spawner() end

---Toggle this entity's equipment movement bonus. Does nothing if the entity does not have an equipment grid.
function LuaEntity.toggle_equipment_movement_bonus() end

---If this character can shoot the given entity or position.
---@param target LuaEntity @
---@param position Position @
---@return boolean @
function LuaEntity.can_shoot(target, position) end

---Only works if the entity is a speech-bubble, with an "effect" defined in its wrapper_flow_style. Starts animating the opacity of the speech bubble towards zero, and destroys the entity when it hits zero.
function LuaEntity.start_fading_out() end

---Returns the new entity prototype. The more entities on the force that are marked for upgrade, the longer this method takes to run.
---@return LuaEntityPrototype @
function LuaEntity.get_upgrade_target() end

---Returns the amount of damage to be taken by this entity.
---@return float @
function LuaEntity.get_damage_to_be_taken() end

---Depletes and destroys this resource entity.
function LuaEntity.deplete() end

---Mines this entity.
---@param options LuaInventory @Table with the following fields: inventory :: LuaInventory  (optional):  If provided the item(s) will be transferred into this inventory. If provided, this must be an inventory created with LuaGameScript::create_inventory or be a basic inventory owned by some entity.force :: boolean  (optional):  If true, when the item(s) don't fit into the given inventory the entity is force mined.                                     If false, the mining operation fails when there isn't enough room to transfer all of the items into the inventory.                                     Defaults to false. This is ignored and acts as 'true' if no inventory is provided.raise_destroyed :: boolean  (optional):  If true, script_raised_destroy will be raised. Defaults to true.ignore_minable :: boolean  (optional):  If true, the minable state of the entity is ignored. Defaults to false. If false, an entity that isn't minable (set as not-minable in the prototype or isn't minable for other reasons) will fail to be mined
---@return boolean @
function LuaEntity.mine(options) end

---@class LuaEntityPrototype Does this prototype have a flag enabled?
---@field type string @ [Read-only] 
---@field name string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field max_health float @ [Read-only] 
---@field infinite_resource boolean @ [Read-only] 
---@field minimum_resource_amount uint @ [Read-only] 
---@field normal_resource_amount uint @ [Read-only] 
---@field infinite_depletion_resource_amount uint @ [Read-only] 
---@field resource_category string @ [Read-only] 
---@field mineable_properties table @(optional) [Read-only] 
---@field items_to_place_this SimpleItemStack[] @ [Read-only] 
---@field collision_box BoundingBox @ [Read-only] 
---@field secondary_collision_box BoundingBox @ [Read-only] 
---@field map_generator_bounding_box BoundingBox @ [Read-only] 
---@field selection_box BoundingBox @ [Read-only] 
---@field drawing_box BoundingBox @ [Read-only] 
---@field sticker_box BoundingBox @ [Read-only] 
---@field collision_mask CollisionMask @ [Read-only] 
---@field collision_mask_with_flags CollisionMaskWithFlags @ [Read-only] 
---@field order string @ [Read-only] 
---@field group LuaGroup @ [Read-only] 
---@field subgroup LuaGroup @ [Read-only] 
---@field healing_per_tick float @ [Read-only] 
---@field emissions_per_second double @ [Read-only] 
---@field corpses table<string, LuaEntityPrototype> @ [Read-only] 
---@field selectable_in_game boolean @ [Read-only] 
---@field selection_priority uint @ [Read-only] The selection priority of this entity - a value between 0 and 255
---@field weight double @ [Read-only] The weight of this vehicle prototype or nil if not a vehicle prototype.
---@field resistances Resistances @ [Read-only] 
---@field fast_replaceable_group string @ [Read-only] 
---@field next_upgrade LuaEntityPrototype @ [Read-only] 
---@field loot Loot @ [Read-only] 
---@field repair_speed_modifier uint @ [Read-only] 
---@field turret_range uint @ [Read-only] The range of this turret or nil if this isn't a turret related prototype.
---@field autoplace_specification AutoplaceSpecification @ [Read-only] Autoplace specification for this entity prototype. nil if none.
---@field belt_speed double @ [Read-only] 
---@field result_units object[] @ [Read-only] 
---@field attack_result Trigger @ [Read-only] 
---@field final_attack_result Trigger @ [Read-only] 
---@field attack_parameters table @ [Read-only] The attack parameters for this entity or nil if the entity doesn't use attack parameters.
---@field spawn_cooldown table @ [Read-only] 
---@field mining_drill_radius double @ [Read-only] The mining radius of this mining drill prototype or nil if this isn't a mining drill prototype.
---@field mining_speed double @ [Read-only] The mining speed of this mining drill/character prototype or nil.
---@field logistic_mode string @ [Read-only] The logistic mode of this logistic container or nil if this isn't a logistic container prototype.
---@field max_underground_distance uint8 @ [Read-only] The max underground distance for underground belts and underground pipes or nil if this isn't one of those prototypes.
---@field flags EntityPrototypeFlags @ [Read-only] The entity prototype flags for this entity.
---@field remains_when_mined LuaEntityPrototype[] @ [Read-only] The remains left behind when this entity is mined.
---@field additional_pastable_entities LuaEntityPrototype[] @ [Read-only] Entities this entity can be pasted onto in addition to the normal allowed ones.
---@field allow_copy_paste boolean @ [Read-only] When false copy-paste is not allowed for this entity.
---@field shooting_cursor_size double @ [Read-only] The cursor size used when shooting at this entity.
---@field created_smoke table @ [Read-only] The smoke trigger run when this entity is built or nil.
---@field created_effect Trigger @ [Read-only] 
---@field map_color Color @ [Read-only] The map color used when charting this entity if a friendly or enemy color isn't defined or nil.
---@field friendly_map_color Color @ [Read-only] The friendly map color used when charting this entity.
---@field enemy_map_color Color @ [Read-only] The enemy map color used when charting this entity.
---@field build_base_evolution_requirement double @ [Read-only] The evolution requirement to build this entity as a base when expanding enemy bases.
---@field instruments ProgrammableSpeakerInstrument[] @ [Read-only] The instruments for this programmable speaker or nil.
---@field max_polyphony uint @ [Read-only] The maximum polyphony for this programmable speaker or nil.
---@field module_inventory_size uint @ [Read-only] The module inventory size or nil if this entity doesn't support modules.
---@field ingredient_count uint @ [Read-only] The max number of ingredients this crafting-machine prototype supports or nil if this isn't a crafting-machine prototype.
---@field crafting_speed double @ [Read-only] The crafting speed of this crafting-machine or nil.
---@field crafting_categories table<string, boolean> @ [Read-only] The crafting categories this entity supports. Only meaningful when this is a crafting-machine or player entity type.
---@field resource_categories table<string, boolean> @ [Read-only] The resource categories this mining drill supports or nil if not a mining dill.
---@field supply_area_distance double @ [Read-only] The supply area of this electric pole, beacon, or nil if this is neither.
---@field max_wire_distance double @ [Read-only] The maximum wire distance for this entity. 0 when the entity doesn't support wires.
---@field max_circuit_wire_distance double @ [Read-only] The maximum circuit wire distance for this entity. 0 when the entity doesn't support circuit wires.
---@field energy_usage double @ [Read-only] The direct energy usage of this entity or nil if this entity doesn't have a direct energy usage.
---@field max_energy_usage double @ [Read-only] The theoretical maximum energy usage for this entity.
---@field effectivity double @ [Read-only] The effectivity of this car prototype, generator prototype or nil.
---@field consumption double @ [Read-only] The energy consumption of this car prototype or nil if not a car prototype.
---@field friction_force double @ [Read-only] The friction of this vehicle prototype or nil if not a vehicle prototype.
---@field braking_force double @ [Read-only] The braking force of this vehicle prototype or nil if not a vehicle prototype.
---@field tank_driving boolean @ [Read-only] If this car prototype uses tank controls to drive or nil if this is not a car prototype.
---@field rotation_speed double @ [Read-only] The rotation speed of this car prototype or nil if not a car prototype.
---@field turret_rotation_speed double @ [Read-only] The turret rotation speed of this car prototype or nil if not a car prototype.
---@field guns table<string, LuaItemPrototype> @ [Read-only] The guns this car prototype uses or nil if not a car prototype.
---@field speed double @ [Read-only] The default speed of this flying robot, rolling stock, unit or nil.
---@field speed_multiplier_when_out_of_energy float @ [Read-only] The speed multiplier when this flying robot is out of energy or nil.
---@field max_payload_size uint @ [Read-only] The max payload size of this logistics or construction robot or nil.
---@field draw_cargo boolean @ [Read-only] Whether this logistics or construction robot renders its cargo when flying or nil.
---@field energy_per_move double @ [Read-only] The energy consumed per tile moved for this flying robot or nil.
---@field energy_per_tick double @ [Read-only] The energy consumed per tick for this flying robot or nil.
---@field max_energy double @ [Read-only] The max energy for this flying robot or nil.
---@field min_to_charge float @ [Read-only] The minimum energy for this flying robot before it tries to recharge or nil.
---@field max_to_charge float @ [Read-only] The maximum energy for this flying robot above which it won't try to recharge when stationing or nil.
---@field burner_prototype LuaBurnerPrototype @ [Read-only] The burner energy source prototype this entity uses or nil.
---@field electric_energy_source_prototype LuaElectricEnergySourcePrototype @ [Read-only] The electric energy source prototype this entity uses or nil.
---@field heat_energy_source_prototype LuaHeatEnergySourcePrototype @ [Read-only] The heat energy source prototype this entity uses or nil.
---@field fluid_energy_source_prototype LuaFluidEnergySourcePrototype @ [Read-only] The fluid energy source prototype this entity uses or nil.
---@field void_energy_source_prototype LuaVoidEnergySourcePrototype @ [Read-only] The void energy source prototype this entity uses or nil.
---@field building_grid_bit_shift uint @ [Read-only] The log2 of grid size of the building
---@field fluid_usage_per_tick double @ [Read-only] The fluid usage of this generator prototype or nil.
---@field maximum_temperature double @ [Read-only] The maximum fluid temperature of this generator prototype or nil.
---@field target_temperature double @ [Read-only] The target temperature of this boiler prototype or nil.
---@field fluid LuaFluidPrototype @ [Read-only] The fluid this offshore pump produces or nil.
---@field fluid_capacity double @ [Read-only] The fluid capacity of this entity or 0 if this entity doesn't support fluids.
---@field pumping_speed double @ [Read-only] The pumping speed of this offshore pump, normal pump, or nil.
---@field stack boolean @ [Read-only] If this inserter is a stack-type.
---@field allow_custom_vectors boolean @ [Read-only] If this inserter allows custom pickup and drop vectors.
---@field allow_burner_leech boolean @ [Read-only] If this inserter allows burner leeching.
---@field inserter_extension_speed double @ [Read-only] 
---@field inserter_rotation_speed double @ [Read-only] 
---@field inserter_pickup_position Vector @ [Read-only] 
---@field inserter_drop_position Vector @ [Read-only] 
---@field inserter_chases_belt_items boolean @ [Read-only] True if this inserter chases items on belts for pickup or nil.
---@field count_as_rock_for_filtered_deconstruction boolean @ [Read-only] If this simple-entity is counted as a rock for the deconstruction planner "trees and rocks only" filter.
---@field filter_count uint @ [Read-only] The filter count of this inserter, loader, or requester chest or nil.
---@field production double @ [Read-only] The max production this solar panel prototype produces or nil.
---@field time_to_live uint @ [Read-only] The time to live for this prototype or 0 if prototype doesn't have time_to_live or time_before_removed.
---@field distribution_effectivity double @ [Read-only] The distribution effectivity for this beacon prototype or nil if not a beacon prototype.
---@field explosion_beam double @ [Read-only] Does this explosion have a beam or nil if not an explosion prototype.
---@field explosion_rotate double @ [Read-only] Does this explosion rotate or nil if not an explosion prototype.
---@field tree_color_count uint8 @ [Read-only] If it is a tree, return the number of colors it supports. nil otherwise.
---@field alert_when_damaged boolean @ [Read-only] Does this entity with health prototype alert when damaged? or nil if not entity with health prototype.
---@field alert_when_attacking boolean @ [Read-only] Does this turret prototype alert when attacking? or nil if not turret prototype.
---@field color Color @ [Read-only] The color of the prototype, or nil if the prototype doesn't have color.
---@field collision_mask_collides_with_self boolean @ [Read-only] Does this prototype collision mask collide with itself?
---@field collision_mask_collides_with_tiles_only boolean @ [Read-only] Does this prototype collision mask collide with tiles only?
---@field collision_mask_considers_tile_transitions boolean @ [Read-only] Does this prototype collision mask consider tile transitions?
---@field allowed_effects table<string, boolean> @ [Read-only] The allowed module effects for this entity or nil.
---@field rocket_parts_required uint @ [Read-only] The rocket parts required for this rocket silo prototype or nil.
---@field fixed_recipe string @ [Read-only] The fixed recipe name for this assembling machine prototype or nil.
---@field construction_radius double @ [Read-only] The construction radius for this roboport prototype or nil.
---@field logistic_radius double @ [Read-only] The logistic radius for this roboport prototype or nil.
---@field energy_per_hit_point double @ [Read-only] The energy used per hitpoint taken for this vehicle during collisions or nil.
---@field create_ghost_on_death boolean @ [Read-only] If this prototype will attempt to create a ghost of itself on death.
---@field timeout uint @ [Read-only] The time it takes this land mine to arm.
---@field fluidbox_prototypes LuaFluidBoxPrototype[] @ [Read-only] The fluidbox prototypes for this entity.
---@field neighbour_bonus double @ [Read-only] 
---@field neighbour_collision_increase double @ [Read-only] Controls how much a reactor extends when connected to other reactors.
---@field container_distance double @ [Read-only] 
---@field belt_distance double @ [Read-only] 
---@field belt_length double @ [Read-only] 
---@field is_building boolean @ [Read-only] 
---@field automated_ammo_count uint @ [Read-only] 
---@field max_speed double @ [Read-only] 
---@field darkness_for_all_lamps_on float @ [Read-only] 
---@field darkness_for_all_lamps_off float @ [Read-only] 
---@field always_on boolean @ [Read-only] 
---@field min_darkness_to_spawn float @ [Read-only] 
---@field max_darkness_to_spawn float @ [Read-only] 
---@field call_for_help_radius double @ [Read-only] 
---@field max_count_of_owned_units double @ [Read-only] 
---@field max_friends_around_to_spawn double @ [Read-only] 
---@field spawning_radius double @ [Read-only] 
---@field spawning_spacing double @ [Read-only] 
---@field radius double @ [Read-only] 
---@field cliff_explosive_prototype string @ [Read-only] 
---@field has_belt_immunity boolean @ [Read-only] 
---@field vision_distance double @ [Read-only] 
---@field pollution_to_join_attack float @ [Read-only] 
---@field min_pursue_time uint @ [Read-only] 
---@field max_pursue_distance double @ [Read-only] 
---@field radar_range uint @ [Read-only] 
---@field move_while_shooting boolean @ [Read-only] 
---@field can_open_gates boolean @ [Read-only] 
---@field affected_by_tiles boolean @ [Read-only] 
---@field distraction_cooldown uint @ [Read-only] 
---@field spawning_time_modifier double @ [Read-only] 
---@field alert_icon_shift Vector @ [Read-only] 
---@field lab_inputs string[] @ [Read-only] The item prototype names that are the inputs of this lab prototype or nil.
---@field researching_speed double @ [Read-only] The base researching speed of this lab prototype or nil.
---@field item_slot_count uint @ [Read-only] The item slot count of this constant combinator prototype or nil.
---@field base_productivity double @ [Read-only] The base productivity of this crafting machine, lab, or mining drill, or nil.
---@field allow_access_to_all_forces boolean @ [Read-only] If this market allows access to all forces or just friendly ones.
---@field supports_direction boolean @ [Read-only] If this entity prototype could possibly ever be rotated.
---@field terrain_friction_modifier float @ [Read-only] The terrain friction modifier for this vehicle.
---@field max_distance_of_sector_revealed uint @ [Read-only] The radius of the area this radar can chart, in chunks.
---@field max_distance_of_nearby_sector_revealed uint @ [Read-only] The radius of the area constantly revealed by this radar, in chunks.
---@field adjacent_tile_collision_box BoundingBox @ [Read-only] 
---@field adjacent_tile_collision_mask CollisionMask @ [Read-only] 
---@field adjacent_tile_collision_test CollisionMask @ [Read-only] 
---@field center_collision_mask CollisionMask @ [Read-only] 
---@field grid_prototype LuaEquipmentGridPrototype @ [Read-only] The equipment grid prototype for this entity or nil.
---@field running_speed double @ [Read-only] 
---@field maximum_corner_sliding_distance double @ [Read-only] 
---@field build_distance uint @ [Read-only] 
---@field drop_item_distance uint @ [Read-only] 
---@field reach_distance uint @ [Read-only] 
---@field reach_resource_distance double @ [Read-only] 
---@field item_pickup_distance double @ [Read-only] 
---@field loot_pickup_distance double @ [Read-only] 
---@field enter_vehicle_distance double @ [Read-only] 
---@field ticks_to_keep_gun uint @ [Read-only] 
---@field ticks_to_keep_aiming_direction uint @ [Read-only] 
---@field ticks_to_stay_in_combat uint @ [Read-only] 
---@field respawn_time uint @ [Read-only] 
---@field damage_hit_tint Color @ [Read-only] 
---@field character_corpse LuaEntityPrototype @ [Read-only] 

---Does this prototype have a flag enabled?
---@param flag string @The flag to check. Must be one of  "not-rotatable" "placeable-neutral" "placeable-player" "placeable-enemy" "placeable-off-grid" "player-creation" "building-direction-8-way" "filter-directions" "fast-replaceable-no-build-while-moving" "breaths-air" "not-repairable" "not-on-map" "not-deconstructable" "not-blueprintable" "hide-from-bonus-gui" "hide-alt-info" "fast-replaceable-no-cross-type-while-moving" "no-gap-fill-while-building" "not-flammable" "no-automated-item-removal" "no-automated-item-insertion" "not-upgradable
---@return boolean @
function LuaEntityPrototype.has_flag(flag) end

---Gets the base size of the given inventory on this entity or nil if the given inventory doesn't exist.
---@param index defines.inventory @
---@return uint @
function LuaEntityPrototype.get_inventory_size(index) end

---@class LuaEquipment 
---@field name string @ [Read-only] 
---@field type string @ [Read-only] 
---@field position Position @ [Read-only] 
---@field shape table @ [Read-only] Shape of this equipment. It is a table:
---@field shield double @ [Read-Write] 
---@field max_shield double @ [Read-only] 
---@field max_solar_power double @ [Read-only] 
---@field movement_bonus double @ [Read-only] 
---@field generator_power double @ [Read-only] 
---@field energy double @ [Read-Write] 
---@field max_energy double @ [Read-only] 
---@field prototype LuaEquipmentPrototype @ [Read-only] 
---@field burner LuaBurner @ [Read-only] The burner energy source for this equipment or nil if there isn't one.

---@class LuaEquipmentCategoryPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 

---@class LuaEquipmentGrid Remove an equipment from the grid.
---@field take SimpleItemStack @(optional) undefined Remove an equipment from the grid.
---@field put LuaEquipment @(optional) undefined Insert an equipment into the grid.
---@field can_move boolean @ undefined Check whether moving an equipment would succeed.
---@field move boolean @ undefined Move an equipment within this grid.
---@field prototype LuaEquipmentGridPrototype @ [Read-only] 
---@field width uint @ [Read-only] 
---@field height uint @ [Read-only] 
---@field equipment LuaEquipment[] @ [Read-only] 
---@field generator_energy double @ [Read-only] 
---@field max_solar_energy double @ [Read-only] 
---@field available_in_batteries double @ [Read-only] 
---@field battery_capacity double @ [Read-only] 
---@field shield float @ [Read-only] The amount of shields this equipment grid has.
---@field max_shield float @ [Read-only] The maximum amount of shields this equipment grid has.
---@field inhibit_movement_bonus boolean @ [Read-Write] True if this movement bonus equipment is turned off, otherwise false.

---Remove all equipment from the grid.
---@return dictionary string → uint @
function LuaEquipmentGrid.take_all() end

---Clear all equipment from the grid. I.e. remove it without actually returning it.
function LuaEquipmentGrid.clear() end

---Find equipment in the Equipment Grid based off a position.
---@param position Position @The positio
---@return LuaEquipment @
function LuaEquipmentGrid.get(position) end

---Get counts of all equipment in this grid.
---@return dictionary string → uint @
function LuaEquipmentGrid.get_contents() end

---@class LuaEquipmentGridPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field equipment_categories string[] @ [Read-only] 
---@field width uint @ [Read-only] 
---@field height uint @ [Read-only] 
---@field locked boolean @ [Read-only] If the player can move equipment into or out of this grid.

---@class LuaEquipmentPrototype 
---@field name string @ [Read-only] 
---@field type string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field shape table @(optional) [Read-only] Shape of this equipment prototype. It is a table:
---@field take_result LuaItemPrototype @ [Read-only] 
---@field energy_production double @ [Read-only] 
---@field shield float @ [Read-only] 
---@field energy_per_shield double @ [Read-only] 
---@field logistic_parameters table @ [Read-only] 
---@field energy_consumption double @ [Read-only] 
---@field movement_bonus float @ [Read-only] 
---@field energy_source LuaElectricEnergySourcePrototype @ [Read-only] 
---@field equipment_categories string[] @ [Read-only] 
---@field burner_prototype LuaBurnerPrototype @ [Read-only] The burner energy source prototype this equipment uses or nil.
---@field electric_energy_source_prototype LuaElectricEnergySourcePrototype @ [Read-only] The electric energy source prototype this equipment uses or nil.
---@field background_color Color @ [Read-only] 
---@field attack_parameters AttackParameters @ [Read-only] The equipment attack parameters or nil.
---@field automatic boolean @ [Read-only] Is this active defense equipment automatic. Returns false if not active defense equipment.

---@class LuaFlowStatistics Gets the total input count for a given prototype.
---@field get_flow_count double @(optional) undefined Gets the flow count value for the given time frame.
---@field input_counts table<string, uint64> @ [Read-only] 
---@field output_counts table<string, uint64> @ [Read-only] 
---@field force LuaForce @ [Read-only] 

---Gets the total input count for a given prototype.
---@param string string @The prototype name
---@return uint64 or double @
function LuaFlowStatistics.get_input_count(string) end

---Sets the total input count for a given prototype.
---@param string string @The prototype name
---@param count uint64 | double @The new count. The type depends on the instance of the statistics
function LuaFlowStatistics.set_input_count(string, count) end

---Gets the total output count for a given prototype.
---@param string string @The prototype name
---@return uint64 or double @
function LuaFlowStatistics.get_output_count(string) end

---Sets the total output count for a given prototype.
---@param string string @The prototype name
---@param count uint64 | double @The new count. The type depends on the instance of the statistics
function LuaFlowStatistics.set_output_count(string, count) end

---Adds a value to this flow statistics.
---@param string string @The prototype name
---@param count float @The count: positive or negative determines if the value goes in the input or output statistics
function LuaFlowStatistics.on_flow(string, count) end

---Reset all the statistics data to 0.
function LuaFlowStatistics.clear() end

---@class LuaFluidBox The prototype of this fluidbox index.
---@field hash_operator uint @ [Read-only] 
---@field owner LuaEntity @ [Read-only] The entity that owns this fluidbox.
---@field bracket_operator Fluid | nil @ [Read-only] 

---The prototype of this fluidbox index.
---@param index uint @
---@return LuaFluidBoxPrototype @
function LuaFluidBox.get_prototype(index) end

---The capacity of the given fluidbox index.
---@param index uint @
---@return double @
function LuaFluidBox.get_capacity(index) end

---The fluidbox connections for the given fluidbox index.
---@param index uint @
---@return array of LuaFluidBox @
function LuaFluidBox.get_connections(index) end

---The filter of the given fluidbox index, 'nil' if none.
---@param index uint @
---@return table @
function LuaFluidBox.get_filter(index) end

---Set the filter of the given fluidbox index, 'nil' to clear. Some entities cannot have their fluidbox filter set, notably fluid wagons and crafting machines.
---@param index uint @
---@param table string @Table with the following fields: name :: string:  Fluid prototype name of the filtered fluid.minimum_temperature :: double  (optional):  The minimum temperature allowed into the fluidboxmaximum_temperature :: double  (optional):  The maximum temperature allowed into the fluidboxforce :: boolean  (optional):  Force the filter to be set, regardless of current fluid content. or 'nil'
---@return boolean @
function LuaFluidBox.set_filter(index, table) end

---Flow through the fluidbox in the last tick. It is the larger of in-flow and out-flow. Note that wagons do not track it and will return 0.
---@param index uint @
---@return double @
function LuaFluidBox.get_flow(index) end

---Returns the fluid the fluidbox is locked onto (along with its whole system) Returns 'nil' for no lock
---@param index uint @
---@return string @
function LuaFluidBox.get_locked_fluid(index) end

---@class LuaFluidBoxPrototype The entity that this belongs to.
---@field entity LuaEntityPrototype @ [Read-only] The entity that this belongs to.
---@field index uint @ [Read-only] The index of this fluidbox prototype in the owning entity.
---@field pipe_connections FluidBoxConnection[] @ [Read-only] The pipe connection points.
---@field production_type string @ [Read-only] The production type. "input", "output", "input-output", or "none".
---@field base_area double @ [Read-only] 
---@field base_level double @ [Read-only] 
---@field height double @ [Read-only] 
---@field volume double @ [Read-only] 
---@field filter LuaFluidPrototype @ [Read-only] The filter or nil if no filter is set.
---@field minimum_temperature double @ [Read-only] The minimum temperature or nil if none is set.
---@field maximum_temperature double @ [Read-only] The maximum temperature or nil if none is set.
---@field secondary_draw_orders int[] @ [Read-only] The secondary draw orders for the 4 possible connection directions.
---@field render_layer string @ [Read-only] The render layer.

---@class LuaFluidEnergySourcePrototype 
---@field emissions double @ [Read-only] 
---@field render_no_network_icon boolean @ [Read-only] 
---@field render_no_power_icon boolean @ [Read-only] 
---@field effectivity double @ [Read-only] 
---@field burns_fluid boolean @ [Read-only] 
---@field scale_fluid_usage boolean @ [Read-only] 
---@field fluid_usage_per_tick double @ [Read-only] 
---@field smoke SmokeSource[] @ [Read-only] The smoke sources for this prototype if any.
---@field maximum_temperature double @ [Read-only] 
---@field fluid_box nil @ [Read-only] The fluid box for this energy source.

---@class LuaFluidPrototype 
---@field name string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field default_temperature double @ [Read-only] 
---@field max_temperature double @ [Read-only] 
---@field heat_capacity double @ [Read-only] 
---@field order string @ [Read-only] 
---@field group LuaGroup @ [Read-only] 
---@field subgroup LuaGroup @ [Read-only] 
---@field base_color Color @ [Read-only] 
---@field flow_color Color @ [Read-only] 
---@field gas_temperature double @ [Read-only] 
---@field emissions_multiplier double @ [Read-only] 
---@field fuel_value double @ [Read-only] 
---@field hidden boolean @ [Read-only] 

---@class LuaForce Count entities of given type.
---@field play_sound boolean @(optional) undefined Plays a sound for every player on this force
---@field name string @ [Read-only] 
---@field technologies CustomDictionary @ [Read-only] 
---@field recipes CustomDictionary @ [Read-only] 
---@field manual_mining_speed_modifier double @ [Read-Write] 
---@field manual_crafting_speed_modifier double @ [Read-Write] 
---@field laboratory_speed_modifier double @ [Read-Write] 
---@field laboratory_productivity_bonus double @ [Read-Write] 
---@field worker_robots_speed_modifier double @ [Read-Write] 
---@field worker_robots_battery_modifier double @ [Read-Write] 
---@field worker_robots_storage_bonus double @ [Read-Write] 
---@field current_research LuaTechnology @ [Read-only] 
---@field research_progress double @ [Read-Write] 
---@field previous_research LuaTechnology @ [Read-Write] 
---@field inserter_stack_size_bonus double @ [Read-Write] 
---@field stack_inserter_capacity_bonus uint @ [Read-Write] 
---@field character_trash_slot_count double @ [Read-Write] 
---@field maximum_following_robot_count uint @ [Read-Write] 
---@field following_robots_lifetime_modifier double @ [Read-Write] Additional lifetime for following robots.
---@field ghost_time_to_live uint @ [Read-Write] 
---@field players LuaPlayer[] @ [Read-only] 
---@field ai_controllable boolean @ [Read-Write] 
---@field logistic_networks table<string, LuaLogisticNetwork> @ [Read-only] 
---@field item_production_statistics LuaFlowStatistics @ [Read-only] 
---@field fluid_production_statistics LuaFlowStatistics @ [Read-only] 
---@field kill_count_statistics LuaFlowStatistics @ [Read-only] 
---@field entity_build_count_statistics LuaFlowStatistics @ [Read-only] 
---@field character_running_speed_modifier double @ [Read-Write] 
---@field artillery_range_modifier double @ [Read-Write] 
---@field character_build_distance_bonus uint @ [Read-Write] 
---@field character_item_drop_distance_bonus uint @ [Read-Write] 
---@field character_reach_distance_bonus uint @ [Read-Write] 
---@field character_resource_reach_distance_bonus double @ [Read-Write] 
---@field character_item_pickup_distance_bonus double @ [Read-Write] 
---@field character_loot_pickup_distance_bonus double @ [Read-Write] 
---@field character_inventory_slots_bonus uint @ [Read-Write] 
---@field deconstruction_time_to_live uint @ [Read-Write] 
---@field character_health_bonus double @ [Read-Write] 
---@field max_successful_attempts_per_tick_per_construction_queue uint @ [Read-Write] 
---@field max_failed_attempts_per_tick_per_construction_queue uint @ [Read-Write] 
---@field auto_character_trash_slots boolean @ [Read-Write] true if auto character trash slots are enabled. Character trash slots must be > 0 as well for this to actually be used.
---@field zoom_to_world_enabled boolean @ [Read-Write] Ability to use zoom-to-world on map.
---@field zoom_to_world_ghost_building_enabled boolean @ [Read-Write] Ability to build ghosts through blueprint or direct ghost placement, or "mine" ghosts when using zoom-to-world.
---@field zoom_to_world_blueprint_enabled boolean @ [Read-Write] Ability to create new blueprints using empty blueprint item when using zoom-to-world.
---@field zoom_to_world_deconstruction_planner_enabled boolean @ [Read-Write] Ability to use deconstruction planner when using zoom-to-world.
---@field zoom_to_world_selection_tool_enabled boolean @ [Read-Write] Ability to use custom selection tools when using zoom-to-world.
---@field character_logistic_requests boolean @ [Read-Write] true if character requester logistics is enabled.
---@field rockets_launched uint @ [Read-Write] The number of rockets launched.
---@field items_launched table<string, uint> @ [Read-only] All of the items that have been launched in rockets.
---@field connected_players LuaPlayer[] @ [Read-only] 
---@field mining_drill_productivity_bonus double @ [Read-Write] 
---@field train_braking_force_bonus double @ [Read-Write] 
---@field evolution_factor double @ [Read-Write] 
---@field evolution_factor_by_pollution double @ [Read-Write] 
---@field evolution_factor_by_time double @ [Read-Write] 
---@field evolution_factor_by_killing_spawners double @ [Read-Write] 
---@field friendly_fire boolean @ [Read-Write] 
---@field share_chart boolean @ [Read-Write] 
---@field research_queue_enabled boolean @ [Read-Write] 
---@field index uint @ [Read-only] 
---@field research_queue TechnologySpecification[] @ [Read-Write] 
---@field research_enabled boolean @ [Read-only] 

---Count entities of given type.
---@param name string @Prototype name of the entity
---@return uint @
function LuaForce.get_entity_count(name) end

---Disable research for this force.
function LuaForce.disable_research() end

---Enable research for this force.
function LuaForce.enable_research() end

---Disable all recipes and technologies. Only recipes and technologies enabled explicitly will be useable from this point.
function LuaForce.disable_all_prototypes() end

---Enables all recipes and technologies. The opposite of LuaForce::disable_all_prototypes
function LuaForce.enable_all_prototypes() end

---Load the original version of all recipes from the prototypes.
function LuaForce.reset_recipes() end

---Unlock all recipes.
function LuaForce.enable_all_recipes() end

---Unlock all technologies.
function LuaForce.enable_all_technologies() end

---Research all technologies.
---@param include_disabled_prototypes include_disabled_prototypes @If technologies that are explicitly disabled in the prototype are also researched. This defaults to false
function LuaForce.research_all_technologies(include_disabled_prototypes) end

---Load the original versions of technologies from prototypes. Preserves research state of technologies.
function LuaForce.reset_technologies() end

---Reset everything. All technologies are set to not researched, all modifiers are set to default values.
function LuaForce.reset() end

---Reapplies all possible research effects, including unlocked recipes. Any custom changes are lost. Preserves research state of technologies.
function LuaForce.reset_technology_effects() end

---Chart a portion of the map. The chart for the given area is refreshed; it creates chart for any parts of the given area that haven't been charted yet.
---@param surface SurfaceSpecification @
---@param area BoundingBox @The area on the given surface to chart
function LuaForce.chart(surface, area) end

---Erases chart data for this force.
---@param surface SurfaceSpecification @Which surface to erase chart data for or if not provided all surfaces charts are erased
function LuaForce.clear_chart(surface) end

---Force a rechart of the whole chart.
function LuaForce.rechart() end

---Chart all generated chunks.
---@param surface SurfaceSpecification @Which surface to chart or all if not given
function LuaForce.chart_all(surface) end

---Has a chunk been charted?
---@param surface SurfaceSpecification @
---@param position ChunkPosition @Position of the chunk
---@return boolean @
function LuaForce.is_chunk_charted(surface, position) end

---Is the given chunk currently charted and visible (not covered by fog of war) on the map.
---@param surface SurfaceSpecification @
---@param position ChunkPosition @
---@return boolean @
function LuaForce.is_chunk_visible(surface, position) end

---Cancels pending chart requests for the given surface or all surfaces.
---@param surface SurfaceSpecification @
function LuaForce.cancel_charting(surface) end

---
---@param ammo string @Ammo categor
---@return double @
function LuaForce.get_ammo_damage_modifier(ammo) end

---
---@param ammo string @Ammo categor
---@param modifier double @
function LuaForce.set_ammo_damage_modifier(ammo, modifier) end

---
---@param ammo string @Ammo categor
---@return double @
function LuaForce.get_gun_speed_modifier(ammo) end

---
---@param ammo string @Ammo categor
---@param modifier double @
function LuaForce.set_gun_speed_modifier(ammo, modifier) end

---
---@param turret string @Turret prototype nam
---@return double @
function LuaForce.get_turret_attack_modifier(turret) end

---
---@param turret string @Turret prototype nam
---@param modifier double @
function LuaForce.set_turret_attack_modifier(turret, modifier) end

---Stop attacking members of a given force.
---@param other ForceSpecification @
---@param cease_fire boolean @When true, this force won't attack other; otherwise it will
function LuaForce.set_cease_fire(other, cease_fire) end

---Will this force attack members of another force?
---@param other ForceSpecification @
---@return boolean @
function LuaForce.get_cease_fire(other) end

---Friends have unrestricted access to buildings and turrets won't fire at them.
---@param other ForceSpecification @
---@param cease_fire boolean @
function LuaForce.set_friend(other, cease_fire) end

---Is this force a friend?
---@param other ForceSpecification @
---@return boolean @
function LuaForce.get_friend(other) end

---Is pathfinder busy? When the pathfinder is busy, it won't accept any more pathfinding requests.
---@return boolean @
function LuaForce.is_pathfinder_busy() end

---Kill all units and flush the pathfinder.
function LuaForce.kill_all_units() end

---
---@param position Position @Position to find a network fo
---@param surface SurfaceSpecification @Surface to search o
---@return LuaLogisticNetwork @
function LuaForce.find_logistic_network_by_position(position, surface) end

---
---@param position Position @The new position on the given surface
---@param surface SurfaceSpecification @Surface to set the spawn position for
function LuaForce.set_spawn_position(position, surface) end

---
---@param surface SurfaceSpecification @
---@return Position @
function LuaForce.get_spawn_position(surface) end

---
---@param position ChunkPosition @The chunk position to unchart
---@param surface SurfaceSpecification @Surface to unchart on
function LuaForce.unchart_chunk(position, surface) end

---Gets the count of a given item launched in rockets.
---@param item string @The item to ge
---@return uint @
function LuaForce.get_item_launched(item) end

---Sets the count of a given item launched in rockets.
---@param item string @The item to se
---@param count uint @The count to se
function LuaForce.set_item_launched(item, count) end

---Print text to the chat console of all players on this force.
---@param message LocalisedString @
---@param color Color @
function LuaForce.print(message, color) end

---
---@param surface SurfaceSpecification @If given only trains on the surface are returned
---@return array of LuaTrain @
function LuaForce.get_trains(surface) end

---Adds a custom chart tag to the given surface and returns the new tag or nil if the given position isn't valid for a chart tag.
---@param surface SurfaceSpecification @Which surface to add the tag to
---@param tag SignalID @Table with the following fields: icon :: SignalID  (optional): )position :: Positiontext :: string  (optional)last_user :: PlayerSpecification  (optional
---@return LuaCustomChartTag @
function LuaForce.add_chart_tag(surface, tag) end

---Finds all custom chart tags within the given bounding box on the given surface.
---@param surface SurfaceSpecification @
---@param area BoundingBox @
---@return array of LuaCustomChartTag @
function LuaForce.find_chart_tags(surface, area) end

---Gets the saved progress for the given technology or nil if there is no saved progress.
---@param technology TechnologySpecification @The technolog
---@return double @
function LuaForce.get_saved_technology_progress(technology) end

---Sets the saved progress for the given technology. The technology must not be in progress, must not be completed, and the new progress must be < 100%.
---@param technology TechnologySpecification @The technolog
---@param double double @Progress as a percent. Set to nil to remove the saved progress
function LuaForce.set_saved_technology_progress(technology, double) end

---Resets evolution for this force to zero.
function LuaForce.reset_evolution() end

---Gets train stops matching the given filters.
---@param opts string | string[] | string @Table with the following fields: name :: string or array of string  (optional)surface :: SurfaceSpecification  (optional
---@return array of LuaEntity @
function LuaForce.get_train_stops(opts) end

---Gets if the given recipe is explicitly disabled from being hand crafted.
---@param recipe string | LuaRecipe @
---@return boolean @
function LuaForce.get_hand_crafting_disabled_for_recipe(recipe) end

---Sets if the given recipe can be hand-crafted. This is used to explicitly disable hand crafting a recipe - it won't allow hand-crafting otherwise not hand-craftable recipes.
---@param recipe string | LuaRecipe @
---@param hand_crafting_disabled boolean @
function LuaForce.set_hand_crafting_disabled_for_recipe(recipe, hand_crafting_disabled) end

---Add this technology to the back of the research queue if the queue is enabled. Otherwise, set this technology to be researched now.
---@param technology TechnologySpecification @
---@return boolean @
function LuaForce.add_research(technology) end

---Stop the research currently in progress. This will remove any dependent technologies from the research queue.
function LuaForce.cancel_current_research() end

---@class LuaFuelCategoryPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 

---@class LuaGameScript Internal
---@field set_game_state nil @ undefined Set scenario state.
---@field show_message_dialog nil @(optional) undefined Show an in-game message dialog.
---@field take_screenshot nil @(optional) undefined Take a screenshot and save it to a file.
---@field take_technology_screenshot nil @(optional) undefined 
---@field play_sound boolean @(optional) undefined Plays a sound for every player in the game on every surface.
---@field object_name string @ [Read-only] This objects name.
---@field player LuaPlayer @ [Read-only] 
---@field players CustomDictionary @ [Read-only] 
---@field map_settings MapSettings @ [Read-only] 
---@field difficulty_settings DifficultySettings @ [Read-only] 
---@field difficulty defines.difficulty @ [Read-only] 
---@field forces CustomDictionary @ [Read-only] 
---@field entity_prototypes CustomDictionary @ [Read-only] 
---@field item_prototypes CustomDictionary @ [Read-only] 
---@field fluid_prototypes CustomDictionary @ [Read-only] 
---@field tile_prototypes CustomDictionary @ [Read-only] 
---@field equipment_prototypes CustomDictionary @ [Read-only] 
---@field damage_prototypes CustomDictionary @ [Read-only] 
---@field virtual_signal_prototypes CustomDictionary @ [Read-only] 
---@field equipment_grid_prototypes CustomDictionary @ [Read-only] 
---@field recipe_prototypes CustomDictionary @ [Read-only] 
---@field technology_prototypes CustomDictionary @ [Read-only] 
---@field decorative_prototypes CustomDictionary @ [Read-only] 
---@field particle_prototypes CustomDictionary @ [Read-only] 
---@field autoplace_control_prototypes CustomDictionary @ [Read-only] 
---@field noise_layer_prototypes CustomDictionary @ [Read-only] 
---@field mod_setting_prototypes CustomDictionary @ [Read-only] 
---@field custom_input_prototypes CustomDictionary @ [Read-only] 
---@field ammo_category_prototypes CustomDictionary @ [Read-only] 
---@field named_noise_expressions CustomDictionary @ [Read-only] 
---@field item_subgroup_prototypes CustomDictionary @ [Read-only] 
---@field item_group_prototypes CustomDictionary @ [Read-only] 
---@field fuel_category_prototypes CustomDictionary @ [Read-only] 
---@field resource_category_prototypes CustomDictionary @ [Read-only] 
---@field achievement_prototypes CustomDictionary @ [Read-only] 
---@field module_category_prototypes CustomDictionary @ [Read-only] 
---@field equipment_category_prototypes CustomDictionary @ [Read-only] 
---@field trivial_smoke_prototypes CustomDictionary @ [Read-only] 
---@field shortcut_prototypes CustomDictionary @ [Read-only] 
---@field recipe_category_prototypes CustomDictionary @ [Read-only] 
---@field styles CustomDictionary @ [Read-only] The styles that LuaGuiElement can use. A mapping of style name to style type.
---@field tick uint @ [Read-only] 
---@field ticks_played uint @ [Read-only] 
---@field tick_paused boolean @ [Read-Write] 
---@field ticks_to_run uint @ [Read-Write] 
---@field finished boolean @ [Read-only] Is the scenario finished?
---@field speed float @ [Read-Write] 
---@field surfaces CustomDictionary @ [Read-only] 
---@field active_mods table<string, string> @ [Read-only] The active mods versions. The keys are mod names, the values are the versions.
---@field connected_players LuaPlayer[] @ [Read-only] The online players
---@field permissions LuaPermissionGroups @ [Read-only] 
---@field backer_names CustomDictionary @ [Read-only] 
---@field default_map_gen_settings MapGenSettings @ [Read-only] The default map gen settings for this save.
---@field enemy_has_vision_on_land_mines boolean @ [Read-Write] Determines if enemy land mines are completely invisible or not.
---@field autosave_enabled boolean @ [Read-Write] True by default. Can be used to disable autosaving. Make sure to turn it back on soon after.
---@field draw_resource_selection boolean @ [Read-Write] True by default. Can be used to disable the highlighting of resource patches when they are hovered on the map.
---@field pollution_statistics LuaFlowStatistics @ [Read-only] 
---@field max_force_distraction_distance double @ [Read-only] 
---@field max_force_distraction_chunk_distance uint @ [Read-only] 
---@field max_electric_pole_supply_area_distance float @ [Read-only] 
---@field max_electric_pole_connection_distance double @ [Read-only] 
---@field max_beacon_supply_area_distance double @ [Read-only] 
---@field max_gate_activation_distance double @ [Read-only] 
---@field max_inserter_reach_distance double @ [Read-only] 
---@field max_pipe_to_ground_distance uint8 @ [Read-only] 
---@field max_underground_belt_distance uint8 @ [Read-only] 

---Internal
function LuaGameScript.help() end

---
---@param tag string @
---@return LuaEntity @
function LuaGameScript.get_entity_by_tag(tag) end

---Disable showing tips and tricks.
function LuaGameScript.disable_tips_and_tricks() end

---Is this the demo version of Factorio?
---@return boolean @
function LuaGameScript.is_demo() end

---Forces a reload of the scenario script from the original scenario location.
function LuaGameScript.reload_script() end

---Forces a reload of all mods.
function LuaGameScript.reload_mods() end

---Saves the current configuration of Atlas to a file. This will result in huge file containing all of the game graphics moved to as small space as possible.
function LuaGameScript.save_atlas() end

---Run internal consistency checks. Allegedly prints any errors it finds.
function LuaGameScript.check_consistency() end

---Regenerate autoplacement of some entities on all surfaces. This can be used to autoplace newly-added entities.
---@param entities string | string[] | string @
function LuaGameScript.regenerate_entity(entities) end

---Forces the screenshot saving system to wait until all queued screenshots have been written to disk.
function LuaGameScript.set_wait_for_screenshots_to_finish() end

---Convert a table to a JSON string
---@param data table @
---@return string @
function LuaGameScript.table_to_json(data) end

---Convert a JSON string to a table
---@param json string @The string to conver
---@return Any @
function LuaGameScript.json_to_table(json) end

---Write a string to a file.
---@param filename string @Path to the file to write to
---@param data LocalisedString @File conten
---@param app_end boolean @When true, this will append to the end of the file. Defaults to false, which will overwrite any pre-existing file with the new data
---@param for_player uint @If given, the file will only be written for this player_index. 0 means only the server if one exists
function LuaGameScript.write_file(filename, data, app_end, for_player) end

---Remove file or directory. Given path is taken relative to the script output directory. Can be used to remove files created by LuaGameScript::write_file.
---@param path string @Path to remove, relative to the script output director
function LuaGameScript.remove_path(path) end

---Remove players who are currently not connected from the map.
---@param players LuaPlayer[] @List of players to remove. If not specified,   remove all offline players
function LuaGameScript.remove_offline_players(players) end

---Force a CRC check. Tells all peers to calculate their current map CRC; these CRC are then compared against each other. If a mismatch is detected, the game is desynced and some peers are forced to reconnect.
function LuaGameScript.force_crc() end

---Create a new force.
---@param force string @Name of the new forc
---@return LuaForce @
function LuaGameScript.create_force(force) end

---Marks two forces to be merge together. All entities in the source force will be reassigned to the target force. The source force will then be destroyed.
---@param source ForceSpecification @The force to remov
---@param destination ForceSpecification @The force to reassign all entities t
function LuaGameScript.merge_forces(source, destination) end

---Create a new surface
---@param name string @Name of the new surfac
---@param settings MapGenSettings @Map generation setting
---@return LuaSurface @
function LuaGameScript.create_surface(name, settings) end

---Instruct the server to save the map.
---@param name string @Save name. If not specified, writes into the currently-running save
function LuaGameScript.server_save(name) end

---Instruct the game to perform an auto-save.
---@param name string @The autosave name if any. Saves will be named _autosave-*name* when provided
function LuaGameScript.auto_save(name) end

---Deletes the given surface and all entities on it.
---@param surface string | LuaSurface @The surface to be deleted. Currently the primary surface (1, 'nauvis') cannot be deleted
function LuaGameScript.delete_surface(surface) end

---Disables replay saving for the current save file. Once done there's no way to re-enable replay saving for the save file without loading an old save.
function LuaGameScript.disable_replay() end

---Disables tutorial triggers, that unlock new tutorials and show notices about unlocked tutorials.
function LuaGameScript.disable_tutorial_triggers() end

---Converts the given direction into the string version of the direction.
---@param direction defines.direction @
function LuaGameScript.direction_to_string(direction) end

---Print text to the chat console all players.
---@param message LocalisedString @
---@param color Color @
function LuaGameScript.print(message, color) end

---Creates a deterministic standalone random generator with the given seed or if a seed is not provided the initial map seed is used.
---@param seed uint @
---@return LuaRandomGenerator @
function LuaGameScript.create_random_generator(seed) end

---Goes over all items, entities, tiles, recipes, technologies among other things and logs if the locale is incorrect.
function LuaGameScript.check_prototype_translations() end

---Checks if the given sound path is valid.
---@return boolean @
function LuaGameScript.is_valid_sound_path() end

---Returns true if sprite_path is valid and contains loaded sprite, otherwise false. Sprite path of type file doesn't validate if file exists.
---@param sprite_path SpritePath @Path to a image
---@return boolean @
function LuaGameScript.is_valid_sprite_path(sprite_path) end

---Kicks the given player from this multiplayer game. Does nothing if this is a single player game or if the player running this isn't an admin.
---@param PlayerSpecification PlayerSpecification @The player to kick
---@param reason LocalisedString @The reason given if any
function LuaGameScript.kick_player(PlayerSpecification, reason) end

---Bans the given player from this multiplayer game. Does nothing if this is a single player game of if the player running this isn't an admin.
---@param PlayerSpecification PlayerSpecification @The player to ban
---@param reason LocalisedString @The reason given if any
function LuaGameScript.ban_player(PlayerSpecification, reason) end

---Unbans the given player from this multiplayer game. Does nothing if this is a single player game of if the player running this isn't an admin.
---@param PlayerSpecification PlayerSpecification @The player to unban
function LuaGameScript.unban_player(PlayerSpecification) end

---Purges the given players messages from the game. Does nothing if the player running this isn't an admin.
---@param PlayerSpecification PlayerSpecification @The player to purge
function LuaGameScript.purge_player(PlayerSpecification) end

---Mutes the given player. Does nothing if the player running this isn't an admin.
---@param PlayerSpecification PlayerSpecification @The player to mute
function LuaGameScript.mute_player(PlayerSpecification) end

---Unmutes the given player. Does nothing if the player running this isn't an admin.
---@param PlayerSpecification PlayerSpecification @The player to unmute
function LuaGameScript.unmute_player(PlayerSpecification) end

---Counts how many distinct groups of pipes exist in the world.
function LuaGameScript.count_pipe_groups() end

---Is the map loaded is multiplayer?
---@return boolean @
function LuaGameScript.is_multiplayer() end

---Gets the number of entities that are active (updated each tick).
---@param surface SurfaceSpecification @If give, only the entities active on this surface are counted
---@return uint @
function LuaGameScript.get_active_entities_count(surface) end

---Gets the map exchange string for the map generation settings that were used to create this map.
---@return string @
function LuaGameScript.get_map_exchange_string() end

---Convert a map exchange string to map gen settings and map settings.
---@param map_exchange_string string @
---@return MapExchangeStringData @
function LuaGameScript.parse_map_exchange_string(map_exchange_string) end

---Gets train stops matching the given filters.
---@param opts string | string[] | string @Table with the following fields: name :: string or array of string  (optional)surface :: SurfaceSpecification  (optional)force :: ForceSpecification  (optional
---@return array of LuaEntity @
function LuaGameScript.get_train_stops(opts) end

---Gets the given player or returns nil if no player is found.
---@param player uint | string @The player index or name
---@return LuaPlayer @
function LuaGameScript.get_player(player) end

---Gets the given surface or returns nil if no surface is found.
---@param surface uint | string @The surface index or name
---@return LuaSurface @
function LuaGameScript.get_surface(surface) end

---Creates a LuaProfiler, which is used for measuring script performance.
---@param stopped boolean @Create the timer stoppe
---@return LuaProfiler @
function LuaGameScript.create_profiler(stopped) end

---Evaluate an expression, substituting variables as provided. For details on the formula, see the relevant page on the  Factorio wiki.
---@param expression string @The expression to evaluate
---@param variables table<string, double> @Variables to be substituted
---@return double @
function LuaGameScript.evaluate_expression(expression, variables) end

---
---@param filters EntityPrototypeFilters @
---@return CustomDictionary string → LuaEntityPrototype @
function LuaGameScript.get_filtered_entity_prototypes(filters) end

---
---@param filters ItemPrototypeFilters @
---@return CustomDictionary string → LuaItemPrototype @
function LuaGameScript.get_filtered_item_prototypes(filters) end

---
---@param filters EquipmentPrototypeFilters @
---@return CustomDictionary string → LuaEquipmentPrototype @
function LuaGameScript.get_filtered_equipment_prototypes(filters) end

---
---@param filters ModSettingPrototypeFilters @
---@return CustomDictionary string → LuaModSettingPrototype @
function LuaGameScript.get_filtered_mod_setting_prototypes(filters) end

---
---@param filters AchievementPrototypeFilters @
---@return CustomDictionary string → LuaAchievementPrototype @
function LuaGameScript.get_filtered_achievement_prototypes(filters) end

---
---@param filters TilePrototypeFilters @
---@return CustomDictionary string → LuaTilePrototype @
function LuaGameScript.get_filtered_tile_prototypes(filters) end

---
---@param filters DecorativePrototypeFilters @
---@return CustomDictionary string → LuaDecorativePrototype @
function LuaGameScript.get_filtered_decorative_prototypes(filters) end

---
---@param filters FluidPrototypeFilters @
---@return CustomDictionary string → LuaFluidPrototype @
function LuaGameScript.get_filtered_fluid_prototypes(filters) end

---
---@param filters RecipePrototypeFilters @
---@return CustomDictionary string → LuaRecipePrototype @
function LuaGameScript.get_filtered_recipe_prototypes(filters) end

---
---@param filters TechnologyPrototypeFilters @
---@return CustomDictionary string → LuaTechnologyPrototype @
function LuaGameScript.get_filtered_technology_prototypes(filters) end

---Creates an inventory that is not owned by any game object. It can be resized later with LuaInventory::resize.
---@param size uint16 @The number of slots the inventory initially has
---@return LuaInventory @
function LuaGameScript.create_inventory(size) end

---Gets the inventories created through LuaGameScript::create_inventory
---@param mod string @The mod who's inventories to get. If not provided all inventories are returned
---@return dictionary string → array of LuaInventory @
function LuaGameScript.get_script_inventories(mod) end

---Resets the amount of time played for this map.
function LuaGameScript.reset_time_played() end

---Deflates and base64 encodes the given string.
---@param string string @The string to encode
---@return string @
function LuaGameScript.encode_string(string) end

---Base64 decodes and inflates the given string.
---@param string string @The string to decode
---@return string @
function LuaGameScript.decode_string(string) end

---@class LuaGroup 
---@field name string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] Localised name of the group.
---@field type string @ [Read-only] 
---@field group LuaGroup @ [Read-only] 
---@field subgroups LuaGroup[] @ [Read-only] 
---@field order_in_recipe string @ [Read-only] 
---@field order string @ [Read-only] 

---@class LuaGui Returns true if sprite_path is valid and contains loaded sprite, otherwise false. Sprite path of type file doesn't validate if file exists.
---@field player LuaPlayer @ [Read-only] 
---@field children table<string, LuaGuiElement> @ [Read-only] The children GUI elements mapped by name <> element.
---@field top LuaGuiElement @ [Read-only] 
---@field left LuaGuiElement @ [Read-only] 
---@field center LuaGuiElement @ [Read-only] 
---@field goal LuaGuiElement @ [Read-only] 
---@field screen LuaGuiElement @ [Read-only] 

---Returns true if sprite_path is valid and contains loaded sprite, otherwise false. Sprite path of type file doesn't validate if file exists.
---@param sprite_path SpritePath @Path to a image
---@return boolean @
function LuaGui.is_valid_sprite_path(sprite_path) end

---@class LuaGuiElement Add a child element.
---@field add LuaGuiElement @(optional) undefined Add a child element.
---@field index uint @ [Read-only] The unique index of this GUI element.
---@field gui LuaGui @ [Read-only] 
---@field parent LuaGuiElement @ [Read-only] 
---@field name string @ [Read-only] 
---@field caption LocalisedString @ [Read-Write] 
---@field value double @ [Read-Write] 
---@field direction string @ [Read-only] 
---@field style LuaStyle | string @ [Read-Write] 
---@field visible boolean @ [Read-Write] When not visible the GUI element is hidden completely and takes no space in the layout.
---@field text string @ [Read-Write] 
---@field children_names string[] @ [Read-only] 
---@field state boolean @ [Read-Write] 
---@field player_index uint @ [Read-only] 
---@field sprite SpritePath @ [Read-Write] The image to display on this sprite-button or sprite in the default state.
---@field resize_to_sprite boolean @ [Read-Write] Whether should the image widget resize its size according to the sprite in it (true by default)
---@field hovered_sprite SpritePath @ [Read-Write] 
---@field clicked_sprite SpritePath @ [Read-Write] 
---@field tooltip LocalisedString @ [Read-Write] 
---@field horizontal_scroll_policy string @ [Read-Write] Policy of the horizontal scroll bar, possible values are "auto" (default), "never", "always", "auto-and-reserve-space".
---@field vertical_scroll_policy string @ [Read-Write] Policy of the vertical scroll bar, possible values are "auto" (default), "never", "always", "auto-and-reserve-space".
---@field type string @ [Read-only] The type of this GUI element.
---@field children LuaGuiElement[] @ [Read-only] The children elements
---@field items LocalisedString[] @ [Read-Write] The items in this dropdown or listbox.
---@field selected_index uint @ [Read-Write] The selected index for this dropdown or listbox. 0 if none.
---@field number double @ [Read-Write] The number to be shown in the right-bottom corner of the sprite-button, or nil to show nothing.
---@field show_percent_for_small_numbers boolean @ [Read-Write] Related to the number to be shown in the right-bottom corner of the sprite-button. When set to true, numbers that are not 0 and smaller than one are shown as percent rather than the value, so for example 0.5 is shown as 50% instead.
---@field location GuiLocation @ [Read-Write] The location of this widget when stored in LuaGui::screen or nil if not not set or not in LuaGui::screen.
---@field auto_center boolean @ [Read-Write] If this frame auto-centers on window resize when stored in LuaGui::screen.
---@field badge_text LocalisedString @ [Read-Write] The text to display after the normal tab text (designed to work with numbers)
---@field position Position @ [Read-Write] The position this camera or minimap is focused on if any.
---@field surface_index uint @ [Read-Write] The surface index this camera or minimap is using.
---@field zoom double @ [Read-Write] The zoom this camera or minimap is using.
---@field minimap_player_index uint @ [Read-Write] The player index this minimap is using.
---@field force string @ [Read-Write] The force this minimap is using or nil if no force is set.
---@field elem_type string @ [Read-only] The elem type of this choose-elem-button.
---@field elem_value string | SignalID @ [Read-Write] The elem value of this choose-elem-button or nil if there is no value.
---@field elem_filters PrototypeFilters @ [Read-Write] The elem filters of this choose-elem-button or nil if there are no filters.
---@field selectable boolean @ [Read-Write] If the contents of this text-box are selectable.
---@field word_wrap boolean @ [Read-Write] If this text-box will word-wrap automatically.
---@field read_only boolean @ [Read-Write] If this text-box is read-only.
---@field enabled boolean @ [Read-Write] If this GUI element is enabled.
---@field ignored_by_interaction boolean @ [Read-Write] If this GUI element is ignored by interaction. This means, that for example, label on a button can't steal the focus or click events of the button.
---@field locked boolean @ [Read-Write] If this choose-elem-button can be changed by the player.
---@field draw_vertical_lines boolean @ [Read-Write] If this table should draw vertical grid lines.
---@field draw_horizontal_lines boolean @ [Read-Write] If this table should draw horizontal grid lines.
---@field draw_horizontal_line_after_headers boolean @ [Read-Write] If this table should draw a horizontal grid line after the headers.
---@field column_count uint @ [Read-only] The number of columns in this table.
---@field vertical_centering boolean @ [Read-Write] Whether the fields of this table should be vertically centered. This true by default and overrides LuaStyle::column_alignments.
---@field slider_value double @ [Read-Write] The value of this slider element.
---@field mouse_button_filter MouseButtonFlags @ [Read-Write] The mouse button filters for this button or sprite-button.
---@field numeric boolean @ [Read-Write] If this text field only accepts numbers.
---@field allow_decimal boolean @ [Read-Write] If this text field (when in numeric mode) allows decimal numbers.
---@field allow_negative boolean @ [Read-Write] If this text field (when in numeric mode) allows negative numbers.
---@field is_password boolean @ [Read-Write] If this text field displays as a password field (renders all characters as '*').
---@field lose_focus_on_confirm boolean @ [Read-Write] If this text field loses focus after defines.events.on_gui_confirmed is fired.
---@field clear_and_focus_on_right_click boolean @ [Read-Write] 
---@field drag_target LuaGuiElement @ [Read-Write] The frame drag target for this flow, frame, label, table, or empty-widget.
---@field selected_tab_index uint @ [Read-Write] The selected tab index or nil if no tab is selected.
---@field tabs object[] @ [Read-only] The tabs and contents being shown in this tabbed-pane.
---@field entity LuaEntity @ [Read-Write] The entity associated with this entity-preview or nil if no entity is associated.
---@field switch_state string @ [Read-Write] The switch state (left, none, right) for this switch.
---@field allow_none_state boolean @ [Read-Write] If the 'none' state is allowed for this switch.
---@field left_label_caption LocalisedString @ [Read-Write] The text shown for the left switch label.
---@field left_label_tooltip LocalisedString @ [Read-Write] The text shown for the left switch tooltip.
---@field right_label_caption LocalisedString @ [Read-Write] The text shown for the right switch label.
---@field right_label_tooltip LocalisedString @ [Read-Write] The text shown for the right switch tooltip.
---@field bracket_operator LuaGuiElement @ [Read-only] The indexing operator. Gets children by name.

---Remove children of this element. Any LuaGuiElement objects referring to the destroyed elements become invalid after this operation.
function LuaGuiElement.clear() end

---Remove this element, along with its children. Any LuaGuiElement objects referring to the destroyed elements become invalid after this operation.
function LuaGuiElement.destroy() end

---The mod that owns this Gui element or nil if it's owned by the scenario script.
---@return string @
function LuaGuiElement.get_mod() end

---Clears the items in this dropdown or listbox.
function LuaGuiElement.clear_items() end

---Gets an item at the given index from this dropdown or listbox.
---@param index uint @The index to get
---@return LocalisedString @
function LuaGuiElement.get_item(index) end

---Sets an item at the given index in this dropdown or listbox.
---@param index uint @The inde
---@param LocalisedString LocalisedString @The item
function LuaGuiElement.set_item(index, LocalisedString) end

---Adds an item at the end or at the given index in this dropdown or listbox.
---@param LocalisedString LocalisedString @The item
---@param index uint @The inde
function LuaGuiElement.add_item(LocalisedString, index) end

---Removes an item at the given index in this dropdown or listbox.
---@param index uint @The inde
function LuaGuiElement.remove_item(index) end

---Gets this sliders minimum value.
---@return double @
function LuaGuiElement.get_slider_minimum() end

---Gets this sliders maximum value.
---@return double @
function LuaGuiElement.get_slider_maximum() end

---Sets this sliders minimum and maximum values.
---@param minimum double @
---@param maximum double @
function LuaGuiElement.set_slider_minimum_maximum(minimum, maximum) end

---Gets the minimum distance the slider can move.
---@return double @
function LuaGuiElement.get_slider_value_step() end

---Gets if the slider only allows being moved to discrete positions.
---@return boolean @
function LuaGuiElement.get_slider_discrete_slider() end

---Gets if the slider only allows being having discrete values.
---@return boolean @
function LuaGuiElement.get_slider_discrete_values() end

---The minimum distance the slider can move.
---@param value double @
function LuaGuiElement.set_slider_value_step(value) end

---Sets if the slider only allows being moved to discrete positions.
---@param value boolean @
function LuaGuiElement.set_slider_discrete_slider(value) end

---Sets if the slider only allows being having discrete values.
---@param value boolean @
function LuaGuiElement.set_slider_discrete_values(value) end

---Focuses this GUI element if possible.
function LuaGuiElement.focus() end

---Scrolls the scroll bar to the top.
function LuaGuiElement.scroll_to_top() end

---Scrolls the scroll bar to the bottom.
function LuaGuiElement.scroll_to_bottom() end

---Scrolls the scroll bar to the left.
function LuaGuiElement.scroll_to_left() end

---Scrolls the scroll bar to the right.
function LuaGuiElement.scroll_to_right() end

---Scrolls the scroll bar such that the specified GUI element is visible to the player.
---@param element LuaGuiElement @The element to scroll to
---@param scroll_mode string @Where the element should be positioned in the scroll-pane. Must be either: "in-view", or "top-third". Defaults to "in-view"
function LuaGuiElement.scroll_to_element(element, scroll_mode) end

---Select all text in the text box.
function LuaGuiElement.select_all() end

---Select a range of text in the text box.
---@param start int @The index of the first character to select
---@param _end int @The index of the last character to select
function LuaGuiElement.select(start, _end) end

---Adds the given tab and content widgets to this tabbed pane as a new tab.
---@param tab LuaGuiElement @The tab to add, must be a GUI element of type "tab"
---@param content LuaGuiElement @The content to show when this tab is selected. Can be any type of GUI element
function LuaGuiElement.add_tab(tab, content) end

---Removes the given tab and what ever it's associated content is from this tabbed pane.
---@param tab LuaGuiElement @The tab to remove. If nil all tabs are removed
function LuaGuiElement.remove_tab(tab) end

---Forces this frame to re-auto-center. Only works on frames stored directly in LuaGui::screen.
function LuaGuiElement.force_auto_center() end

---Scrolls the scroll bar such that the specified listbox item is visible to the player.
---@param index int @The item index to scroll to
---@param scroll_mode string @Where the item should be positioned in the scroll-pane. Must be either: "in-view", or "top-third". Defaults to "in-view"
function LuaGuiElement.scroll_to_item(index, scroll_mode) end

---@class LuaHeatEnergySourcePrototype 
---@field emissions double @ [Read-only] 
---@field render_no_network_icon boolean @ [Read-only] 
---@field render_no_power_icon boolean @ [Read-only] 
---@field max_temperature double @ [Read-only] 
---@field default_temperature double @ [Read-only] 
---@field specific_heat double @ [Read-only] 
---@field max_transfer double @ [Read-only] 
---@field min_temperature_gradient double @ [Read-only] 
---@field min_working_temperature double @ [Read-only] 
---@field minimum_glow_temperature double @ [Read-only] 
---@field connections object[] @ [Read-only] 

---@class LuaInventory Make this inventory empty.
---@field hash_operator uint @ [Read-only] Get the number of slots in this inventory.
---@field index defines.inventory @ [Read-only] 
---@field entity_owner LuaEntity @ [Read-only] 
---@field player_owner LuaPlayer @ [Read-only] 
---@field equipment_owner LuaEntity @ [Read-only] 
---@field mod_owner string @ [Read-only] 
---@field bracket_operator LuaItemStack @ [Read-only] The indexing operator.

---Make this inventory empty.
function LuaInventory.clear() end

---Can at least some items be inserted?
---@param items ItemStackSpecification @Items that would be inserted
---@return boolean @
function LuaInventory.can_insert(items) end

---Insert items into this inventory.
---@param items ItemStackSpecification @Items to insert
---@return uint @
function LuaInventory.insert(items) end

---Remove items from this inventory.
---@param items ItemStackSpecification @Items to remove
---@return uint @
function LuaInventory.remove(items) end

---Get the number of all or some items in this inventory.
---@param item string @Prototype name of the item to count. If not specified, count all items
---@return uint @
function LuaInventory.get_item_count(item) end

---Does this inventory contain nothing?
---@return boolean @
function LuaInventory.is_empty() end

---Get counts of all items in this inventory.
---@return dictionary string → uint @
function LuaInventory.get_contents() end

---Does this inventory support a bar? Bar is the draggable red thing, found for example on chests, that limits the portion of the inventory that may be manipulated by machines.
---@return boolean @
function LuaInventory.supports_bar() end

---Get the current bar. This is the index at which the red area starts.
---@return uint @
function LuaInventory.get_bar() end

---Set the current bar.
---@param bar uint @The new limit. Omitting this parameter will clear the limit
function LuaInventory.set_bar(bar) end

---If this inventory supports filters.
---@return boolean @
function LuaInventory.supports_filters() end

---If this inventory supports filters and has at least 1 filter set.
---@return boolean @
function LuaInventory.is_filtered() end

---If the given inventory slot filter can be set to the given filter.
---@param index uint @The item stack inde
---@param filter string @The item name of the filte
---@return boolean @
function LuaInventory.can_set_filter(index, filter) end

---Gets the filter for the given item stack index.
---@param index uint @The item stack inde
---@return string @
function LuaInventory.get_filter(index) end

---Sets the filter for the given item stack index.
---@param index uint @The item stack inde
---@param filter string @The new filter or nil to erase the filte
---@return boolean @
function LuaInventory.set_filter(index, filter) end

---Gets the first LuaItemStack in the inventory that matches the given item name.
---@param item string @The item name to fin
---@return LuaItemStack @
function LuaInventory.find_item_stack(item) end

---Finds the first empty stack. Filtered slots are excluded unless a filter item is given.
---@param item string @If given, empty stacks that are filtered for this item will be included
---@return LuaItemStack @
function LuaInventory.find_empty_stack(item) end

---Counts the number of empty stacks.
---@param include_filtered boolean @If true, filtered slots will be included. Defaults to false
---@return uint @
function LuaInventory.count_empty_stacks(include_filtered) end

---Gets the number of the given item that can be inserted into this inventory.
---@param item string @The item to check
function LuaInventory.get_insertable_count(item) end

---Sorts and merges the items in this inventory.
function LuaInventory.sort_and_merge() end

---Resizes the inventory.
---@param size uint16 @New size of a inventor
function LuaInventory.resize(size) end

---Destroys this inventory.
function LuaInventory.destroy() end

---@class LuaItemPrototype Does this prototype have a flag enabled?
---@field type string @ [Read-only] 
---@field name string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field order string @ [Read-only] 
---@field place_result LuaEntityPrototype @ [Read-only] 
---@field place_as_equipment_result LuaEquipmentPrototype @ [Read-only] 
---@field place_as_tile_result PlaceAsTileResult @ [Read-only] The place as tile result if one is defined else nil.
---@field stackable boolean @ [Read-only] 
---@field default_request_amount uint @ [Read-only] 
---@field stack_size uint @ [Read-only] 
---@field wire_count uint @ [Read-only] 
---@field fuel_category string @ [Read-only] 
---@field burnt_result LuaItemPrototype @ [Read-only] 
---@field fuel_value float @ [Read-only] 
---@field fuel_acceleration_multiplier double @ [Read-only] 
---@field fuel_top_speed_multiplier double @ [Read-only] 
---@field fuel_emissions_multiplier double @ [Read-only] 
---@field subgroup LuaGroup @ [Read-only] 
---@field group LuaGroup @ [Read-only] 
---@field flags table<string, boolean> @ [Read-only] The item prototype flags for this item prototype. It is a dictionary where the keys are the set flags and the value is always true -- if a flag is unset, it isn't present in the dictionary at all.
---@field rocket_launch_products Product[] @ [Read-only] The results from launching this item in a rocket.
---@field can_be_mod_opened boolean @ [Read-only] If this item can be mod-opened.
---@field magazine_size float @ [Read-only] 
---@field reload_time float @ [Read-only] 
---@field equipment_grid LuaEquipmentGridPrototype @ [Read-only] The prototype of this armor equipment grid or nil if none or this is not an armor item.
---@field resistances Resistances @ [Read-only] 
---@field inventory_size_bonus uint @ [Read-only] The inventory size bonus for this armor prototype. nil if this isn't an armor prototype.
---@field capsule_action CapsuleAction @ [Read-only] The capsule action for this capsule item prototype or nil if this isn't a capsule item prototype.
---@field attack_parameters AttackParameters @ [Read-only] The gun attack parameters or nil if not a gun item prototype.
---@field inventory_size uint @ [Read-only] The main inventory size for item-with-inventory-prototype. nil if not an item-with-inventory-prototype.
---@field item_filters table<string, LuaItemPrototype> @ [Read-only] 
---@field item_group_filters table<string, LuaGroup> @ [Read-only] 
---@field item_subgroup_filters table<string, LuaGroup> @ [Read-only] 
---@field filter_mode string @ [Read-only] The filter mode used by this item with inventory.
---@field insertion_priority_mode string @ [Read-only] The insertion priority mode used by this item with inventory.
---@field localised_filter_message LocalisedString @ [Read-only] The localised string used when the player attempts to put items into this item with inventory that aren't allowed.
---@field extend_inventory_by_default boolean @ [Read-only] If this item with inventory extends the inventory it resides in by default.
---@field default_label_color Color @ [Read-only] The default label color used for this item with label. nil if not defined or if this isn't an item with label.
---@field draw_label_for_cursor_render boolean @ [Read-only] If true, and this item with label has a label it is drawn in place of the normal number when held in the cursor.
---@field speed float @ [Read-only] 
---@field module_effects Effects @ [Read-only] Effects of this module; nil if this is not a module. It is a dictionary indexed by the effect type.
---@field category string @ [Read-only] The name of a LuaModuleCategoryPrototype. Used when upgrading modules: Ctrl + click modules into an entity and it will replace lower tier modules of the same category with higher tier modules.
---@field tier uint @ [Read-only] Tier of the module inside its category. Used when upgrading modules: Ctrl + click modules into an entity and it will replace lower tier modules with higher tier modules if they have the same category.
---@field limitations string[] @ [Read-only] An array of recipe names this module is allowed to work with.
---@field limitation_message_key string @ [Read-only] The limitation message key used when the player attempts to use this modules in some place it's not allowed.
---@field straight_rail LuaEntityPrototype @ [Read-only] The straight rail prototype used for this rail planner prototype.
---@field curved_rail LuaEntityPrototype @ [Read-only] The curved rail prototype used for this rail planner prototype.
---@field repair_result Trigger @ [Read-only] The repair result of this repair tool prototype or nil if this isn't a repair tool prototype.
---@field selection_border_color Color @ [Read-only] The color used when doing normal selection with this selection tool prototype.
---@field alt_selection_border_color Color @ [Read-only] The color used when doing alt selection with this selection tool prototype.
---@field selection_mode_flags SelectionModeFlags @ [Read-only] 
---@field alt_selection_mode_flags SelectionModeFlags @ [Read-only] 
---@field selection_cursor_box_type string @ [Read-only] 
---@field alt_selection_cursor_box_type string @ [Read-only] 
---@field always_include_tiles boolean @ [Read-only] If tiles area always included when doing selection with this selection tool prototype.
---@field show_in_library boolean @ [Read-only] Is this selection tool prototype available in the blueprint library. nil if not selection tool or blueprint book.
---@field entity_filter_mode string @ [Read-only] The entity filter mode used by this selection tool.
---@field alt_entity_filter_mode string @ [Read-only] The alt entity filter mode used by this selection tool.
---@field tile_filter_mode string @ [Read-only] The tile filter mode used by this selection tool.
---@field alt_tile_filter_mode string @ [Read-only] The alt tile filter mode used by this selection tool.
---@field entity_filters table<string, LuaEntityPrototype> @ [Read-only] The entity filters used by this selection tool indexed by entity name.
---@field alt_entity_filters table<string, LuaEntityPrototype> @ [Read-only] The alt entity filters used by this selection tool indexed by entity name.
---@field entity_type_filters table<string, boolean> @ [Read-only] The entity type filters used by this selection tool indexed by entity type.
---@field alt_entity_type_filters table<string, boolean> @ [Read-only] The alt entity type filters used by this selection tool indexed by entity type.
---@field tile_filters table<string, LuaTilePrototype> @ [Read-only] The tile filters used by this selection tool indexed by tile name.
---@field alt_tile_filters table<string, LuaTilePrototype> @ [Read-only] The alt tile filters used by this selection tool indexed by tile name.
---@field entity_filter_slots uint @ [Read-only] The number of entity filters this deconstruction item has or nil if this isn't a deconstruction item prototype.
---@field tile_filter_slots uint @ [Read-only] The number of tile filters this deconstruction item has or nil if this isn't a deconstruction item prototype.
---@field durability_description_key string @ [Read-only] The durability message key used when displaying the durability of this tool.
---@field durability double @ [Read-only] The durability of this tool item or nil if not a tool item.
---@field infinite boolean @ [Read-only] If this tool item has infinite durability. nil if not a tool type item.
---@field mapper_count uint @ [Read-only] How many filters an upgrade item has. nil if not a upgrade item.

---Does this prototype have a flag enabled?
---@param flag string @The flag to check. Can be "hidden", "hide-from-bonus-gui", or "hide-from-fuel-tooltip"
---@return boolean @
function LuaItemPrototype.has_flag(flag) end

---Type of this ammo prototype or nil if this is not an ammo prototype.
---@param ammo_source_type string @"default", "player", "turret", or "vehicle
---@return AmmoType @
function LuaItemPrototype.get_ammo_type(ammo_source_type) end

---@class LuaItemStack Is this blueprint item setup? I.e. is it a non-empty blueprint?
---@field build_blueprint array of LuaEntity @(optional) undefined Build this blueprint
---@field deconstruct_area nil @(optional) undefined Deconstruct the given area with this deconstruction item.
---@field cancel_deconstruct_area nil @(optional) undefined Cancel deconstruct the given area with this deconstruction item.
---@field create_blueprint dictionary uint → LuaEntity @(optional) undefined Sets up this blueprint using the found blueprintable entities/tiles on the surface.
---@field valid_for_read boolean @ [Read-only] 
---@field prototype LuaItemPrototype @ [Read-only] 
---@field name string @ [Read-only] 
---@field type string @ [Read-only] 
---@field count uint @ [Read-Write] 
---@field grid LuaEquipmentGrid @ [Read-only] 
---@field health float @ [Read-Write] 
---@field durability double @ [Read-Write] 
---@field ammo uint @ [Read-Write] 
---@field blueprint_icons object[] @ [Read-Write] 
---@field label string @ [Read-Write] 
---@field label_color Color @ [Read-Write] 
---@field allow_manual_label_change boolean @ [Read-Write] 
---@field cost_to_build table<string, uint> @ [Read-only] 
---@field extends_inventory boolean @ [Read-Write] 
---@field prioritize_insertion_mode string @ [Read-Write] 
---@field default_icons object[] @ [Read-only] 
---@field tags Tags @ [Read-Write] 
---@field custom_description LocalisedString @ [Read-Write] The custom description this item-with-tags. This is shown over the normal item description if this is set to a non-empty value.
---@field entity_filters string[] @ [Read-Write] The entity filters for this deconstruction item.
---@field tile_filters string[] @ [Read-Write] The tile filters for this deconstruction item.
---@field entity_filter_mode defines.deconstruction_item.entity_filter_mode @ [Read-Write] The blacklist/whitelist entity filter mode for this deconstruction item.
---@field tile_filter_mode defines.deconstruction_item.tile_filter_mode @ [Read-Write] The blacklist/whitelist tile filter mode for this deconstruction item.
---@field tile_selection_mode defines.deconstruction_item.tile_selection_mode @ [Read-Write] The tile selection mode for this deconstruction item.
---@field trees_and_rocks_only boolean @ [Read-Write] If this deconstruction item is set to allow trees and rocks only.
---@field entity_filter_count uint @ [Read-only] The number of entity filters this deconstruction item supports.
---@field tile_filter_count uint @ [Read-only] The number of tile filters this deconstruction item supports.
---@field active_index uint @ [Read-Write] The active blueprint index for this blueprint book.
---@field item_number uint @ [Read-only] The unique ID for this item if it has a unique ID or nil. The following item types have unique IDs:
---@field is_blueprint boolean @ [Read-only] If this is a blueprint item.
---@field is_blueprint_book boolean @ [Read-only] If this is a blueprint book item.
---@field is_module boolean @ [Read-only] If this is a module item.
---@field is_tool boolean @ [Read-only] If this is a tool item.
---@field is_mining_tool boolean @ [Read-only] If this is a mining tool item.
---@field is_armor boolean @ [Read-only] If this is an armor item.
---@field is_repair_tool boolean @ [Read-only] If this is a repair tool item.
---@field is_item_with_label boolean @ [Read-only] If this is an item with label item.
---@field is_item_with_inventory boolean @ [Read-only] If this is an item with inventory item.
---@field is_item_with_entity_data boolean @ [Read-only] If this is an item with entity data item.
---@field is_selection_tool boolean @ [Read-only] If this is a selection tool item.
---@field is_item_with_tags boolean @ [Read-only] If this is an item with tags item.
---@field is_deconstruction_item boolean @ [Read-only] If this is a deconstruction tool item.
---@field is_upgrade_item boolean @ [Read-only] If this is a upgrade item.

---Is this blueprint item setup? I.e. is it a non-empty blueprint?
---@return boolean @
function LuaItemStack.is_blueprint_setup() end

---Entities in this blueprint.
---@return array of blueprint entity @
function LuaItemStack.get_blueprint_entities() end

---Set new entities to be a part of this blueprint.
---@param entities object[] @New blueprint entities. The format is the same as in   LuaItemStack::get_blueprint_entities
function LuaItemStack.set_blueprint_entities(entities) end

---Add ammo to this ammo item.
---@param amount float @Amount of ammo to add
function LuaItemStack.add_ammo(amount) end

---Remove ammo from this ammo item.
---@param amount float @Amount of ammo to remove
function LuaItemStack.drain_ammo(amount) end

---Add durability to this tool item.
---@param amount double @Amount of durability to add
function LuaItemStack.add_durability(amount) end

---Remove durability from this tool item.
---@param amount double @Amount of durability to remove
function LuaItemStack.drain_durability(amount) end

---Would a call to LuaItemStack::set_stack succeed?
---@param stack ItemStackSpecification @Stack that would be set, possibly nil
---@return boolean @
function LuaItemStack.can_set_stack(stack) end

---Set this item stack to another item stack.
---@param stack ItemStackSpecification @
---@return boolean @
function LuaItemStack.set_stack(stack) end

---Transfers the given item stack into this item stack.
---@param stack ItemStackSpecification @
---@return boolean @
function LuaItemStack.transfer_stack(stack) end

---Export a supported item (blueprint, blueprint-book, deconstruction-planner, upgrade-planner, item-with-tags) to a string
---@return string @
function LuaItemStack.export_stack() end

---Import a supported item (blueprint, blueprint-book, deconstruction-planner, upgrade-planner, item-with-tags) from a string
---@param data string @The string to impor
---@return int @
function LuaItemStack.import_stack(data) end

---Swaps this item stack with the given item stack if allowed.
---@param stack LuaItemStack @
---@return boolean @
function LuaItemStack.swap_stack(stack) end

---Clear this item stack.
function LuaItemStack.clear() end

---Tiles in this blueprint
---@return array of blueprint tile @
function LuaItemStack.get_blueprint_tiles() end

---Set tiles in this blueprint
---@param tiles object[] @Tiles to be a part of the blueprint; the format is the same as is   returned from the corresponding get function; see LuaItemStack::get_blueprint_tiles
function LuaItemStack.set_blueprint_tiles(tiles) end

---Access the inner inventory of an item.
---@param inventory defines.inventory @
---@return LuaInventory @
function LuaItemStack.get_inventory(inventory) end

---Gets the tag with the given name or returns nil if it doesn't exist.
---@param tag_name string @
---@return Any @
function LuaItemStack.get_tag(tag_name) end

---Sets the tag with the given name and value.
---@param tag_name string @
---@param tag Any @
---@return Any @
function LuaItemStack.set_tag(tag_name, tag) end

---Removes a tag with the given name.
---@param tag string @
---@return boolean @
function LuaItemStack.remove_tag(tag) end

---Clears this blueprint item.
function LuaItemStack.clear_blueprint() end

---Gets the entity filter at the given index for this deconstruction item.
---@param index uint @
---@return string @
function LuaItemStack.get_entity_filter(index) end

---Sets the entity filter at the given index for this deconstruction item.
---@param index uint @
---@param filter string | LuaEntityPrototype | LuaEntity @Setting to nil erases the filter
---@return boolean @
function LuaItemStack.set_entity_filter(index, filter) end

---Gets the tile filter at the given index for this deconstruction item.
---@param index uint @
---@return string @
function LuaItemStack.get_tile_filter(index) end

---Sets the tile filter at the given index for this deconstruction item.
---@param index uint @
---@param filter string | LuaTilePrototype | LuaTile @Setting to nil erases the filter
---@return boolean @
function LuaItemStack.set_tile_filter(index, filter) end

---Clears all settings/filters on this deconstruction item resetting it to default values.
function LuaItemStack.clear_deconstruction_item() end

---Clears all settings/filters on this upgrade item resetting it to default values.
function LuaItemStack.clear_upgrade_item() end

---Gets the filter at the given index for this upgrade item.
---@param index uint @The index of the mapper to read
---@param type string @'from' or 'to'
---@return UpgradeFilter @
function LuaItemStack.get_mapper(index, type) end

---Sets the module filter at the given index for this upgrade item.
---@param index uint @The index of the mapper to set
---@param type string @from or to
---@param filter UpgradeFilter @The filter to set or ni
function LuaItemStack.set_mapper(index, type, filter) end

---Gets the number of entities in this blueprint item.
---@return uint @
function LuaItemStack.get_blueprint_entity_count() end

---Gets the tags for the given blueprint entity index in this blueprint item.
---@param index uint @
---@return Tags @
function LuaItemStack.get_blueprint_entity_tags(index) end

---Sets the tags on the given blueprint entity index in this blueprint item.
---@param index uint @The entity inde
---@param tags Tags @
function LuaItemStack.set_blueprint_entity_tags(index, tags) end

---Gets the given tag on the given blueprint entity index in this blueprint item.
---@param index uint @The entity inde
---@param tag string @The tag to ge
---@return Any @
function LuaItemStack.get_blueprint_entity_tag(index, tag) end

---Sets the given tag on the given blueprint entity index in this blueprint item.
---@param index uint @The entity inde
---@param tag string @The tag to se
---@param value Any @The tag value to set or nil to clear the ta
function LuaItemStack.set_blueprint_entity_tag(index, tag, value) end

---@class LuaLazyLoadedValue Gets the value of this lazy loaded value.

---Gets the value of this lazy loaded value.
---@return varies @
function LuaLazyLoadedValue.get() end

---@class LuaLogisticCell Is a given position within the logistic range of this cell?
---@field logistic_radius float @ [Read-only] 
---@field logistics_connection_distance float @ [Read-only] 
---@field construction_radius float @ [Read-only] 
---@field stationed_logistic_robot_count uint @ [Read-only] 
---@field stationed_construction_robot_count uint @ [Read-only] 
---@field mobile boolean @ [Read-only] 
---@field transmitting boolean @ [Read-only] 
---@field charge_approach_distance float @ [Read-only] 
---@field charging_robot_count uint @ [Read-only] 
---@field to_charge_robot_count uint @ [Read-only] 
---@field owner LuaEntity @ [Read-only] 
---@field logistic_network LuaLogisticNetwork @ [Read-only] 
---@field neighbours LuaLogisticCell[] @ [Read-only] 
---@field charging_robots LuaEntity[] @ [Read-only] 
---@field to_charge_robots LuaEntity[] @ [Read-only] 

---Is a given position within the logistic range of this cell?
---@param position Position @
---@return boolean @
function LuaLogisticCell.is_in_logistic_range(position) end

---Is a given position within the construction range of this cell?
---@param position Position @
---@return boolean @
function LuaLogisticCell.is_in_construction_range(position) end

---Are two cells neighbours?
---@param other LuaLogisticCell @
---@return boolean @
function LuaLogisticCell.is_neighbour_with(other) end

---@class LuaLogisticNetwork Count given or all items in the network or given members.
---@field select_pickup_point LuaLogisticPoint @(optional) undefined Find the 'best' logistic point with this item ID and from the given position or from given chest type.
---@field select_drop_point LuaLogisticPoint @(optional) undefined Find a logistic point to drop the specific item stack.
---@field force LuaForce @ [Read-only] The force this logistic network belongs to.
---@field available_logistic_robots uint @ [Read-only] 
---@field all_logistic_robots uint @ [Read-only] 
---@field available_construction_robots uint @ [Read-only] 
---@field all_construction_robots uint @ [Read-only] 
---@field robot_limit uint @ [Read-only] 
---@field cells LuaLogisticCell[] @ [Read-only] 
---@field providers LuaEntity[] @ [Read-only] 
---@field empty_providers LuaEntity[] @ [Read-only] 
---@field requesters LuaEntity[] @ [Read-only] 
---@field storages LuaEntity[] @ [Read-only] 
---@field logistic_members LuaEntity[] @ [Read-only] 
---@field provider_points LuaLogisticPoint[] @ [Read-only] 
---@field passive_provider_points LuaLogisticPoint[] @ [Read-only] 
---@field active_provider_points LuaLogisticPoint[] @ [Read-only] 
---@field empty_provider_points LuaLogisticPoint[] @ [Read-only] 
---@field requester_points LuaLogisticPoint[] @ [Read-only] 
---@field storage_points LuaLogisticPoint[] @ [Read-only] 
---@field robots LuaEntity[] @ [Read-only] All robots in this logistic network.
---@field construction_robots LuaEntity[] @ [Read-only] All construction robots in this logistic network.
---@field logistic_robots LuaEntity[] @ [Read-only] All logistic robots in this logistic network.

---Count given or all items in the network or given members.
---@param item string @Item name to count. If not given, gives counts   of all items in the network
---@param member string @Logistic members to check, must be either "storage"   or "providers". If not given, gives count in the entire network
---@return int @
function LuaLogisticNetwork.get_item_count(item, member) end

---Get item counts for the entire network.
---@return dictionary string → uint @
function LuaLogisticNetwork.get_contents() end

---Remove items from the logistic network. This will actually remove the items from some logistic chests.
---@param item ItemStackSpecification @What to remove
---@param members string @Which logistic members to remove from. Must be   "storage", "passive-provider", "buffer", or "active-provider". If not specified, removes   from the network in the usual order
---@return uint @
function LuaLogisticNetwork.remove_item(item, members) end

---Insert items into the logistic network. This will actually insert the items into some logistic chests.
---@param item ItemStackSpecification @What to insert
---@param members string @Which logistic members to insert the items to. Must be   "storage", "storage-empty" (storage chests that are completely empty),   "storage-empty-slot" (storage chests that have an empty slot), or "requester". If not   specified, inserts items into the logistic network in the usual order
---@return uint @
function LuaLogisticNetwork.insert(item, members) end

---Find logistic cell closest to a given position.
---@param position Position @
---@return LuaLogisticCell @
function LuaLogisticNetwork.find_cell_closest_to(position) end

---@class LuaLogisticPoint The LuaEntity owner of this LuaLogisticPoint.
---@field owner LuaEntity @ [Read-only] The LuaEntity owner of this LuaLogisticPoint.
---@field logistic_network LuaLogisticNetwork @ [Read-only] 
---@field logistic_member_index uint @ [Read-only] The Logistic member index of this logistic point.
---@field filters LogisticFilter[] @ [Read-only] The logistic filters for this logistic point or nil if this doesn't use logistic filters.
---@field mode defines.logistic_mode @ [Read-only] The logistic mode.
---@field force LuaForce @ [Read-only] The force of this logistic point.
---@field targeted_items_pickup table<string, uint> @ [Read-only] Items targeted to be picked up from this logistic point by robots.
---@field targeted_items_deliver table<string, uint> @ [Read-only] Items targeted to be dropped off into this logistic point by robots.
---@field exact boolean @ [Read-only] If this logistic point is using the exact mode. In exact mode robots never over-deliver requests.

---@class LuaModSettingPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field mod string @ [Read-only] The mod that owns this setting.
---@field setting_type string @ [Read-only] 
---@field default_value boolean | double | int | string @ [Read-only] The default value of this setting.
---@field minimum_value double | int @ [Read-only] The minimum value for this setting or nil if  this setting type doesn't support a minimum.
---@field maximum_value double | int @ [Read-only] The maximum value for this setting or nil if  this setting type doesn't support a maximum.
---@field allowed_values string[] | string | int[] | int | double[] | double @ [Read-only] The allowed values for this setting or nil if this setting doesn't use the a fixed set of values.
---@field allow_blank boolean @ [Read-only] If this string setting allows blank values or nil if not a string setting.
---@field auto_trim boolean @ [Read-only] If this string setting auto-trims values or nil if not a string setting.
---@field hidden boolean @ [Read-only] If this setting is hidden from the GUI.

---@class LuaModuleCategoryPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 

---@class LuaNamedNoiseExpression 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field intended_property string @ [Read-only] 
---@field expression NoiseExpression @ [Read-only] 

---@class LuaNoiseLayerPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 

---@class LuaParticlePrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field regular_trigger_effect TriggerEffectItem @ [Read-only] 
---@field ended_in_water_trigger_effect TriggerEffectItem @ [Read-only] 
---@field render_layer RenderLayer @ [Read-only] 
---@field render_layer_when_on_ground RenderLayer @ [Read-only] 
---@field life_time uint @ [Read-only] 
---@field regular_trigger_effect_frequency uint @ [Read-only] 
---@field movement_modifier_when_on_ground float @ [Read-only] 
---@field movement_modifier float @ [Read-only] 
---@field mining_particle_frame_speed float @ [Read-only] 

---@class LuaPermissionGroup Adds the given player to this group.
---@field name string @ [Read-Write] The name of this group.
---@field players LuaPlayer[] @ [Read-only] The players in this group.
---@field group_id uint @ [Read-only] The group ID

---Adds the given player to this group.
---@param player PlayerSpecification @
---@return boolean @
function LuaPermissionGroup.add_player(player) end

---Removes the given player from this group.
---@param player PlayerSpecification @
---@return boolean @
function LuaPermissionGroup.remove_player(player) end

---If this group allows the given action.
---@param action action @The defines.input_action value
---@return boolean @
function LuaPermissionGroup.allows_action(action) end

---Sets if the player is allowed to perform the given action.
---@param action action @The defines.input_action value
---@return boolean @
function LuaPermissionGroup.set_allows_action(action) end

---Destroys this group.
---@return boolean @
function LuaPermissionGroup.destroy() end

---@class LuaPermissionGroups Creates a new permission group.
---@field groups LuaPermissionGroup[] @ [Read-only] All of the permission groups.

---Creates a new permission group.
---@param name string @
---@return LuaPermissionGroup @
function LuaPermissionGroups.create_group(name) end

---Gets the permission group with the given name or group ID or nil if there is no matching group.
---@param group string | uint @
---@return LuaPermissionGroup @
function LuaPermissionGroups.get_group(group) end

---@class LuaPlayer : LuaControl Setup the screen to be shown when the game is finished.
---@field set_controller nil @(optional) undefined Set the controller type of the player.
---@field remove_alert nil @(optional) undefined Removes all alerts matching the given filters or if an empty filters table is given all alerts are removed.
---@field get_alerts dictionary uint → dictionary defines.alert_type → array of alert @(optional) undefined Gets all alerts matching the given filters or if no filters are given all alerts are returned.
---@field can_place_entity boolean @(optional) undefined Checks if this player can build the give entity at the given location on the surface the player is on.
---@field can_build_from_cursor boolean @(optional) undefined Checks if this player can build what ever is in the cursor on the surface the player is on.
---@field build_from_cursor nil @(optional) undefined Builds what ever is in the cursor on the surface the player is on.
---@field play_sound boolean @(optional) undefined Plays a sound for this player
---@field create_local_flying_text nil @(optional) undefined Spawn a flying text that is only visible to this player.
---@field connect_to_server nil @(optional) undefined Asks the player if they would like to connect to the given server.
---@field character LuaEntity @ [Read-Write] 
---@field index uint @ [Read-only] 
---@field gui LuaGui @ [Read-only] 
---@field opened_self boolean @ [Read-only] 
---@field controller_type defines.controllers @ [Read-only] 
---@field stashed_controller_type defines.controllers @ [Read-only] The stashed controller type or nil if no controller is stashed.
---@field game_view_settings GameViewSettings @ [Read-Write] 
---@field minimap_enabled boolean @ [Read-Write] 
---@field color Color @ [Read-Write] 
---@field chat_color Color @ [Read-Write] 
---@field name string @ [Read-only] 
---@field tag string @ [Read-Write] 
---@field connected boolean @ [Read-only] 
---@field admin boolean @ [Read-Write] 
---@field entity_copy_source LuaEntity @ [Read-only] The source entity used during entity settings copy-paste if any.
---@field afk_time uint @ [Read-only] How many ticks since the last action of this player
---@field online_time uint @ [Read-only] How many ticks did this player spend playing this save (all sessions combined)
---@field last_online uint @ [Read-only] At what tick this player was last online.
---@field permission_group LuaPermissionGroup @ [Read-Write] The permission group this player is part of or nil if not part of any group.
---@field mod_settings CustomDictionary @ [Read-only] 
---@field ticks_to_respawn uint @ [Read-Write] The number of ticks until this player will respawn or nil if not waiting to respawn.
---@field display_resolution DisplayResolution @ [Read-only] The display resolution for this player.
---@field display_scale double @ [Read-only] The display scale for this player.
---@field blueprint_to_setup LuaItemStack @ [Read-only] The item stack containing a blueprint to be setup.
---@field render_mode defines.render_mode @ [Read-only] The render mode of the player, like map or zoom to world. The render mode can be set using LuaPlayer::open_map, LuaPlayer::zoom_to_world and LuaPlayer::close_map.
---@field spectator boolean @ [Read-Write] 
---@field remove_unfiltered_items boolean @ [Read-Write] If items not included in this map editor infinity inventory filters should be removed.
---@field infinity_inventory_filters InfinityInventoryFilter[] @ [Read-Write] The filters for this map editor infinity inventory settings.
---@field zoom double @ [Write-only] 
---@field map_view_settings MapViewSettings @ [Write-only] The player's map view settings. To write to this, use a table containing the fields that should be changed.

---Setup the screen to be shown when the game is finished.
---@param message LocalisedString @Message to be shown
---@param file string @Path to image to be shown
function LuaPlayer.set_ending_screen_data(message, file) end

---Print text to the chat console.
---@param message LocalisedString @
---@param color Color @
function LuaPlayer.print(message, color) end

---Clear the chat console.
function LuaPlayer.clear_console() end

---Get the current goal description, as a localised string.
---@return LocalisedString @
function LuaPlayer.get_goal_description() end

---Set the text in the goal window (top left).
---@param text LocalisedString @The text to display. \n can be used to delimit lines. Passing empty   string or omitting this parameter entirely will make the goal window disappear
---@param only_update boolean @When true, won't play the "goal updated" sound
function LuaPlayer.set_goal_description(text, only_update) end

---Disable recipe groups.
function LuaPlayer.disable_recipe_groups() end

---Enable recipe groups.
function LuaPlayer.enable_recipe_groups() end

---Disable recipe subgroups.
function LuaPlayer.disable_recipe_subgroups() end

---Enable recipe subgroups.
function LuaPlayer.enable_recipe_subgroups() end

---Print entity statistics to the player's console.
---@param entities string[] @Entity prototypes to get statistics for. If not specified or empty,   display statistics for all entities
function LuaPlayer.print_entity_statistics(entities) end

---Print construction robot job counts to the players console.
function LuaPlayer.print_robot_jobs() end

---Print LuaObject counts per mod.
function LuaPlayer.print_lua_object_statistics() end

---Logs a dictionary of chunks -> active entities for the surface this player is on.
function LuaPlayer.log_active_entity_chunk_counts() end

---Logs a dictionary of active entities -> count for the surface this player is on.
function LuaPlayer.log_active_entity_counts() end

---Unlock the achievements of the given player. This has any effect only when this is the local player, the achievement isn't unlocked so far and the achievement is of the type "achievement".
---@param name string @name of the achievement to unloc
function LuaPlayer.unlock_achievement(name) end

---Invokes the "clean cursor" action on the player as if the user pressed it.
---@return boolean @
function LuaPlayer.clean_cursor() end

---Creates and attaches a character entity to this player.
---@param character string @The character to create else the default is used
---@return boolean @
function LuaPlayer.create_character(character) end

---Adds an alert to this player for the given entity of the given alert type.
---@param entity LuaEntity @
---@param type defines.alert_type @
function LuaPlayer.add_alert(entity, type) end

---Adds a custom alert to this player.
---@param entity LuaEntity @If the alert is clicked, the map will open at the position of this entity
---@param icon SignalID @
---@param message LocalisedString @
---@param show_on_map boolean @
function LuaPlayer.add_custom_alert(entity, icon, message, show_on_map) end

---Mutes alerts for the given alert category.
---@param alert_type defines.alert_type @
---@return boolean @
function LuaPlayer.mute_alert(alert_type) end

---Unmutes alerts for the given alert category.
---@param alert_type defines.alert_type @
---@return boolean @
function LuaPlayer.unmute_alert(alert_type) end

---If the given alert type is currently muted.
---@param alert_type defines.alert_type @
---@return boolean @
function LuaPlayer.is_alert_muted(alert_type) end

---Enables alerts for the given alert category.
---@param alert_type defines.alert_type @
---@return boolean @
function LuaPlayer.enable_alert(alert_type) end

---Disables alerts for the given alert category.
---@param alert_type defines.alert_type @
---@return boolean @
function LuaPlayer.disable_alert(alert_type) end

---If the given alert type is currently enabled.
---@param alert_type defines.alert_type @
---@return boolean @
function LuaPlayer.is_alert_enabled(alert_type) end

---Invokes the "smart pipette" action on the player as if the user pressed it.
---@param entity string | LuaEntity | LuaEntityPrototype @
---@return boolean @
function LuaPlayer.pipette_entity(entity) end

---Uses the current item in the cursor if it's a capsule or does nothing if not.
---@param position Position @Where the item would be used
function LuaPlayer.use_from_cursor(position) end

---
---@return array of LuaEntity @
function LuaPlayer.get_associated_characters() end

---Associates a character with this player.
---@param character LuaEntity @The character entity
function LuaPlayer.associate_character(character) end

---Disassociates a character from this player. This is functionally the same as setting LuaEntity::associated_player to nil.
---@param character LuaEntity @The character entit
function LuaPlayer.disassociate_character(character) end

---Gets the quick bar filter for the given slot or nil.
---@param index uint @The slot index. 1 for the first slot of page one, 2 for slot two of page one, 11 for the first slot of page 2, etc
---@return LuaItemPrototype @
function LuaPlayer.get_quick_bar_slot(index) end

---Sets the quick bar filter for the given slot.
---@param index uint @The slot index. 1 for the first slot of page one, 2 for slot two of page one, 11 for the first slot of page 2, etc
---@param filter string | LuaItemPrototype | LuaItemStack @The filter or nil
function LuaPlayer.set_quick_bar_slot(index, filter) end

---Gets which quick bar page is being used for the given screen page or nil if not known.
---@param index uint @The screen page. Index 1 is the top row in the gui. Index can go beyond the visible number of bars on the screen to account for the interface config setting change
---@return uint8 @
function LuaPlayer.get_active_quick_bar_page(index) end

---Sets which quick bar page is being used for the given screen page.
---@param screen_index uint @The screen page. Index 1 is the top row in the gui. Index can go beyond the visible number of bars on the screen to account for the interface config setting change
---@param page_index uint @The new quick bar page
function LuaPlayer.set_active_quick_bar_page(screen_index, page_index) end

---Jump to the specified cutscene waypoint. Only works when the player is viewing a cutscene.
---@param waypoint_index uint @
function LuaPlayer.jump_to_cutscene_waypoint(waypoint_index) end

---Exit the current cutscene. Errors if not in a cutscene.
function LuaPlayer.exit_cutscene() end

---Queues a request to open the map at the specified position. If the map is already opened, the request will simply set the position (and scale). Render mode change requests are processed before rendering of the next frame.
---@param position Position @
---@param scale double @
function LuaPlayer.open_map(position, scale) end

---Queues a request to zoom to world at the specified position. If the player is already zooming to world, the request will simply set the position (and scale). Render mode change requests are processed before rendering of the next frame.
---@param position Position @
---@param scale double @
function LuaPlayer.zoom_to_world(position, scale) end

---Queues request to switch to the normal game view from the map or zoom to world view. Render mode change requests are processed before rendering of the next frame.
function LuaPlayer.close_map() end

---Is a custom shortcut currently toggled?
---@param prototype_name string @Prototype name of the custom shortcut
---@return boolean @
function LuaPlayer.is_shortcut_toggled(prototype_name) end

---Is a custom shortcut currently available?
---@param prototype_name string @Prototype name of the custom shortcut
---@return boolean @
function LuaPlayer.is_shortcut_available(prototype_name) end

---Toggle or untoggle a custom shortcut
---@param prototype_name string @Prototype name of the custom shortcut
---@param toggled boolean @
function LuaPlayer.set_shortcut_toggled(prototype_name, toggled) end

---Make a custom shortcut available or unavailable.
---@param prototype_name string @Prototype name of the custom shortcut
---@param available boolean @
function LuaPlayer.set_shortcut_available(prototype_name, available) end

---Toggles this player into or out of the map editor. Does nothing if this player isn't an admin or if the player doesn't have permission to use the map editor.
function LuaPlayer.toggle_map_editor() end

---Requests a translation for the given localised string. If the request is successful the on_string_translated event will be fired at a later time with the results.
---@param localised_string LocalisedString @
---@return boolean @
function LuaPlayer.request_translation(localised_string) end

---Gets the filter for this map editor infinity filters at the given index or nil if the filter index doesn't exist or is empty.
---@param index uint @The index to get
---@return InfinityInventoryFilter @
function LuaPlayer.get_infinity_inventory_filter(index) end

---Sets the filter for this map editor infinity filters at the given index.
---@param index uint @The index to set
---@param filter InfinityInventoryFilter @The new filter or nil to clear the filter
function LuaPlayer.set_infinity_inventory_filter(index, filter) end

---@class LuaProfiler Resets the clock, also restarting it.

---Resets the clock, also restarting it.
function LuaProfiler.reset() end

---Stops the clock.
function LuaProfiler.stop() end

---Start the clock again, without resetting it.
function LuaProfiler.restart() end

---Add the duration of another timer to this timer. Useful to reduce start/stop overhead when accumulating time onto many timers at once.
---@param other LuaProfiler @The timer to add to this timer
function LuaProfiler.add(other) end

---Divides the current duration by a set value. Useful for calculating the average of many iterations.
---@param number double @The number to divide by. Must be > 0
function LuaProfiler.divide(number) end

---@class LuaRCON Print text to the calling RCON interface if any.
---@field object_name string @ [Read-only] This objects name.

---Print text to the calling RCON interface if any.
---@param message LocalisedString @
function LuaRCON.print(message) end

---@class LuaRailPath The total number of rails in this path.
---@field size uint @ [Read-only] The total number of rails in this path.
---@field current uint @ [Read-only] The current rail index.
---@field total_distance double @ [Read-only] The total path distance.
---@field travelled_distance double @ [Read-only] The total distance travelled.
---@field rails CustomDictionary @ [Read-only] The rails this path travels.

---@class LuaRandomGenerator Generates a random number. If no parameters are given a number in the [0, 1) range is returned. If a single parameter is given a floored number in the [1, N] range is returned. If 2 parameters are given a floored number in the [N1, N2] range is returned.

---Generates a random number. If no parameters are given a number in the [0, 1) range is returned. If a single parameter is given a floored number in the [1, N] range is returned. If 2 parameters are given a floored number in the [N1, N2] range is returned.
---@param lower int @Inclusive lower bound on the resul
---@param upper int @Inclusive upper bound on the resul
---@return double @
function LuaRandomGenerator.operator__call(lower, upper) end

---Re-seeds the random generator with the given value.
---@param seed uint @
function LuaRandomGenerator.re_seed(seed) end

---@class LuaRecipe Reload the recipe from the prototype.
---@field name string @ [Read-only] Name of the recipe. This can be different than the name of the result items as there could be more recipes to make the same item.
---@field localised_name LocalisedString @ [Read-only] Localised name of the recipe.
---@field localised_description LocalisedString @ [Read-only] 
---@field prototype LuaRecipePrototype @ [Read-only] The prototype for this recipe.
---@field enabled boolean @ [Read-Write] Can the recipe be used?
---@field category string @ [Read-only] Category of the recipe.
---@field ingredients Ingredient[] @ [Read-only] Ingredients for this recipe.
---@field products Product[] @ [Read-only] 
---@field hidden boolean @ [Read-only] Is the recipe hidden? Hidden recipe don't show up in the crafting menu.
---@field hidden_from_flow_stats boolean @ [Read-Write] Is the recipe hidden from flow statistics?
---@field energy double @ [Read-only] Energy required to execute this recipe. This directly affects the crafting time: Recipe's energy is exactly its crafting time in seconds, when crafted in an assembling machine with crafting speed exactly equal to one.
---@field order string @ [Read-only] Order string. This is used to sort the crafting menu.
---@field group LuaGroup @ [Read-only] Group of this recipe.
---@field subgroup LuaGroup @ [Read-only] Subgroup of this recipe.
---@field force LuaForce @ [Read-only] The force that owns this recipe.

---Reload the recipe from the prototype.
function LuaRecipe.reload() end

---@class LuaRecipeCategoryPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 

---@class LuaRecipePrototype If this recipe prototype is enabled by default (enabled at the beginning of a game).
---@field enabled boolean @ [Read-only] If this recipe prototype is enabled by default (enabled at the beginning of a game).
---@field name string @ [Read-only] Name of the recipe. This can be different than the name of the result items as there could be more recipes to make the same item.
---@field localised_name LocalisedString @ [Read-only] Localised name of the recipe.
---@field localised_description LocalisedString @ [Read-only] 
---@field category string @ [Read-only] Category of the recipe.
---@field ingredients Ingredient[] @ [Read-only] Ingredients for this recipe.
---@field products Product[] @ [Read-only] 
---@field main_product Product @ [Read-only] 
---@field hidden boolean @ [Read-only] Is the recipe hidden? Hidden recipe don't show up in the crafting menu.
---@field hidden_from_flow_stats boolean @ [Read-only] Is the recipe hidden from flow statistics (item/fluid production statistics)?
---@field hidden_from_player_crafting boolean @ [Read-only] Is the recipe hidden from player crafting? The recipe will still show up for selection in machines.
---@field always_show_made_in boolean @ [Read-only] Should this recipe always show "Made in" in the tooltip?
---@field energy double @ [Read-only] Energy required to execute this recipe. This directly affects the crafting time: Recipe's energy is exactly its crafting time in seconds, when crafted in an assembling machine with crafting speed exactly equal to one.
---@field order string @ [Read-only] Order string. This is used to sort the crafting menu.
---@field group LuaGroup @ [Read-only] Group of this recipe.
---@field subgroup LuaGroup @ [Read-only] Subgroup of this recipe.
---@field request_paste_multiplier uint @ [Read-only] The multiplier used when this recipe is copied from an assembling machine to a requester chest. For each item in the recipe the item count * this value is set in the requester chest.
---@field overload_multiplier uint @ [Read-only] Used to determine how many extra items are put into an assembling machine before it's considered "full enough".
---@field allow_as_intermediate boolean @ [Read-only] If this recipe is enabled for the purpose of intermediate hand-crafting.
---@field allow_intermediates boolean @ [Read-only] If this recipe is allowed to use intermediate recipes when hand-crafting.
---@field show_amount_in_title boolean @ [Read-only] If the amount is shown in the recipe tooltip title when the recipe produces more than 1 product.
---@field always_show_products boolean @ [Read-only] If the products are always shown in the recipe tooltip.
---@field emissions_multiplier double @ [Read-only] The emissions multiplier for this recipe.
---@field allow_decomposition boolean @ [Read-only] Is this recipe allowed to be broken down for the recipe tooltip "Total raw" calculations?

---@class LuaRemote Add a remote interface.
---@field object_name string @ [Read-only] This objects name.
---@field interfaces table<string, string> @ [Read-only] 

---Add a remote interface.
---@param name string @Name of the interface
---@param funcs table<string, function> @List of functions that are members of the new interface
function LuaRemote.add_interface(name, funcs) end

---Removes an interface with the given name.
---@param name string @Name of the interface
---@return boolean @
function LuaRemote.remove_interface(name) end

---Call a function of an interface.
---@param interface string @Interface to look up function in
---@param func string @Function name that belongs to interface
---@param ... ... @Arguments to pass to the called function
---@return Anything @
function LuaRemote.call(interface, func, ...) end

---@class LuaRendering Create a line.
---@field draw_line uint64 @(optional) undefined Create a line.
---@field draw_text uint64 @(optional) undefined Create a text.
---@field draw_circle uint64 @(optional) undefined Create a circle.
---@field draw_rectangle uint64 @(optional) undefined Create a rectangle.
---@field draw_arc uint64 @(optional) undefined Create an arc.
---@field draw_polygon uint64 @(optional) undefined Create a polygon.
---@field draw_sprite uint64 @(optional) undefined Create a sprite.
---@field draw_light uint64 @(optional) undefined Create a light.
---@field draw_animation uint64 @(optional) undefined Create an animation.
---@field object_name string @ [Read-only] This objects name.

---Destroy the object with the given id.
---@param id uint64 @
function LuaRendering.destroy(id) end

---Does a font with this name exist?
---@param font_name string @
---@return boolean @
function LuaRendering.is_font_valid(font_name) end

---Does a valid object with this id exist?
---@param id uint64 @
---@return boolean @
function LuaRendering.is_valid(id) end

---Gets an array of all valid object ids.
---@param mod_name string @If provided, get only the render objects created by this mod
---@return array of uint64 @
function LuaRendering.get_all_ids(mod_name) end

---Destroys all render objects.
---@param mod_name string @If provided, only the render objects created by this mod are destroyed
function LuaRendering.clear(mod_name) end

---Gets the type of the given object. The types are "text", "line", "circle", "rectangle", "arc", "polygon", "sprite", "light" and "animation".
---@param id uint64 @
---@return string @
function LuaRendering.get_type(id) end

---Reorder this object so that it is drawn in front of the already existing objects.
---@param id uint64 @
function LuaRendering.bring_to_front(id) end

---The surface the object with this id is rendered on.
---@param id uint64 @
---@return LuaSurface @
function LuaRendering.get_surface(id) end

---Get the time to live of the object with this id. This will be 0 if the object does not expire.
---@param id uint64 @
---@return uint @
function LuaRendering.get_time_to_live(id) end

---Set the time to live of the object with this id. Set to 0 if the object should not expire.
---@param id uint64 @
---@param time_to_live uint @
function LuaRendering.set_time_to_live(id, time_to_live) end

---Get the forces that the object with this id is rendered to or nil if visible to all forces.
---@param id uint64 @
---@return array of LuaForce @
function LuaRendering.get_forces(id) end

---Set the forces that the object with this id is rendered to.
---@param id uint64 @
---@param forces ForceSpecification[] @Providing an empty array will set the object to be visible to all forces
function LuaRendering.set_forces(id, forces) end

---Get the players that the object with this id is rendered to or nil if visible to all players.
---@param id uint64 @
---@return array of LuaPlayer @
function LuaRendering.get_players(id) end

---Set the players that the object with this id is rendered to.
---@param id uint64 @
---@param players PlayerSpecification[] @Providing an empty array will set the object to be visible to all players
function LuaRendering.set_players(id, players) end

---Get whether this is rendered to anyone at all.
---@param id uint64 @
---@return boolean @
function LuaRendering.get_visible(id) end

---Set whether this is rendered to anyone at all.
---@param id uint64 @
---@param visible boolean @
function LuaRendering.set_visible(id, visible) end

---Get whether this is being drawn on the ground, under most entities and sprites.
---@param id uint64 @
---@return boolean @
function LuaRendering.get_draw_on_ground(id) end

---Set whether this is being drawn on the ground, under most entities and sprites.
---@param id uint64 @
---@param draw_on_ground boolean @
function LuaRendering.set_draw_on_ground(id, draw_on_ground) end

---Get whether this is only rendered in alt-mode.
---@param id uint64 @
---@return boolean @
function LuaRendering.get_only_in_alt_mode(id) end

---Set whether this is only rendered in alt-mode.
---@param id uint64 @
---@param only_in_alt_mode boolean @
function LuaRendering.set_only_in_alt_mode(id, only_in_alt_mode) end

---Get the color or tint of the object with this id.
---@param id uint64 @
---@return Color @
function LuaRendering.get_color(id) end

---Set the color or tint of the object with this id. Does nothing if this object does not support color.
---@param id uint64 @
---@param color Color @
function LuaRendering.set_color(id, color) end

---Get the width of the object with this id. Value is in pixels (32 per tile).
---@param id uint64 @
---@return float @
function LuaRendering.get_width(id) end

---Set the width of the object with this id. Does nothing if this object does not support width. Value is in pixels (32 per tile).
---@param id uint64 @
---@param width float @
function LuaRendering.set_width(id, width) end

---Get from where the line with this id is drawn or nil if this object is not a line.
---@param id uint64 @
---@return ScriptRenderTarget @
function LuaRendering.get_from(id) end

---Set from where the line with this id is drawn. Does nothing if the object is not a line.
---@param id uint64 @
---@param from Position | LuaEntity @
---@param from_offset Vector @
function LuaRendering.set_from(id, from, from_offset) end

---Get where the line with this id is drawn to or nil if the object is not a line.
---@param id uint64 @
---@return ScriptRenderTarget @
function LuaRendering.get_to(id) end

---Set where the line with this id is drawn to. Does nothing if this object is not a line.
---@param id uint64 @
---@param to Position | LuaEntity @
---@param to_offset Vector @
function LuaRendering.set_to(id, to, to_offset) end

---Get the dash length of the line with this id or nil if the object is not a line.
---@param id uint64 @
---@return double @
function LuaRendering.get_dash_length(id) end

---Set the dash length of the line with this id. Does nothing if this object is not a line.
---@param id uint64 @
---@param dash_length double @
function LuaRendering.set_dash_length(id, dash_length) end

---Get the length of the gaps in the line with this id or nil if the object is not a line.
---@param id uint64 @
---@return double @
function LuaRendering.get_gap_length(id) end

---Set the length of the gaps in the line with this id. Does nothing if this object is not a line.
---@param id uint64 @
---@param gap_length double @
function LuaRendering.set_gap_length(id, gap_length) end

---Set the length of the dashes and the length of the gaps in the line with this id. Does nothing if this object is not a line.
---@param id uint64 @
---@param dash_length double @
---@param gap_length double @
function LuaRendering.set_dashes(id, dash_length, gap_length) end

---Get where the object with this id is drawn or nil if the object does not support target.
---@param id uint64 @
---@return ScriptRenderTarget @
function LuaRendering.get_target(id) end

---Set where the object with this id is drawn. Does nothing if this object does not support target.
---@param id uint64 @
---@param target Position | LuaEntity @
---@param target_offset Vector @
function LuaRendering.set_target(id, target, target_offset) end

---Get the orientation of the object with this id or nil if the object is not a text, polygon, sprite, light or animation.
---@param id uint64 @
---@return float @
function LuaRendering.get_orientation(id) end

---Set the orientation of the object with this id. Does nothing if this object is not a text, polygon, sprite, light or animation.
---@param id uint64 @
---@param orientation float @
function LuaRendering.set_orientation(id, orientation) end

---Get the scale of the text or light with this id or nil if the object is not a text or light.
---@param id uint64 @
---@return double @
function LuaRendering.get_scale(id) end

---Set the scale of the text or light with this id. Does nothing if this object is not a text or light.
---@param id uint64 @
---@param scale double @
function LuaRendering.set_scale(id, scale) end

---Get the text that is displayed by the text with this id or nil if the object is not a text.
---@param id uint64 @
---@return LocalisedString @
function LuaRendering.get_text(id) end

---Set the text that is displayed by the text with this id. Does nothing if this object is not a text.
---@param id uint64 @
---@param text LocalisedString @
function LuaRendering.set_text(id, text) end

---Get the font of the text with this id or nil if the object is not a text.
---@param id uint64 @
---@return string @
function LuaRendering.get_font(id) end

---Set the font of the text with this id. Does nothing if this object is not a text.
---@param id uint64 @
---@param font string @
function LuaRendering.set_font(id, font) end

---Get the alignment  of the text with this id or nil if the object is not a text.
---@param id uint64 @
---@return string @
function LuaRendering.get_alignment(id) end

---Set the alignment of the text with this id. Does nothing if this object is not a text.
---@param id uint64 @
---@param alignment string @"left", "right" or "center"
function LuaRendering.set_alignment(id, alignment) end

---Get if the text with this id scales with player zoom or nil if the object is not a text.
---@param id uint64 @
---@return boolean @
function LuaRendering.get_scale_with_zoom(id) end

---Set if the text with this id scales with player zoom, resulting in it always being the same size on screen, and the size compared to the game world changes. Does nothing if this object is not a text.
---@param id uint64 @
---@param scale_with_zoom boolean @
function LuaRendering.set_scale_with_zoom(id, scale_with_zoom) end

---Get if the circle or rectangle with this id is filled or nil if the object is not a circle or rectangle.
---@param id uint64 @
---@return boolean @
function LuaRendering.get_filled(id) end

---Set if the circle or rectangle with this id is filled. Does nothing if this object is not a circle or rectangle.
---@param id uint64 @
---@param filled boolean @
function LuaRendering.set_filled(id, filled) end

---Get the radius of the circle with this id or nil if the object is not a circle.
---@param id uint64 @
---@return double @
function LuaRendering.get_radius(id) end

---Set the radius of the circle with this id. Does nothing if this object is not a circle.
---@param id uint64 @
---@param radius double @
function LuaRendering.set_radius(id, radius) end

---Get where top left corner of the rectangle with this id is drawn or nil if the object is not a rectangle.
---@param id uint64 @
---@return ScriptRenderTarget @
function LuaRendering.get_left_top(id) end

---Set where top left corner of the rectangle with this id is drawn. Does nothing if this object is not a rectangle.
---@param id uint64 @
---@param left_top Position | LuaEntity @
---@param left_top_offset Vector @
function LuaRendering.set_left_top(id, left_top, left_top_offset) end

---Get where bottom right corner of the rectangle with this id is drawn or nil if the object is not a rectangle.
---@param id uint64 @
---@return ScriptRenderTarget @
function LuaRendering.get_right_bottom(id) end

---Set where top bottom right of the rectangle with this id is drawn. Does nothing if this object is not a rectangle.
---@param id uint64 @
---@param right_bottom Position | LuaEntity @
---@param right_bottom_offset Vector @
function LuaRendering.set_right_bottom(id, right_bottom, right_bottom_offset) end

---Set the corners of the rectangle with this id. Does nothing if this object is not a rectangle.
---@param id uint64 @
---@param left_top Position | LuaEntity @
---@param left_top_offset Vector @
---@param right_bottom Position | LuaEntity @
---@param right_bottom_offset Vector @
function LuaRendering.set_corners(id, left_top, left_top_offset, right_bottom, right_bottom_offset) end

---Get the radius of the outer edge of the arc with this id or nil if the object is not a arc.
---@param id uint64 @
---@return double @
function LuaRendering.get_max_radius(id) end

---Set the radius of the outer edge of the arc with this id. Does nothing if this object is not a arc.
---@param id uint64 @
---@param max_radius double @
function LuaRendering.set_max_radius(id, max_radius) end

---Get the radius of the inner edge of the arc with this id or nil if the object is not a arc.
---@param id uint64 @
---@return double @
function LuaRendering.get_min_radius(id) end

---Set the radius of the inner edge of the arc with this id. Does nothing if this object is not a arc.
---@param id uint64 @
---@param min_radius double @
function LuaRendering.set_min_radius(id, min_radius) end

---Get where the arc with this id starts or nil if the object is not a arc.
---@param id uint64 @
---@return float @
function LuaRendering.get_start_angle(id) end

---Set where the arc with this id starts. Does nothing if this object is not a arc.
---@param id uint64 @
---@param start_angle float @angle in radia
function LuaRendering.set_start_angle(id, start_angle) end

---Get the angle of the arc with this id or nil if the object is not a arc.
---@param id uint64 @
---@return float @
function LuaRendering.get_angle(id) end

---Set the angle of the arc with this id. Does nothing if this object is not a arc.
---@param id uint64 @
---@param angle float @angle in radia
function LuaRendering.set_angle(id, angle) end

---Get the vertices of the polygon with this id or nil if the object is not a polygon.
---@param id uint64 @
---@return array of ScriptRenderTarget @
function LuaRendering.get_vertices(id) end

---Set the vertices of the polygon with this id. Does nothing if this object is not a polygon.
---@param id uint64 @
---@param vertices ScriptRenderTarget[] @
function LuaRendering.set_vertices(id, vertices) end

---Get the sprite of the sprite or light with this id or nil if the object is not a sprite or light.
---@param id uint64 @
---@return SpritePath @
function LuaRendering.get_sprite(id) end

---Set the sprite of the sprite or light with this id. Does nothing if this object is not a sprite or light.
---@param id uint64 @
---@param sprite SpritePath @
function LuaRendering.set_sprite(id, sprite) end

---Get the horizontal scale of the sprite or animation with this id or nil if the object is not a sprite or animation.
---@param id uint64 @
---@return double @
function LuaRendering.get_x_scale(id) end

---Set the horizontal scale of the sprite or animation with this id. Does nothing if this object is not a sprite or animation.
---@param id uint64 @
---@param x_scale double @
function LuaRendering.set_x_scale(id, x_scale) end

---Get the vertical scale of the sprite or animation with this id or nil if the object is not a sprite or animation.
---@param id uint64 @
---@return double @
function LuaRendering.get_y_scale(id) end

---Set the vertical scale of the sprite or animation with this id. Does nothing if this object is not a sprite or animation.
---@param id uint64 @
---@param y_scale double @
function LuaRendering.set_y_scale(id, y_scale) end

---Get the render layer of the sprite or animation with this id or nil if the object is not a sprite or animation.
---@param id uint64 @
---@return RenderLayer @
function LuaRendering.get_render_layer(id) end

---Set the render layer of the sprite or animation with this id. Does nothing if this object is not a sprite or animation.
---@param id uint64 @
---@param r_ender_layer RenderLayer @
function LuaRendering.set_render_layer(id, r_ender_layer) end

---The object rotates so that it faces this target. Note that orientation is still applied to the object. Get the orientation_target of the object with this id or nil if no target or if this object is not a polygon, sprite, or animation.
---@param id uint64 @
---@return ScriptRenderTarget @
function LuaRendering.get_orientation_target(id) end

---The object rotates so that it faces this target. Note that orientation is still applied to the object. Set the orientation_target of the object with this id. Does nothing if this object is not a polygon, sprite, or animation. Set to nil if the object should not have an orientation_target.
---@param id uint64 @
---@param orientation_target Position | LuaEntity @
---@param orientation_target_offset Vector @
function LuaRendering.set_orientation_target(id, orientation_target, orientation_target_offset) end

---Offsets the center of the sprite or animation if orientation_target is given. This offset will rotate together with the sprite or animation. Get the oriented_offset of the sprite or animation with this id or nil if this object is not a sprite or animation.
---@param id uint64 @
---@return Vector @
function LuaRendering.get_oriented_offset(id) end

---Offsets the center of the sprite or animation if orientation_target is given. This offset will rotate together with the sprite or animation. Set the oriented_offset of the sprite or animation with this id. Does nothing if this object is not a sprite or animation.
---@param id uint64 @
---@param oriented_offset Vector @
function LuaRendering.set_oriented_offset(id, oriented_offset) end

---Get the intensity of the light with this id or nil if the object is not a light.
---@param id uint64 @
---@return float @
function LuaRendering.get_intensity(id) end

---Set the intensity of the light with this id. Does nothing if this object is not a light.
---@param id uint64 @
---@param intensity float @
function LuaRendering.set_intensity(id, intensity) end

---Get the minimum darkness at which the light with this id is rendered or nil if the object is not a light.
---@param id uint64 @
---@return float @
function LuaRendering.get_minimum_darkness(id) end

---Set the minimum darkness at which the light with this id is rendered. Does nothing if this object is not a light.
---@param id uint64 @
---@param minimum_darkness float @
function LuaRendering.set_minimum_darkness(id, minimum_darkness) end

---Get if the light with this id is rendered has the same orientation as the target entity or nil if the object is not a light. Note that orientation is still applied to the sprite.
---@param id uint64 @
---@return boolean @
function LuaRendering.get_oriented(id) end

---Set if the light with this id is rendered has the same orientation as the target entity. Does nothing if this object is not a light. Note that orientation is still applied to the sprite.
---@param id uint64 @
---@param oriented boolean @
function LuaRendering.set_oriented(id, oriented) end

---Get the animation prototype name of the animation with this id or nil if the object is not an animation.
---@param id uint64 @
---@return string @
function LuaRendering.get_animation(id) end

---Set the animation prototype name of the animation with this id. Does nothing if this object is not an animation.
---@param id uint64 @
---@param animation string @
function LuaRendering.set_animation(id, animation) end

---Get the animation speed of the animation with this id or nil if the object is not an animation.
---@param id uint64 @
---@return double @
function LuaRendering.get_animation_speed(id) end

---Set the animation speed of the animation with this id. Does nothing if this object is not an animation.
---@param id uint64 @
---@param animation_speed double @Animation speed in frames per tick
function LuaRendering.set_animation_speed(id, animation_speed) end

---Get the animation offset of the animation with this id or nil if the object is not an animation.
---@param id uint64 @
---@return double @
function LuaRendering.get_animation_offset(id) end

---Set the animation offset of the animation with this id. Does nothing if this object is not an animation.
---@param id uint64 @
---@param animation_offset double @Animation offset in frames
function LuaRendering.set_animation_offset(id, animation_offset) end

---@class LuaResourceCategoryPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 

---@class LuaSettings 
---@field object_name string @ [Read-only] This objects name.
---@field startup CustomDictionary @ [Read-only] 
---@field global CustomDictionary @ [Read-only] 
---@field player CustomDictionary @ [Read-only] 

---
---@param player LuaPlayer @
---@return CustomDictionary string → ModSetting @
function LuaSettings.get_player_settings(player) end

---@class LuaShortcutPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field action string @ [Read-only] 
---@field item_to_create LuaItemPrototype @ [Read-only] 
---@field technology_to_unlock LuaTechnologyPrototype @ [Read-only] 
---@field toggleable boolean @ [Read-only] 
---@field associated_control_input string @ [Read-only] 

---@class LuaStyle 
---@field gui LuaGui @ [Read-only] 
---@field name string @ [Read-only] 
---@field minimal_width int @ [Read-Write] Minimal width ensures, that the widget will never be smaller than than that size. It can't be squashed to be smaller.
---@field maximal_width int @ [Read-Write] Maximal width ensures, that the widget will never be bigger than than that size. It can't be stretched to be bigger.
---@field minimal_height int @ [Read-Write] Minimal height ensures, that the widget will never be smaller than than that size. It can't be squashed to be smaller.
---@field maximal_height int @ [Read-Write] Maximal height ensures, that the widget will never be bigger than than that size. It can't be stretched to be bigger.
---@field natural_width int @ [Read-Write] Natural width specifies the width of the element tries to have, but it can still be squashed/stretched to have a smaller or bigger size.
---@field natural_height int @ [Read-Write] Natural height specifies the height of the element tries to have, but it can still be squashed/stretched to have a smaller or bigger size.
---@field top_padding int @ [Read-Write] 
---@field right_padding int @ [Read-Write] 
---@field bottom_padding int @ [Read-Write] 
---@field left_padding int @ [Read-Write] 
---@field top_margin int @ [Read-Write] 
---@field right_margin int @ [Read-Write] 
---@field bottom_margin int @ [Read-Write] 
---@field left_margin int @ [Read-Write] 
---@field horizontal_align string @ [Read-Write] Horizontal align of the inner content of the widget, possible values are "left", "center" or "right"
---@field vertical_align string @ [Read-Write] Vertical align of the inner content of the widget, possible values are "top", "center" or "bottom"
---@field font_color Color @ [Read-Write] 
---@field font string @ [Read-Write] 
---@field top_cell_padding int @ [Read-Write] 
---@field right_cell_padding int @ [Read-Write] 
---@field bottom_cell_padding int @ [Read-Write] 
---@field left_cell_padding int @ [Read-Write] 
---@field horizontally_stretchable boolean @ [Read-Write] If the GUI element stretches its size horizontally to other elements.
---@field vertically_stretchable boolean @ [Read-Write] If the GUI element stretches its size vertically to other elements.
---@field horizontally_squashable boolean @ [Read-Write] If the GUI element can be squashed (by maximal width of some parent element) horizontally. This is mainly meant to be used for scroll-pane The default value is false.
---@field vertically_squashable boolean @ [Read-Write] If the GUI element can be squashed (by maximal height of some parent element) vertically. This is mainly meant to be used for scroll-pane The default (parent) value for scroll pane is true, false otherwise.
---@field rich_text_setting defines.rich_text_setting @ [Read-Write] How this GUI element handles rich text.
---@field hovered_font_color Color @ [Read-Write] 
---@field clicked_font_color Color @ [Read-Write] 
---@field disabled_font_color Color @ [Read-Write] 
---@field pie_progress_color Color @ [Read-Write] 
---@field clicked_vertical_offset int @ [Read-Write] 
---@field selected_font_color Color @ [Read-Write] 
---@field selected_hovered_font_color Color @ [Read-Write] 
---@field selected_clicked_font_color Color @ [Read-Write] 
---@field strikethrough_color Color @ [Read-Write] 
---@field horizontal_spacing int @ [Read-Write] 
---@field vertical_spacing int @ [Read-Write] 
---@field use_header_filler boolean @ [Read-Write] 
---@field color Color @ [Read-Write] 
---@field column_alignments CustomArray @ [Read-only] 
---@field single_line boolean @ [Read-Write] 
---@field extra_top_padding_when_activated int @ [Read-Write] 
---@field extra_bottom_padding_when_activated int @ [Read-Write] 
---@field extra_left_padding_when_activated int @ [Read-Write] 
---@field extra_right_padding_when_activated int @ [Read-Write] 
---@field extra_top_margin_when_activated int @ [Read-Write] 
---@field extra_bottom_margin_when_activated int @ [Read-Write] 
---@field extra_left_margin_when_activated int @ [Read-Write] 
---@field extra_right_margin_when_activated int @ [Read-Write] 
---@field stretch_image_to_widget_size boolean @ [Read-Write] 
---@field badge_font string @ [Read-Write] 
---@field badge_horizontal_spacing int @ [Read-Write] 
---@field default_badge_font_color Color @ [Read-Write] 
---@field selected_badge_font_color Color @ [Read-Write] 
---@field disabled_badge_font_color Color @ [Read-Write] 
---@field width int @ [Write-only] 
---@field height int @ [Write-only] 
---@field padding int | int[] | int @ [Write-only] 
---@field margin int | int[] | int @ [Write-only] 
---@field cell_padding int @ [Write-only] 

---@class LuaSurface Get the pollution for a given position.
---@field can_place_entity boolean @(optional) undefined Check for collisions with terrain or other entities.
---@field can_fast_replace boolean @(optional) undefined If there exists an entity at the given location that can be fast-replaced with the given entity parameters.
---@field find_entities_filtered array of LuaEntity @(optional) undefined Find entities of given type or name in a given area.
---@field find_tiles_filtered array of LuaTile @(optional) undefined Find tiles of a given name in a given area.
---@field count_entities_filtered uint @(optional) undefined Count entities of given type or name in a given area. Works just like LuaSurface::find_entities_filtered, except this only returns the count. As it doesn't construct all the wrapper objects, this is more efficient if one is only interested in the number of entities.
---@field count_tiles_filtered uint @(optional) undefined Count tiles of a given name in a given area. Works just like LuaSurface::find_tiles_filtered, except this only returns the count. As it doesn't construct all the wrapper objects, this is more efficient if one is only interested in the number of tiles.
---@field find_units array of LuaEntity @ undefined Find units (entities with type "unit") of a given force and force condition within a given area.
---@field find_nearest_enemy LuaEntity @(optional) undefined Find the enemy entity-with-force (military entity) closest to the given position.
---@field set_multi_command uint @(optional) undefined Give a command to multiple units. This will automatically select suitable units for the task.
---@field create_entity LuaEntity @(optional) undefined Create an entity on this surface.
---@field create_trivial_smoke nil @ undefined 
---@field create_particle nil @ undefined Creates a particle at the given location
---@field create_unit_group LuaUnitGroup @(optional) undefined Create a new unit group at a given position.
---@field deconstruct_area nil @(optional) undefined Place a deconstruction request.
---@field cancel_deconstruct_area nil @(optional) undefined Cancel a deconstruction order.
---@field upgrade_area nil @(optional) undefined Place an upgrade request.
---@field cancel_upgrade_area nil @(optional) undefined Cancel a upgrade order.
---@field destroy_decoratives nil @(optional) undefined Removes all decoratives from the given area.
---@field create_decoratives nil @(optional) undefined Adds the given decoratives to the surface.
---@field find_decoratives_filtered array of DecorativeResult @(optional) undefined Find decoratives of a given name in a given area.
---@field play_sound boolean @(optional) undefined Plays a sound on this surface.
---@field clone_area nil @(optional) undefined Clones the given area.
---@field clone_brush nil @(optional) undefined Clones the given area.
---@field clone_entities nil @(optional) undefined Clones the given entities.
---@field request_path uint @(optional) undefined Starts a path find request without actually ordering a unit to move. Result is ultimately returned asynchronously via defines.events.on_script_path_request_finished.
---@field name string @ [Read-Write] 
---@field index uint @ [Read-only] 
---@field map_gen_settings MapGenSettings @ [Read-Write] The generation settings for the surface.
---@field generate_with_lab_tiles boolean @ [Read-Write] When set to true, new chunks will be generated with lab tiles, instead of using the surface's map generation settings.
---@field always_day boolean @ [Read-Write] When set to true, the sun will always shine.
---@field daytime float @ [Read-Write] 
---@field darkness float @ [Read-only] 
---@field wind_speed float @ [Read-Write] 
---@field wind_orientation float @ [Read-Write] 
---@field wind_orientation_change float @ [Read-Write] 
---@field peaceful_mode boolean @ [Read-Write] 
---@field freeze_daytime boolean @ [Read-Write] True if daytime is currently frozen.
---@field ticks_per_day uint @ [Read-Write] The number of ticks per day for this surface.
---@field dusk double @ [Read-Write] The daytime when dusk starts.
---@field dawn double @ [Read-Write] The daytime when dawn starts.
---@field evening double @ [Read-Write] The daytime when evening starts.
---@field morning double @ [Read-Write] The daytime when morning starts.
---@field solar_power_multiplier double @ [Read-Write] The multiplier of solar power on this surface. Cannot be less than 0.
---@field min_brightness double @ [Read-Write] The minimal brightness during the night. Default is 0.15. The value has an effect on the game simalution only, it doesn't have any effect on rendering.
---@field brightness_visual_weights ColorModifier @ [Read-Write] Defines how surface daytime brightness influences each color channel of the current color lookup table (LUT).
---@field show_clouds boolean @ [Read-Write] If clouds are shown on this surface.

---Get the pollution for a given position.
---@param position Position @
---@return double @
function LuaSurface.get_pollution(position) end

---Find a specific entity at a specific position.
---@param entity string @Entity to look fo
---@param position Position @Coordinates to look a
---@return LuaEntity @
function LuaSurface.find_entity(entity, position) end

---Find entities in a given area.
---@param area BoundingBox @
---@return array of LuaEntity @
function LuaSurface.find_entities(area) end

---Find a non-colliding position within a given radius.
---@param name string @Prototype name of the entity to find a position for. (The bounding   box for the collision checking is taken from this prototype.
---@param center Position @Center of the search area
---@param radius double @Max distance from center to search in. 0 for infinitely-large   search area
---@param precision double @The step length from the given position as it searches, in tiles. Minimum value is 0.01
---@param force_to_tile_center boolean @Will only check tile centers. This can be useful when your intent is to place a building at the resulting position,   as they must generally be placed at tile centers. Default false
---@return Position @
function LuaSurface.find_non_colliding_position(name, center, radius, precision, force_to_tile_center) end

---Find a non-colliding position within a given rectangle.
---@param name string @Prototype name of the entity to find a position for. (The bounding   box for the collision checking is taken from this prototype.
---@param search_space BoundingBox @The rectangle to search inside
---@param precision double @The step length from the given position as it searches, in tiles. Minimum value is 0.01
---@param force_to_tile_center boolean @Will only check tile centers. This can be useful when your intent is to place a building at the resulting position,   as they must generally be placed at tile centers. Default false
---@return Position @
function LuaSurface.find_non_colliding_position_in_box(name, search_space, precision, force_to_tile_center) end

---Spill items on the ground centered at a given location.
---@param position Position @Center of the spillag
---@param items ItemStackSpecification @Items to spil
---@param enable_looted boolean @When true, each created item will be flagged with the LuaEntity::to_be_looted flag
---@param force LuaForce | string @When provided (and not nil) the items will be marked for deconstruction by this force
---@param allow_belts boolean @Whether items can be spilled onto belts. Defaults to true
---@return array of LuaEntity @
function LuaSurface.spill_item_stack(position, items, enable_looted, force, allow_belts) end

---Find enemy units (entities with type "unit") of a given force within an area.
---@param center Position @Center of the search are
---@param radius double @Radius of the circular search are
---@param force LuaForce | string @Force to find enemies of. If not given,   uses the player force
---@return array of LuaEntity @
function LuaSurface.find_enemy_units(center, radius, force) end

---Send a group to build a new base.
---@param position Position @Location of the new base
---@param unit_count uint @Number of biters to send for the base-building task
---@param force ForceSpecification @Force the new base will belong to. Defaults to enemy
function LuaSurface.build_enemy_base(position, unit_count, force) end

---Get the tile at a given position.
---@param x int @
---@param y int @
---@return LuaTile @
function LuaSurface.get_tile(x, y) end

---Set tiles at specified locations. Automatically corrects the edges around modified tiles.
---@param tiles object[] @Each Tile is a table: name :: stringposition :: Positio
---@param correct_tiles boolean @If false, the correction logic is not done on the changed tiles.                                           Defaults to true
---@param remove_colliding_entities boolean | string @true, false, or abort_on_collision. Defaults to true
---@param remove_colliding_decoratives boolean @true or false. Defaults to tru
---@param raise_event boolean @true or false. Defaults to fals
function LuaSurface.set_tiles(tiles, correct_tiles, remove_colliding_entities, remove_colliding_decoratives, raise_event) end

---Spawn pollution at the given position.
---@param source Position @Where to spawn the pollution
---@param amount double @How much pollution to add
function LuaSurface.pollute(source, amount) end

---Get an iterator going over every chunk on this surface.
---@return LuaChunkIterator @
function LuaSurface.get_chunks() end

---Is a given chunk generated?
---@param position ChunkPosition @The chunk's position
---@return boolean @
function LuaSurface.is_chunk_generated(position) end

---Request that the game's map generator generate chunks at the given position for the given radius on this surface.
---@param position Position @Where to generate the new chunks
---@param radius uint @The chunk radius from position to generate new chunks in
function LuaSurface.request_to_generate_chunks(position, radius) end

---Blocks and generates all chunks that have been requested using all available threads.
function LuaSurface.force_generate_chunk_requests() end

---Set generated status of a chunk. Useful when copying chunks.
---@param position ChunkPosition @The chunk's position
---@param status defines.chunk_generated_status @The chunk's new status
function LuaSurface.set_chunk_generated_status(position, status) end

---Find the logistic network that covers a given position.
---@param position Position @
---@param force ForceSpecification @Force the logistic network should belong to
---@return LuaLogisticNetwork @
function LuaSurface.find_logistic_network_by_position(position, force) end

---Finds all of the logistics networks whose construction area intersects with the given position.
---@param position Position @
---@param force ForceSpecification @Force the logistic networks should belong to
---@return array of LuaLogisticNetwork @
function LuaSurface.find_logistic_networks_by_construction_area(position, force) end

---
---@param position TilePosition @The tile position
---@return string @
function LuaSurface.get_hidden_tile(position) end

---
---@param position TilePosition @The tile position
---@param tile string | LuaTilePrototype @The new hidden tile or nil to clear the hidden tile
function LuaSurface.set_hidden_tile(position, tile) end

---Gets all tiles of the given types that are connected horizontally or vertically to the given tile position including the given tile position.
---@param position Position @The tile position to start at
---@param tiles string[] @The tiles to search for
---@return array of Position @
function LuaSurface.get_connected_tiles(position, tiles) end

---
---@param position ChunkPosition @The chunk position to delet
function LuaSurface.delete_chunk(position) end

---Regenerate autoplacement of some entities on this surface. This can be used to autoplace newly-added entities.
---@param entities string | string[] | string @
---@param chunks ChunkPosition[] @
function LuaSurface.regenerate_entity(entities, chunks) end

---Regenerate autoplacement of some decoratives on this surface. This can be used to autoplace newly-added decoratives.
---@param decoratives string | string[] | string @
---@param chunks ChunkPosition[] @
function LuaSurface.regenerate_decorative(decoratives, chunks) end

---Print text to the chat console of all players on this surface.
---@param message LocalisedString @
---@param color Color @
function LuaSurface.print(message, color) end

---
---@param force ForceSpecification @If given only trains matching this force are returned
---@return array of LuaTrain @
function LuaSurface.get_trains(force) end

---Clears all pollution on this surface.
function LuaSurface.clear_pollution() end

---Gets the resource amount of all resources on this surface
---@return dictionary string → uint @
function LuaSurface.get_resource_counts() end

---Gets a random generated chunk position or 0,0 if no chunks have been generated on this surface.
---@return ChunkPosition @
function LuaSurface.get_random_chunk() end

---Clears this surface deleting all entities and chunks on it.
---@param ignore_characters boolean @Whether characters on this surface that are connected to or associated with players should be ignored (not destroyed)
function LuaSurface.clear(ignore_characters) end

---Gets the script areas that match the given name or if no name is given all areas are returned.
---@param name string @
---@return array of ScriptArea @
function LuaSurface.get_script_areas(name) end

---Gets the first script area by name or id.
---@param key string | uint @The name or id of the area to get
---@return ScriptArea @
function LuaSurface.get_script_area(key) end

---Sets the given script area to the new values.
---@param id uint @The area to edit
---@param area ScriptArea @
function LuaSurface.edit_script_area(id, area) end

---Adds the given script area.
---@param area ScriptArea @
---@return uint @
function LuaSurface.add_script_area(area) end

---Removes the given script area.
---@param id uint @
---@return boolean @
function LuaSurface.remove_script_area(id) end

---Gets the script positions that match the given name or if no name is given all positions are returned.
---@param name string @
---@return array of ScriptPosition @
function LuaSurface.get_script_positions(name) end

---Gets the first script position by name or id.
---@param key string | uint @The name or id of the position to get
---@return ScriptPosition @
function LuaSurface.get_script_position(key) end

---Sets the given script position to the new values.
---@param id uint @The position to edit
---@param area ScriptPosition @
function LuaSurface.edit_script_position(id, area) end

---Adds the given script position.
---@param area ScriptPosition @
---@return uint @
function LuaSurface.add_script_position(area) end

---Removes the given script position.
---@param id uint @
---@return boolean @
function LuaSurface.remove_script_position(id) end

---Gets the map exchange string for the current map generation settings of this surface.
---@return string @
function LuaSurface.get_map_exchange_string() end

---Gets the starting area radius of this surface.
---@return double @
function LuaSurface.get_starting_area_radius() end

---Gets the closest entity in the list to this position.
---@param position Position @
---@param entities LuaEntity[] @The Entities to chec
---@return LuaEntity @
function LuaSurface.get_closest(position, entities) end

---Gets train stops matching the given filters.
---@param opts string | string[] | string @Table with the following fields: name :: string or array of string  (optional)force :: ForceSpecification  (optional
---@return array of LuaEntity @
function LuaSurface.get_train_stops(opts) end

---Gets the total amount of pollution on the surface by iterating over all of the chunks containing pollution.
---@return double @
function LuaSurface.get_total_pollution() end

---
---@param prototype EntityPrototypeSpecification @The entity prototype to chec
---@param position Position @The position to chec
---@param use_map_generation_bounding_box boolean @If the map generation bounding box should be used instead of the collision bounding bo
---@param direction defines.direction @
function LuaSurface.entity_prototype_collides(prototype, position, use_map_generation_bounding_box, direction) end

---
---@param prototype string @The decorative prototype to chec
---@param position Position @The position to chec
function LuaSurface.decorative_prototype_collides(prototype, position) end

---
---@param property_names string[] @Names of properties (e.g. "elevation") to calculat
---@param positions Position[] @Positions for which to calculate property value
---@return dictionary string → array of double @
function LuaSurface.calculate_tile_properties(property_names, positions) end

---Returns all the entities with force on this chunk for the given force.
---@param position ChunkPosition @The chunk's position
---@param force LuaForce | string @Entities of this force will be returned
---@return array of LuaEntity @
function LuaSurface.get_entities_with_force(position, force) end

---@class LuaTechnology Reload this technology from its prototype.
---@field force LuaForce @ [Read-only] 
---@field name string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field prototype LuaTechnologyPrototype @ [Read-only] The prototype of this technology.
---@field enabled boolean @ [Read-Write] 
---@field visible_when_disabled boolean @ [Read-Write] 
---@field upgrade boolean @ [Read-only] 
---@field researched boolean @ [Read-Write] 
---@field prerequisites table<string, LuaTechnology> @ [Read-only] 
---@field research_unit_ingredients Ingredient[] @ [Read-only] 
---@field effects Modifier[] @ [Read-only] 
---@field research_unit_count uint @ [Read-only] 
---@field research_unit_energy double @ [Read-only] 
---@field order string @ [Read-only] 
---@field level uint @ [Read-Write] The current level of this technology. For level-based technology writing to this is the same as researching the technology to the *previous* level. Writing the level will set LuaTechnology::enabled to true.
---@field research_unit_count_formula string @ [Read-only] The count formula used for this infinite research or nil if this isn't an infinite research.

---Reload this technology from its prototype.
function LuaTechnology.reload() end

---@class LuaTechnologyPrototype 
---@field name string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field enabled boolean @ [Read-only] If this technology prototype is enabled by default (enabled at the beginning of a game).
---@field hidden boolean @ [Read-only] If this technology prototype is hidden.
---@field visible_when_disabled boolean @ [Read-only] If this technology will be visible in the research GUI even though it is disabled.
---@field upgrade boolean @ [Read-only] If the is technology prototype is an upgrade to some other technology.
---@field prerequisites table<string, LuaTechnologyPrototype> @ [Read-only] 
---@field research_unit_ingredients Ingredient[] @ [Read-only] 
---@field effects Modifier[] @ [Read-only] 
---@field research_unit_count uint @ [Read-only] 
---@field research_unit_energy double @ [Read-only] 
---@field order string @ [Read-only] 
---@field level uint @ [Read-only] 
---@field max_level uint @ [Read-only] 
---@field research_unit_count_formula string @ [Read-only] The count formula used for this infinite research or nil if this isn't an infinite research.

---@class LuaTile What type of things can collide with this tile?
---@field name string @ [Read-only] 
---@field prototype LuaTilePrototype @ [Read-only] 
---@field position Position @ [Read-only] The position this tile references.
---@field hidden_tile string @(optional) [Read-only] 
---@field surface LuaSurface @ [Read-only] The surface this tile is on.

---What type of things can collide with this tile?
---@param layer CollisionMaskLayer @
---@return boolean @
function LuaTile.collides_with(layer) end

---Orders deconstruction of this tile by the given force.
---@param force ForceSpecification @The force whose robots are supposed to do the deconstruction
---@param player PlayerSpecification @The player to set the last_user to if any
---@return LuaEntity @
function LuaTile.order_deconstruction(force, player) end

---Cancels deconstruction if it is scheduled, does nothing otherwise.
---@param force ForceSpecification @The force who did the deconstruction order
---@param player PlayerSpecification @The player to set the last_user to if any
function LuaTile.cancel_deconstruction(force, player) end

---@class LuaTilePrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field collision_mask CollisionMask @ [Read-only] 
---@field collision_mask_with_flags CollisionMaskWithFlags @ [Read-only] 
---@field layer uint @ [Read-only] 
---@field autoplace_specification AutoplaceSpecification @ [Read-only] Autoplace specification for this prototype. nil if none.
---@field walking_speed_modifier float @ [Read-only] 
---@field vehicle_friction_modifier float @ [Read-only] 
---@field map_color Color @ [Read-only] 
---@field decorative_removal_probability float @ [Read-only] 
---@field automatic_neighbors boolean @ [Read-only] 
---@field allowed_neighbors table<string, LuaTilePrototype> @ [Read-only] 
---@field needs_correction boolean @ [Read-only] If this tile needs correction logic applied when it's generated in the world..
---@field mineable_properties table @(optional) [Read-only] 
---@field next_direction LuaTilePrototype @ [Read-only] The next direction of this tile or nil - used when a tile has multiple directions (such as hazard concrete)
---@field items_to_place_this SimpleItemStack[] @ [Read-only] 
---@field can_be_part_of_blueprint boolean @ [Read-only] 
---@field emissions_per_second double @ [Read-only] 

---@class LuaTrain Get the amount of a particular item stored in the train.
---@field manual_mode boolean @ [Read-Write] 
---@field speed double @ [Read-Write] 
---@field max_forward_speed double @ [Read-only] 
---@field max_backward_speed double @ [Read-only] 
---@field weight double @ [Read-only] 
---@field carriages LuaEntity[] @ [Read-only] 
---@field locomotives table<string, LuaEntity> @ [Read-only] 
---@field cargo_wagons LuaEntity[] @ [Read-only] 
---@field fluid_wagons LuaEntity[] @ [Read-only] 
---@field schedule TrainSchedule @ [Read-Write] The trains current schedule or nil if empty. Set to nil to clear.
---@field state defines.train_state @ [Read-only] 
---@field front_rail LuaEntity @ [Read-only] 
---@field back_rail LuaEntity @ [Read-only] 
---@field rail_direction_from_front_rail defines.rail_direction @ [Read-only] 
---@field rail_direction_from_back_rail defines.rail_direction @ [Read-only] 
---@field front_stock LuaEntity @ [Read-only] 
---@field back_stock LuaEntity @ [Read-only] 
---@field station LuaEntity @ [Read-only] The train stop this train is stopped at or nil.
---@field has_path boolean @ [Read-only] If this train has a path.
---@field path_end_rail LuaEntity @ [Read-only] The destination rail this train is currently pathing to or nil.
---@field path_end_stop LuaEntity @ [Read-only] The destination train stop this train is currently pathing to or nil.
---@field id uint @ [Read-only] The unique train ID.
---@field passengers LuaPlayer[] @ [Read-only] The player passengers on the train
---@field riding_state RidingState @ [Read-only] The riding state of this train.
---@field killed_players table<uint, uint> @ [Read-only] The players killed by this train.
---@field kill_count uint @ [Read-only] The total number of kills by this train.
---@field path LuaRailPath @ [Read-only] The path this train is using or nil if none.
---@field signal LuaEntity @ [Read-only] The signal this train is arriving or waiting at or nil if none.

---Get the amount of a particular item stored in the train.
---@param item string @Item name to count. If not given, counts all items
---@return uint @
function LuaTrain.get_item_count(item) end

---Get a mapping of the train's inventory.
---@return dictionary string → uint @
function LuaTrain.get_contents() end

---Remove some items from the train.
---@param stack ItemStackSpecification @The amount and type of items to remov
---@return uint @
function LuaTrain.remove_item(stack) end

---Insert a stack into the train.
---@param stack ItemStackSpecification @
function LuaTrain.insert(stack) end

---Clear all items in this train.
function LuaTrain.clear_items_inside() end

---Checks if the path is invalid and tries to re-path if it isn't.
---@param force boolean @Forces the train to re-path regardless of the current path being valid or not
---@return boolean @
function LuaTrain.recalculate_path(force) end

---Get the amount of a particular fluid stored in the train.
---@param fluid string @Fluid name to count. If not given, counts all fluids
---@return double @
function LuaTrain.get_fluid_count(fluid) end

---Gets a mapping of the train's fluid inventory.
---@return dictionary string → double @
function LuaTrain.get_fluid_contents() end

---Remove some fluid from the train.
---@param fluid Fluid @
---@return double @
function LuaTrain.remove_fluid(fluid) end

---Inserts the given fluid into the first available location in this train.
---@param fluid Fluid @
---@return double @
function LuaTrain.insert_fluid(fluid) end

---Clears all fluids in this train.
function LuaTrain.clear_fluids_inside() end

---Go to the station specified by the index in the train's schedule.
---@param index uint @
function LuaTrain.go_to_station(index) end

---Gets all rails under the train.
---@return array of LuaEntity @
function LuaTrain.get_rails() end

---@class LuaTransportLine Remove all items from this transport line.
---@field hash_operator uint @ [Read-only] Get the number of items on this transport line.
---@field owner LuaEntity @ [Read-only] 
---@field output_lines LuaTransportLine[] @ [Read-only] 
---@field input_lines LuaTransportLine[] @ [Read-only] 
---@field bracket_operator LuaItemStack @ [Read-only] The indexing operator.

---Remove all items from this transport line.
function LuaTransportLine.clear() end

---Count some or all items on this line.
---@param item string @Prototype name of the item to count. If not specified, count all items
---@return uint @
function LuaTransportLine.get_item_count(item) end

---Remove some items from this line.
---@param items ItemStackSpecification @Items to remove
---@return uint @
function LuaTransportLine.remove_item(items) end

---Can an item be inserted at a given position?
---@param position float @Where to insert an item
---@return boolean @
function LuaTransportLine.can_insert_at(position) end

---Can an item be inserted at the back of this line?
---@return boolean @
function LuaTransportLine.can_insert_at_back() end

---Insert items at a given position.
---@param position float @Where on the line to insert the items
---@param items ItemStackSpecification @Items to insert
---@return boolean @
function LuaTransportLine.insert_at(position, items) end

---Insert items at the back of this line.
---@param items ItemStackSpecification @
---@return boolean @
function LuaTransportLine.insert_at_back(items) end

---Get counts of all items on this line.
---@return dictionary string → uint @
function LuaTransportLine.get_contents() end

---Returns whether the associated internal transport line of this line is the same as the others associated internal transport line.
---@param other LuaTransportLine @
---@return boolean @
function LuaTransportLine.line_equals(other) end

---@class LuaTrivialSmokePrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field color Color @ [Read-only] 
---@field start_scale double @ [Read-only] 
---@field end_scale double @ [Read-only] 
---@field movement_slow_down_factor double @ [Read-only] 
---@field duration uint @ [Read-only] 
---@field spread_duration uint @ [Read-only] 
---@field fade_away_duration uint @ [Read-only] 
---@field fade_in_duration uint @ [Read-only] 
---@field glow_fade_away_duration uint @ [Read-only] 
---@field cyclic boolean @ [Read-only] 
---@field affected_by_wind boolean @ [Read-only] 
---@field show_when_smoke_off boolean @ [Read-only] 
---@field glow_animation boolean @ [Read-only] 
---@field render_layer RenderLayer @ [Read-only] 

---@class LuaUnitGroup Make a unit a member of this group. Has the same effect as giving a group_command with this group to the unit.
---@field members LuaEntity[] @ [Read-only] 
---@field position Position @ [Read-only] 
---@field state defines.group_state @ [Read-only] 
---@field force LuaForce @ [Read-only] 
---@field surface LuaSurface @ [Read-only] 
---@field group_number uint @ [Read-only] The group number for this unit group.
---@field is_script_driven boolean @ [Read-only] Whether this unit group is controlled by a script or by the game engine.
---@field command Command @ [Read-only] The command given to this group or nil is the group has no command.
---@field distraction_command Command @ [Read-only] The distraction command given to this group or nil is the group currently isn't distracted.

---Make a unit a member of this group. Has the same effect as giving a group_command with this group to the unit.
---@param unit LuaEntity @
function LuaUnitGroup.add_member(unit) end

---Give this group a command.
---@param command Command @
function LuaUnitGroup.set_command(command) end

---Make this group autonomous. Autonomous groups will automatically attack polluted areas. Autonomous groups aren't considered to be script driven
function LuaUnitGroup.set_autonomous() end

---Make the group start moving even if some of its members haven't yet arrived.
function LuaUnitGroup.start_moving() end

---Dissolve this group. Its members won't be destroyed, they will be merely unlinked from this group.
function LuaUnitGroup.destroy() end

---@class LuaVirtualSignalPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field special boolean @ [Read-only] If this is a special signal
---@field subgroup LuaGroup @ [Read-only] 

---@class LuaVoidEnergySourcePrototype 
---@field emissions double @ [Read-only] 
---@field render_no_network_icon boolean @ [Read-only] 
---@field render_no_power_icon boolean @ [Read-only] 

---@class LuaAISettings If enabled, units that repeatedly fail to succeed at commands will be destroyed.
---@field allow_destroy_when_commands_fail boolean @ [Read-Write] If enabled, units that repeatedly fail to succeed at commands will be destroyed.
---@field allow_try_return_to_spawner boolean @ [Read-Write] If enabled, units that have nothing else to do will attempt to return to a spawner.
---@field do_separation boolean @ [Read-Write] If enabled, units will try to separate themselves from nearby friendly units.
---@field path_resolution_modifier int8 @ [Read-Write] The pathing resolution modifier, must be between -8 and 8.

---@class LuaAchievementPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field allowed_without_fight boolean @ [Read-only] 
---@field hidden boolean @ [Read-only] 

---@class LuaAmmoCategoryPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field bonus_gui_order string @ [Read-only] 

---@class LuaAutoplaceControlPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field richness boolean @ [Read-only] 
---@field control_order string @ [Read-only] 
---@field category string @ [Read-only] 

---@class LuaBootstrap Register a callback to be run on mod init. This is called once when a new save game is created or once when a save file is loaded that previously didn't contain the mod. This is always called before other event handlers and is meant for setting up initial values that a mod will use for its lifetime.
---@field mod_name string @ [Read-only] The name of the mod from the environment this is used in.
---@field active_mods table<string, string> @ [Read-only] The active mods versions. The keys are mod names, the values are the versions.
---@field is_game_in_debug_mode nil @ [Read-only] Is the game compiled in a debug mode. This will always return false in retail builds.
---@field object_name string @ [Read-only] This objects name.

---Register a callback to be run on mod init. This is called once when a new save game is created or once when a save file is loaded that previously didn't contain the mod. This is always called before other event handlers and is meant for setting up initial values that a mod will use for its lifetime.
---@param f fun() @The function to call. Passing nil will   unregister the handler
function LuaBootstrap.on_init(f) end

---Register a function to be run on module load. This is called every time a save file is loaded *except* for the instance when a mod is loaded into a save file that it previously wasn't part of. Additionally this is called when connecting to any other game in a multiplayer session and should never change the game state.
---@param f fun() @The function to call. Passing nil will unregister the handler
function LuaBootstrap.on_load(f) end

---Register a function to be run when mod configuration changes. This is called any time the game version changes, prototypes change, startup mod settings change, and any time mod versions change including adding or removing mods.
---@param f fun(arg0: ConfigurationChangedData) @
function LuaBootstrap.on_configuration_changed(f) end

---Register a handler to run on event or events.
---@param event defines.events | defines.events[] | defines.events | string @The events or custom-input name to invoke the handler o
---@param f fun(arg0: Event) @The handler to run. Passing nil will unregister the handler. The handler   will receive a table that contains the key name (of type defines.events) specifying the name   of the event it was called to handle, and tick that specifies when the event was created. This table will   also contain other fields, depending on the type of the event. See    the list of Factorio events for a listing of these additional fields
---@param filters Filters @The filters for this single event registration.   See  the list of event filters for a listing of these filters
function LuaBootstrap.on_event(event, f, filters) end

---Register a handler to run every nth tick(s). When the game is on tick 0 it will trigger all registered handlers.
---@param tick uint | uint[] | uint @The nth-tick(s) to invoke the handler on. Passing nil as the only parameter will unregister all nth-tick handlers
---@param f fun(arg0: NthTickEvent) @The handler to run. Passing nil will unregister the handler for the provided ticks
function LuaBootstrap.on_nth_tick(tick, f) end

---Registers an entity so that after it's destroyed on_entity_destroyed is called.
---@param entity LuaEntity @The entity to register
---@return uint64 @
function LuaBootstrap.register_on_entity_destroyed(entity) end

---Generate a new, unique event ID.
---@return uint @
function LuaBootstrap.generate_event_name() end

---
---@param event uint @The event identifier to get a handler fo
function LuaBootstrap.get_event_handler(event) end

---Gets the mod event order. type(string)
function LuaBootstrap.get_event_order() end

---Sets the filters for the given event.
---@param event uint @ID of the event to filter
---@param filters Filters @The  filters or nil to clear the filter
function LuaBootstrap.set_event_filter(event, filters) end

---Gets the filters for the given event.
---@param event uint @ID of the event to get
---@return table @
function LuaBootstrap.get_event_filter(event) end

---Raise an event. Only events generated with LuaBootstrap::generate_event_name and the following can be raised: on_console_chat on_player_crafted_item on_player_fast_transferred on_biter_base_built on_market_item_purchased script_raised_built script_raised_destroy script_raised_revive script_raised_set_tiles
---@param event uint @ID of the event to rais
---@param table table @Table with extra data. This table will be passed to the event handler
function LuaBootstrap.raise_event(event, table) end

---Raises on_console_chat
---@param table RaiseEventParameters @
function LuaBootstrap.raise_console_chat(table) end

---Raises on_player_crafted_item
---@param table RaiseEventParameters @
function LuaBootstrap.raise_player_crafted_item(table) end

---Raises on_player_fast_transferred
---@param table RaiseEventParameters @
function LuaBootstrap.raise_player_fast_transferred(table) end

---Raises on_biter_base_built
---@param table RaiseEventParameters @
function LuaBootstrap.raise_biter_base_built(table) end

---Raises on_market_item_purchased
---@param table RaiseEventParameters @
function LuaBootstrap.raise_market_item_purchased(table) end

---Raises script_raised_built
---@param table RaiseEventParameters @
function LuaBootstrap.raise_script_built(table) end

---Raises script_raised_destroy
---@param table RaiseEventParameters @
function LuaBootstrap.raise_script_destroy(table) end

---Raises script_raised_revive
---@param table RaiseEventParameters @
function LuaBootstrap.raise_script_revive(table) end

---Raises script_raised_set_tiles
---@param table RaiseEventParameters @
function LuaBootstrap.raise_script_set_tiles(table) end

---@class LuaBurner The owner of this burner energy source
---@field owner LuaEntity | LuaEquipment @ [Read-only] The owner of this burner energy source
---@field inventory LuaInventory @ [Read-only] The fuel inventory.
---@field burnt_result_inventory LuaInventory @ [Read-only] The burnt result inventory.
---@field heat double @ [Read-Write] 
---@field heat_capacity double @ [Read-only] 
---@field remaining_burning_fuel double @ [Read-Write] 
---@field currently_burning LuaItemPrototype @ [Read-Write] 
---@field fuel_categories table<string, boolean> @ [Read-only] The fuel categories this burner uses.

---@class LuaBurnerPrototype 
---@field emissions double @ [Read-only] 
---@field render_no_network_icon boolean @ [Read-only] 
---@field render_no_power_icon boolean @ [Read-only] 
---@field effectivity double @ [Read-only] 
---@field fuel_inventory_size uint @ [Read-only] 
---@field burnt_inventory_size uint @ [Read-only] 
---@field smoke SmokeSource[] @ [Read-only] The smoke sources for this burner prototype if any.
---@field light_flicker table @ [Read-only] The light flicker definition for this burner prototype if any.
---@field fuel_categories table<string, boolean> @ [Read-only] 

---@class LuaChunkIterator 

---
---@return ChunkPositionAndArea @
function LuaChunkIterator.operator__call() end

---@class LuaCircuitNetwork 
---@field entity LuaEntity @ [Read-only] 
---@field wire_type defines.wire_type @ [Read-only] 
---@field circuit_connector_id defines.circuit_connector_id @ [Read-only] 
---@field signals Signal[] @ [Read-only] 
---@field network_id uint @ [Read-only] 
---@field connected_circuit_count uint @ [Read-only] 

---
---@param signal SignalID @The signal to read
---@return int @
function LuaCircuitNetwork.get_signal(signal) end

---@class LuaCommandProcessor Add a command.
---@field commands table<string, LocalisedString> @ [Read-only] Commands registered by scripts through LuaCommandProcessor.
---@field game_commands table<string, LocalisedString> @ [Read-only] Builtin commands of the core game.
---@field object_name string @ [Read-only] This objects name.

---Add a command.
---@param name string @Name of the command (case sensitive)
---@param help LocalisedString @The localised help message
---@param func fun() @The function that will be called when this command is invoked
function LuaCommandProcessor.add_command(name, help, func) end

---Removes a registered command
---@return boolean @
function LuaCommandProcessor.remove_command() end

---@class LuaControl Get an inventory belonging to this entity. This can be either the "main" inventory or some auxiliary one, like the module slots or logistic trash slots.
---@field set_gui_arrow nil @ undefined Create an arrow which points at this entity. This is used in the tutorial. For examples, see control.lua in the campaign missions.
---@field begin_crafting uint @(optional) undefined Begins crafting the given count of the given recipe
---@field surface LuaSurface @ [Read-only] 
---@field position Position @ [Read-only] 
---@field vehicle LuaEntity @ [Read-only] 
---@field force ForceSpecification @ [Read-Write] The force of this entity. Reading will always give a LuaForce, but it is possible to assign either string or LuaForce to this attribute to change the force.
---@field selected LuaEntity @ [Read-Write] 
---@field opened LuaEntity | LuaItemStack | LuaEquipment | LuaEquipmentGrid | LuaPlayer | LuaGuiElement | defines.gui_type @ [Read-Write] 
---@field crafting_queue_size uint @ [Read-only] 
---@field walking_state table @ [Read-Write] Current walking state.
---@field riding_state RidingState @ [Read-Write] Current riding state of this car or the vehicle this player is riding in.
---@field mining_state table @(optional) [Read-Write] Current mining state.
---@field shooting_state table @ [Read-Write] Current shooting state.
---@field picking_state boolean @ [Read-Write] Current item-picking state.
---@field repair_state table @ [Read-Write] Current repair state.
---@field cursor_stack LuaItemStack @ [Read-only] 
---@field cursor_ghost ItemPrototypeSpecification @ [Read-Write] 
---@field driving boolean @ [Read-Write] 
---@field crafting_queue object[] @ [Read-only] Gets the current crafting queue items.
---@field following_robots LuaEntity[] @ [Read-only] The current combat robots following the character
---@field cheat_mode boolean @ [Read-Write] 
---@field character_crafting_speed_modifier double @ [Read-Write] 
---@field character_mining_speed_modifier double @ [Read-Write] 
---@field character_additional_mining_categories string[] @ [Read-Write] 
---@field character_running_speed_modifier double @ [Read-Write] 
---@field character_build_distance_bonus uint @ [Read-Write] 
---@field character_item_drop_distance_bonus uint @ [Read-Write] 
---@field character_reach_distance_bonus uint @ [Read-Write] 
---@field character_resource_reach_distance_bonus uint @ [Read-Write] 
---@field character_item_pickup_distance_bonus uint @ [Read-Write] 
---@field character_loot_pickup_distance_bonus uint @ [Read-Write] 
---@field character_inventory_slots_bonus uint @ [Read-Write] 
---@field character_trash_slot_count_bonus uint @ [Read-Write] 
---@field character_maximum_following_robot_count_bonus uint @ [Read-Write] 
---@field character_health_bonus float @ [Read-Write] 
---@field character_logistic_slot_count uint @ [Read-Write] 
---@field character_personal_logistic_requests_enabled boolean @ [Read-Write] 
---@field auto_trash_filters table<string, uint> @ [Read-Write] 
---@field opened_gui_type defines.gui_type @ [Read-only] 
---@field build_distance uint @ [Read-only] The build distance of this character or max uint when not a character or player connected to a character.
---@field drop_item_distance uint @ [Read-only] The item drop distance of this character or max uint when not a character or player connected to a character.
---@field reach_distance uint @ [Read-only] The reach distance of this character or max uint when not a character or player connected to a character.
---@field item_pickup_distance double @ [Read-only] The item pickup distance of this character or max double when not a character or player connected to a character.
---@field loot_pickup_distance double @ [Read-only] The loot pickup distance of this character or max double when not a character or player connected to a character.
---@field resource_reach_distance double @ [Read-only] The resource reach distance of this character or max double when not a character or player connected to a character.
---@field in_combat boolean @ [Read-only] If this character entity is in combat.
---@field character_running_speed double @ [Read-only] Gets the current movement speed of this character, including effects from exoskeletons, tiles, stickers and shooting.
---@field character_mining_progress double @ [Read-only] Gets the current mining progress between 0 and 1 of this character, or 0 if they aren't mining.

---Get an inventory belonging to this entity. This can be either the "main" inventory or some auxiliary one, like the module slots or logistic trash slots.
---@param inventory defines.inventory @
---@return LuaInventory @
function LuaControl.get_inventory(inventory) end

---Gets the main inventory for this character or player if this is a character or player.
---@return LuaInventory @
function LuaControl.get_main_inventory() end

---Can at least some items be inserted?
---@param items ItemStackSpecification @Items that would be inserted
---@return boolean @
function LuaControl.can_insert(items) end

---Insert items into this entity. This works the same way as inserters or shift-clicking: the "best" inventory is chosen automatically.
---@param items ItemStackSpecification @Items to insert
---@return uint @
function LuaControl.insert(items) end

---Removes the arrow created by set_gui_arrow.
function LuaControl.clear_gui_arrow() end

---Get the number of all or some items in this entity.
---@param item string @Prototype name of the item to count. If not specified, count all items
---@return uint @
function LuaControl.get_item_count(item) end

---Does this entity have any item inside it?
---@return boolean @
function LuaControl.has_items_inside() end

---Can a given entity be opened or accessed?
---@param entity LuaEntity @
---@return boolean @
function LuaControl.can_reach_entity(entity) end

---Remove all items from this entity.
function LuaControl.clear_items_inside() end

---Remove items from this entity.
---@param items ItemStackSpecification @Items to remove
---@return uint @
function LuaControl.remove_item(items) end

---Teleport the entity to a given position, possibly on another surface.
---@param position Position @Where to teleport to
---@param surface SurfaceSpecification @Surface to teleport to. If not given, will teleport   to the entity's current surface. Only players and cars can be teleported cross-surface
---@return boolean @
function LuaControl.teleport(position, surface) end

---Select an entity, as if by hovering the mouse above it.
---@param position Position @Position of the entity to selec
function LuaControl.update_selected_entity(position) end

---Unselect any selected entity.
function LuaControl.clear_selected_entity() end

---Disable the flashlight.
function LuaControl.disable_flashlight() end

---Enable the flashlight.
function LuaControl.enable_flashlight() end

---Is the flashlight enabled.
function LuaControl.is_flashlight_enabled() end

---Gets the count of the given recipe that can be crafted.
---@param recipe string | LuaRecipe @The recipe
---@return uint @
function LuaControl.get_craftable_count(recipe) end

---Cancels crafting the given count of the given crafting queue index
---@param options uint @The crafting queue index.count :: uint:  The count to cancel crafting
function LuaControl.cancel_crafting(options) end

---Mines the given entity as if this player (or character) mined it.
---@param entity LuaEntity @The entity to min
---@param force boolean @Forces mining the entity even if the items can't fit in the player
---@return boolean @
function LuaControl.mine_entity(entity, force) end

---Mines the given tile as if this player (or character) mined it.
---@param tile LuaTile @The tile to mine
---@return boolean @
function LuaControl.mine_tile(tile) end

---
---@return boolean @
function LuaControl.is_player() end

---Open the technology GUI and select a given technology.
---@param technology TechnologySpecification @The technology to select after opening the GUI
function LuaControl.open_technology_gui(technology) end

---Sets the personal request and trash to the given values.
---@param slot_index uint @The slot to set
---@param value PersonalLogisticParameters @
---@return boolean @
function LuaControl.set_personal_logistic_slot(slot_index, value) end

---Sets the personal request and trash to the given values.
---@param slot_index uint @The slot to get
---@return PersonalLogisticParameters @
function LuaControl.get_personal_logistic_slot(slot_index) end

---
---@param slot_index uint @The slot to clear
function LuaControl.clear_personal_logistic_slot(slot_index) end

---@class LuaControlBehavior : LuaControlBehavior The control behavior for an entity. Inserters have logistic network and circuit network behavior logic, lamps have circuit logic and so on. This is an abstract base class that concrete control behaviors inherit.
---@field type defines.control_behavior.type @ [Read-only] 
---@field entity LuaEntity @ [Read-only] 

---
---@param wire defines.wire_type @Wire color of the network connected to this entity
---@param circuit_connector defines.circuit_connector_id @The connector to get circuit network for.   Must be specified for entities with more than one circuit network connector
---@return LuaCircuitNetwork @
function LuaControlBehavior.get_circuit_network(wire, circuit_connector) end

---@class LuaAccumulatorControlBehavior : LuaControlBehavior Control behavior for accumulators.
---@field output_signal SignalID @ [Read-Write] 

---@class LuaCombinatorControlBehavior 
---@field signals_last_tick Signal[] @ [Read-only] 

---Gets the value of a specific signal sent by this combinator behavior last tick or nil if the signal didn't exist.
---@param signal SignalID @The signal to ge
---@return int @
function LuaCombinatorControlBehavior.get_signal_last_tick(signal) end

---@class LuaConstantCombinatorControlBehavior : LuaControlBehavior Control behavior for constant combinators.
---@field parameters ConstantCombinatorParameters @ [Read-Write] 
---@field enabled boolean @ [Read-Write] Turns this constant combinator on and off.
---@field signals_count uint @ [Read-only] The number of signals this constant combinator supports

---Sets the signal at the given index
---@param index uint @
---@param signal Signal @
function LuaConstantCombinatorControlBehavior.set_signal(index, signal) end

---Gets the signal at the given index. Returned Signal will not contain signal if none is set for the index.
---@param index uint @
---@return Signal @
function LuaConstantCombinatorControlBehavior.get_signal(index) end

---@class LuaContainerControlBehavior : LuaControlBehavior Control behavior for container entities.

---@class LuaGenericOnOffControlBehavior : LuaControlBehavior An abstract base class for behaviors that support switching the entity on or off based on some condition.
---@field disabled boolean @ [Read-only] 
---@field circuit_condition CircuitConditionSpecification @ [Read-Write] 
---@field logistic_condition CircuitConditionSpecification @ [Read-Write] 
---@field connect_to_logistic_network boolean @ [Read-Write] 

---@class LuaLogisticContainerControlBehavior : LuaControlBehavior Control behavior for logistic chests.
---@field circuit_mode_of_operation defines.control_behavior.logistic_container.circuit_mode_of_operation @ [Read-Write] 

---@class LuaProgrammableSpeakerControlBehavior : LuaControlBehavior Control behavior for programmable speakers.
---@field circuit_parameters ProgrammableSpeakerCircuitParameters @ [Read-Write] 
---@field circuit_condition CircuitConditionSpecification @ [Read-Write] 

---@class LuaRailChainSignalControlBehavior : LuaControlBehavior Control behavior for rail chain signals.
---@field red_signal SignalID @ [Read-Write] 
---@field orange_signal SignalID @ [Read-Write] 
---@field green_signal SignalID @ [Read-Write] 
---@field blue_signal SignalID @ [Read-Write] 

---@class LuaRailSignalControlBehavior : LuaControlBehavior Control behavior for rail signals.
---@field red_signal SignalID @ [Read-Write] 
---@field orange_signal SignalID @ [Read-Write] 
---@field green_signal SignalID @ [Read-Write] 
---@field close_signal boolean @ [Read-Write] If this will close the rail signal based off the circuit condition.
---@field read_signal boolean @ [Read-Write] If this will read the rail signal state.
---@field circuit_condition CircuitConditionSpecification @ [Read-Write] The circuit condition when controlling the signal through the circuit network.

---@class LuaRoboportControlBehavior : LuaControlBehavior Control behavior for roboports.
---@field read_logistics boolean @ [Read-Write] 
---@field read_robot_stats boolean @ [Read-Write] 
---@field available_logistic_output_signal SignalID @ [Read-Write] 
---@field total_logistic_output_signal SignalID @ [Read-Write] 
---@field available_construction_output_signal SignalID @ [Read-Write] 
---@field total_construction_output_signal SignalID @ [Read-Write] 

---@class LuaStorageTankControlBehavior : LuaControlBehavior Control behavior for storage tanks.

---@class LuaWallControlBehavior : LuaControlBehavior Control behavior for walls.
---@field circuit_condition CircuitConditionSpecification @ [Read-Write] 
---@field open_gate boolean @ [Read-Write] 
---@field read_sensor boolean @ [Read-Write] 
---@field output_signal SignalID @ [Read-Write] 

---@class LuaArithmeticCombinatorControlBehavior : LuaControlBehavior Control behavior for arithmetic combinators.
---@field parameters ArithmeticCombinatorParameters @ [Read-Write] 

---@class LuaDeciderCombinatorControlBehavior : LuaCombinatorControlBehavior Control behavior for decider combinators.
---@field parameters DeciderCombinatorParameters @ [Read-Write] 

---@class LuaInserterControlBehavior : LuaControlBehavior Control behavior for inserters.
---@field circuit_read_hand_contents boolean @ [Read-Write] 
---@field circuit_mode_of_operation defines.control_behavior.inserter.circuit_mode_of_operation @ [Read-Write] 
---@field circuit_hand_read_mode defines.control_behavior.inserter.hand_read_mode @ [Read-Write] 
---@field circuit_set_stack_size boolean @ [Read-Write] If the stack size of the inserter is set through the circuit network or not.
---@field circuit_stack_control_signal SignalID @ [Read-Write] The signal used to set the stack size of the inserter.

---@class LuaLampControlBehavior : LuaControlBehavior Control behavior for lamps.
---@field use_colors boolean @ [Read-Write] 
---@field color Color @ [Read-only] The color the lamp is showing or nil if not using any color.

---@class LuaMiningDrillControlBehavior : LuaControlBehavior Control behavior for mining drills.
---@field circuit_enable_disable boolean @ [Read-Write] 
---@field circuit_read_resources boolean @ [Read-Write] 
---@field resource_read_mode defines.control_behavior.mining_drill.resource_read_mode @ [Read-Write] 
---@field resource_read_targets LuaEntity[] @ [Read-only] 

---@class LuaTrainStopControlBehavior : LuaControlBehavior Control behavior for train stops.
---@field send_to_train boolean @ [Read-Write] 
---@field read_from_train boolean @ [Read-Write] 
---@field read_stopped_train boolean @ [Read-Write] 
---@field enable_disable boolean @ [Read-Write] 
---@field stopped_train_signal SignalID @ [Read-Write] The signal that will be sent when using the send-train-id option.

---@class LuaTransportBeltControlBehavior : LuaControlBehavior Control behavior for transport belts.
---@field enable_disable boolean @ [Read-Write] If the belt will be enabled/disabled based off the circuit network.
---@field read_contents boolean @ [Read-Write] If the belt will read the contents and send them to the circuit network.
---@field read_contents_mode defines.control_behavior.transport_belt.content_read_mode @ [Read-Write] 

---@class LuaCustomChartTag Destroys this tag.
---@field icon SignalID @ [Read-Write] 
---@field last_user LuaPlayer @ [Read-Write] The player who last edited this tag.
---@field position Position @ [Read-only] The position of this tag.
---@field text string @ [Read-Write] 
---@field tag_number uint @ [Read-only] The unique ID for this tag on this force.
---@field force LuaForce @ [Read-only] The force this tag belongs to.
---@field surface LuaSurface @ [Read-only] The surface this tag belongs to.

---Destroys this tag.
function LuaCustomChartTag.destroy() end

---@class LuaCustomInputPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field key_sequence string @ [Read-only] The default key sequence for this custom input.
---@field alternative_key_sequence string @ [Read-only] The default alternative key sequence for this custom input. nil when not defined.
---@field linked_game_control string @ [Read-only] The linked game control name or nil.
---@field consuming string @ [Read-only] The consuming type: "none" or "game-only".
---@field enabled boolean @ [Read-only] If this custom input is enabled. Disabled custom inputs exist but are not used by the game.

---@class LuaCustomTable Access an element of this custom table.
---@field bracket_operator nil @ [Read-Write] Access an element of this custom table.
---@field hash_operator uint @ [Read-only] 

---@class LuaDamagePrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field hidden boolean @ [Read-only] Whether this damage type is hidden from entity tooltips.

---@class LuaDecorativePrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field collision_box BoundingBox @ [Read-only] 
---@field collision_mask CollisionMask @ [Read-only] 
---@field collision_mask_with_flags CollisionMaskWithFlags @ [Read-only] 
---@field autoplace_specification AutoplaceSpecification @ [Read-only] Autoplace specification for this decorative prototype. nil if none.

---@class LuaElectricEnergySourcePrototype 
---@field buffer_capacity double @ [Read-only] 
---@field usage_priority string @ [Read-only] 
---@field input_flow_limit double @ [Read-only] 
---@field output_flow_limit double @ [Read-only] 
---@field drain double @ [Read-only] 
---@field emissions double @ [Read-only] 
---@field render_no_network_icon boolean @ [Read-only] 
---@field render_no_power_icon boolean @ [Read-only] 

---@class LuaEntity : LuaControl Gets the entities output inventory if it has one.
---@field order_upgrade boolean @(optional) undefined Sets the entity to be upgraded by construction robots.
---@field get_connected_rail LuaEntity @ undefined 
---@field clone LuaEntity @(optional) undefined Clones this entity.
---@field remove_fluid double @(optional) undefined Remove fluid from this entity.
---@field name string @ [Read-only] Name of the entity prototype. E.g. "inserter" or "filter-inserter".
---@field ghost_name string @ [Read-only] Name of the entity or tile contained in this ghost
---@field localised_name LocalisedString @ [Read-only] Localised name of the entity.
---@field localised_description LocalisedString @ [Read-only] 
---@field ghost_localised_name LocalisedString @ [Read-only] Localised name of the entity or tile contained in this ghost.
---@field ghost_localised_description LocalisedString @ [Read-only] 
---@field type string @ [Read-only] 
---@field ghost_type string @ [Read-only] 
---@field active boolean @ [Read-Write] Deactivating an entity will stop all its operations (car will stop moving, inserters will stop working, fish will stop moving etc).
---@field destructible boolean @ [Read-Write] When the entity is not destructible it can't be damaged.
---@field minable boolean @ [Read-Write] 
---@field rotatable boolean @ [Read-Write] When entity is not to be rotatable (inserter, transport belt etc), it can't be rotated by player using the R key.
---@field operable boolean @ [Read-Write] Player can't open gui of this entity and he can't quick insert/input stuff in to the entity when it is not operable.
---@field health float @ [Read-Write] 
---@field direction defines.direction @ [Read-Write] The current direction this entity is facing.
---@field supports_direction boolean @ [Read-only] Whether the entity has direction. When it is false for this entity, it will always return north direction when asked for.
---@field orientation float @ [Read-Write] The smooth orientation.
---@field cliff_orientation string @ [Read-only] The orientation of this cliff.
---@field amount uint @ [Read-Write] 
---@field initial_amount uint @ [Read-Write] 
---@field effectivity_modifier float @ [Read-Write] Multiplies the acceleration the vehicle can create for one unit of energy. By default is 1.
---@field consumption_modifier float @ [Read-Write] Multiplies the energy consumption.
---@field friction_modifier float @ [Read-Write] Multiplies the car friction rate.
---@field driver_is_gunner boolean @ [Read-Write] Whether the driver of this car is the gunner, if false, the passenger is the gunner.
---@field speed float @ [Read-Write] The current speed of the car or rolling stock or projectile, or current max speed of the unit. Only the speed of units, cars, and projectiles are writable.
---@field effective_speed float @ [Read-only] The current speed of a unit, taking into account any walking speed modifier given by the tile the unit is standing on.
---@field stack LuaItemStack @ [Read-only] 
---@field prototype LuaEntityPrototype @ [Read-only] 
---@field ghost_prototype LuaEntityPrototype | LuaTilePrototype @ [Read-only] 
---@field drop_position Position @ [Read-Write] Position where the entity puts its stuff.
---@field pickup_position Position @ [Read-Write] Where the inserter will pick up items from.
---@field drop_target LuaEntity @ [Read-Write] The entity this entity is putting its stuff to or nil if there is no such entity.
---@field pickup_target LuaEntity @ [Read-Write] The entity the inserter will attempt to pick up from. For example, this can be a transport belt or a storage chest.
---@field selected_gun_index uint @ [Read-Write] Index of the currently selected weapon slot of this character or car, or nil if the car doesn't have guns.
---@field energy double @ [Read-Write] Energy stored in the entity (heat in furnace, energy stored in electrical devices etc.). always 0 for entities that don't have the concept of energy stored inside.
---@field temperature double @ [Read-Write] The temperature of this entities heat energy source if this entity uses a heat energy source or nil.
---@field previous_recipe LuaRecipe @ [Read-only] The previous recipe this furnace was using or nil if the furnace had no previous recipe.
---@field held_stack LuaItemStack @ [Read-only] The item stack currently held in an inserter's hand.
---@field held_stack_position Position @ [Read-only] Current position of the inserter's "hand".
---@field train LuaTrain @ [Read-only] The train this rolling stock belongs to or nil if not rolling stock.
---@field neighbours table<string, LuaEntity> | string | LuaEntity[] | LuaEntity | LuaEntity[] | LuaEntity[] | LuaEntity | LuaEntity @ [Read-only] 
---@field belt_neighbours table<string, LuaEntity> @ [Read-only] The belt connectable neighbours of this belt connectable entity. Only entities that input to or are outputs of this entity. Does not contain the other end of an underground belt, see LuaEntity::neighbours for that. This is a dictionary with "inputs", "outputs" entries that are arrays of transport belt connectable entities, or empty tables if no entities.
---@field fluidbox LuaFluidBox @ [Read-Write] Fluidboxes of this entity.
---@field backer_name string @ [Read-Write] The name of a backer (of Factorio) assigned to a lab or train station / stop.
---@field time_to_live uint @ [Read-Write] The ticks left before a ghost, combat robot or highlight box is destroyed.
---@field color Color @ [Read-Write] The character, rolling stock, train stop, car, flying text, corpse or simple-entity-with-owner color. Returns nil if this entity doesn't use custom colors.
---@field text LocalisedString @ [Read-Write] The text of this flying-text entity.
---@field signal_state defines.signal_state @ [Read-only] The state of this rail signal.
---@field chain_signal_state defines.chain_signal_state @ [Read-only] The state of this chain signal.
---@field to_be_looted boolean @ [Read-Write] Will this entity be picked up automatically when the player walks over it?
---@field crafting_speed double @ [Read-only] The current crafting speed, including speed bonuses from modules and beacons.
---@field crafting_progress float @ [Read-Write] The current crafting progress, as a number in range [0, 1].
---@field bonus_progress double @ [Read-Write] The current productivity bonus progress, as a number in range [0, 1].
---@field productivity_bonus double @ [Read-only] The productivity bonus of this entity.
---@field pollution_bonus double @ [Read-only] The pollution bonus of this entity.
---@field speed_bonus double @ [Read-only] The speed bonus of this entity.
---@field consumption_bonus double @ [Read-only] The consumption bonus of this entity.
---@field belt_to_ground_type string @ [Read-only] "input" or "output", depending on whether this underground belt goes down or up.
---@field loader_type string @ [Read-Write] "input" or "output", depending on whether this loader puts to or gets from a container.
---@field rocket_parts uint @ [Read-Write] Number of rocket parts in the silo.
---@field logistic_network LuaLogisticNetwork @ [Read-Write] The logistic network this entity is a part of.
---@field logistic_cell LuaLogisticCell @ [Read-only] The logistic cell this entity is a part of. Will be nil if this entity is not a part of any logistic cell.
---@field item_requests table<string, uint> @ [Read-Write] 
---@field player LuaPlayer @ [Read-only] The player connected to this character or nil if none.
---@field unit_group LuaUnitGroup @ [Read-only] The unit group this unit is a member of, or nil if none.
---@field damage_dealt double @ [Read-Write] The damage dealt by this turret, artillery turret, or artillery wagon.
---@field kills uint @ [Read-Write] The number of units killed by this turret, artillery turret, or artillery wagon.
---@field last_user LuaPlayer @ [Read-Write] The player who built the entity
---@field electric_buffer_size double @ [Read-Write] The buffer size for the electric energy source or nil if the entity doesn't have an electric energy source.
---@field electric_input_flow_limit double @ [Read-only] The input flow limit for the electric energy source or nil if the entity doesn't have an electric energy source.
---@field electric_output_flow_limit double @ [Read-only] The output flow limit for the electric energy source or nil if the entity doesn't have an electric energy source.
---@field electric_drain double @ [Read-only] The electric drain for the electric energy source or nil if the entity doesn't have an electric energy source.
---@field electric_emissions double @ [Read-only] The emissions for the electric energy source or nil if the entity doesn't have an electric energy source.
---@field unit_number uint @ [Read-only] 
---@field ghost_unit_number uint @ [Read-only] The unit number of the entity contained in this ghost or nil if the entity doesn't have one.
---@field mining_progress double @ [Read-Write] The mining progress for this mining drill or nil if this isn't a mining drill.  Is a number in range [0, mining_target.prototype.mineable_properties.mining_time]
---@field bonus_mining_progress double @ [Read-Write] The bonus mining progress for this mining drill or nil if this isn't a mining drill.  Read yields a number in range [0, mining_target.prototype.mineable_properties.mining_time]
---@field power_production double @ [Read-Write] The power production specific to the ElectricEnergyInterface entity type.
---@field power_usage double @ [Read-Write] The power usage specific to the ElectricEnergyInterface entity type.
---@field bounding_box BoundingBox @ [Read-only] LuaEntityPrototype::collision_box around entity's given position and respecting the current entity orientation.
---@field secondary_bounding_box BoundingBox @ [Read-only] The secondary bounding box of this entity or nil if it doesn't have one.
---@field selection_box BoundingBox @ [Read-only] LuaEntityPrototype::selection_box around entity's given position and respecting the current entity orientation.
---@field secondary_selection_box BoundingBox @ [Read-only] The secondary selection box of this entity or nil if it doesn't have one.
---@field mining_target LuaEntity @ [Read-only] 
---@field circuit_connected_entities table @ [Read-only] Entities connected to this entity via the circuit network.
---@field circuit_connection_definitions object[] @ [Read-only] The connection definition for entities connected to this entity via the circuit network.
---@field request_slot_count uint @ [Read-only] The number of request slots this entity has.
---@field filter_slot_count uint @ [Read-only] The number of filter slots this inserter or loader has. 0 if not an inserter or loader.
---@field loader_container LuaEntity @ [Read-only] The container entity this loader is pointing at/pulling from depending on the LuaEntity::loader_type.
---@field grid LuaEquipmentGrid @ [Read-only] The equipment grid or nil if this entity doesn't have an equipment grid.
---@field graphics_variation uint8 @ [Read-Write] The graphics variation for this entity or nil if this entity doesn't use graphics variations.
---@field tree_color_index uint8 @ [Read-Write] Index of the tree color.
---@field tree_color_index_max uint8 @ [Read-only] Maximum index of the tree colors.
---@field tree_stage_index uint8 @ [Read-Write] Index of the tree stage.
---@field tree_stage_index_max uint8 @ [Read-only] Maximum index of the tree stages.
---@field burner LuaBurner @ [Read-only] The burner energy source for this entity or nil if there isn't one.
---@field shooting_target LuaEntity @ [Read-Write] The shooting target for this turret or nil.
---@field proxy_target LuaEntity @ [Read-only] The target entity for this item-request-proxy or nil
---@field stickers LuaEntity[] @ [Read-only] The sticker entities attached to this entity.
---@field sticked_to LuaEntity @ [Read-only] The entity this sticker is sticked to.
---@field parameters ProgrammableSpeakerParameters @ [Read-Write] 
---@field alert_parameters ProgrammableSpeakerAlertParameters @ [Read-Write] 
---@field electric_network_statistics LuaFlowStatistics @ [Read-only] 
---@field inserter_stack_size_override uint @ [Read-Write] Sets the stack size limit on this inserter. If the stack size is > than the force stack size limit the value is ignored.
---@field products_finished uint @ [Read-Write] The number of products this machine finished crafting in its lifetime.
---@field spawner LuaEntity @ [Read-only] The spawner associated with this unit entity or nil if the unit has no associated spawner.
---@field units LuaEntity[] @ [Read-only] The units associated with this spawner entity.
---@field power_switch_state boolean @ [Read-Write] The state of this power switch.
---@field relative_turret_orientation float @ [Read-Write] The relative orientation of the vehicle turret or nil if this entity isn't a vehicle or have a vehicle turret.
---@field effects Effects @ [Read-only] The effects being applied to this entity or nil. For beacons this is the effect the beacon is broadcasting.
---@field infinity_container_filters InfinityInventoryFilter[] @ [Read-Write] The filters for this infinity container.
---@field remove_unfiltered_items boolean @ [Read-Write] If items not included in this infinity container filters should be removed from the container.
---@field character_corpse_player_index uint @ [Read-Write] The player index associated with this character corpse.
---@field character_corpse_tick_of_death uint @ [Read-Write] The tick this character corpse died at.
---@field character_corpse_death_cause LocalisedString @ [Read-Write] The reason this character corpse character died (if any).
---@field associated_player LuaPlayer @ [Read-Write] The player this character is associated with or nil if none. When the player logs off in multiplayer all of the associated characters will be logged off with him.
---@field tick_of_last_attack uint @ [Read-Write] The last tick this character entity was attacked.
---@field tick_of_last_damage uint @ [Read-Write] The last tick this character entity was damaged.
---@field splitter_filter LuaItemPrototype @ [Read-Write] The filter for this splitter or nil if no filter is set.
---@field inserter_filter_mode string @ [Read-Write] The filter mode for this filter inserter: "whitelist", "blacklist", or nil if this inserter doesn't use filters.
---@field splitter_input_priority string @ [Read-Write] The input priority for this splitter : "left", "none", or "right".
---@field splitter_output_priority string @ [Read-Write] The output priority for this splitter : "left", "none", or "right".
---@field armed boolean @ [Read-only] If this land mine is armed.
---@field recipe_locked boolean @ [Read-Write] When locked; the recipe in this assembling machine can't be changed by the player.
---@field connected_rail LuaEntity @ [Read-only] The rail entity this train stop is connected to or nil if there is none.
---@field trains_in_block uint @ [Read-only] The number of trains in this rail block for this rail entity.
---@field timeout uint @ [Read-Write] The timeout left on this landmine in ticks.
---@field neighbour_bonus double @ [Read-only] The current total neighbour bonus of this reactor.
---@field ai_settings LuaAISettings @ [Read-only] The ai settings of this unit.
---@field highlight_box_type string @ [Read-Write] The hightlight box type of this highlight box entity.
---@field highlight_box_blink_interval uint @ [Read-Write] The blink interval of this highlight box entity. 0 indicates no blink.
---@field status defines.entity_status @ [Read-only] The status of this entity or nil if no status.
---@field enable_logistics_while_moving boolean @ [Read-Write] If equipment grid logistics are enabled while this vehicle is moving.
---@field render_player LuaPlayer @ [Read-Write] The player that this simple-entity-with-owner, simple-entity-with-force, flying-text or highlight-box is visible to or nil. Set to nil to clear.
---@field render_to_forces ForceSpecification[] @ [Read-Write] The forces that this simple-entity-with-owner, simple-entity-with-force or flying-text is visible to or nil. Set to nil to clear.
---@field pump_rail_target LuaEntity @ [Read-only] The rail target of this pump or nil.
---@field moving LuaEntity @ [Read-only] Returns true if this unit is moving.
---@field electric_network_id uint @ [Read-only] Returns the id of the electric network that this entity is connected to or nil.
---@field allow_dispatching_robots boolean @ [Read-Write] Whether this character's personal roboports are allowed to dispatch robots.
---@field auto_launch boolean @ [Read-Write] Whether this rocket silo automatically launches the rocket when cargo is inserted.
---@field energy_generated_last_tick double @ [Read-only] How much energy this generator generated in the last tick.
---@field storage_filter LuaItemPrototype @ [Read-Write] The storage filter for this logistic storage container.
---@field request_from_buffers boolean @ [Read-Write] Whether this requester chest is set to also request from buffer chests.
---@field corpse_expires boolean @ [Read-Write] Whether this corpse will ever fade away.
---@field corpse_immune_to_entity_placement boolean @ [Read-Write] If true, corpse won't be destroyed when entities are placed over it. If false, whether corpse will be removed or not depends on value of CorpsePrototype::remove_on_entity_placement.
---@field tags Tags @ [Read-Write] The tags associated with this entity ghost or nil if not an entity ghost.
---@field command Command @ [Read-only] The command given to this unit or nil is the unit has no command.
---@field distraction_command Command @ [Read-only] The distraction command given to this unit or nil is the unit currently isn't distracted.

---Gets the entities output inventory if it has one.
---@return LuaInventory @
function LuaEntity.get_output_inventory() end

---
---@return LuaInventory @
function LuaEntity.get_module_inventory() end

---The fuel inventory for this entity or nil if this entity doesn't have a fuel inventory.
---@return LuaInventory @
function LuaEntity.get_fuel_inventory() end

---The burnt result inventory for this entity or nil if this entity doesn't have a burnt result inventory.
---@return LuaInventory @
function LuaEntity.get_burnt_result_inventory() end

---Damages the entity.
---@param damage float @The amount of damage to be don
---@param force ForceSpecification @The force that will be doing the damage
---@param type string @The type of damage to be done, defaults to "impact"
---@param dealer LuaEntity @The entity to consider as the damage dealer
---@return float @
function LuaEntity.damage(damage, force, type, dealer) end

---Checks if the entity can be destroyed
---@return boolean @
function LuaEntity.can_be_destroyed() end

---Destroys the entity.
---@param opts boolean @Table with the following fields: do_cliff_correction :: boolean  (optional):  If neighbouring cliffs should be corrected. Defaults to false.raise_destroy :: boolean  (optional):  If true; defines.events.script_raised_destroy will be called
---@return boolean @
function LuaEntity.destroy(opts) end

---Give the entity a command.
---@param command Command @
function LuaEntity.set_command(command) end

---Has this unit been assigned a command?
---@return boolean @
function LuaEntity.has_command() end

---Immediately kills the entity. Doesn't care whether the entity is destroyable or damageable. Does nothing if the entity doesn't have health. Unlike LuaEntity::destroy, die will trigger on_entity_died and the entity will drop loot and corpse if it have any.
---@param force ForceSpecification @The force to attribute the kill to
---@param cause LuaEntity @The cause to attribute the kill to
---@return boolean @
function LuaEntity.die(force, cause) end

---Test whether this entity's prototype has a flag set.
---@param flag string @The flag to tes
---@return boolean @
function LuaEntity.has_flag(flag) end

---Same as LuaEntity::has_flag but targets the inner entity on a entity ghost.
---@param flag string @The flag to tes
---@return boolean @
function LuaEntity.ghost_has_flag(flag) end

---Offer a thing on the market.
---@param offer Offer @
function LuaEntity.add_market_item(offer) end

---Remove an offer from a market.
---@param offer uint @Index of offer to remove
---@return boolean @
function LuaEntity.remove_market_item(offer) end

---Get all offers in a market as an array.
---@return array of Offer @
function LuaEntity.get_market_items() end

---Removes all offers from a market.
function LuaEntity.clear_market_items() end

---Connect two devices with wire or cable.
---@param target LuaEntity | table @Wire color, either defines.wire_type.red or           defines.wire_type.green.target_entity :: LuaEntity:  The entity to connect the wire tosource_circuit_id :: uint  (optional):  Mandatory if the source entity has more than one           circuit connector.target_circuit_id :: uint  (optional):  Mandatory if the target entity has more than one           circuit connector
---@return boolean @
function LuaEntity.connect_neighbour(target) end

---Disconnect wires or cables.
---@param target defines.wire_type | LuaEntity | table @Wire colortarget_entity :: LuaEntitysource_circuit_id :: uint  (optional)target_circuit_id :: uint  (optional
function LuaEntity.disconnect_neighbour(target) end

---Sets the entity to be deconstructed by construction robots.
---@param force ForceSpecification @The force whose robots are supposed to do the deconstruction
---@param player PlayerSpecification @The player to set the last_user to if any
---@return boolean @
function LuaEntity.order_deconstruction(force, player) end

---Cancels deconstruction if it is scheduled, does nothing otherwise.
---@param force ForceSpecification @The force who did the deconstruction order
---@param player PlayerSpecification @The player to set the last_user to if any
function LuaEntity.cancel_deconstruction(force, player) end

---Is this entity marked for deconstruction?
---@return boolean @
function LuaEntity.to_be_deconstructed() end

---Cancels upgrade if it is scheduled, does nothing otherwise.
---@param force ForceSpecification @The force who did the upgrade order
---@param player PlayerSpecification @The player to set the last_user to if any
---@return boolean @
function LuaEntity.cancel_upgrade(force, player) end

---Is this entity marked for upgrade?
---@return boolean @
function LuaEntity.to_be_upgraded() end

---Get a logistic requester slot.
---@param slot uint @The slot index
---@return SimpleItemStack @
function LuaEntity.get_request_slot(slot) end

---Set a logistic requester slot.
---@param request ItemStackSpecification @What to request
---@param slot uint @The slot index
function LuaEntity.set_request_slot(request, slot) end

---Clear a logistic requester slot.
---@param slot uint @The slot index
function LuaEntity.clear_request_slot(slot) end

---
---@return boolean @
function LuaEntity.is_crafting() end

---
---@return boolean @
function LuaEntity.is_opened() end

---
---@return boolean @
function LuaEntity.is_opening() end

---
---@return boolean @
function LuaEntity.is_closed() end

---
---@return boolean @
function LuaEntity.is_closing() end

---
---@param force ForceSpecification @The force that requests the gate to be open
---@param extra_time uint @Extra ticks to stay open
function LuaEntity.request_to_open(force, extra_time) end

---
---@param force ForceSpecification @The force that requests the gate to be closed
function LuaEntity.request_to_close(force) end

---Get a transport line of a belt or belt connectable entity.
---@param index uint @Index of the requested transport line
---@return LuaTransportLine @
function LuaEntity.get_transport_line(index) end

---Get the maximum transport line index of a belt or belt connectable entity.
---@return uint @
function LuaEntity.get_max_transport_line_index() end

---
---@return boolean @
function LuaEntity.launch_rocket() end

---Revive a ghost. I.e. turn it from a ghost to a real entity or tile.
---@param opts boolean @Table with the following fields: return_item_request_proxy :: boolean  (optional):  If true the function will return item request proxy as the third parameter.raise_revive :: boolean  (optional):  If true, and an entity ghost; script_raised_revive will be called. Else if true, and a tile ghost; script_raised_set_tiles will be called
---@return dictionary string → uint @
function LuaEntity.revive(opts) end

---Revives a ghost silently.
---@param opts boolean @Table with the following fields: return_item_request_proxy :: boolean  (optional):  If true the function will return item request proxy as the third parameter.raise_revive :: boolean  (optional):  If true, and an entity ghost; script_raised_revive will be called. Else if true, and a tile ghost; script_raised_set_tiles will be called
---@return dictionary string → uint @
function LuaEntity.silent_revive(opts) end

---Get the rails that this signal is connected to.
---@return array of LuaEntity @
function LuaEntity.get_connected_rails() end

---Get the rail signal or train stop at the start/end of the rail segment this rail is in, or nil if the rail segment doesn't start/end with a signal nor a train stop.
---@param direction defines.rail_direction @The direction of travel relative to this rail
---@param in_else_out boolean @If true, gets the entity at the entrance of the rail segment, otherwise gets the entity at the exit of the rail segment
---@return LuaEntity @
function LuaEntity.get_rail_segment_entity(direction, in_else_out) end

---Get the rail at the end of the rail segment this rail is in.
---@param direction defines.rail_direction @
---@return LuaEntity @
function LuaEntity.get_rail_segment_end(direction) end

---Get the length of the rail segment this rail is in.
---@return double @
function LuaEntity.get_rail_segment_length() end

---Get a rail from each rail segment that overlaps with this rail's rail segment.
---@return array of LuaEntity @
function LuaEntity.get_rail_segment_overlaps() end

---Get the filter for a slot in an inserter or a loader.
---@param uint uint @Slot to get the filter of
---@return string @
function LuaEntity.get_filter(uint) end

---Set the filter for a slot in an inserter or a loader
---@param uint uint @Slot to set the filter of
---@param string string @Prototype name of the item to filter
function LuaEntity.set_filter(uint, string) end

---Gets the filter for this infinity container at the given index or nil if the filter index doesn't exist or is empty.
---@param index uint @The index to get
---@return InfinityInventoryFilter @
function LuaEntity.get_infinity_container_filter(index) end

---Sets the filter for this infinity container at the given index.
---@param index uint @The index to set
---@param filter InfinityInventoryFilter @The new filter or nil to clear the filter
function LuaEntity.set_infinity_container_filter(index, filter) end

---Gets the filter for this infinity pipe or nil if the filter is empty.
---@return InfinityPipeFilter @
function LuaEntity.get_infinity_pipe_filter() end

---Sets the filter for this infinity pipe.
---@param filter InfinityPipeFilter @The new filter or nil to clear the filter
function LuaEntity.set_infinity_pipe_filter(filter) end

---Gets the heat setting for this heat interface.
---@return HeatSetting @
function LuaEntity.get_heat_setting() end

---Sets the heat setting for this heat interface.
---@param filter HeatSetting @The new setting
function LuaEntity.set_heat_setting(filter) end

---Gets the control behavior of the entity (if any).
---@return LuaControlBehavior @
function LuaEntity.get_control_behavior() end

---Gets (and or creates if needed) the control behavior of the entity.
---@return LuaControlBehavior @
function LuaEntity.get_or_create_control_behavior() end

---
---@param wire defines.wire_type @Wire color of the network connected to this entity
---@param circuit_connector defines.circuit_connector_id @The connector to get circuit network for.   Must be specified for entities with more than one circuit network connector
---@return LuaCircuitNetwork @
function LuaEntity.get_circuit_network(wire, circuit_connector) end

---Read a single signal from the combined circuit networks.
---@param signal SignalID @The signal to read
---@param circuit_connector defines.circuit_connector_id @The connector to get signals for.   Must be specified for entities with more than one circuit network connector
---@return int @
function LuaEntity.get_merged_signal(signal, circuit_connector) end

---The merged circuit network signals or nil if there are no signals.
---@param circuit_connector defines.circuit_connector_id @The connector to get signals for.   Must be specified for entities with more than one circuit network connector
---@return array of Signal @
function LuaEntity.get_merged_signals(circuit_connector) end

---
---@return boolean @
function LuaEntity.supports_backer_name() end

---Copies settings from the given entity onto this entity.
---@param entity LuaEntity @
---@param by_player LuaPlayer @If provided, the copying is done 'as' this player and on_entity_settings_pasted is triggered
---@return dictionary string → uint @
function LuaEntity.copy_settings(entity, by_player) end

---Gets the LuaLogisticPoint specified by the given index or if not given returns all of the points this entity owns.
---@param defines__ogistic_member_index defines__ogistic_member_index @
---@return LuaLogisticPoint or array of LuaLogisticPoint @
function LuaEntity.get_logistic_point(defines__ogistic_member_index) end

---Plays a note with the given instrument and note.
---@param instrument uint @
---@param note uint @
---@return boolean @
function LuaEntity.play_note(instrument, note) end

---Connects the rolling stock in the given direction.
---@param direction defines.rail_direction @
---@return boolean @
function LuaEntity.connect_rolling_stock(direction) end

---Tries to disconnect this rolling stock in the given direction.
---@param direction defines.rail_direction @
---@return boolean @
function LuaEntity.disconnect_rolling_stock(direction) end

---Reconnect loader, beacon, cliff and mining drill connections to entities that might have been teleported out or in by the script. The game doesn't do this automatically as we don't want to loose performance by checking this in normal games.
function LuaEntity.update_connections() end

---Current recipe being assembled by this machine or nil if no recipe is set.
---@return LuaRecipe @
function LuaEntity.get_recipe() end

---Sets the current recipe in this assembly machine.
---@param recipe string | LuaRecipe @The new recipe or nil to clear the recipe
---@return dictionary string → uint @
function LuaEntity.set_recipe(recipe) end

---Rotates this entity as if the player rotated it
---@param options boolean @Table with the following fields: reverse :: boolean  (optional)by_player :: LuaPlayer  (optional)spill_items :: boolean  (optional):  If the player is not given should extra items be spilled or returned as a second return value from this.enable_looted :: boolean  (optional):  When true, each spilled item will be flagged with the LuaEntity::to_be_looted flag.force :: LuaForce or string  (optional):  When provided the spilled items will be marked for deconstruction by this force
---@return boolean @
function LuaEntity.rotate(options) end

---Gets the driver of this vehicle if any.
---@return LuaEntity or LuaPlayer @
function LuaEntity.get_driver() end

---Sets the driver of this vehicle.
---@param driver LuaEntity | LuaPlayer @The new driver or nil to eject the current driver if any
function LuaEntity.set_driver(driver) end

---Gets the passenger of this car if any.
---@return LuaEntity or LuaPlayer @
function LuaEntity.get_passenger() end

---Sets the passenger of this car.
---@param passenger LuaEntity | LuaPlayer @
function LuaEntity.set_passenger(passenger) end

---Returns true if this entity is connected to an electric network.
---@return boolean @
function LuaEntity.is_connected_to_electric_network() end

---The trains scheduled to stop at this train stop.
---@return array of LuaTrain @
function LuaEntity.get_train_stop_trains() end

---The train currently stopped at this train stop or nil if none.
---@return LuaTrain @
function LuaEntity.get_stopped_train() end

---Get the amount of all or some fluid in this entity.
---@param fluid string @Prototype name of the fluid to count. If not specified, count all fluids
---@return double @
function LuaEntity.get_fluid_count(fluid) end

---Get amounts of all fluids in this entity.
---@return dictionary string → double @
function LuaEntity.get_fluid_contents() end

---Insert fluid into this entity. Fluidbox is chosen automatically.
---@param fluid Fluid @Fluid to insert
---@return double @
function LuaEntity.insert_fluid(fluid) end

---Remove all fluids from this entity.
function LuaEntity.clear_fluid_inside() end

---Get the source of this beam.
---@return BeamTarget @
function LuaEntity.get_beam_source() end

---Set the source of this beam.
---@param source LuaEntity | Position @
function LuaEntity.set_beam_source(source) end

---Get the target of this beam.
---@return BeamTarget @
function LuaEntity.get_beam_target() end

---Set the target of this beam.
---@param target LuaEntity | Position @
function LuaEntity.set_beam_target(target) end

---The radius of this entity.
---@return double @
function LuaEntity.get_radius() end

---The health ratio of this entity between 1 and 0 (for full health and no health respectively).
---@return float @
function LuaEntity.get_health_ratio() end

---Creates the same smoke that is created when you place a building by hand. You can play the building sound to go with it by using LuaSurface::play_sound, eg: entity.surface.play_sound{path="entity-build/"..entity.prototype.name, position=entity.position}
function LuaEntity.create_build_effect_smoke() end

---Release the unit from the spawner which spawned it. This allows the spawner to continue spawning additional units.
function LuaEntity.release_from_spawner() end

---Toggle this entity's equipment movement bonus. Does nothing if the entity does not have an equipment grid.
function LuaEntity.toggle_equipment_movement_bonus() end

---If this character can shoot the given entity or position.
---@param target LuaEntity @
---@param position Position @
---@return boolean @
function LuaEntity.can_shoot(target, position) end

---Only works if the entity is a speech-bubble, with an "effect" defined in its wrapper_flow_style. Starts animating the opacity of the speech bubble towards zero, and destroys the entity when it hits zero.
function LuaEntity.start_fading_out() end

---Returns the new entity prototype. The more entities on the force that are marked for upgrade, the longer this method takes to run.
---@return LuaEntityPrototype @
function LuaEntity.get_upgrade_target() end

---Returns the amount of damage to be taken by this entity.
---@return float @
function LuaEntity.get_damage_to_be_taken() end

---Depletes and destroys this resource entity.
function LuaEntity.deplete() end

---Mines this entity.
---@param options LuaInventory @Table with the following fields: inventory :: LuaInventory  (optional):  If provided the item(s) will be transferred into this inventory. If provided, this must be an inventory created with LuaGameScript::create_inventory or be a basic inventory owned by some entity.force :: boolean  (optional):  If true, when the item(s) don't fit into the given inventory the entity is force mined.                                     If false, the mining operation fails when there isn't enough room to transfer all of the items into the inventory.                                     Defaults to false. This is ignored and acts as 'true' if no inventory is provided.raise_destroyed :: boolean  (optional):  If true, script_raised_destroy will be raised. Defaults to true.ignore_minable :: boolean  (optional):  If true, the minable state of the entity is ignored. Defaults to false. If false, an entity that isn't minable (set as not-minable in the prototype or isn't minable for other reasons) will fail to be mined
---@return boolean @
function LuaEntity.mine(options) end

---@class LuaEntityPrototype Does this prototype have a flag enabled?
---@field type string @ [Read-only] 
---@field name string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field max_health float @ [Read-only] 
---@field infinite_resource boolean @ [Read-only] 
---@field minimum_resource_amount uint @ [Read-only] 
---@field normal_resource_amount uint @ [Read-only] 
---@field infinite_depletion_resource_amount uint @ [Read-only] 
---@field resource_category string @ [Read-only] 
---@field mineable_properties table @(optional) [Read-only] 
---@field items_to_place_this SimpleItemStack[] @ [Read-only] 
---@field collision_box BoundingBox @ [Read-only] 
---@field secondary_collision_box BoundingBox @ [Read-only] 
---@field map_generator_bounding_box BoundingBox @ [Read-only] 
---@field selection_box BoundingBox @ [Read-only] 
---@field drawing_box BoundingBox @ [Read-only] 
---@field sticker_box BoundingBox @ [Read-only] 
---@field collision_mask CollisionMask @ [Read-only] 
---@field collision_mask_with_flags CollisionMaskWithFlags @ [Read-only] 
---@field order string @ [Read-only] 
---@field group LuaGroup @ [Read-only] 
---@field subgroup LuaGroup @ [Read-only] 
---@field healing_per_tick float @ [Read-only] 
---@field emissions_per_second double @ [Read-only] 
---@field corpses table<string, LuaEntityPrototype> @ [Read-only] 
---@field selectable_in_game boolean @ [Read-only] 
---@field selection_priority uint @ [Read-only] The selection priority of this entity - a value between 0 and 255
---@field weight double @ [Read-only] The weight of this vehicle prototype or nil if not a vehicle prototype.
---@field resistances Resistances @ [Read-only] 
---@field fast_replaceable_group string @ [Read-only] 
---@field next_upgrade LuaEntityPrototype @ [Read-only] 
---@field loot Loot @ [Read-only] 
---@field repair_speed_modifier uint @ [Read-only] 
---@field turret_range uint @ [Read-only] The range of this turret or nil if this isn't a turret related prototype.
---@field autoplace_specification AutoplaceSpecification @ [Read-only] Autoplace specification for this entity prototype. nil if none.
---@field belt_speed double @ [Read-only] 
---@field result_units object[] @ [Read-only] 
---@field attack_result Trigger @ [Read-only] 
---@field final_attack_result Trigger @ [Read-only] 
---@field attack_parameters table @ [Read-only] The attack parameters for this entity or nil if the entity doesn't use attack parameters.
---@field spawn_cooldown table @ [Read-only] 
---@field mining_drill_radius double @ [Read-only] The mining radius of this mining drill prototype or nil if this isn't a mining drill prototype.
---@field mining_speed double @ [Read-only] The mining speed of this mining drill/character prototype or nil.
---@field logistic_mode string @ [Read-only] The logistic mode of this logistic container or nil if this isn't a logistic container prototype.
---@field max_underground_distance uint8 @ [Read-only] The max underground distance for underground belts and underground pipes or nil if this isn't one of those prototypes.
---@field flags EntityPrototypeFlags @ [Read-only] The entity prototype flags for this entity.
---@field remains_when_mined LuaEntityPrototype[] @ [Read-only] The remains left behind when this entity is mined.
---@field additional_pastable_entities LuaEntityPrototype[] @ [Read-only] Entities this entity can be pasted onto in addition to the normal allowed ones.
---@field allow_copy_paste boolean @ [Read-only] When false copy-paste is not allowed for this entity.
---@field shooting_cursor_size double @ [Read-only] The cursor size used when shooting at this entity.
---@field created_smoke table @ [Read-only] The smoke trigger run when this entity is built or nil.
---@field created_effect Trigger @ [Read-only] 
---@field map_color Color @ [Read-only] The map color used when charting this entity if a friendly or enemy color isn't defined or nil.
---@field friendly_map_color Color @ [Read-only] The friendly map color used when charting this entity.
---@field enemy_map_color Color @ [Read-only] The enemy map color used when charting this entity.
---@field build_base_evolution_requirement double @ [Read-only] The evolution requirement to build this entity as a base when expanding enemy bases.
---@field instruments ProgrammableSpeakerInstrument[] @ [Read-only] The instruments for this programmable speaker or nil.
---@field max_polyphony uint @ [Read-only] The maximum polyphony for this programmable speaker or nil.
---@field module_inventory_size uint @ [Read-only] The module inventory size or nil if this entity doesn't support modules.
---@field ingredient_count uint @ [Read-only] The max number of ingredients this crafting-machine prototype supports or nil if this isn't a crafting-machine prototype.
---@field crafting_speed double @ [Read-only] The crafting speed of this crafting-machine or nil.
---@field crafting_categories table<string, boolean> @ [Read-only] The crafting categories this entity supports. Only meaningful when this is a crafting-machine or player entity type.
---@field resource_categories table<string, boolean> @ [Read-only] The resource categories this mining drill supports or nil if not a mining dill.
---@field supply_area_distance double @ [Read-only] The supply area of this electric pole, beacon, or nil if this is neither.
---@field max_wire_distance double @ [Read-only] The maximum wire distance for this entity. 0 when the entity doesn't support wires.
---@field max_circuit_wire_distance double @ [Read-only] The maximum circuit wire distance for this entity. 0 when the entity doesn't support circuit wires.
---@field energy_usage double @ [Read-only] The direct energy usage of this entity or nil if this entity doesn't have a direct energy usage.
---@field max_energy_usage double @ [Read-only] The theoretical maximum energy usage for this entity.
---@field effectivity double @ [Read-only] The effectivity of this car prototype, generator prototype or nil.
---@field consumption double @ [Read-only] The energy consumption of this car prototype or nil if not a car prototype.
---@field friction_force double @ [Read-only] The friction of this vehicle prototype or nil if not a vehicle prototype.
---@field braking_force double @ [Read-only] The braking force of this vehicle prototype or nil if not a vehicle prototype.
---@field tank_driving boolean @ [Read-only] If this car prototype uses tank controls to drive or nil if this is not a car prototype.
---@field rotation_speed double @ [Read-only] The rotation speed of this car prototype or nil if not a car prototype.
---@field turret_rotation_speed double @ [Read-only] The turret rotation speed of this car prototype or nil if not a car prototype.
---@field guns table<string, LuaItemPrototype> @ [Read-only] The guns this car prototype uses or nil if not a car prototype.
---@field speed double @ [Read-only] The default speed of this flying robot, rolling stock, unit or nil.
---@field speed_multiplier_when_out_of_energy float @ [Read-only] The speed multiplier when this flying robot is out of energy or nil.
---@field max_payload_size uint @ [Read-only] The max payload size of this logistics or construction robot or nil.
---@field draw_cargo boolean @ [Read-only] Whether this logistics or construction robot renders its cargo when flying or nil.
---@field energy_per_move double @ [Read-only] The energy consumed per tile moved for this flying robot or nil.
---@field energy_per_tick double @ [Read-only] The energy consumed per tick for this flying robot or nil.
---@field max_energy double @ [Read-only] The max energy for this flying robot or nil.
---@field min_to_charge float @ [Read-only] The minimum energy for this flying robot before it tries to recharge or nil.
---@field max_to_charge float @ [Read-only] The maximum energy for this flying robot above which it won't try to recharge when stationing or nil.
---@field burner_prototype LuaBurnerPrototype @ [Read-only] The burner energy source prototype this entity uses or nil.
---@field electric_energy_source_prototype LuaElectricEnergySourcePrototype @ [Read-only] The electric energy source prototype this entity uses or nil.
---@field heat_energy_source_prototype LuaHeatEnergySourcePrototype @ [Read-only] The heat energy source prototype this entity uses or nil.
---@field fluid_energy_source_prototype LuaFluidEnergySourcePrototype @ [Read-only] The fluid energy source prototype this entity uses or nil.
---@field void_energy_source_prototype LuaVoidEnergySourcePrototype @ [Read-only] The void energy source prototype this entity uses or nil.
---@field building_grid_bit_shift uint @ [Read-only] The log2 of grid size of the building
---@field fluid_usage_per_tick double @ [Read-only] The fluid usage of this generator prototype or nil.
---@field maximum_temperature double @ [Read-only] The maximum fluid temperature of this generator prototype or nil.
---@field target_temperature double @ [Read-only] The target temperature of this boiler prototype or nil.
---@field fluid LuaFluidPrototype @ [Read-only] The fluid this offshore pump produces or nil.
---@field fluid_capacity double @ [Read-only] The fluid capacity of this entity or 0 if this entity doesn't support fluids.
---@field pumping_speed double @ [Read-only] The pumping speed of this offshore pump, normal pump, or nil.
---@field stack boolean @ [Read-only] If this inserter is a stack-type.
---@field allow_custom_vectors boolean @ [Read-only] If this inserter allows custom pickup and drop vectors.
---@field allow_burner_leech boolean @ [Read-only] If this inserter allows burner leeching.
---@field inserter_extension_speed double @ [Read-only] 
---@field inserter_rotation_speed double @ [Read-only] 
---@field inserter_pickup_position Vector @ [Read-only] 
---@field inserter_drop_position Vector @ [Read-only] 
---@field inserter_chases_belt_items boolean @ [Read-only] True if this inserter chases items on belts for pickup or nil.
---@field count_as_rock_for_filtered_deconstruction boolean @ [Read-only] If this simple-entity is counted as a rock for the deconstruction planner "trees and rocks only" filter.
---@field filter_count uint @ [Read-only] The filter count of this inserter, loader, or requester chest or nil.
---@field production double @ [Read-only] The max production this solar panel prototype produces or nil.
---@field time_to_live uint @ [Read-only] The time to live for this prototype or 0 if prototype doesn't have time_to_live or time_before_removed.
---@field distribution_effectivity double @ [Read-only] The distribution effectivity for this beacon prototype or nil if not a beacon prototype.
---@field explosion_beam double @ [Read-only] Does this explosion have a beam or nil if not an explosion prototype.
---@field explosion_rotate double @ [Read-only] Does this explosion rotate or nil if not an explosion prototype.
---@field tree_color_count uint8 @ [Read-only] If it is a tree, return the number of colors it supports. nil otherwise.
---@field alert_when_damaged boolean @ [Read-only] Does this entity with health prototype alert when damaged? or nil if not entity with health prototype.
---@field alert_when_attacking boolean @ [Read-only] Does this turret prototype alert when attacking? or nil if not turret prototype.
---@field color Color @ [Read-only] The color of the prototype, or nil if the prototype doesn't have color.
---@field collision_mask_collides_with_self boolean @ [Read-only] Does this prototype collision mask collide with itself?
---@field collision_mask_collides_with_tiles_only boolean @ [Read-only] Does this prototype collision mask collide with tiles only?
---@field collision_mask_considers_tile_transitions boolean @ [Read-only] Does this prototype collision mask consider tile transitions?
---@field allowed_effects table<string, boolean> @ [Read-only] The allowed module effects for this entity or nil.
---@field rocket_parts_required uint @ [Read-only] The rocket parts required for this rocket silo prototype or nil.
---@field fixed_recipe string @ [Read-only] The fixed recipe name for this assembling machine prototype or nil.
---@field construction_radius double @ [Read-only] The construction radius for this roboport prototype or nil.
---@field logistic_radius double @ [Read-only] The logistic radius for this roboport prototype or nil.
---@field energy_per_hit_point double @ [Read-only] The energy used per hitpoint taken for this vehicle during collisions or nil.
---@field create_ghost_on_death boolean @ [Read-only] If this prototype will attempt to create a ghost of itself on death.
---@field timeout uint @ [Read-only] The time it takes this land mine to arm.
---@field fluidbox_prototypes LuaFluidBoxPrototype[] @ [Read-only] The fluidbox prototypes for this entity.
---@field neighbour_bonus double @ [Read-only] 
---@field neighbour_collision_increase double @ [Read-only] Controls how much a reactor extends when connected to other reactors.
---@field container_distance double @ [Read-only] 
---@field belt_distance double @ [Read-only] 
---@field belt_length double @ [Read-only] 
---@field is_building boolean @ [Read-only] 
---@field automated_ammo_count uint @ [Read-only] 
---@field max_speed double @ [Read-only] 
---@field darkness_for_all_lamps_on float @ [Read-only] 
---@field darkness_for_all_lamps_off float @ [Read-only] 
---@field always_on boolean @ [Read-only] 
---@field min_darkness_to_spawn float @ [Read-only] 
---@field max_darkness_to_spawn float @ [Read-only] 
---@field call_for_help_radius double @ [Read-only] 
---@field max_count_of_owned_units double @ [Read-only] 
---@field max_friends_around_to_spawn double @ [Read-only] 
---@field spawning_radius double @ [Read-only] 
---@field spawning_spacing double @ [Read-only] 
---@field radius double @ [Read-only] 
---@field cliff_explosive_prototype string @ [Read-only] 
---@field has_belt_immunity boolean @ [Read-only] 
---@field vision_distance double @ [Read-only] 
---@field pollution_to_join_attack float @ [Read-only] 
---@field min_pursue_time uint @ [Read-only] 
---@field max_pursue_distance double @ [Read-only] 
---@field radar_range uint @ [Read-only] 
---@field move_while_shooting boolean @ [Read-only] 
---@field can_open_gates boolean @ [Read-only] 
---@field affected_by_tiles boolean @ [Read-only] 
---@field distraction_cooldown uint @ [Read-only] 
---@field spawning_time_modifier double @ [Read-only] 
---@field alert_icon_shift Vector @ [Read-only] 
---@field lab_inputs string[] @ [Read-only] The item prototype names that are the inputs of this lab prototype or nil.
---@field researching_speed double @ [Read-only] The base researching speed of this lab prototype or nil.
---@field item_slot_count uint @ [Read-only] The item slot count of this constant combinator prototype or nil.
---@field base_productivity double @ [Read-only] The base productivity of this crafting machine, lab, or mining drill, or nil.
---@field allow_access_to_all_forces boolean @ [Read-only] If this market allows access to all forces or just friendly ones.
---@field supports_direction boolean @ [Read-only] If this entity prototype could possibly ever be rotated.
---@field terrain_friction_modifier float @ [Read-only] The terrain friction modifier for this vehicle.
---@field max_distance_of_sector_revealed uint @ [Read-only] The radius of the area this radar can chart, in chunks.
---@field max_distance_of_nearby_sector_revealed uint @ [Read-only] The radius of the area constantly revealed by this radar, in chunks.
---@field adjacent_tile_collision_box BoundingBox @ [Read-only] 
---@field adjacent_tile_collision_mask CollisionMask @ [Read-only] 
---@field adjacent_tile_collision_test CollisionMask @ [Read-only] 
---@field center_collision_mask CollisionMask @ [Read-only] 
---@field grid_prototype LuaEquipmentGridPrototype @ [Read-only] The equipment grid prototype for this entity or nil.
---@field running_speed double @ [Read-only] 
---@field maximum_corner_sliding_distance double @ [Read-only] 
---@field build_distance uint @ [Read-only] 
---@field drop_item_distance uint @ [Read-only] 
---@field reach_distance uint @ [Read-only] 
---@field reach_resource_distance double @ [Read-only] 
---@field item_pickup_distance double @ [Read-only] 
---@field loot_pickup_distance double @ [Read-only] 
---@field enter_vehicle_distance double @ [Read-only] 
---@field ticks_to_keep_gun uint @ [Read-only] 
---@field ticks_to_keep_aiming_direction uint @ [Read-only] 
---@field ticks_to_stay_in_combat uint @ [Read-only] 
---@field respawn_time uint @ [Read-only] 
---@field damage_hit_tint Color @ [Read-only] 
---@field character_corpse LuaEntityPrototype @ [Read-only] 

---Does this prototype have a flag enabled?
---@param flag string @The flag to check. Must be one of  "not-rotatable" "placeable-neutral" "placeable-player" "placeable-enemy" "placeable-off-grid" "player-creation" "building-direction-8-way" "filter-directions" "fast-replaceable-no-build-while-moving" "breaths-air" "not-repairable" "not-on-map" "not-deconstructable" "not-blueprintable" "hide-from-bonus-gui" "hide-alt-info" "fast-replaceable-no-cross-type-while-moving" "no-gap-fill-while-building" "not-flammable" "no-automated-item-removal" "no-automated-item-insertion" "not-upgradable
---@return boolean @
function LuaEntityPrototype.has_flag(flag) end

---Gets the base size of the given inventory on this entity or nil if the given inventory doesn't exist.
---@param index defines.inventory @
---@return uint @
function LuaEntityPrototype.get_inventory_size(index) end

---@class LuaEquipment 
---@field name string @ [Read-only] 
---@field type string @ [Read-only] 
---@field position Position @ [Read-only] 
---@field shape table @ [Read-only] Shape of this equipment. It is a table:
---@field shield double @ [Read-Write] 
---@field max_shield double @ [Read-only] 
---@field max_solar_power double @ [Read-only] 
---@field movement_bonus double @ [Read-only] 
---@field generator_power double @ [Read-only] 
---@field energy double @ [Read-Write] 
---@field max_energy double @ [Read-only] 
---@field prototype LuaEquipmentPrototype @ [Read-only] 
---@field burner LuaBurner @ [Read-only] The burner energy source for this equipment or nil if there isn't one.

---@class LuaEquipmentCategoryPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 

---@class LuaEquipmentGrid Remove an equipment from the grid.
---@field take SimpleItemStack @(optional) undefined Remove an equipment from the grid.
---@field put LuaEquipment @(optional) undefined Insert an equipment into the grid.
---@field can_move boolean @ undefined Check whether moving an equipment would succeed.
---@field move boolean @ undefined Move an equipment within this grid.
---@field prototype LuaEquipmentGridPrototype @ [Read-only] 
---@field width uint @ [Read-only] 
---@field height uint @ [Read-only] 
---@field equipment LuaEquipment[] @ [Read-only] 
---@field generator_energy double @ [Read-only] 
---@field max_solar_energy double @ [Read-only] 
---@field available_in_batteries double @ [Read-only] 
---@field battery_capacity double @ [Read-only] 
---@field shield float @ [Read-only] The amount of shields this equipment grid has.
---@field max_shield float @ [Read-only] The maximum amount of shields this equipment grid has.
---@field inhibit_movement_bonus boolean @ [Read-Write] True if this movement bonus equipment is turned off, otherwise false.

---Remove all equipment from the grid.
---@return dictionary string → uint @
function LuaEquipmentGrid.take_all() end

---Clear all equipment from the grid. I.e. remove it without actually returning it.
function LuaEquipmentGrid.clear() end

---Find equipment in the Equipment Grid based off a position.
---@param position Position @The positio
---@return LuaEquipment @
function LuaEquipmentGrid.get(position) end

---Get counts of all equipment in this grid.
---@return dictionary string → uint @
function LuaEquipmentGrid.get_contents() end

---@class LuaEquipmentGridPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field equipment_categories string[] @ [Read-only] 
---@field width uint @ [Read-only] 
---@field height uint @ [Read-only] 
---@field locked boolean @ [Read-only] If the player can move equipment into or out of this grid.

---@class LuaEquipmentPrototype 
---@field name string @ [Read-only] 
---@field type string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field shape table @(optional) [Read-only] Shape of this equipment prototype. It is a table:
---@field take_result LuaItemPrototype @ [Read-only] 
---@field energy_production double @ [Read-only] 
---@field shield float @ [Read-only] 
---@field energy_per_shield double @ [Read-only] 
---@field logistic_parameters table @ [Read-only] 
---@field energy_consumption double @ [Read-only] 
---@field movement_bonus float @ [Read-only] 
---@field energy_source LuaElectricEnergySourcePrototype @ [Read-only] 
---@field equipment_categories string[] @ [Read-only] 
---@field burner_prototype LuaBurnerPrototype @ [Read-only] The burner energy source prototype this equipment uses or nil.
---@field electric_energy_source_prototype LuaElectricEnergySourcePrototype @ [Read-only] The electric energy source prototype this equipment uses or nil.
---@field background_color Color @ [Read-only] 
---@field attack_parameters AttackParameters @ [Read-only] The equipment attack parameters or nil.
---@field automatic boolean @ [Read-only] Is this active defense equipment automatic. Returns false if not active defense equipment.

---@class LuaFlowStatistics Gets the total input count for a given prototype.
---@field get_flow_count double @(optional) undefined Gets the flow count value for the given time frame.
---@field input_counts table<string, uint64> @ [Read-only] 
---@field output_counts table<string, uint64> @ [Read-only] 
---@field force LuaForce @ [Read-only] 

---Gets the total input count for a given prototype.
---@param string string @The prototype name
---@return uint64 or double @
function LuaFlowStatistics.get_input_count(string) end

---Sets the total input count for a given prototype.
---@param string string @The prototype name
---@param count uint64 | double @The new count. The type depends on the instance of the statistics
function LuaFlowStatistics.set_input_count(string, count) end

---Gets the total output count for a given prototype.
---@param string string @The prototype name
---@return uint64 or double @
function LuaFlowStatistics.get_output_count(string) end

---Sets the total output count for a given prototype.
---@param string string @The prototype name
---@param count uint64 | double @The new count. The type depends on the instance of the statistics
function LuaFlowStatistics.set_output_count(string, count) end

---Adds a value to this flow statistics.
---@param string string @The prototype name
---@param count float @The count: positive or negative determines if the value goes in the input or output statistics
function LuaFlowStatistics.on_flow(string, count) end

---Reset all the statistics data to 0.
function LuaFlowStatistics.clear() end

---@class LuaFluidBox The prototype of this fluidbox index.
---@field hash_operator uint @ [Read-only] 
---@field owner LuaEntity @ [Read-only] The entity that owns this fluidbox.
---@field bracket_operator Fluid | nil @ [Read-only] 

---The prototype of this fluidbox index.
---@param index uint @
---@return LuaFluidBoxPrototype @
function LuaFluidBox.get_prototype(index) end

---The capacity of the given fluidbox index.
---@param index uint @
---@return double @
function LuaFluidBox.get_capacity(index) end

---The fluidbox connections for the given fluidbox index.
---@param index uint @
---@return array of LuaFluidBox @
function LuaFluidBox.get_connections(index) end

---The filter of the given fluidbox index, 'nil' if none.
---@param index uint @
---@return table @
function LuaFluidBox.get_filter(index) end

---Set the filter of the given fluidbox index, 'nil' to clear. Some entities cannot have their fluidbox filter set, notably fluid wagons and crafting machines.
---@param index uint @
---@param table string @Table with the following fields: name :: string:  Fluid prototype name of the filtered fluid.minimum_temperature :: double  (optional):  The minimum temperature allowed into the fluidboxmaximum_temperature :: double  (optional):  The maximum temperature allowed into the fluidboxforce :: boolean  (optional):  Force the filter to be set, regardless of current fluid content. or 'nil'
---@return boolean @
function LuaFluidBox.set_filter(index, table) end

---Flow through the fluidbox in the last tick. It is the larger of in-flow and out-flow. Note that wagons do not track it and will return 0.
---@param index uint @
---@return double @
function LuaFluidBox.get_flow(index) end

---Returns the fluid the fluidbox is locked onto (along with its whole system) Returns 'nil' for no lock
---@param index uint @
---@return string @
function LuaFluidBox.get_locked_fluid(index) end

---@class LuaFluidBoxPrototype The entity that this belongs to.
---@field entity LuaEntityPrototype @ [Read-only] The entity that this belongs to.
---@field index uint @ [Read-only] The index of this fluidbox prototype in the owning entity.
---@field pipe_connections FluidBoxConnection[] @ [Read-only] The pipe connection points.
---@field production_type string @ [Read-only] The production type. "input", "output", "input-output", or "none".
---@field base_area double @ [Read-only] 
---@field base_level double @ [Read-only] 
---@field height double @ [Read-only] 
---@field volume double @ [Read-only] 
---@field filter LuaFluidPrototype @ [Read-only] The filter or nil if no filter is set.
---@field minimum_temperature double @ [Read-only] The minimum temperature or nil if none is set.
---@field maximum_temperature double @ [Read-only] The maximum temperature or nil if none is set.
---@field secondary_draw_orders int[] @ [Read-only] The secondary draw orders for the 4 possible connection directions.
---@field render_layer string @ [Read-only] The render layer.

---@class LuaFluidEnergySourcePrototype 
---@field emissions double @ [Read-only] 
---@field render_no_network_icon boolean @ [Read-only] 
---@field render_no_power_icon boolean @ [Read-only] 
---@field effectivity double @ [Read-only] 
---@field burns_fluid boolean @ [Read-only] 
---@field scale_fluid_usage boolean @ [Read-only] 
---@field fluid_usage_per_tick double @ [Read-only] 
---@field smoke SmokeSource[] @ [Read-only] The smoke sources for this prototype if any.
---@field maximum_temperature double @ [Read-only] 
---@field fluid_box nil @ [Read-only] The fluid box for this energy source.

---@class LuaFluidPrototype 
---@field name string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field default_temperature double @ [Read-only] 
---@field max_temperature double @ [Read-only] 
---@field heat_capacity double @ [Read-only] 
---@field order string @ [Read-only] 
---@field group LuaGroup @ [Read-only] 
---@field subgroup LuaGroup @ [Read-only] 
---@field base_color Color @ [Read-only] 
---@field flow_color Color @ [Read-only] 
---@field gas_temperature double @ [Read-only] 
---@field emissions_multiplier double @ [Read-only] 
---@field fuel_value double @ [Read-only] 
---@field hidden boolean @ [Read-only] 

---@class LuaForce Count entities of given type.
---@field play_sound boolean @(optional) undefined Plays a sound for every player on this force
---@field name string @ [Read-only] 
---@field technologies CustomDictionary @ [Read-only] 
---@field recipes CustomDictionary @ [Read-only] 
---@field manual_mining_speed_modifier double @ [Read-Write] 
---@field manual_crafting_speed_modifier double @ [Read-Write] 
---@field laboratory_speed_modifier double @ [Read-Write] 
---@field laboratory_productivity_bonus double @ [Read-Write] 
---@field worker_robots_speed_modifier double @ [Read-Write] 
---@field worker_robots_battery_modifier double @ [Read-Write] 
---@field worker_robots_storage_bonus double @ [Read-Write] 
---@field current_research LuaTechnology @ [Read-only] 
---@field research_progress double @ [Read-Write] 
---@field previous_research LuaTechnology @ [Read-Write] 
---@field inserter_stack_size_bonus double @ [Read-Write] 
---@field stack_inserter_capacity_bonus uint @ [Read-Write] 
---@field character_trash_slot_count double @ [Read-Write] 
---@field maximum_following_robot_count uint @ [Read-Write] 
---@field following_robots_lifetime_modifier double @ [Read-Write] Additional lifetime for following robots.
---@field ghost_time_to_live uint @ [Read-Write] 
---@field players LuaPlayer[] @ [Read-only] 
---@field ai_controllable boolean @ [Read-Write] 
---@field logistic_networks table<string, LuaLogisticNetwork> @ [Read-only] 
---@field item_production_statistics LuaFlowStatistics @ [Read-only] 
---@field fluid_production_statistics LuaFlowStatistics @ [Read-only] 
---@field kill_count_statistics LuaFlowStatistics @ [Read-only] 
---@field entity_build_count_statistics LuaFlowStatistics @ [Read-only] 
---@field character_running_speed_modifier double @ [Read-Write] 
---@field artillery_range_modifier double @ [Read-Write] 
---@field character_build_distance_bonus uint @ [Read-Write] 
---@field character_item_drop_distance_bonus uint @ [Read-Write] 
---@field character_reach_distance_bonus uint @ [Read-Write] 
---@field character_resource_reach_distance_bonus double @ [Read-Write] 
---@field character_item_pickup_distance_bonus double @ [Read-Write] 
---@field character_loot_pickup_distance_bonus double @ [Read-Write] 
---@field character_inventory_slots_bonus uint @ [Read-Write] 
---@field deconstruction_time_to_live uint @ [Read-Write] 
---@field character_health_bonus double @ [Read-Write] 
---@field max_successful_attempts_per_tick_per_construction_queue uint @ [Read-Write] 
---@field max_failed_attempts_per_tick_per_construction_queue uint @ [Read-Write] 
---@field auto_character_trash_slots boolean @ [Read-Write] true if auto character trash slots are enabled. Character trash slots must be > 0 as well for this to actually be used.
---@field zoom_to_world_enabled boolean @ [Read-Write] Ability to use zoom-to-world on map.
---@field zoom_to_world_ghost_building_enabled boolean @ [Read-Write] Ability to build ghosts through blueprint or direct ghost placement, or "mine" ghosts when using zoom-to-world.
---@field zoom_to_world_blueprint_enabled boolean @ [Read-Write] Ability to create new blueprints using empty blueprint item when using zoom-to-world.
---@field zoom_to_world_deconstruction_planner_enabled boolean @ [Read-Write] Ability to use deconstruction planner when using zoom-to-world.
---@field zoom_to_world_selection_tool_enabled boolean @ [Read-Write] Ability to use custom selection tools when using zoom-to-world.
---@field character_logistic_requests boolean @ [Read-Write] true if character requester logistics is enabled.
---@field rockets_launched uint @ [Read-Write] The number of rockets launched.
---@field items_launched table<string, uint> @ [Read-only] All of the items that have been launched in rockets.
---@field connected_players LuaPlayer[] @ [Read-only] 
---@field mining_drill_productivity_bonus double @ [Read-Write] 
---@field train_braking_force_bonus double @ [Read-Write] 
---@field evolution_factor double @ [Read-Write] 
---@field evolution_factor_by_pollution double @ [Read-Write] 
---@field evolution_factor_by_time double @ [Read-Write] 
---@field evolution_factor_by_killing_spawners double @ [Read-Write] 
---@field friendly_fire boolean @ [Read-Write] 
---@field share_chart boolean @ [Read-Write] 
---@field research_queue_enabled boolean @ [Read-Write] 
---@field index uint @ [Read-only] 
---@field research_queue TechnologySpecification[] @ [Read-Write] 
---@field research_enabled boolean @ [Read-only] 

---Count entities of given type.
---@param name string @Prototype name of the entity
---@return uint @
function LuaForce.get_entity_count(name) end

---Disable research for this force.
function LuaForce.disable_research() end

---Enable research for this force.
function LuaForce.enable_research() end

---Disable all recipes and technologies. Only recipes and technologies enabled explicitly will be useable from this point.
function LuaForce.disable_all_prototypes() end

---Enables all recipes and technologies. The opposite of LuaForce::disable_all_prototypes
function LuaForce.enable_all_prototypes() end

---Load the original version of all recipes from the prototypes.
function LuaForce.reset_recipes() end

---Unlock all recipes.
function LuaForce.enable_all_recipes() end

---Unlock all technologies.
function LuaForce.enable_all_technologies() end

---Research all technologies.
---@param include_disabled_prototypes include_disabled_prototypes @If technologies that are explicitly disabled in the prototype are also researched. This defaults to false
function LuaForce.research_all_technologies(include_disabled_prototypes) end

---Load the original versions of technologies from prototypes. Preserves research state of technologies.
function LuaForce.reset_technologies() end

---Reset everything. All technologies are set to not researched, all modifiers are set to default values.
function LuaForce.reset() end

---Reapplies all possible research effects, including unlocked recipes. Any custom changes are lost. Preserves research state of technologies.
function LuaForce.reset_technology_effects() end

---Chart a portion of the map. The chart for the given area is refreshed; it creates chart for any parts of the given area that haven't been charted yet.
---@param surface SurfaceSpecification @
---@param area BoundingBox @The area on the given surface to chart
function LuaForce.chart(surface, area) end

---Erases chart data for this force.
---@param surface SurfaceSpecification @Which surface to erase chart data for or if not provided all surfaces charts are erased
function LuaForce.clear_chart(surface) end

---Force a rechart of the whole chart.
function LuaForce.rechart() end

---Chart all generated chunks.
---@param surface SurfaceSpecification @Which surface to chart or all if not given
function LuaForce.chart_all(surface) end

---Has a chunk been charted?
---@param surface SurfaceSpecification @
---@param position ChunkPosition @Position of the chunk
---@return boolean @
function LuaForce.is_chunk_charted(surface, position) end

---Is the given chunk currently charted and visible (not covered by fog of war) on the map.
---@param surface SurfaceSpecification @
---@param position ChunkPosition @
---@return boolean @
function LuaForce.is_chunk_visible(surface, position) end

---Cancels pending chart requests for the given surface or all surfaces.
---@param surface SurfaceSpecification @
function LuaForce.cancel_charting(surface) end

---
---@param ammo string @Ammo categor
---@return double @
function LuaForce.get_ammo_damage_modifier(ammo) end

---
---@param ammo string @Ammo categor
---@param modifier double @
function LuaForce.set_ammo_damage_modifier(ammo, modifier) end

---
---@param ammo string @Ammo categor
---@return double @
function LuaForce.get_gun_speed_modifier(ammo) end

---
---@param ammo string @Ammo categor
---@param modifier double @
function LuaForce.set_gun_speed_modifier(ammo, modifier) end

---
---@param turret string @Turret prototype nam
---@return double @
function LuaForce.get_turret_attack_modifier(turret) end

---
---@param turret string @Turret prototype nam
---@param modifier double @
function LuaForce.set_turret_attack_modifier(turret, modifier) end

---Stop attacking members of a given force.
---@param other ForceSpecification @
---@param cease_fire boolean @When true, this force won't attack other; otherwise it will
function LuaForce.set_cease_fire(other, cease_fire) end

---Will this force attack members of another force?
---@param other ForceSpecification @
---@return boolean @
function LuaForce.get_cease_fire(other) end

---Friends have unrestricted access to buildings and turrets won't fire at them.
---@param other ForceSpecification @
---@param cease_fire boolean @
function LuaForce.set_friend(other, cease_fire) end

---Is this force a friend?
---@param other ForceSpecification @
---@return boolean @
function LuaForce.get_friend(other) end

---Is pathfinder busy? When the pathfinder is busy, it won't accept any more pathfinding requests.
---@return boolean @
function LuaForce.is_pathfinder_busy() end

---Kill all units and flush the pathfinder.
function LuaForce.kill_all_units() end

---
---@param position Position @Position to find a network fo
---@param surface SurfaceSpecification @Surface to search o
---@return LuaLogisticNetwork @
function LuaForce.find_logistic_network_by_position(position, surface) end

---
---@param position Position @The new position on the given surface
---@param surface SurfaceSpecification @Surface to set the spawn position for
function LuaForce.set_spawn_position(position, surface) end

---
---@param surface SurfaceSpecification @
---@return Position @
function LuaForce.get_spawn_position(surface) end

---
---@param position ChunkPosition @The chunk position to unchart
---@param surface SurfaceSpecification @Surface to unchart on
function LuaForce.unchart_chunk(position, surface) end

---Gets the count of a given item launched in rockets.
---@param item string @The item to ge
---@return uint @
function LuaForce.get_item_launched(item) end

---Sets the count of a given item launched in rockets.
---@param item string @The item to se
---@param count uint @The count to se
function LuaForce.set_item_launched(item, count) end

---Print text to the chat console of all players on this force.
---@param message LocalisedString @
---@param color Color @
function LuaForce.print(message, color) end

---
---@param surface SurfaceSpecification @If given only trains on the surface are returned
---@return array of LuaTrain @
function LuaForce.get_trains(surface) end

---Adds a custom chart tag to the given surface and returns the new tag or nil if the given position isn't valid for a chart tag.
---@param surface SurfaceSpecification @Which surface to add the tag to
---@param tag SignalID @Table with the following fields: icon :: SignalID  (optional): )position :: Positiontext :: string  (optional)last_user :: PlayerSpecification  (optional
---@return LuaCustomChartTag @
function LuaForce.add_chart_tag(surface, tag) end

---Finds all custom chart tags within the given bounding box on the given surface.
---@param surface SurfaceSpecification @
---@param area BoundingBox @
---@return array of LuaCustomChartTag @
function LuaForce.find_chart_tags(surface, area) end

---Gets the saved progress for the given technology or nil if there is no saved progress.
---@param technology TechnologySpecification @The technolog
---@return double @
function LuaForce.get_saved_technology_progress(technology) end

---Sets the saved progress for the given technology. The technology must not be in progress, must not be completed, and the new progress must be < 100%.
---@param technology TechnologySpecification @The technolog
---@param double double @Progress as a percent. Set to nil to remove the saved progress
function LuaForce.set_saved_technology_progress(technology, double) end

---Resets evolution for this force to zero.
function LuaForce.reset_evolution() end

---Gets train stops matching the given filters.
---@param opts string | string[] | string @Table with the following fields: name :: string or array of string  (optional)surface :: SurfaceSpecification  (optional
---@return array of LuaEntity @
function LuaForce.get_train_stops(opts) end

---Gets if the given recipe is explicitly disabled from being hand crafted.
---@param recipe string | LuaRecipe @
---@return boolean @
function LuaForce.get_hand_crafting_disabled_for_recipe(recipe) end

---Sets if the given recipe can be hand-crafted. This is used to explicitly disable hand crafting a recipe - it won't allow hand-crafting otherwise not hand-craftable recipes.
---@param recipe string | LuaRecipe @
---@param hand_crafting_disabled boolean @
function LuaForce.set_hand_crafting_disabled_for_recipe(recipe, hand_crafting_disabled) end

---Add this technology to the back of the research queue if the queue is enabled. Otherwise, set this technology to be researched now.
---@param technology TechnologySpecification @
---@return boolean @
function LuaForce.add_research(technology) end

---Stop the research currently in progress. This will remove any dependent technologies from the research queue.
function LuaForce.cancel_current_research() end

---@class LuaFuelCategoryPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 

---@class LuaGameScript Internal
---@field set_game_state nil @ undefined Set scenario state.
---@field show_message_dialog nil @(optional) undefined Show an in-game message dialog.
---@field take_screenshot nil @(optional) undefined Take a screenshot and save it to a file.
---@field take_technology_screenshot nil @(optional) undefined 
---@field play_sound boolean @(optional) undefined Plays a sound for every player in the game on every surface.
---@field object_name string @ [Read-only] This objects name.
---@field player LuaPlayer @ [Read-only] 
---@field players CustomDictionary @ [Read-only] 
---@field map_settings MapSettings @ [Read-only] 
---@field difficulty_settings DifficultySettings @ [Read-only] 
---@field difficulty defines.difficulty @ [Read-only] 
---@field forces CustomDictionary @ [Read-only] 
---@field entity_prototypes CustomDictionary @ [Read-only] 
---@field item_prototypes CustomDictionary @ [Read-only] 
---@field fluid_prototypes CustomDictionary @ [Read-only] 
---@field tile_prototypes CustomDictionary @ [Read-only] 
---@field equipment_prototypes CustomDictionary @ [Read-only] 
---@field damage_prototypes CustomDictionary @ [Read-only] 
---@field virtual_signal_prototypes CustomDictionary @ [Read-only] 
---@field equipment_grid_prototypes CustomDictionary @ [Read-only] 
---@field recipe_prototypes CustomDictionary @ [Read-only] 
---@field technology_prototypes CustomDictionary @ [Read-only] 
---@field decorative_prototypes CustomDictionary @ [Read-only] 
---@field particle_prototypes CustomDictionary @ [Read-only] 
---@field autoplace_control_prototypes CustomDictionary @ [Read-only] 
---@field noise_layer_prototypes CustomDictionary @ [Read-only] 
---@field mod_setting_prototypes CustomDictionary @ [Read-only] 
---@field custom_input_prototypes CustomDictionary @ [Read-only] 
---@field ammo_category_prototypes CustomDictionary @ [Read-only] 
---@field named_noise_expressions CustomDictionary @ [Read-only] 
---@field item_subgroup_prototypes CustomDictionary @ [Read-only] 
---@field item_group_prototypes CustomDictionary @ [Read-only] 
---@field fuel_category_prototypes CustomDictionary @ [Read-only] 
---@field resource_category_prototypes CustomDictionary @ [Read-only] 
---@field achievement_prototypes CustomDictionary @ [Read-only] 
---@field module_category_prototypes CustomDictionary @ [Read-only] 
---@field equipment_category_prototypes CustomDictionary @ [Read-only] 
---@field trivial_smoke_prototypes CustomDictionary @ [Read-only] 
---@field shortcut_prototypes CustomDictionary @ [Read-only] 
---@field recipe_category_prototypes CustomDictionary @ [Read-only] 
---@field styles CustomDictionary @ [Read-only] The styles that LuaGuiElement can use. A mapping of style name to style type.
---@field tick uint @ [Read-only] 
---@field ticks_played uint @ [Read-only] 
---@field tick_paused boolean @ [Read-Write] 
---@field ticks_to_run uint @ [Read-Write] 
---@field finished boolean @ [Read-only] Is the scenario finished?
---@field speed float @ [Read-Write] 
---@field surfaces CustomDictionary @ [Read-only] 
---@field active_mods table<string, string> @ [Read-only] The active mods versions. The keys are mod names, the values are the versions.
---@field connected_players LuaPlayer[] @ [Read-only] The online players
---@field permissions LuaPermissionGroups @ [Read-only] 
---@field backer_names CustomDictionary @ [Read-only] 
---@field default_map_gen_settings MapGenSettings @ [Read-only] The default map gen settings for this save.
---@field enemy_has_vision_on_land_mines boolean @ [Read-Write] Determines if enemy land mines are completely invisible or not.
---@field autosave_enabled boolean @ [Read-Write] True by default. Can be used to disable autosaving. Make sure to turn it back on soon after.
---@field draw_resource_selection boolean @ [Read-Write] True by default. Can be used to disable the highlighting of resource patches when they are hovered on the map.
---@field pollution_statistics LuaFlowStatistics @ [Read-only] 
---@field max_force_distraction_distance double @ [Read-only] 
---@field max_force_distraction_chunk_distance uint @ [Read-only] 
---@field max_electric_pole_supply_area_distance float @ [Read-only] 
---@field max_electric_pole_connection_distance double @ [Read-only] 
---@field max_beacon_supply_area_distance double @ [Read-only] 
---@field max_gate_activation_distance double @ [Read-only] 
---@field max_inserter_reach_distance double @ [Read-only] 
---@field max_pipe_to_ground_distance uint8 @ [Read-only] 
---@field max_underground_belt_distance uint8 @ [Read-only] 

---Internal
function LuaGameScript.help() end

---
---@param tag string @
---@return LuaEntity @
function LuaGameScript.get_entity_by_tag(tag) end

---Disable showing tips and tricks.
function LuaGameScript.disable_tips_and_tricks() end

---Is this the demo version of Factorio?
---@return boolean @
function LuaGameScript.is_demo() end

---Forces a reload of the scenario script from the original scenario location.
function LuaGameScript.reload_script() end

---Forces a reload of all mods.
function LuaGameScript.reload_mods() end

---Saves the current configuration of Atlas to a file. This will result in huge file containing all of the game graphics moved to as small space as possible.
function LuaGameScript.save_atlas() end

---Run internal consistency checks. Allegedly prints any errors it finds.
function LuaGameScript.check_consistency() end

---Regenerate autoplacement of some entities on all surfaces. This can be used to autoplace newly-added entities.
---@param entities string | string[] | string @
function LuaGameScript.regenerate_entity(entities) end

---Forces the screenshot saving system to wait until all queued screenshots have been written to disk.
function LuaGameScript.set_wait_for_screenshots_to_finish() end

---Convert a table to a JSON string
---@param data table @
---@return string @
function LuaGameScript.table_to_json(data) end

---Convert a JSON string to a table
---@param json string @The string to conver
---@return Any @
function LuaGameScript.json_to_table(json) end

---Write a string to a file.
---@param filename string @Path to the file to write to
---@param data LocalisedString @File conten
---@param app_end boolean @When true, this will append to the end of the file. Defaults to false, which will overwrite any pre-existing file with the new data
---@param for_player uint @If given, the file will only be written for this player_index. 0 means only the server if one exists
function LuaGameScript.write_file(filename, data, app_end, for_player) end

---Remove file or directory. Given path is taken relative to the script output directory. Can be used to remove files created by LuaGameScript::write_file.
---@param path string @Path to remove, relative to the script output director
function LuaGameScript.remove_path(path) end

---Remove players who are currently not connected from the map.
---@param players LuaPlayer[] @List of players to remove. If not specified,   remove all offline players
function LuaGameScript.remove_offline_players(players) end

---Force a CRC check. Tells all peers to calculate their current map CRC; these CRC are then compared against each other. If a mismatch is detected, the game is desynced and some peers are forced to reconnect.
function LuaGameScript.force_crc() end

---Create a new force.
---@param force string @Name of the new forc
---@return LuaForce @
function LuaGameScript.create_force(force) end

---Marks two forces to be merge together. All entities in the source force will be reassigned to the target force. The source force will then be destroyed.
---@param source ForceSpecification @The force to remov
---@param destination ForceSpecification @The force to reassign all entities t
function LuaGameScript.merge_forces(source, destination) end

---Create a new surface
---@param name string @Name of the new surfac
---@param settings MapGenSettings @Map generation setting
---@return LuaSurface @
function LuaGameScript.create_surface(name, settings) end

---Instruct the server to save the map.
---@param name string @Save name. If not specified, writes into the currently-running save
function LuaGameScript.server_save(name) end

---Instruct the game to perform an auto-save.
---@param name string @The autosave name if any. Saves will be named _autosave-*name* when provided
function LuaGameScript.auto_save(name) end

---Deletes the given surface and all entities on it.
---@param surface string | LuaSurface @The surface to be deleted. Currently the primary surface (1, 'nauvis') cannot be deleted
function LuaGameScript.delete_surface(surface) end

---Disables replay saving for the current save file. Once done there's no way to re-enable replay saving for the save file without loading an old save.
function LuaGameScript.disable_replay() end

---Disables tutorial triggers, that unlock new tutorials and show notices about unlocked tutorials.
function LuaGameScript.disable_tutorial_triggers() end

---Converts the given direction into the string version of the direction.
---@param direction defines.direction @
function LuaGameScript.direction_to_string(direction) end

---Print text to the chat console all players.
---@param message LocalisedString @
---@param color Color @
function LuaGameScript.print(message, color) end

---Creates a deterministic standalone random generator with the given seed or if a seed is not provided the initial map seed is used.
---@param seed uint @
---@return LuaRandomGenerator @
function LuaGameScript.create_random_generator(seed) end

---Goes over all items, entities, tiles, recipes, technologies among other things and logs if the locale is incorrect.
function LuaGameScript.check_prototype_translations() end

---Checks if the given sound path is valid.
---@return boolean @
function LuaGameScript.is_valid_sound_path() end

---Returns true if sprite_path is valid and contains loaded sprite, otherwise false. Sprite path of type file doesn't validate if file exists.
---@param sprite_path SpritePath @Path to a image
---@return boolean @
function LuaGameScript.is_valid_sprite_path(sprite_path) end

---Kicks the given player from this multiplayer game. Does nothing if this is a single player game or if the player running this isn't an admin.
---@param PlayerSpecification PlayerSpecification @The player to kick
---@param reason LocalisedString @The reason given if any
function LuaGameScript.kick_player(PlayerSpecification, reason) end

---Bans the given player from this multiplayer game. Does nothing if this is a single player game of if the player running this isn't an admin.
---@param PlayerSpecification PlayerSpecification @The player to ban
---@param reason LocalisedString @The reason given if any
function LuaGameScript.ban_player(PlayerSpecification, reason) end

---Unbans the given player from this multiplayer game. Does nothing if this is a single player game of if the player running this isn't an admin.
---@param PlayerSpecification PlayerSpecification @The player to unban
function LuaGameScript.unban_player(PlayerSpecification) end

---Purges the given players messages from the game. Does nothing if the player running this isn't an admin.
---@param PlayerSpecification PlayerSpecification @The player to purge
function LuaGameScript.purge_player(PlayerSpecification) end

---Mutes the given player. Does nothing if the player running this isn't an admin.
---@param PlayerSpecification PlayerSpecification @The player to mute
function LuaGameScript.mute_player(PlayerSpecification) end

---Unmutes the given player. Does nothing if the player running this isn't an admin.
---@param PlayerSpecification PlayerSpecification @The player to unmute
function LuaGameScript.unmute_player(PlayerSpecification) end

---Counts how many distinct groups of pipes exist in the world.
function LuaGameScript.count_pipe_groups() end

---Is the map loaded is multiplayer?
---@return boolean @
function LuaGameScript.is_multiplayer() end

---Gets the number of entities that are active (updated each tick).
---@param surface SurfaceSpecification @If give, only the entities active on this surface are counted
---@return uint @
function LuaGameScript.get_active_entities_count(surface) end

---Gets the map exchange string for the map generation settings that were used to create this map.
---@return string @
function LuaGameScript.get_map_exchange_string() end

---Convert a map exchange string to map gen settings and map settings.
---@param map_exchange_string string @
---@return MapExchangeStringData @
function LuaGameScript.parse_map_exchange_string(map_exchange_string) end

---Gets train stops matching the given filters.
---@param opts string | string[] | string @Table with the following fields: name :: string or array of string  (optional)surface :: SurfaceSpecification  (optional)force :: ForceSpecification  (optional
---@return array of LuaEntity @
function LuaGameScript.get_train_stops(opts) end

---Gets the given player or returns nil if no player is found.
---@param player uint | string @The player index or name
---@return LuaPlayer @
function LuaGameScript.get_player(player) end

---Gets the given surface or returns nil if no surface is found.
---@param surface uint | string @The surface index or name
---@return LuaSurface @
function LuaGameScript.get_surface(surface) end

---Creates a LuaProfiler, which is used for measuring script performance.
---@param stopped boolean @Create the timer stoppe
---@return LuaProfiler @
function LuaGameScript.create_profiler(stopped) end

---Evaluate an expression, substituting variables as provided. For details on the formula, see the relevant page on the  Factorio wiki.
---@param expression string @The expression to evaluate
---@param variables table<string, double> @Variables to be substituted
---@return double @
function LuaGameScript.evaluate_expression(expression, variables) end

---
---@param filters EntityPrototypeFilters @
---@return CustomDictionary string → LuaEntityPrototype @
function LuaGameScript.get_filtered_entity_prototypes(filters) end

---
---@param filters ItemPrototypeFilters @
---@return CustomDictionary string → LuaItemPrototype @
function LuaGameScript.get_filtered_item_prototypes(filters) end

---
---@param filters EquipmentPrototypeFilters @
---@return CustomDictionary string → LuaEquipmentPrototype @
function LuaGameScript.get_filtered_equipment_prototypes(filters) end

---
---@param filters ModSettingPrototypeFilters @
---@return CustomDictionary string → LuaModSettingPrototype @
function LuaGameScript.get_filtered_mod_setting_prototypes(filters) end

---
---@param filters AchievementPrototypeFilters @
---@return CustomDictionary string → LuaAchievementPrototype @
function LuaGameScript.get_filtered_achievement_prototypes(filters) end

---
---@param filters TilePrototypeFilters @
---@return CustomDictionary string → LuaTilePrototype @
function LuaGameScript.get_filtered_tile_prototypes(filters) end

---
---@param filters DecorativePrototypeFilters @
---@return CustomDictionary string → LuaDecorativePrototype @
function LuaGameScript.get_filtered_decorative_prototypes(filters) end

---
---@param filters FluidPrototypeFilters @
---@return CustomDictionary string → LuaFluidPrototype @
function LuaGameScript.get_filtered_fluid_prototypes(filters) end

---
---@param filters RecipePrototypeFilters @
---@return CustomDictionary string → LuaRecipePrototype @
function LuaGameScript.get_filtered_recipe_prototypes(filters) end

---
---@param filters TechnologyPrototypeFilters @
---@return CustomDictionary string → LuaTechnologyPrototype @
function LuaGameScript.get_filtered_technology_prototypes(filters) end

---Creates an inventory that is not owned by any game object. It can be resized later with LuaInventory::resize.
---@param size uint16 @The number of slots the inventory initially has
---@return LuaInventory @
function LuaGameScript.create_inventory(size) end

---Gets the inventories created through LuaGameScript::create_inventory
---@param mod string @The mod who's inventories to get. If not provided all inventories are returned
---@return dictionary string → array of LuaInventory @
function LuaGameScript.get_script_inventories(mod) end

---Resets the amount of time played for this map.
function LuaGameScript.reset_time_played() end

---Deflates and base64 encodes the given string.
---@param string string @The string to encode
---@return string @
function LuaGameScript.encode_string(string) end

---Base64 decodes and inflates the given string.
---@param string string @The string to decode
---@return string @
function LuaGameScript.decode_string(string) end

---@class LuaGroup 
---@field name string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] Localised name of the group.
---@field type string @ [Read-only] 
---@field group LuaGroup @ [Read-only] 
---@field subgroups LuaGroup[] @ [Read-only] 
---@field order_in_recipe string @ [Read-only] 
---@field order string @ [Read-only] 

---@class LuaGui Returns true if sprite_path is valid and contains loaded sprite, otherwise false. Sprite path of type file doesn't validate if file exists.
---@field player LuaPlayer @ [Read-only] 
---@field children table<string, LuaGuiElement> @ [Read-only] The children GUI elements mapped by name <> element.
---@field top LuaGuiElement @ [Read-only] 
---@field left LuaGuiElement @ [Read-only] 
---@field center LuaGuiElement @ [Read-only] 
---@field goal LuaGuiElement @ [Read-only] 
---@field screen LuaGuiElement @ [Read-only] 

---Returns true if sprite_path is valid and contains loaded sprite, otherwise false. Sprite path of type file doesn't validate if file exists.
---@param sprite_path SpritePath @Path to a image
---@return boolean @
function LuaGui.is_valid_sprite_path(sprite_path) end

---@class LuaGuiElement Add a child element.
---@field add LuaGuiElement @(optional) undefined Add a child element.
---@field index uint @ [Read-only] The unique index of this GUI element.
---@field gui LuaGui @ [Read-only] 
---@field parent LuaGuiElement @ [Read-only] 
---@field name string @ [Read-only] 
---@field caption LocalisedString @ [Read-Write] 
---@field value double @ [Read-Write] 
---@field direction string @ [Read-only] 
---@field style LuaStyle | string @ [Read-Write] 
---@field visible boolean @ [Read-Write] When not visible the GUI element is hidden completely and takes no space in the layout.
---@field text string @ [Read-Write] 
---@field children_names string[] @ [Read-only] 
---@field state boolean @ [Read-Write] 
---@field player_index uint @ [Read-only] 
---@field sprite SpritePath @ [Read-Write] The image to display on this sprite-button or sprite in the default state.
---@field resize_to_sprite boolean @ [Read-Write] Whether should the image widget resize its size according to the sprite in it (true by default)
---@field hovered_sprite SpritePath @ [Read-Write] 
---@field clicked_sprite SpritePath @ [Read-Write] 
---@field tooltip LocalisedString @ [Read-Write] 
---@field horizontal_scroll_policy string @ [Read-Write] Policy of the horizontal scroll bar, possible values are "auto" (default), "never", "always", "auto-and-reserve-space".
---@field vertical_scroll_policy string @ [Read-Write] Policy of the vertical scroll bar, possible values are "auto" (default), "never", "always", "auto-and-reserve-space".
---@field type string @ [Read-only] The type of this GUI element.
---@field children LuaGuiElement[] @ [Read-only] The children elements
---@field items LocalisedString[] @ [Read-Write] The items in this dropdown or listbox.
---@field selected_index uint @ [Read-Write] The selected index for this dropdown or listbox. 0 if none.
---@field number double @ [Read-Write] The number to be shown in the right-bottom corner of the sprite-button, or nil to show nothing.
---@field show_percent_for_small_numbers boolean @ [Read-Write] Related to the number to be shown in the right-bottom corner of the sprite-button. When set to true, numbers that are not 0 and smaller than one are shown as percent rather than the value, so for example 0.5 is shown as 50% instead.
---@field location GuiLocation @ [Read-Write] The location of this widget when stored in LuaGui::screen or nil if not not set or not in LuaGui::screen.
---@field auto_center boolean @ [Read-Write] If this frame auto-centers on window resize when stored in LuaGui::screen.
---@field badge_text LocalisedString @ [Read-Write] The text to display after the normal tab text (designed to work with numbers)
---@field position Position @ [Read-Write] The position this camera or minimap is focused on if any.
---@field surface_index uint @ [Read-Write] The surface index this camera or minimap is using.
---@field zoom double @ [Read-Write] The zoom this camera or minimap is using.
---@field minimap_player_index uint @ [Read-Write] The player index this minimap is using.
---@field force string @ [Read-Write] The force this minimap is using or nil if no force is set.
---@field elem_type string @ [Read-only] The elem type of this choose-elem-button.
---@field elem_value string | SignalID @ [Read-Write] The elem value of this choose-elem-button or nil if there is no value.
---@field elem_filters PrototypeFilters @ [Read-Write] The elem filters of this choose-elem-button or nil if there are no filters.
---@field selectable boolean @ [Read-Write] If the contents of this text-box are selectable.
---@field word_wrap boolean @ [Read-Write] If this text-box will word-wrap automatically.
---@field read_only boolean @ [Read-Write] If this text-box is read-only.
---@field enabled boolean @ [Read-Write] If this GUI element is enabled.
---@field ignored_by_interaction boolean @ [Read-Write] If this GUI element is ignored by interaction. This means, that for example, label on a button can't steal the focus or click events of the button.
---@field locked boolean @ [Read-Write] If this choose-elem-button can be changed by the player.
---@field draw_vertical_lines boolean @ [Read-Write] If this table should draw vertical grid lines.
---@field draw_horizontal_lines boolean @ [Read-Write] If this table should draw horizontal grid lines.
---@field draw_horizontal_line_after_headers boolean @ [Read-Write] If this table should draw a horizontal grid line after the headers.
---@field column_count uint @ [Read-only] The number of columns in this table.
---@field vertical_centering boolean @ [Read-Write] Whether the fields of this table should be vertically centered. This true by default and overrides LuaStyle::column_alignments.
---@field slider_value double @ [Read-Write] The value of this slider element.
---@field mouse_button_filter MouseButtonFlags @ [Read-Write] The mouse button filters for this button or sprite-button.
---@field numeric boolean @ [Read-Write] If this text field only accepts numbers.
---@field allow_decimal boolean @ [Read-Write] If this text field (when in numeric mode) allows decimal numbers.
---@field allow_negative boolean @ [Read-Write] If this text field (when in numeric mode) allows negative numbers.
---@field is_password boolean @ [Read-Write] If this text field displays as a password field (renders all characters as '*').
---@field lose_focus_on_confirm boolean @ [Read-Write] If this text field loses focus after defines.events.on_gui_confirmed is fired.
---@field clear_and_focus_on_right_click boolean @ [Read-Write] 
---@field drag_target LuaGuiElement @ [Read-Write] The frame drag target for this flow, frame, label, table, or empty-widget.
---@field selected_tab_index uint @ [Read-Write] The selected tab index or nil if no tab is selected.
---@field tabs object[] @ [Read-only] The tabs and contents being shown in this tabbed-pane.
---@field entity LuaEntity @ [Read-Write] The entity associated with this entity-preview or nil if no entity is associated.
---@field switch_state string @ [Read-Write] The switch state (left, none, right) for this switch.
---@field allow_none_state boolean @ [Read-Write] If the 'none' state is allowed for this switch.
---@field left_label_caption LocalisedString @ [Read-Write] The text shown for the left switch label.
---@field left_label_tooltip LocalisedString @ [Read-Write] The text shown for the left switch tooltip.
---@field right_label_caption LocalisedString @ [Read-Write] The text shown for the right switch label.
---@field right_label_tooltip LocalisedString @ [Read-Write] The text shown for the right switch tooltip.
---@field bracket_operator LuaGuiElement @ [Read-only] The indexing operator. Gets children by name.

---Remove children of this element. Any LuaGuiElement objects referring to the destroyed elements become invalid after this operation.
function LuaGuiElement.clear() end

---Remove this element, along with its children. Any LuaGuiElement objects referring to the destroyed elements become invalid after this operation.
function LuaGuiElement.destroy() end

---The mod that owns this Gui element or nil if it's owned by the scenario script.
---@return string @
function LuaGuiElement.get_mod() end

---Clears the items in this dropdown or listbox.
function LuaGuiElement.clear_items() end

---Gets an item at the given index from this dropdown or listbox.
---@param index uint @The index to get
---@return LocalisedString @
function LuaGuiElement.get_item(index) end

---Sets an item at the given index in this dropdown or listbox.
---@param index uint @The inde
---@param LocalisedString LocalisedString @The item
function LuaGuiElement.set_item(index, LocalisedString) end

---Adds an item at the end or at the given index in this dropdown or listbox.
---@param LocalisedString LocalisedString @The item
---@param index uint @The inde
function LuaGuiElement.add_item(LocalisedString, index) end

---Removes an item at the given index in this dropdown or listbox.
---@param index uint @The inde
function LuaGuiElement.remove_item(index) end

---Gets this sliders minimum value.
---@return double @
function LuaGuiElement.get_slider_minimum() end

---Gets this sliders maximum value.
---@return double @
function LuaGuiElement.get_slider_maximum() end

---Sets this sliders minimum and maximum values.
---@param minimum double @
---@param maximum double @
function LuaGuiElement.set_slider_minimum_maximum(minimum, maximum) end

---Gets the minimum distance the slider can move.
---@return double @
function LuaGuiElement.get_slider_value_step() end

---Gets if the slider only allows being moved to discrete positions.
---@return boolean @
function LuaGuiElement.get_slider_discrete_slider() end

---Gets if the slider only allows being having discrete values.
---@return boolean @
function LuaGuiElement.get_slider_discrete_values() end

---The minimum distance the slider can move.
---@param value double @
function LuaGuiElement.set_slider_value_step(value) end

---Sets if the slider only allows being moved to discrete positions.
---@param value boolean @
function LuaGuiElement.set_slider_discrete_slider(value) end

---Sets if the slider only allows being having discrete values.
---@param value boolean @
function LuaGuiElement.set_slider_discrete_values(value) end

---Focuses this GUI element if possible.
function LuaGuiElement.focus() end

---Scrolls the scroll bar to the top.
function LuaGuiElement.scroll_to_top() end

---Scrolls the scroll bar to the bottom.
function LuaGuiElement.scroll_to_bottom() end

---Scrolls the scroll bar to the left.
function LuaGuiElement.scroll_to_left() end

---Scrolls the scroll bar to the right.
function LuaGuiElement.scroll_to_right() end

---Scrolls the scroll bar such that the specified GUI element is visible to the player.
---@param element LuaGuiElement @The element to scroll to
---@param scroll_mode string @Where the element should be positioned in the scroll-pane. Must be either: "in-view", or "top-third". Defaults to "in-view"
function LuaGuiElement.scroll_to_element(element, scroll_mode) end

---Select all text in the text box.
function LuaGuiElement.select_all() end

---Select a range of text in the text box.
---@param start int @The index of the first character to select
---@param _end int @The index of the last character to select
function LuaGuiElement.select(start, _end) end

---Adds the given tab and content widgets to this tabbed pane as a new tab.
---@param tab LuaGuiElement @The tab to add, must be a GUI element of type "tab"
---@param content LuaGuiElement @The content to show when this tab is selected. Can be any type of GUI element
function LuaGuiElement.add_tab(tab, content) end

---Removes the given tab and what ever it's associated content is from this tabbed pane.
---@param tab LuaGuiElement @The tab to remove. If nil all tabs are removed
function LuaGuiElement.remove_tab(tab) end

---Forces this frame to re-auto-center. Only works on frames stored directly in LuaGui::screen.
function LuaGuiElement.force_auto_center() end

---Scrolls the scroll bar such that the specified listbox item is visible to the player.
---@param index int @The item index to scroll to
---@param scroll_mode string @Where the item should be positioned in the scroll-pane. Must be either: "in-view", or "top-third". Defaults to "in-view"
function LuaGuiElement.scroll_to_item(index, scroll_mode) end

---@class LuaHeatEnergySourcePrototype 
---@field emissions double @ [Read-only] 
---@field render_no_network_icon boolean @ [Read-only] 
---@field render_no_power_icon boolean @ [Read-only] 
---@field max_temperature double @ [Read-only] 
---@field default_temperature double @ [Read-only] 
---@field specific_heat double @ [Read-only] 
---@field max_transfer double @ [Read-only] 
---@field min_temperature_gradient double @ [Read-only] 
---@field min_working_temperature double @ [Read-only] 
---@field minimum_glow_temperature double @ [Read-only] 
---@field connections object[] @ [Read-only] 

---@class LuaInventory Make this inventory empty.
---@field hash_operator uint @ [Read-only] Get the number of slots in this inventory.
---@field index defines.inventory @ [Read-only] 
---@field entity_owner LuaEntity @ [Read-only] 
---@field player_owner LuaPlayer @ [Read-only] 
---@field equipment_owner LuaEntity @ [Read-only] 
---@field mod_owner string @ [Read-only] 
---@field bracket_operator LuaItemStack @ [Read-only] The indexing operator.

---Make this inventory empty.
function LuaInventory.clear() end

---Can at least some items be inserted?
---@param items ItemStackSpecification @Items that would be inserted
---@return boolean @
function LuaInventory.can_insert(items) end

---Insert items into this inventory.
---@param items ItemStackSpecification @Items to insert
---@return uint @
function LuaInventory.insert(items) end

---Remove items from this inventory.
---@param items ItemStackSpecification @Items to remove
---@return uint @
function LuaInventory.remove(items) end

---Get the number of all or some items in this inventory.
---@param item string @Prototype name of the item to count. If not specified, count all items
---@return uint @
function LuaInventory.get_item_count(item) end

---Does this inventory contain nothing?
---@return boolean @
function LuaInventory.is_empty() end

---Get counts of all items in this inventory.
---@return dictionary string → uint @
function LuaInventory.get_contents() end

---Does this inventory support a bar? Bar is the draggable red thing, found for example on chests, that limits the portion of the inventory that may be manipulated by machines.
---@return boolean @
function LuaInventory.supports_bar() end

---Get the current bar. This is the index at which the red area starts.
---@return uint @
function LuaInventory.get_bar() end

---Set the current bar.
---@param bar uint @The new limit. Omitting this parameter will clear the limit
function LuaInventory.set_bar(bar) end

---If this inventory supports filters.
---@return boolean @
function LuaInventory.supports_filters() end

---If this inventory supports filters and has at least 1 filter set.
---@return boolean @
function LuaInventory.is_filtered() end

---If the given inventory slot filter can be set to the given filter.
---@param index uint @The item stack inde
---@param filter string @The item name of the filte
---@return boolean @
function LuaInventory.can_set_filter(index, filter) end

---Gets the filter for the given item stack index.
---@param index uint @The item stack inde
---@return string @
function LuaInventory.get_filter(index) end

---Sets the filter for the given item stack index.
---@param index uint @The item stack inde
---@param filter string @The new filter or nil to erase the filte
---@return boolean @
function LuaInventory.set_filter(index, filter) end

---Gets the first LuaItemStack in the inventory that matches the given item name.
---@param item string @The item name to fin
---@return LuaItemStack @
function LuaInventory.find_item_stack(item) end

---Finds the first empty stack. Filtered slots are excluded unless a filter item is given.
---@param item string @If given, empty stacks that are filtered for this item will be included
---@return LuaItemStack @
function LuaInventory.find_empty_stack(item) end

---Counts the number of empty stacks.
---@param include_filtered boolean @If true, filtered slots will be included. Defaults to false
---@return uint @
function LuaInventory.count_empty_stacks(include_filtered) end

---Gets the number of the given item that can be inserted into this inventory.
---@param item string @The item to check
function LuaInventory.get_insertable_count(item) end

---Sorts and merges the items in this inventory.
function LuaInventory.sort_and_merge() end

---Resizes the inventory.
---@param size uint16 @New size of a inventor
function LuaInventory.resize(size) end

---Destroys this inventory.
function LuaInventory.destroy() end

---@class LuaItemPrototype Does this prototype have a flag enabled?
---@field type string @ [Read-only] 
---@field name string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field order string @ [Read-only] 
---@field place_result LuaEntityPrototype @ [Read-only] 
---@field place_as_equipment_result LuaEquipmentPrototype @ [Read-only] 
---@field place_as_tile_result PlaceAsTileResult @ [Read-only] The place as tile result if one is defined else nil.
---@field stackable boolean @ [Read-only] 
---@field default_request_amount uint @ [Read-only] 
---@field stack_size uint @ [Read-only] 
---@field wire_count uint @ [Read-only] 
---@field fuel_category string @ [Read-only] 
---@field burnt_result LuaItemPrototype @ [Read-only] 
---@field fuel_value float @ [Read-only] 
---@field fuel_acceleration_multiplier double @ [Read-only] 
---@field fuel_top_speed_multiplier double @ [Read-only] 
---@field fuel_emissions_multiplier double @ [Read-only] 
---@field subgroup LuaGroup @ [Read-only] 
---@field group LuaGroup @ [Read-only] 
---@field flags table<string, boolean> @ [Read-only] The item prototype flags for this item prototype. It is a dictionary where the keys are the set flags and the value is always true -- if a flag is unset, it isn't present in the dictionary at all.
---@field rocket_launch_products Product[] @ [Read-only] The results from launching this item in a rocket.
---@field can_be_mod_opened boolean @ [Read-only] If this item can be mod-opened.
---@field magazine_size float @ [Read-only] 
---@field reload_time float @ [Read-only] 
---@field equipment_grid LuaEquipmentGridPrototype @ [Read-only] The prototype of this armor equipment grid or nil if none or this is not an armor item.
---@field resistances Resistances @ [Read-only] 
---@field inventory_size_bonus uint @ [Read-only] The inventory size bonus for this armor prototype. nil if this isn't an armor prototype.
---@field capsule_action CapsuleAction @ [Read-only] The capsule action for this capsule item prototype or nil if this isn't a capsule item prototype.
---@field attack_parameters AttackParameters @ [Read-only] The gun attack parameters or nil if not a gun item prototype.
---@field inventory_size uint @ [Read-only] The main inventory size for item-with-inventory-prototype. nil if not an item-with-inventory-prototype.
---@field item_filters table<string, LuaItemPrototype> @ [Read-only] 
---@field item_group_filters table<string, LuaGroup> @ [Read-only] 
---@field item_subgroup_filters table<string, LuaGroup> @ [Read-only] 
---@field filter_mode string @ [Read-only] The filter mode used by this item with inventory.
---@field insertion_priority_mode string @ [Read-only] The insertion priority mode used by this item with inventory.
---@field localised_filter_message LocalisedString @ [Read-only] The localised string used when the player attempts to put items into this item with inventory that aren't allowed.
---@field extend_inventory_by_default boolean @ [Read-only] If this item with inventory extends the inventory it resides in by default.
---@field default_label_color Color @ [Read-only] The default label color used for this item with label. nil if not defined or if this isn't an item with label.
---@field draw_label_for_cursor_render boolean @ [Read-only] If true, and this item with label has a label it is drawn in place of the normal number when held in the cursor.
---@field speed float @ [Read-only] 
---@field module_effects Effects @ [Read-only] Effects of this module; nil if this is not a module. It is a dictionary indexed by the effect type.
---@field category string @ [Read-only] The name of a LuaModuleCategoryPrototype. Used when upgrading modules: Ctrl + click modules into an entity and it will replace lower tier modules of the same category with higher tier modules.
---@field tier uint @ [Read-only] Tier of the module inside its category. Used when upgrading modules: Ctrl + click modules into an entity and it will replace lower tier modules with higher tier modules if they have the same category.
---@field limitations string[] @ [Read-only] An array of recipe names this module is allowed to work with.
---@field limitation_message_key string @ [Read-only] The limitation message key used when the player attempts to use this modules in some place it's not allowed.
---@field straight_rail LuaEntityPrototype @ [Read-only] The straight rail prototype used for this rail planner prototype.
---@field curved_rail LuaEntityPrototype @ [Read-only] The curved rail prototype used for this rail planner prototype.
---@field repair_result Trigger @ [Read-only] The repair result of this repair tool prototype or nil if this isn't a repair tool prototype.
---@field selection_border_color Color @ [Read-only] The color used when doing normal selection with this selection tool prototype.
---@field alt_selection_border_color Color @ [Read-only] The color used when doing alt selection with this selection tool prototype.
---@field selection_mode_flags SelectionModeFlags @ [Read-only] 
---@field alt_selection_mode_flags SelectionModeFlags @ [Read-only] 
---@field selection_cursor_box_type string @ [Read-only] 
---@field alt_selection_cursor_box_type string @ [Read-only] 
---@field always_include_tiles boolean @ [Read-only] If tiles area always included when doing selection with this selection tool prototype.
---@field show_in_library boolean @ [Read-only] Is this selection tool prototype available in the blueprint library. nil if not selection tool or blueprint book.
---@field entity_filter_mode string @ [Read-only] The entity filter mode used by this selection tool.
---@field alt_entity_filter_mode string @ [Read-only] The alt entity filter mode used by this selection tool.
---@field tile_filter_mode string @ [Read-only] The tile filter mode used by this selection tool.
---@field alt_tile_filter_mode string @ [Read-only] The alt tile filter mode used by this selection tool.
---@field entity_filters table<string, LuaEntityPrototype> @ [Read-only] The entity filters used by this selection tool indexed by entity name.
---@field alt_entity_filters table<string, LuaEntityPrototype> @ [Read-only] The alt entity filters used by this selection tool indexed by entity name.
---@field entity_type_filters table<string, boolean> @ [Read-only] The entity type filters used by this selection tool indexed by entity type.
---@field alt_entity_type_filters table<string, boolean> @ [Read-only] The alt entity type filters used by this selection tool indexed by entity type.
---@field tile_filters table<string, LuaTilePrototype> @ [Read-only] The tile filters used by this selection tool indexed by tile name.
---@field alt_tile_filters table<string, LuaTilePrototype> @ [Read-only] The alt tile filters used by this selection tool indexed by tile name.
---@field entity_filter_slots uint @ [Read-only] The number of entity filters this deconstruction item has or nil if this isn't a deconstruction item prototype.
---@field tile_filter_slots uint @ [Read-only] The number of tile filters this deconstruction item has or nil if this isn't a deconstruction item prototype.
---@field durability_description_key string @ [Read-only] The durability message key used when displaying the durability of this tool.
---@field durability double @ [Read-only] The durability of this tool item or nil if not a tool item.
---@field infinite boolean @ [Read-only] If this tool item has infinite durability. nil if not a tool type item.
---@field mapper_count uint @ [Read-only] How many filters an upgrade item has. nil if not a upgrade item.

---Does this prototype have a flag enabled?
---@param flag string @The flag to check. Can be "hidden", "hide-from-bonus-gui", or "hide-from-fuel-tooltip"
---@return boolean @
function LuaItemPrototype.has_flag(flag) end

---Type of this ammo prototype or nil if this is not an ammo prototype.
---@param ammo_source_type string @"default", "player", "turret", or "vehicle
---@return AmmoType @
function LuaItemPrototype.get_ammo_type(ammo_source_type) end

---@class LuaItemStack Is this blueprint item setup? I.e. is it a non-empty blueprint?
---@field build_blueprint array of LuaEntity @(optional) undefined Build this blueprint
---@field deconstruct_area nil @(optional) undefined Deconstruct the given area with this deconstruction item.
---@field cancel_deconstruct_area nil @(optional) undefined Cancel deconstruct the given area with this deconstruction item.
---@field create_blueprint dictionary uint → LuaEntity @(optional) undefined Sets up this blueprint using the found blueprintable entities/tiles on the surface.
---@field valid_for_read boolean @ [Read-only] 
---@field prototype LuaItemPrototype @ [Read-only] 
---@field name string @ [Read-only] 
---@field type string @ [Read-only] 
---@field count uint @ [Read-Write] 
---@field grid LuaEquipmentGrid @ [Read-only] 
---@field health float @ [Read-Write] 
---@field durability double @ [Read-Write] 
---@field ammo uint @ [Read-Write] 
---@field blueprint_icons object[] @ [Read-Write] 
---@field label string @ [Read-Write] 
---@field label_color Color @ [Read-Write] 
---@field allow_manual_label_change boolean @ [Read-Write] 
---@field cost_to_build table<string, uint> @ [Read-only] 
---@field extends_inventory boolean @ [Read-Write] 
---@field prioritize_insertion_mode string @ [Read-Write] 
---@field default_icons object[] @ [Read-only] 
---@field tags Tags @ [Read-Write] 
---@field custom_description LocalisedString @ [Read-Write] The custom description this item-with-tags. This is shown over the normal item description if this is set to a non-empty value.
---@field entity_filters string[] @ [Read-Write] The entity filters for this deconstruction item.
---@field tile_filters string[] @ [Read-Write] The tile filters for this deconstruction item.
---@field entity_filter_mode defines.deconstruction_item.entity_filter_mode @ [Read-Write] The blacklist/whitelist entity filter mode for this deconstruction item.
---@field tile_filter_mode defines.deconstruction_item.tile_filter_mode @ [Read-Write] The blacklist/whitelist tile filter mode for this deconstruction item.
---@field tile_selection_mode defines.deconstruction_item.tile_selection_mode @ [Read-Write] The tile selection mode for this deconstruction item.
---@field trees_and_rocks_only boolean @ [Read-Write] If this deconstruction item is set to allow trees and rocks only.
---@field entity_filter_count uint @ [Read-only] The number of entity filters this deconstruction item supports.
---@field tile_filter_count uint @ [Read-only] The number of tile filters this deconstruction item supports.
---@field active_index uint @ [Read-Write] The active blueprint index for this blueprint book.
---@field item_number uint @ [Read-only] The unique ID for this item if it has a unique ID or nil. The following item types have unique IDs:
---@field is_blueprint boolean @ [Read-only] If this is a blueprint item.
---@field is_blueprint_book boolean @ [Read-only] If this is a blueprint book item.
---@field is_module boolean @ [Read-only] If this is a module item.
---@field is_tool boolean @ [Read-only] If this is a tool item.
---@field is_mining_tool boolean @ [Read-only] If this is a mining tool item.
---@field is_armor boolean @ [Read-only] If this is an armor item.
---@field is_repair_tool boolean @ [Read-only] If this is a repair tool item.
---@field is_item_with_label boolean @ [Read-only] If this is an item with label item.
---@field is_item_with_inventory boolean @ [Read-only] If this is an item with inventory item.
---@field is_item_with_entity_data boolean @ [Read-only] If this is an item with entity data item.
---@field is_selection_tool boolean @ [Read-only] If this is a selection tool item.
---@field is_item_with_tags boolean @ [Read-only] If this is an item with tags item.
---@field is_deconstruction_item boolean @ [Read-only] If this is a deconstruction tool item.
---@field is_upgrade_item boolean @ [Read-only] If this is a upgrade item.

---Is this blueprint item setup? I.e. is it a non-empty blueprint?
---@return boolean @
function LuaItemStack.is_blueprint_setup() end

---Entities in this blueprint.
---@return array of blueprint entity @
function LuaItemStack.get_blueprint_entities() end

---Set new entities to be a part of this blueprint.
---@param entities object[] @New blueprint entities. The format is the same as in   LuaItemStack::get_blueprint_entities
function LuaItemStack.set_blueprint_entities(entities) end

---Add ammo to this ammo item.
---@param amount float @Amount of ammo to add
function LuaItemStack.add_ammo(amount) end

---Remove ammo from this ammo item.
---@param amount float @Amount of ammo to remove
function LuaItemStack.drain_ammo(amount) end

---Add durability to this tool item.
---@param amount double @Amount of durability to add
function LuaItemStack.add_durability(amount) end

---Remove durability from this tool item.
---@param amount double @Amount of durability to remove
function LuaItemStack.drain_durability(amount) end

---Would a call to LuaItemStack::set_stack succeed?
---@param stack ItemStackSpecification @Stack that would be set, possibly nil
---@return boolean @
function LuaItemStack.can_set_stack(stack) end

---Set this item stack to another item stack.
---@param stack ItemStackSpecification @
---@return boolean @
function LuaItemStack.set_stack(stack) end

---Transfers the given item stack into this item stack.
---@param stack ItemStackSpecification @
---@return boolean @
function LuaItemStack.transfer_stack(stack) end

---Export a supported item (blueprint, blueprint-book, deconstruction-planner, upgrade-planner, item-with-tags) to a string
---@return string @
function LuaItemStack.export_stack() end

---Import a supported item (blueprint, blueprint-book, deconstruction-planner, upgrade-planner, item-with-tags) from a string
---@param data string @The string to impor
---@return int @
function LuaItemStack.import_stack(data) end

---Swaps this item stack with the given item stack if allowed.
---@param stack LuaItemStack @
---@return boolean @
function LuaItemStack.swap_stack(stack) end

---Clear this item stack.
function LuaItemStack.clear() end

---Tiles in this blueprint
---@return array of blueprint tile @
function LuaItemStack.get_blueprint_tiles() end

---Set tiles in this blueprint
---@param tiles object[] @Tiles to be a part of the blueprint; the format is the same as is   returned from the corresponding get function; see LuaItemStack::get_blueprint_tiles
function LuaItemStack.set_blueprint_tiles(tiles) end

---Access the inner inventory of an item.
---@param inventory defines.inventory @
---@return LuaInventory @
function LuaItemStack.get_inventory(inventory) end

---Gets the tag with the given name or returns nil if it doesn't exist.
---@param tag_name string @
---@return Any @
function LuaItemStack.get_tag(tag_name) end

---Sets the tag with the given name and value.
---@param tag_name string @
---@param tag Any @
---@return Any @
function LuaItemStack.set_tag(tag_name, tag) end

---Removes a tag with the given name.
---@param tag string @
---@return boolean @
function LuaItemStack.remove_tag(tag) end

---Clears this blueprint item.
function LuaItemStack.clear_blueprint() end

---Gets the entity filter at the given index for this deconstruction item.
---@param index uint @
---@return string @
function LuaItemStack.get_entity_filter(index) end

---Sets the entity filter at the given index for this deconstruction item.
---@param index uint @
---@param filter string | LuaEntityPrototype | LuaEntity @Setting to nil erases the filter
---@return boolean @
function LuaItemStack.set_entity_filter(index, filter) end

---Gets the tile filter at the given index for this deconstruction item.
---@param index uint @
---@return string @
function LuaItemStack.get_tile_filter(index) end

---Sets the tile filter at the given index for this deconstruction item.
---@param index uint @
---@param filter string | LuaTilePrototype | LuaTile @Setting to nil erases the filter
---@return boolean @
function LuaItemStack.set_tile_filter(index, filter) end

---Clears all settings/filters on this deconstruction item resetting it to default values.
function LuaItemStack.clear_deconstruction_item() end

---Clears all settings/filters on this upgrade item resetting it to default values.
function LuaItemStack.clear_upgrade_item() end

---Gets the filter at the given index for this upgrade item.
---@param index uint @The index of the mapper to read
---@param type string @'from' or 'to'
---@return UpgradeFilter @
function LuaItemStack.get_mapper(index, type) end

---Sets the module filter at the given index for this upgrade item.
---@param index uint @The index of the mapper to set
---@param type string @from or to
---@param filter UpgradeFilter @The filter to set or ni
function LuaItemStack.set_mapper(index, type, filter) end

---Gets the number of entities in this blueprint item.
---@return uint @
function LuaItemStack.get_blueprint_entity_count() end

---Gets the tags for the given blueprint entity index in this blueprint item.
---@param index uint @
---@return Tags @
function LuaItemStack.get_blueprint_entity_tags(index) end

---Sets the tags on the given blueprint entity index in this blueprint item.
---@param index uint @The entity inde
---@param tags Tags @
function LuaItemStack.set_blueprint_entity_tags(index, tags) end

---Gets the given tag on the given blueprint entity index in this blueprint item.
---@param index uint @The entity inde
---@param tag string @The tag to ge
---@return Any @
function LuaItemStack.get_blueprint_entity_tag(index, tag) end

---Sets the given tag on the given blueprint entity index in this blueprint item.
---@param index uint @The entity inde
---@param tag string @The tag to se
---@param value Any @The tag value to set or nil to clear the ta
function LuaItemStack.set_blueprint_entity_tag(index, tag, value) end

---@class LuaLazyLoadedValue Gets the value of this lazy loaded value.

---Gets the value of this lazy loaded value.
---@return varies @
function LuaLazyLoadedValue.get() end

---@class LuaLogisticCell Is a given position within the logistic range of this cell?
---@field logistic_radius float @ [Read-only] 
---@field logistics_connection_distance float @ [Read-only] 
---@field construction_radius float @ [Read-only] 
---@field stationed_logistic_robot_count uint @ [Read-only] 
---@field stationed_construction_robot_count uint @ [Read-only] 
---@field mobile boolean @ [Read-only] 
---@field transmitting boolean @ [Read-only] 
---@field charge_approach_distance float @ [Read-only] 
---@field charging_robot_count uint @ [Read-only] 
---@field to_charge_robot_count uint @ [Read-only] 
---@field owner LuaEntity @ [Read-only] 
---@field logistic_network LuaLogisticNetwork @ [Read-only] 
---@field neighbours LuaLogisticCell[] @ [Read-only] 
---@field charging_robots LuaEntity[] @ [Read-only] 
---@field to_charge_robots LuaEntity[] @ [Read-only] 

---Is a given position within the logistic range of this cell?
---@param position Position @
---@return boolean @
function LuaLogisticCell.is_in_logistic_range(position) end

---Is a given position within the construction range of this cell?
---@param position Position @
---@return boolean @
function LuaLogisticCell.is_in_construction_range(position) end

---Are two cells neighbours?
---@param other LuaLogisticCell @
---@return boolean @
function LuaLogisticCell.is_neighbour_with(other) end

---@class LuaLogisticNetwork Count given or all items in the network or given members.
---@field select_pickup_point LuaLogisticPoint @(optional) undefined Find the 'best' logistic point with this item ID and from the given position or from given chest type.
---@field select_drop_point LuaLogisticPoint @(optional) undefined Find a logistic point to drop the specific item stack.
---@field force LuaForce @ [Read-only] The force this logistic network belongs to.
---@field available_logistic_robots uint @ [Read-only] 
---@field all_logistic_robots uint @ [Read-only] 
---@field available_construction_robots uint @ [Read-only] 
---@field all_construction_robots uint @ [Read-only] 
---@field robot_limit uint @ [Read-only] 
---@field cells LuaLogisticCell[] @ [Read-only] 
---@field providers LuaEntity[] @ [Read-only] 
---@field empty_providers LuaEntity[] @ [Read-only] 
---@field requesters LuaEntity[] @ [Read-only] 
---@field storages LuaEntity[] @ [Read-only] 
---@field logistic_members LuaEntity[] @ [Read-only] 
---@field provider_points LuaLogisticPoint[] @ [Read-only] 
---@field passive_provider_points LuaLogisticPoint[] @ [Read-only] 
---@field active_provider_points LuaLogisticPoint[] @ [Read-only] 
---@field empty_provider_points LuaLogisticPoint[] @ [Read-only] 
---@field requester_points LuaLogisticPoint[] @ [Read-only] 
---@field storage_points LuaLogisticPoint[] @ [Read-only] 
---@field robots LuaEntity[] @ [Read-only] All robots in this logistic network.
---@field construction_robots LuaEntity[] @ [Read-only] All construction robots in this logistic network.
---@field logistic_robots LuaEntity[] @ [Read-only] All logistic robots in this logistic network.

---Count given or all items in the network or given members.
---@param item string @Item name to count. If not given, gives counts   of all items in the network
---@param member string @Logistic members to check, must be either "storage"   or "providers". If not given, gives count in the entire network
---@return int @
function LuaLogisticNetwork.get_item_count(item, member) end

---Get item counts for the entire network.
---@return dictionary string → uint @
function LuaLogisticNetwork.get_contents() end

---Remove items from the logistic network. This will actually remove the items from some logistic chests.
---@param item ItemStackSpecification @What to remove
---@param members string @Which logistic members to remove from. Must be   "storage", "passive-provider", "buffer", or "active-provider". If not specified, removes   from the network in the usual order
---@return uint @
function LuaLogisticNetwork.remove_item(item, members) end

---Insert items into the logistic network. This will actually insert the items into some logistic chests.
---@param item ItemStackSpecification @What to insert
---@param members string @Which logistic members to insert the items to. Must be   "storage", "storage-empty" (storage chests that are completely empty),   "storage-empty-slot" (storage chests that have an empty slot), or "requester". If not   specified, inserts items into the logistic network in the usual order
---@return uint @
function LuaLogisticNetwork.insert(item, members) end

---Find logistic cell closest to a given position.
---@param position Position @
---@return LuaLogisticCell @
function LuaLogisticNetwork.find_cell_closest_to(position) end

---@class LuaLogisticPoint The LuaEntity owner of this LuaLogisticPoint.
---@field owner LuaEntity @ [Read-only] The LuaEntity owner of this LuaLogisticPoint.
---@field logistic_network LuaLogisticNetwork @ [Read-only] 
---@field logistic_member_index uint @ [Read-only] The Logistic member index of this logistic point.
---@field filters LogisticFilter[] @ [Read-only] The logistic filters for this logistic point or nil if this doesn't use logistic filters.
---@field mode defines.logistic_mode @ [Read-only] The logistic mode.
---@field force LuaForce @ [Read-only] The force of this logistic point.
---@field targeted_items_pickup table<string, uint> @ [Read-only] Items targeted to be picked up from this logistic point by robots.
---@field targeted_items_deliver table<string, uint> @ [Read-only] Items targeted to be dropped off into this logistic point by robots.
---@field exact boolean @ [Read-only] If this logistic point is using the exact mode. In exact mode robots never over-deliver requests.

---@class LuaModSettingPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field mod string @ [Read-only] The mod that owns this setting.
---@field setting_type string @ [Read-only] 
---@field default_value boolean | double | int | string @ [Read-only] The default value of this setting.
---@field minimum_value double | int @ [Read-only] The minimum value for this setting or nil if  this setting type doesn't support a minimum.
---@field maximum_value double | int @ [Read-only] The maximum value for this setting or nil if  this setting type doesn't support a maximum.
---@field allowed_values string[] | string | int[] | int | double[] | double @ [Read-only] The allowed values for this setting or nil if this setting doesn't use the a fixed set of values.
---@field allow_blank boolean @ [Read-only] If this string setting allows blank values or nil if not a string setting.
---@field auto_trim boolean @ [Read-only] If this string setting auto-trims values or nil if not a string setting.
---@field hidden boolean @ [Read-only] If this setting is hidden from the GUI.

---@class LuaModuleCategoryPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 

---@class LuaNamedNoiseExpression 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field intended_property string @ [Read-only] 
---@field expression NoiseExpression @ [Read-only] 

---@class LuaNoiseLayerPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 

---@class LuaParticlePrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field regular_trigger_effect TriggerEffectItem @ [Read-only] 
---@field ended_in_water_trigger_effect TriggerEffectItem @ [Read-only] 
---@field render_layer RenderLayer @ [Read-only] 
---@field render_layer_when_on_ground RenderLayer @ [Read-only] 
---@field life_time uint @ [Read-only] 
---@field regular_trigger_effect_frequency uint @ [Read-only] 
---@field movement_modifier_when_on_ground float @ [Read-only] 
---@field movement_modifier float @ [Read-only] 
---@field mining_particle_frame_speed float @ [Read-only] 

---@class LuaPermissionGroup Adds the given player to this group.
---@field name string @ [Read-Write] The name of this group.
---@field players LuaPlayer[] @ [Read-only] The players in this group.
---@field group_id uint @ [Read-only] The group ID

---Adds the given player to this group.
---@param player PlayerSpecification @
---@return boolean @
function LuaPermissionGroup.add_player(player) end

---Removes the given player from this group.
---@param player PlayerSpecification @
---@return boolean @
function LuaPermissionGroup.remove_player(player) end

---If this group allows the given action.
---@param action action @The defines.input_action value
---@return boolean @
function LuaPermissionGroup.allows_action(action) end

---Sets if the player is allowed to perform the given action.
---@param action action @The defines.input_action value
---@return boolean @
function LuaPermissionGroup.set_allows_action(action) end

---Destroys this group.
---@return boolean @
function LuaPermissionGroup.destroy() end

---@class LuaPermissionGroups Creates a new permission group.
---@field groups LuaPermissionGroup[] @ [Read-only] All of the permission groups.

---Creates a new permission group.
---@param name string @
---@return LuaPermissionGroup @
function LuaPermissionGroups.create_group(name) end

---Gets the permission group with the given name or group ID or nil if there is no matching group.
---@param group string | uint @
---@return LuaPermissionGroup @
function LuaPermissionGroups.get_group(group) end

---@class LuaPlayer : LuaControl Setup the screen to be shown when the game is finished.
---@field set_controller nil @(optional) undefined Set the controller type of the player.
---@field remove_alert nil @(optional) undefined Removes all alerts matching the given filters or if an empty filters table is given all alerts are removed.
---@field get_alerts dictionary uint → dictionary defines.alert_type → array of alert @(optional) undefined Gets all alerts matching the given filters or if no filters are given all alerts are returned.
---@field can_place_entity boolean @(optional) undefined Checks if this player can build the give entity at the given location on the surface the player is on.
---@field can_build_from_cursor boolean @(optional) undefined Checks if this player can build what ever is in the cursor on the surface the player is on.
---@field build_from_cursor nil @(optional) undefined Builds what ever is in the cursor on the surface the player is on.
---@field play_sound boolean @(optional) undefined Plays a sound for this player
---@field create_local_flying_text nil @(optional) undefined Spawn a flying text that is only visible to this player.
---@field connect_to_server nil @(optional) undefined Asks the player if they would like to connect to the given server.
---@field character LuaEntity @ [Read-Write] 
---@field index uint @ [Read-only] 
---@field gui LuaGui @ [Read-only] 
---@field opened_self boolean @ [Read-only] 
---@field controller_type defines.controllers @ [Read-only] 
---@field stashed_controller_type defines.controllers @ [Read-only] The stashed controller type or nil if no controller is stashed.
---@field game_view_settings GameViewSettings @ [Read-Write] 
---@field minimap_enabled boolean @ [Read-Write] 
---@field color Color @ [Read-Write] 
---@field chat_color Color @ [Read-Write] 
---@field name string @ [Read-only] 
---@field tag string @ [Read-Write] 
---@field connected boolean @ [Read-only] 
---@field admin boolean @ [Read-Write] 
---@field entity_copy_source LuaEntity @ [Read-only] The source entity used during entity settings copy-paste if any.
---@field afk_time uint @ [Read-only] How many ticks since the last action of this player
---@field online_time uint @ [Read-only] How many ticks did this player spend playing this save (all sessions combined)
---@field last_online uint @ [Read-only] At what tick this player was last online.
---@field permission_group LuaPermissionGroup @ [Read-Write] The permission group this player is part of or nil if not part of any group.
---@field mod_settings CustomDictionary @ [Read-only] 
---@field ticks_to_respawn uint @ [Read-Write] The number of ticks until this player will respawn or nil if not waiting to respawn.
---@field display_resolution DisplayResolution @ [Read-only] The display resolution for this player.
---@field display_scale double @ [Read-only] The display scale for this player.
---@field blueprint_to_setup LuaItemStack @ [Read-only] The item stack containing a blueprint to be setup.
---@field render_mode defines.render_mode @ [Read-only] The render mode of the player, like map or zoom to world. The render mode can be set using LuaPlayer::open_map, LuaPlayer::zoom_to_world and LuaPlayer::close_map.
---@field spectator boolean @ [Read-Write] 
---@field remove_unfiltered_items boolean @ [Read-Write] If items not included in this map editor infinity inventory filters should be removed.
---@field infinity_inventory_filters InfinityInventoryFilter[] @ [Read-Write] The filters for this map editor infinity inventory settings.
---@field zoom double @ [Write-only] 
---@field map_view_settings MapViewSettings @ [Write-only] The player's map view settings. To write to this, use a table containing the fields that should be changed.

---Setup the screen to be shown when the game is finished.
---@param message LocalisedString @Message to be shown
---@param file string @Path to image to be shown
function LuaPlayer.set_ending_screen_data(message, file) end

---Print text to the chat console.
---@param message LocalisedString @
---@param color Color @
function LuaPlayer.print(message, color) end

---Clear the chat console.
function LuaPlayer.clear_console() end

---Get the current goal description, as a localised string.
---@return LocalisedString @
function LuaPlayer.get_goal_description() end

---Set the text in the goal window (top left).
---@param text LocalisedString @The text to display. \n can be used to delimit lines. Passing empty   string or omitting this parameter entirely will make the goal window disappear
---@param only_update boolean @When true, won't play the "goal updated" sound
function LuaPlayer.set_goal_description(text, only_update) end

---Disable recipe groups.
function LuaPlayer.disable_recipe_groups() end

---Enable recipe groups.
function LuaPlayer.enable_recipe_groups() end

---Disable recipe subgroups.
function LuaPlayer.disable_recipe_subgroups() end

---Enable recipe subgroups.
function LuaPlayer.enable_recipe_subgroups() end

---Print entity statistics to the player's console.
---@param entities string[] @Entity prototypes to get statistics for. If not specified or empty,   display statistics for all entities
function LuaPlayer.print_entity_statistics(entities) end

---Print construction robot job counts to the players console.
function LuaPlayer.print_robot_jobs() end

---Print LuaObject counts per mod.
function LuaPlayer.print_lua_object_statistics() end

---Logs a dictionary of chunks -> active entities for the surface this player is on.
function LuaPlayer.log_active_entity_chunk_counts() end

---Logs a dictionary of active entities -> count for the surface this player is on.
function LuaPlayer.log_active_entity_counts() end

---Unlock the achievements of the given player. This has any effect only when this is the local player, the achievement isn't unlocked so far and the achievement is of the type "achievement".
---@param name string @name of the achievement to unloc
function LuaPlayer.unlock_achievement(name) end

---Invokes the "clean cursor" action on the player as if the user pressed it.
---@return boolean @
function LuaPlayer.clean_cursor() end

---Creates and attaches a character entity to this player.
---@param character string @The character to create else the default is used
---@return boolean @
function LuaPlayer.create_character(character) end

---Adds an alert to this player for the given entity of the given alert type.
---@param entity LuaEntity @
---@param type defines.alert_type @
function LuaPlayer.add_alert(entity, type) end

---Adds a custom alert to this player.
---@param entity LuaEntity @If the alert is clicked, the map will open at the position of this entity
---@param icon SignalID @
---@param message LocalisedString @
---@param show_on_map boolean @
function LuaPlayer.add_custom_alert(entity, icon, message, show_on_map) end

---Mutes alerts for the given alert category.
---@param alert_type defines.alert_type @
---@return boolean @
function LuaPlayer.mute_alert(alert_type) end

---Unmutes alerts for the given alert category.
---@param alert_type defines.alert_type @
---@return boolean @
function LuaPlayer.unmute_alert(alert_type) end

---If the given alert type is currently muted.
---@param alert_type defines.alert_type @
---@return boolean @
function LuaPlayer.is_alert_muted(alert_type) end

---Enables alerts for the given alert category.
---@param alert_type defines.alert_type @
---@return boolean @
function LuaPlayer.enable_alert(alert_type) end

---Disables alerts for the given alert category.
---@param alert_type defines.alert_type @
---@return boolean @
function LuaPlayer.disable_alert(alert_type) end

---If the given alert type is currently enabled.
---@param alert_type defines.alert_type @
---@return boolean @
function LuaPlayer.is_alert_enabled(alert_type) end

---Invokes the "smart pipette" action on the player as if the user pressed it.
---@param entity string | LuaEntity | LuaEntityPrototype @
---@return boolean @
function LuaPlayer.pipette_entity(entity) end

---Uses the current item in the cursor if it's a capsule or does nothing if not.
---@param position Position @Where the item would be used
function LuaPlayer.use_from_cursor(position) end

---
---@return array of LuaEntity @
function LuaPlayer.get_associated_characters() end

---Associates a character with this player.
---@param character LuaEntity @The character entity
function LuaPlayer.associate_character(character) end

---Disassociates a character from this player. This is functionally the same as setting LuaEntity::associated_player to nil.
---@param character LuaEntity @The character entit
function LuaPlayer.disassociate_character(character) end

---Gets the quick bar filter for the given slot or nil.
---@param index uint @The slot index. 1 for the first slot of page one, 2 for slot two of page one, 11 for the first slot of page 2, etc
---@return LuaItemPrototype @
function LuaPlayer.get_quick_bar_slot(index) end

---Sets the quick bar filter for the given slot.
---@param index uint @The slot index. 1 for the first slot of page one, 2 for slot two of page one, 11 for the first slot of page 2, etc
---@param filter string | LuaItemPrototype | LuaItemStack @The filter or nil
function LuaPlayer.set_quick_bar_slot(index, filter) end

---Gets which quick bar page is being used for the given screen page or nil if not known.
---@param index uint @The screen page. Index 1 is the top row in the gui. Index can go beyond the visible number of bars on the screen to account for the interface config setting change
---@return uint8 @
function LuaPlayer.get_active_quick_bar_page(index) end

---Sets which quick bar page is being used for the given screen page.
---@param screen_index uint @The screen page. Index 1 is the top row in the gui. Index can go beyond the visible number of bars on the screen to account for the interface config setting change
---@param page_index uint @The new quick bar page
function LuaPlayer.set_active_quick_bar_page(screen_index, page_index) end

---Jump to the specified cutscene waypoint. Only works when the player is viewing a cutscene.
---@param waypoint_index uint @
function LuaPlayer.jump_to_cutscene_waypoint(waypoint_index) end

---Exit the current cutscene. Errors if not in a cutscene.
function LuaPlayer.exit_cutscene() end

---Queues a request to open the map at the specified position. If the map is already opened, the request will simply set the position (and scale). Render mode change requests are processed before rendering of the next frame.
---@param position Position @
---@param scale double @
function LuaPlayer.open_map(position, scale) end

---Queues a request to zoom to world at the specified position. If the player is already zooming to world, the request will simply set the position (and scale). Render mode change requests are processed before rendering of the next frame.
---@param position Position @
---@param scale double @
function LuaPlayer.zoom_to_world(position, scale) end

---Queues request to switch to the normal game view from the map or zoom to world view. Render mode change requests are processed before rendering of the next frame.
function LuaPlayer.close_map() end

---Is a custom shortcut currently toggled?
---@param prototype_name string @Prototype name of the custom shortcut
---@return boolean @
function LuaPlayer.is_shortcut_toggled(prototype_name) end

---Is a custom shortcut currently available?
---@param prototype_name string @Prototype name of the custom shortcut
---@return boolean @
function LuaPlayer.is_shortcut_available(prototype_name) end

---Toggle or untoggle a custom shortcut
---@param prototype_name string @Prototype name of the custom shortcut
---@param toggled boolean @
function LuaPlayer.set_shortcut_toggled(prototype_name, toggled) end

---Make a custom shortcut available or unavailable.
---@param prototype_name string @Prototype name of the custom shortcut
---@param available boolean @
function LuaPlayer.set_shortcut_available(prototype_name, available) end

---Toggles this player into or out of the map editor. Does nothing if this player isn't an admin or if the player doesn't have permission to use the map editor.
function LuaPlayer.toggle_map_editor() end

---Requests a translation for the given localised string. If the request is successful the on_string_translated event will be fired at a later time with the results.
---@param localised_string LocalisedString @
---@return boolean @
function LuaPlayer.request_translation(localised_string) end

---Gets the filter for this map editor infinity filters at the given index or nil if the filter index doesn't exist or is empty.
---@param index uint @The index to get
---@return InfinityInventoryFilter @
function LuaPlayer.get_infinity_inventory_filter(index) end

---Sets the filter for this map editor infinity filters at the given index.
---@param index uint @The index to set
---@param filter InfinityInventoryFilter @The new filter or nil to clear the filter
function LuaPlayer.set_infinity_inventory_filter(index, filter) end

---@class LuaProfiler Resets the clock, also restarting it.

---Resets the clock, also restarting it.
function LuaProfiler.reset() end

---Stops the clock.
function LuaProfiler.stop() end

---Start the clock again, without resetting it.
function LuaProfiler.restart() end

---Add the duration of another timer to this timer. Useful to reduce start/stop overhead when accumulating time onto many timers at once.
---@param other LuaProfiler @The timer to add to this timer
function LuaProfiler.add(other) end

---Divides the current duration by a set value. Useful for calculating the average of many iterations.
---@param number double @The number to divide by. Must be > 0
function LuaProfiler.divide(number) end

---@class LuaRCON Print text to the calling RCON interface if any.
---@field object_name string @ [Read-only] This objects name.

---Print text to the calling RCON interface if any.
---@param message LocalisedString @
function LuaRCON.print(message) end

---@class LuaRailPath The total number of rails in this path.
---@field size uint @ [Read-only] The total number of rails in this path.
---@field current uint @ [Read-only] The current rail index.
---@field total_distance double @ [Read-only] The total path distance.
---@field travelled_distance double @ [Read-only] The total distance travelled.
---@field rails CustomDictionary @ [Read-only] The rails this path travels.

---@class LuaRandomGenerator Generates a random number. If no parameters are given a number in the [0, 1) range is returned. If a single parameter is given a floored number in the [1, N] range is returned. If 2 parameters are given a floored number in the [N1, N2] range is returned.

---Generates a random number. If no parameters are given a number in the [0, 1) range is returned. If a single parameter is given a floored number in the [1, N] range is returned. If 2 parameters are given a floored number in the [N1, N2] range is returned.
---@param lower int @Inclusive lower bound on the resul
---@param upper int @Inclusive upper bound on the resul
---@return double @
function LuaRandomGenerator.operator__call(lower, upper) end

---Re-seeds the random generator with the given value.
---@param seed uint @
function LuaRandomGenerator.re_seed(seed) end

---@class LuaRecipe Reload the recipe from the prototype.
---@field name string @ [Read-only] Name of the recipe. This can be different than the name of the result items as there could be more recipes to make the same item.
---@field localised_name LocalisedString @ [Read-only] Localised name of the recipe.
---@field localised_description LocalisedString @ [Read-only] 
---@field prototype LuaRecipePrototype @ [Read-only] The prototype for this recipe.
---@field enabled boolean @ [Read-Write] Can the recipe be used?
---@field category string @ [Read-only] Category of the recipe.
---@field ingredients Ingredient[] @ [Read-only] Ingredients for this recipe.
---@field products Product[] @ [Read-only] 
---@field hidden boolean @ [Read-only] Is the recipe hidden? Hidden recipe don't show up in the crafting menu.
---@field hidden_from_flow_stats boolean @ [Read-Write] Is the recipe hidden from flow statistics?
---@field energy double @ [Read-only] Energy required to execute this recipe. This directly affects the crafting time: Recipe's energy is exactly its crafting time in seconds, when crafted in an assembling machine with crafting speed exactly equal to one.
---@field order string @ [Read-only] Order string. This is used to sort the crafting menu.
---@field group LuaGroup @ [Read-only] Group of this recipe.
---@field subgroup LuaGroup @ [Read-only] Subgroup of this recipe.
---@field force LuaForce @ [Read-only] The force that owns this recipe.

---Reload the recipe from the prototype.
function LuaRecipe.reload() end

---@class LuaRecipeCategoryPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 

---@class LuaRecipePrototype If this recipe prototype is enabled by default (enabled at the beginning of a game).
---@field enabled boolean @ [Read-only] If this recipe prototype is enabled by default (enabled at the beginning of a game).
---@field name string @ [Read-only] Name of the recipe. This can be different than the name of the result items as there could be more recipes to make the same item.
---@field localised_name LocalisedString @ [Read-only] Localised name of the recipe.
---@field localised_description LocalisedString @ [Read-only] 
---@field category string @ [Read-only] Category of the recipe.
---@field ingredients Ingredient[] @ [Read-only] Ingredients for this recipe.
---@field products Product[] @ [Read-only] 
---@field main_product Product @ [Read-only] 
---@field hidden boolean @ [Read-only] Is the recipe hidden? Hidden recipe don't show up in the crafting menu.
---@field hidden_from_flow_stats boolean @ [Read-only] Is the recipe hidden from flow statistics (item/fluid production statistics)?
---@field hidden_from_player_crafting boolean @ [Read-only] Is the recipe hidden from player crafting? The recipe will still show up for selection in machines.
---@field always_show_made_in boolean @ [Read-only] Should this recipe always show "Made in" in the tooltip?
---@field energy double @ [Read-only] Energy required to execute this recipe. This directly affects the crafting time: Recipe's energy is exactly its crafting time in seconds, when crafted in an assembling machine with crafting speed exactly equal to one.
---@field order string @ [Read-only] Order string. This is used to sort the crafting menu.
---@field group LuaGroup @ [Read-only] Group of this recipe.
---@field subgroup LuaGroup @ [Read-only] Subgroup of this recipe.
---@field request_paste_multiplier uint @ [Read-only] The multiplier used when this recipe is copied from an assembling machine to a requester chest. For each item in the recipe the item count * this value is set in the requester chest.
---@field overload_multiplier uint @ [Read-only] Used to determine how many extra items are put into an assembling machine before it's considered "full enough".
---@field allow_as_intermediate boolean @ [Read-only] If this recipe is enabled for the purpose of intermediate hand-crafting.
---@field allow_intermediates boolean @ [Read-only] If this recipe is allowed to use intermediate recipes when hand-crafting.
---@field show_amount_in_title boolean @ [Read-only] If the amount is shown in the recipe tooltip title when the recipe produces more than 1 product.
---@field always_show_products boolean @ [Read-only] If the products are always shown in the recipe tooltip.
---@field emissions_multiplier double @ [Read-only] The emissions multiplier for this recipe.
---@field allow_decomposition boolean @ [Read-only] Is this recipe allowed to be broken down for the recipe tooltip "Total raw" calculations?

---@class LuaRemote Add a remote interface.
---@field object_name string @ [Read-only] This objects name.
---@field interfaces table<string, string> @ [Read-only] 

---Add a remote interface.
---@param name string @Name of the interface
---@param funcs table<string, function> @List of functions that are members of the new interface
function LuaRemote.add_interface(name, funcs) end

---Removes an interface with the given name.
---@param name string @Name of the interface
---@return boolean @
function LuaRemote.remove_interface(name) end

---Call a function of an interface.
---@param interface string @Interface to look up function in
---@param func string @Function name that belongs to interface
---@param ... ... @Arguments to pass to the called function
---@return Anything @
function LuaRemote.call(interface, func, ...) end

---@class LuaRendering Create a line.
---@field draw_line uint64 @(optional) undefined Create a line.
---@field draw_text uint64 @(optional) undefined Create a text.
---@field draw_circle uint64 @(optional) undefined Create a circle.
---@field draw_rectangle uint64 @(optional) undefined Create a rectangle.
---@field draw_arc uint64 @(optional) undefined Create an arc.
---@field draw_polygon uint64 @(optional) undefined Create a polygon.
---@field draw_sprite uint64 @(optional) undefined Create a sprite.
---@field draw_light uint64 @(optional) undefined Create a light.
---@field draw_animation uint64 @(optional) undefined Create an animation.
---@field object_name string @ [Read-only] This objects name.

---Destroy the object with the given id.
---@param id uint64 @
function LuaRendering.destroy(id) end

---Does a font with this name exist?
---@param font_name string @
---@return boolean @
function LuaRendering.is_font_valid(font_name) end

---Does a valid object with this id exist?
---@param id uint64 @
---@return boolean @
function LuaRendering.is_valid(id) end

---Gets an array of all valid object ids.
---@param mod_name string @If provided, get only the render objects created by this mod
---@return array of uint64 @
function LuaRendering.get_all_ids(mod_name) end

---Destroys all render objects.
---@param mod_name string @If provided, only the render objects created by this mod are destroyed
function LuaRendering.clear(mod_name) end

---Gets the type of the given object. The types are "text", "line", "circle", "rectangle", "arc", "polygon", "sprite", "light" and "animation".
---@param id uint64 @
---@return string @
function LuaRendering.get_type(id) end

---Reorder this object so that it is drawn in front of the already existing objects.
---@param id uint64 @
function LuaRendering.bring_to_front(id) end

---The surface the object with this id is rendered on.
---@param id uint64 @
---@return LuaSurface @
function LuaRendering.get_surface(id) end

---Get the time to live of the object with this id. This will be 0 if the object does not expire.
---@param id uint64 @
---@return uint @
function LuaRendering.get_time_to_live(id) end

---Set the time to live of the object with this id. Set to 0 if the object should not expire.
---@param id uint64 @
---@param time_to_live uint @
function LuaRendering.set_time_to_live(id, time_to_live) end

---Get the forces that the object with this id is rendered to or nil if visible to all forces.
---@param id uint64 @
---@return array of LuaForce @
function LuaRendering.get_forces(id) end

---Set the forces that the object with this id is rendered to.
---@param id uint64 @
---@param forces ForceSpecification[] @Providing an empty array will set the object to be visible to all forces
function LuaRendering.set_forces(id, forces) end

---Get the players that the object with this id is rendered to or nil if visible to all players.
---@param id uint64 @
---@return array of LuaPlayer @
function LuaRendering.get_players(id) end

---Set the players that the object with this id is rendered to.
---@param id uint64 @
---@param players PlayerSpecification[] @Providing an empty array will set the object to be visible to all players
function LuaRendering.set_players(id, players) end

---Get whether this is rendered to anyone at all.
---@param id uint64 @
---@return boolean @
function LuaRendering.get_visible(id) end

---Set whether this is rendered to anyone at all.
---@param id uint64 @
---@param visible boolean @
function LuaRendering.set_visible(id, visible) end

---Get whether this is being drawn on the ground, under most entities and sprites.
---@param id uint64 @
---@return boolean @
function LuaRendering.get_draw_on_ground(id) end

---Set whether this is being drawn on the ground, under most entities and sprites.
---@param id uint64 @
---@param draw_on_ground boolean @
function LuaRendering.set_draw_on_ground(id, draw_on_ground) end

---Get whether this is only rendered in alt-mode.
---@param id uint64 @
---@return boolean @
function LuaRendering.get_only_in_alt_mode(id) end

---Set whether this is only rendered in alt-mode.
---@param id uint64 @
---@param only_in_alt_mode boolean @
function LuaRendering.set_only_in_alt_mode(id, only_in_alt_mode) end

---Get the color or tint of the object with this id.
---@param id uint64 @
---@return Color @
function LuaRendering.get_color(id) end

---Set the color or tint of the object with this id. Does nothing if this object does not support color.
---@param id uint64 @
---@param color Color @
function LuaRendering.set_color(id, color) end

---Get the width of the object with this id. Value is in pixels (32 per tile).
---@param id uint64 @
---@return float @
function LuaRendering.get_width(id) end

---Set the width of the object with this id. Does nothing if this object does not support width. Value is in pixels (32 per tile).
---@param id uint64 @
---@param width float @
function LuaRendering.set_width(id, width) end

---Get from where the line with this id is drawn or nil if this object is not a line.
---@param id uint64 @
---@return ScriptRenderTarget @
function LuaRendering.get_from(id) end

---Set from where the line with this id is drawn. Does nothing if the object is not a line.
---@param id uint64 @
---@param from Position | LuaEntity @
---@param from_offset Vector @
function LuaRendering.set_from(id, from, from_offset) end

---Get where the line with this id is drawn to or nil if the object is not a line.
---@param id uint64 @
---@return ScriptRenderTarget @
function LuaRendering.get_to(id) end

---Set where the line with this id is drawn to. Does nothing if this object is not a line.
---@param id uint64 @
---@param to Position | LuaEntity @
---@param to_offset Vector @
function LuaRendering.set_to(id, to, to_offset) end

---Get the dash length of the line with this id or nil if the object is not a line.
---@param id uint64 @
---@return double @
function LuaRendering.get_dash_length(id) end

---Set the dash length of the line with this id. Does nothing if this object is not a line.
---@param id uint64 @
---@param dash_length double @
function LuaRendering.set_dash_length(id, dash_length) end

---Get the length of the gaps in the line with this id or nil if the object is not a line.
---@param id uint64 @
---@return double @
function LuaRendering.get_gap_length(id) end

---Set the length of the gaps in the line with this id. Does nothing if this object is not a line.
---@param id uint64 @
---@param gap_length double @
function LuaRendering.set_gap_length(id, gap_length) end

---Set the length of the dashes and the length of the gaps in the line with this id. Does nothing if this object is not a line.
---@param id uint64 @
---@param dash_length double @
---@param gap_length double @
function LuaRendering.set_dashes(id, dash_length, gap_length) end

---Get where the object with this id is drawn or nil if the object does not support target.
---@param id uint64 @
---@return ScriptRenderTarget @
function LuaRendering.get_target(id) end

---Set where the object with this id is drawn. Does nothing if this object does not support target.
---@param id uint64 @
---@param target Position | LuaEntity @
---@param target_offset Vector @
function LuaRendering.set_target(id, target, target_offset) end

---Get the orientation of the object with this id or nil if the object is not a text, polygon, sprite, light or animation.
---@param id uint64 @
---@return float @
function LuaRendering.get_orientation(id) end

---Set the orientation of the object with this id. Does nothing if this object is not a text, polygon, sprite, light or animation.
---@param id uint64 @
---@param orientation float @
function LuaRendering.set_orientation(id, orientation) end

---Get the scale of the text or light with this id or nil if the object is not a text or light.
---@param id uint64 @
---@return double @
function LuaRendering.get_scale(id) end

---Set the scale of the text or light with this id. Does nothing if this object is not a text or light.
---@param id uint64 @
---@param scale double @
function LuaRendering.set_scale(id, scale) end

---Get the text that is displayed by the text with this id or nil if the object is not a text.
---@param id uint64 @
---@return LocalisedString @
function LuaRendering.get_text(id) end

---Set the text that is displayed by the text with this id. Does nothing if this object is not a text.
---@param id uint64 @
---@param text LocalisedString @
function LuaRendering.set_text(id, text) end

---Get the font of the text with this id or nil if the object is not a text.
---@param id uint64 @
---@return string @
function LuaRendering.get_font(id) end

---Set the font of the text with this id. Does nothing if this object is not a text.
---@param id uint64 @
---@param font string @
function LuaRendering.set_font(id, font) end

---Get the alignment  of the text with this id or nil if the object is not a text.
---@param id uint64 @
---@return string @
function LuaRendering.get_alignment(id) end

---Set the alignment of the text with this id. Does nothing if this object is not a text.
---@param id uint64 @
---@param alignment string @"left", "right" or "center"
function LuaRendering.set_alignment(id, alignment) end

---Get if the text with this id scales with player zoom or nil if the object is not a text.
---@param id uint64 @
---@return boolean @
function LuaRendering.get_scale_with_zoom(id) end

---Set if the text with this id scales with player zoom, resulting in it always being the same size on screen, and the size compared to the game world changes. Does nothing if this object is not a text.
---@param id uint64 @
---@param scale_with_zoom boolean @
function LuaRendering.set_scale_with_zoom(id, scale_with_zoom) end

---Get if the circle or rectangle with this id is filled or nil if the object is not a circle or rectangle.
---@param id uint64 @
---@return boolean @
function LuaRendering.get_filled(id) end

---Set if the circle or rectangle with this id is filled. Does nothing if this object is not a circle or rectangle.
---@param id uint64 @
---@param filled boolean @
function LuaRendering.set_filled(id, filled) end

---Get the radius of the circle with this id or nil if the object is not a circle.
---@param id uint64 @
---@return double @
function LuaRendering.get_radius(id) end

---Set the radius of the circle with this id. Does nothing if this object is not a circle.
---@param id uint64 @
---@param radius double @
function LuaRendering.set_radius(id, radius) end

---Get where top left corner of the rectangle with this id is drawn or nil if the object is not a rectangle.
---@param id uint64 @
---@return ScriptRenderTarget @
function LuaRendering.get_left_top(id) end

---Set where top left corner of the rectangle with this id is drawn. Does nothing if this object is not a rectangle.
---@param id uint64 @
---@param left_top Position | LuaEntity @
---@param left_top_offset Vector @
function LuaRendering.set_left_top(id, left_top, left_top_offset) end

---Get where bottom right corner of the rectangle with this id is drawn or nil if the object is not a rectangle.
---@param id uint64 @
---@return ScriptRenderTarget @
function LuaRendering.get_right_bottom(id) end

---Set where top bottom right of the rectangle with this id is drawn. Does nothing if this object is not a rectangle.
---@param id uint64 @
---@param right_bottom Position | LuaEntity @
---@param right_bottom_offset Vector @
function LuaRendering.set_right_bottom(id, right_bottom, right_bottom_offset) end

---Set the corners of the rectangle with this id. Does nothing if this object is not a rectangle.
---@param id uint64 @
---@param left_top Position | LuaEntity @
---@param left_top_offset Vector @
---@param right_bottom Position | LuaEntity @
---@param right_bottom_offset Vector @
function LuaRendering.set_corners(id, left_top, left_top_offset, right_bottom, right_bottom_offset) end

---Get the radius of the outer edge of the arc with this id or nil if the object is not a arc.
---@param id uint64 @
---@return double @
function LuaRendering.get_max_radius(id) end

---Set the radius of the outer edge of the arc with this id. Does nothing if this object is not a arc.
---@param id uint64 @
---@param max_radius double @
function LuaRendering.set_max_radius(id, max_radius) end

---Get the radius of the inner edge of the arc with this id or nil if the object is not a arc.
---@param id uint64 @
---@return double @
function LuaRendering.get_min_radius(id) end

---Set the radius of the inner edge of the arc with this id. Does nothing if this object is not a arc.
---@param id uint64 @
---@param min_radius double @
function LuaRendering.set_min_radius(id, min_radius) end

---Get where the arc with this id starts or nil if the object is not a arc.
---@param id uint64 @
---@return float @
function LuaRendering.get_start_angle(id) end

---Set where the arc with this id starts. Does nothing if this object is not a arc.
---@param id uint64 @
---@param start_angle float @angle in radia
function LuaRendering.set_start_angle(id, start_angle) end

---Get the angle of the arc with this id or nil if the object is not a arc.
---@param id uint64 @
---@return float @
function LuaRendering.get_angle(id) end

---Set the angle of the arc with this id. Does nothing if this object is not a arc.
---@param id uint64 @
---@param angle float @angle in radia
function LuaRendering.set_angle(id, angle) end

---Get the vertices of the polygon with this id or nil if the object is not a polygon.
---@param id uint64 @
---@return array of ScriptRenderTarget @
function LuaRendering.get_vertices(id) end

---Set the vertices of the polygon with this id. Does nothing if this object is not a polygon.
---@param id uint64 @
---@param vertices ScriptRenderTarget[] @
function LuaRendering.set_vertices(id, vertices) end

---Get the sprite of the sprite or light with this id or nil if the object is not a sprite or light.
---@param id uint64 @
---@return SpritePath @
function LuaRendering.get_sprite(id) end

---Set the sprite of the sprite or light with this id. Does nothing if this object is not a sprite or light.
---@param id uint64 @
---@param sprite SpritePath @
function LuaRendering.set_sprite(id, sprite) end

---Get the horizontal scale of the sprite or animation with this id or nil if the object is not a sprite or animation.
---@param id uint64 @
---@return double @
function LuaRendering.get_x_scale(id) end

---Set the horizontal scale of the sprite or animation with this id. Does nothing if this object is not a sprite or animation.
---@param id uint64 @
---@param x_scale double @
function LuaRendering.set_x_scale(id, x_scale) end

---Get the vertical scale of the sprite or animation with this id or nil if the object is not a sprite or animation.
---@param id uint64 @
---@return double @
function LuaRendering.get_y_scale(id) end

---Set the vertical scale of the sprite or animation with this id. Does nothing if this object is not a sprite or animation.
---@param id uint64 @
---@param y_scale double @
function LuaRendering.set_y_scale(id, y_scale) end

---Get the render layer of the sprite or animation with this id or nil if the object is not a sprite or animation.
---@param id uint64 @
---@return RenderLayer @
function LuaRendering.get_render_layer(id) end

---Set the render layer of the sprite or animation with this id. Does nothing if this object is not a sprite or animation.
---@param id uint64 @
---@param r_ender_layer RenderLayer @
function LuaRendering.set_render_layer(id, r_ender_layer) end

---The object rotates so that it faces this target. Note that orientation is still applied to the object. Get the orientation_target of the object with this id or nil if no target or if this object is not a polygon, sprite, or animation.
---@param id uint64 @
---@return ScriptRenderTarget @
function LuaRendering.get_orientation_target(id) end

---The object rotates so that it faces this target. Note that orientation is still applied to the object. Set the orientation_target of the object with this id. Does nothing if this object is not a polygon, sprite, or animation. Set to nil if the object should not have an orientation_target.
---@param id uint64 @
---@param orientation_target Position | LuaEntity @
---@param orientation_target_offset Vector @
function LuaRendering.set_orientation_target(id, orientation_target, orientation_target_offset) end

---Offsets the center of the sprite or animation if orientation_target is given. This offset will rotate together with the sprite or animation. Get the oriented_offset of the sprite or animation with this id or nil if this object is not a sprite or animation.
---@param id uint64 @
---@return Vector @
function LuaRendering.get_oriented_offset(id) end

---Offsets the center of the sprite or animation if orientation_target is given. This offset will rotate together with the sprite or animation. Set the oriented_offset of the sprite or animation with this id. Does nothing if this object is not a sprite or animation.
---@param id uint64 @
---@param oriented_offset Vector @
function LuaRendering.set_oriented_offset(id, oriented_offset) end

---Get the intensity of the light with this id or nil if the object is not a light.
---@param id uint64 @
---@return float @
function LuaRendering.get_intensity(id) end

---Set the intensity of the light with this id. Does nothing if this object is not a light.
---@param id uint64 @
---@param intensity float @
function LuaRendering.set_intensity(id, intensity) end

---Get the minimum darkness at which the light with this id is rendered or nil if the object is not a light.
---@param id uint64 @
---@return float @
function LuaRendering.get_minimum_darkness(id) end

---Set the minimum darkness at which the light with this id is rendered. Does nothing if this object is not a light.
---@param id uint64 @
---@param minimum_darkness float @
function LuaRendering.set_minimum_darkness(id, minimum_darkness) end

---Get if the light with this id is rendered has the same orientation as the target entity or nil if the object is not a light. Note that orientation is still applied to the sprite.
---@param id uint64 @
---@return boolean @
function LuaRendering.get_oriented(id) end

---Set if the light with this id is rendered has the same orientation as the target entity. Does nothing if this object is not a light. Note that orientation is still applied to the sprite.
---@param id uint64 @
---@param oriented boolean @
function LuaRendering.set_oriented(id, oriented) end

---Get the animation prototype name of the animation with this id or nil if the object is not an animation.
---@param id uint64 @
---@return string @
function LuaRendering.get_animation(id) end

---Set the animation prototype name of the animation with this id. Does nothing if this object is not an animation.
---@param id uint64 @
---@param animation string @
function LuaRendering.set_animation(id, animation) end

---Get the animation speed of the animation with this id or nil if the object is not an animation.
---@param id uint64 @
---@return double @
function LuaRendering.get_animation_speed(id) end

---Set the animation speed of the animation with this id. Does nothing if this object is not an animation.
---@param id uint64 @
---@param animation_speed double @Animation speed in frames per tick
function LuaRendering.set_animation_speed(id, animation_speed) end

---Get the animation offset of the animation with this id or nil if the object is not an animation.
---@param id uint64 @
---@return double @
function LuaRendering.get_animation_offset(id) end

---Set the animation offset of the animation with this id. Does nothing if this object is not an animation.
---@param id uint64 @
---@param animation_offset double @Animation offset in frames
function LuaRendering.set_animation_offset(id, animation_offset) end

---@class LuaResourceCategoryPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 

---@class LuaSettings 
---@field object_name string @ [Read-only] This objects name.
---@field startup CustomDictionary @ [Read-only] 
---@field global CustomDictionary @ [Read-only] 
---@field player CustomDictionary @ [Read-only] 

---
---@param player LuaPlayer @
---@return CustomDictionary string → ModSetting @
function LuaSettings.get_player_settings(player) end

---@class LuaShortcutPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field action string @ [Read-only] 
---@field item_to_create LuaItemPrototype @ [Read-only] 
---@field technology_to_unlock LuaTechnologyPrototype @ [Read-only] 
---@field toggleable boolean @ [Read-only] 
---@field associated_control_input string @ [Read-only] 

---@class LuaStyle 
---@field gui LuaGui @ [Read-only] 
---@field name string @ [Read-only] 
---@field minimal_width int @ [Read-Write] Minimal width ensures, that the widget will never be smaller than than that size. It can't be squashed to be smaller.
---@field maximal_width int @ [Read-Write] Maximal width ensures, that the widget will never be bigger than than that size. It can't be stretched to be bigger.
---@field minimal_height int @ [Read-Write] Minimal height ensures, that the widget will never be smaller than than that size. It can't be squashed to be smaller.
---@field maximal_height int @ [Read-Write] Maximal height ensures, that the widget will never be bigger than than that size. It can't be stretched to be bigger.
---@field natural_width int @ [Read-Write] Natural width specifies the width of the element tries to have, but it can still be squashed/stretched to have a smaller or bigger size.
---@field natural_height int @ [Read-Write] Natural height specifies the height of the element tries to have, but it can still be squashed/stretched to have a smaller or bigger size.
---@field top_padding int @ [Read-Write] 
---@field right_padding int @ [Read-Write] 
---@field bottom_padding int @ [Read-Write] 
---@field left_padding int @ [Read-Write] 
---@field top_margin int @ [Read-Write] 
---@field right_margin int @ [Read-Write] 
---@field bottom_margin int @ [Read-Write] 
---@field left_margin int @ [Read-Write] 
---@field horizontal_align string @ [Read-Write] Horizontal align of the inner content of the widget, possible values are "left", "center" or "right"
---@field vertical_align string @ [Read-Write] Vertical align of the inner content of the widget, possible values are "top", "center" or "bottom"
---@field font_color Color @ [Read-Write] 
---@field font string @ [Read-Write] 
---@field top_cell_padding int @ [Read-Write] 
---@field right_cell_padding int @ [Read-Write] 
---@field bottom_cell_padding int @ [Read-Write] 
---@field left_cell_padding int @ [Read-Write] 
---@field horizontally_stretchable boolean @ [Read-Write] If the GUI element stretches its size horizontally to other elements.
---@field vertically_stretchable boolean @ [Read-Write] If the GUI element stretches its size vertically to other elements.
---@field horizontally_squashable boolean @ [Read-Write] If the GUI element can be squashed (by maximal width of some parent element) horizontally. This is mainly meant to be used for scroll-pane The default value is false.
---@field vertically_squashable boolean @ [Read-Write] If the GUI element can be squashed (by maximal height of some parent element) vertically. This is mainly meant to be used for scroll-pane The default (parent) value for scroll pane is true, false otherwise.
---@field rich_text_setting defines.rich_text_setting @ [Read-Write] How this GUI element handles rich text.
---@field hovered_font_color Color @ [Read-Write] 
---@field clicked_font_color Color @ [Read-Write] 
---@field disabled_font_color Color @ [Read-Write] 
---@field pie_progress_color Color @ [Read-Write] 
---@field clicked_vertical_offset int @ [Read-Write] 
---@field selected_font_color Color @ [Read-Write] 
---@field selected_hovered_font_color Color @ [Read-Write] 
---@field selected_clicked_font_color Color @ [Read-Write] 
---@field strikethrough_color Color @ [Read-Write] 
---@field horizontal_spacing int @ [Read-Write] 
---@field vertical_spacing int @ [Read-Write] 
---@field use_header_filler boolean @ [Read-Write] 
---@field color Color @ [Read-Write] 
---@field column_alignments CustomArray @ [Read-only] 
---@field single_line boolean @ [Read-Write] 
---@field extra_top_padding_when_activated int @ [Read-Write] 
---@field extra_bottom_padding_when_activated int @ [Read-Write] 
---@field extra_left_padding_when_activated int @ [Read-Write] 
---@field extra_right_padding_when_activated int @ [Read-Write] 
---@field extra_top_margin_when_activated int @ [Read-Write] 
---@field extra_bottom_margin_when_activated int @ [Read-Write] 
---@field extra_left_margin_when_activated int @ [Read-Write] 
---@field extra_right_margin_when_activated int @ [Read-Write] 
---@field stretch_image_to_widget_size boolean @ [Read-Write] 
---@field badge_font string @ [Read-Write] 
---@field badge_horizontal_spacing int @ [Read-Write] 
---@field default_badge_font_color Color @ [Read-Write] 
---@field selected_badge_font_color Color @ [Read-Write] 
---@field disabled_badge_font_color Color @ [Read-Write] 
---@field width int @ [Write-only] 
---@field height int @ [Write-only] 
---@field padding int | int[] | int @ [Write-only] 
---@field margin int | int[] | int @ [Write-only] 
---@field cell_padding int @ [Write-only] 

---@class LuaSurface Get the pollution for a given position.
---@field can_place_entity boolean @(optional) undefined Check for collisions with terrain or other entities.
---@field can_fast_replace boolean @(optional) undefined If there exists an entity at the given location that can be fast-replaced with the given entity parameters.
---@field find_entities_filtered array of LuaEntity @(optional) undefined Find entities of given type or name in a given area.
---@field find_tiles_filtered array of LuaTile @(optional) undefined Find tiles of a given name in a given area.
---@field count_entities_filtered uint @(optional) undefined Count entities of given type or name in a given area. Works just like LuaSurface::find_entities_filtered, except this only returns the count. As it doesn't construct all the wrapper objects, this is more efficient if one is only interested in the number of entities.
---@field count_tiles_filtered uint @(optional) undefined Count tiles of a given name in a given area. Works just like LuaSurface::find_tiles_filtered, except this only returns the count. As it doesn't construct all the wrapper objects, this is more efficient if one is only interested in the number of tiles.
---@field find_units array of LuaEntity @ undefined Find units (entities with type "unit") of a given force and force condition within a given area.
---@field find_nearest_enemy LuaEntity @(optional) undefined Find the enemy entity-with-force (military entity) closest to the given position.
---@field set_multi_command uint @(optional) undefined Give a command to multiple units. This will automatically select suitable units for the task.
---@field create_entity LuaEntity @(optional) undefined Create an entity on this surface.
---@field create_trivial_smoke nil @ undefined 
---@field create_particle nil @ undefined Creates a particle at the given location
---@field create_unit_group LuaUnitGroup @(optional) undefined Create a new unit group at a given position.
---@field deconstruct_area nil @(optional) undefined Place a deconstruction request.
---@field cancel_deconstruct_area nil @(optional) undefined Cancel a deconstruction order.
---@field upgrade_area nil @(optional) undefined Place an upgrade request.
---@field cancel_upgrade_area nil @(optional) undefined Cancel a upgrade order.
---@field destroy_decoratives nil @(optional) undefined Removes all decoratives from the given area.
---@field create_decoratives nil @(optional) undefined Adds the given decoratives to the surface.
---@field find_decoratives_filtered array of DecorativeResult @(optional) undefined Find decoratives of a given name in a given area.
---@field play_sound boolean @(optional) undefined Plays a sound on this surface.
---@field clone_area nil @(optional) undefined Clones the given area.
---@field clone_brush nil @(optional) undefined Clones the given area.
---@field clone_entities nil @(optional) undefined Clones the given entities.
---@field request_path uint @(optional) undefined Starts a path find request without actually ordering a unit to move. Result is ultimately returned asynchronously via defines.events.on_script_path_request_finished.
---@field name string @ [Read-Write] 
---@field index uint @ [Read-only] 
---@field map_gen_settings MapGenSettings @ [Read-Write] The generation settings for the surface.
---@field generate_with_lab_tiles boolean @ [Read-Write] When set to true, new chunks will be generated with lab tiles, instead of using the surface's map generation settings.
---@field always_day boolean @ [Read-Write] When set to true, the sun will always shine.
---@field daytime float @ [Read-Write] 
---@field darkness float @ [Read-only] 
---@field wind_speed float @ [Read-Write] 
---@field wind_orientation float @ [Read-Write] 
---@field wind_orientation_change float @ [Read-Write] 
---@field peaceful_mode boolean @ [Read-Write] 
---@field freeze_daytime boolean @ [Read-Write] True if daytime is currently frozen.
---@field ticks_per_day uint @ [Read-Write] The number of ticks per day for this surface.
---@field dusk double @ [Read-Write] The daytime when dusk starts.
---@field dawn double @ [Read-Write] The daytime when dawn starts.
---@field evening double @ [Read-Write] The daytime when evening starts.
---@field morning double @ [Read-Write] The daytime when morning starts.
---@field solar_power_multiplier double @ [Read-Write] The multiplier of solar power on this surface. Cannot be less than 0.
---@field min_brightness double @ [Read-Write] The minimal brightness during the night. Default is 0.15. The value has an effect on the game simalution only, it doesn't have any effect on rendering.
---@field brightness_visual_weights ColorModifier @ [Read-Write] Defines how surface daytime brightness influences each color channel of the current color lookup table (LUT).
---@field show_clouds boolean @ [Read-Write] If clouds are shown on this surface.

---Get the pollution for a given position.
---@param position Position @
---@return double @
function LuaSurface.get_pollution(position) end

---Find a specific entity at a specific position.
---@param entity string @Entity to look fo
---@param position Position @Coordinates to look a
---@return LuaEntity @
function LuaSurface.find_entity(entity, position) end

---Find entities in a given area.
---@param area BoundingBox @
---@return array of LuaEntity @
function LuaSurface.find_entities(area) end

---Find a non-colliding position within a given radius.
---@param name string @Prototype name of the entity to find a position for. (The bounding   box for the collision checking is taken from this prototype.
---@param center Position @Center of the search area
---@param radius double @Max distance from center to search in. 0 for infinitely-large   search area
---@param precision double @The step length from the given position as it searches, in tiles. Minimum value is 0.01
---@param force_to_tile_center boolean @Will only check tile centers. This can be useful when your intent is to place a building at the resulting position,   as they must generally be placed at tile centers. Default false
---@return Position @
function LuaSurface.find_non_colliding_position(name, center, radius, precision, force_to_tile_center) end

---Find a non-colliding position within a given rectangle.
---@param name string @Prototype name of the entity to find a position for. (The bounding   box for the collision checking is taken from this prototype.
---@param search_space BoundingBox @The rectangle to search inside
---@param precision double @The step length from the given position as it searches, in tiles. Minimum value is 0.01
---@param force_to_tile_center boolean @Will only check tile centers. This can be useful when your intent is to place a building at the resulting position,   as they must generally be placed at tile centers. Default false
---@return Position @
function LuaSurface.find_non_colliding_position_in_box(name, search_space, precision, force_to_tile_center) end

---Spill items on the ground centered at a given location.
---@param position Position @Center of the spillag
---@param items ItemStackSpecification @Items to spil
---@param enable_looted boolean @When true, each created item will be flagged with the LuaEntity::to_be_looted flag
---@param force LuaForce | string @When provided (and not nil) the items will be marked for deconstruction by this force
---@param allow_belts boolean @Whether items can be spilled onto belts. Defaults to true
---@return array of LuaEntity @
function LuaSurface.spill_item_stack(position, items, enable_looted, force, allow_belts) end

---Find enemy units (entities with type "unit") of a given force within an area.
---@param center Position @Center of the search are
---@param radius double @Radius of the circular search are
---@param force LuaForce | string @Force to find enemies of. If not given,   uses the player force
---@return array of LuaEntity @
function LuaSurface.find_enemy_units(center, radius, force) end

---Send a group to build a new base.
---@param position Position @Location of the new base
---@param unit_count uint @Number of biters to send for the base-building task
---@param force ForceSpecification @Force the new base will belong to. Defaults to enemy
function LuaSurface.build_enemy_base(position, unit_count, force) end

---Get the tile at a given position.
---@param x int @
---@param y int @
---@return LuaTile @
function LuaSurface.get_tile(x, y) end

---Set tiles at specified locations. Automatically corrects the edges around modified tiles.
---@param tiles object[] @Each Tile is a table: name :: stringposition :: Positio
---@param correct_tiles boolean @If false, the correction logic is not done on the changed tiles.                                           Defaults to true
---@param remove_colliding_entities boolean | string @true, false, or abort_on_collision. Defaults to true
---@param remove_colliding_decoratives boolean @true or false. Defaults to tru
---@param raise_event boolean @true or false. Defaults to fals
function LuaSurface.set_tiles(tiles, correct_tiles, remove_colliding_entities, remove_colliding_decoratives, raise_event) end

---Spawn pollution at the given position.
---@param source Position @Where to spawn the pollution
---@param amount double @How much pollution to add
function LuaSurface.pollute(source, amount) end

---Get an iterator going over every chunk on this surface.
---@return LuaChunkIterator @
function LuaSurface.get_chunks() end

---Is a given chunk generated?
---@param position ChunkPosition @The chunk's position
---@return boolean @
function LuaSurface.is_chunk_generated(position) end

---Request that the game's map generator generate chunks at the given position for the given radius on this surface.
---@param position Position @Where to generate the new chunks
---@param radius uint @The chunk radius from position to generate new chunks in
function LuaSurface.request_to_generate_chunks(position, radius) end

---Blocks and generates all chunks that have been requested using all available threads.
function LuaSurface.force_generate_chunk_requests() end

---Set generated status of a chunk. Useful when copying chunks.
---@param position ChunkPosition @The chunk's position
---@param status defines.chunk_generated_status @The chunk's new status
function LuaSurface.set_chunk_generated_status(position, status) end

---Find the logistic network that covers a given position.
---@param position Position @
---@param force ForceSpecification @Force the logistic network should belong to
---@return LuaLogisticNetwork @
function LuaSurface.find_logistic_network_by_position(position, force) end

---Finds all of the logistics networks whose construction area intersects with the given position.
---@param position Position @
---@param force ForceSpecification @Force the logistic networks should belong to
---@return array of LuaLogisticNetwork @
function LuaSurface.find_logistic_networks_by_construction_area(position, force) end

---
---@param position TilePosition @The tile position
---@return string @
function LuaSurface.get_hidden_tile(position) end

---
---@param position TilePosition @The tile position
---@param tile string | LuaTilePrototype @The new hidden tile or nil to clear the hidden tile
function LuaSurface.set_hidden_tile(position, tile) end

---Gets all tiles of the given types that are connected horizontally or vertically to the given tile position including the given tile position.
---@param position Position @The tile position to start at
---@param tiles string[] @The tiles to search for
---@return array of Position @
function LuaSurface.get_connected_tiles(position, tiles) end

---
---@param position ChunkPosition @The chunk position to delet
function LuaSurface.delete_chunk(position) end

---Regenerate autoplacement of some entities on this surface. This can be used to autoplace newly-added entities.
---@param entities string | string[] | string @
---@param chunks ChunkPosition[] @
function LuaSurface.regenerate_entity(entities, chunks) end

---Regenerate autoplacement of some decoratives on this surface. This can be used to autoplace newly-added decoratives.
---@param decoratives string | string[] | string @
---@param chunks ChunkPosition[] @
function LuaSurface.regenerate_decorative(decoratives, chunks) end

---Print text to the chat console of all players on this surface.
---@param message LocalisedString @
---@param color Color @
function LuaSurface.print(message, color) end

---
---@param force ForceSpecification @If given only trains matching this force are returned
---@return array of LuaTrain @
function LuaSurface.get_trains(force) end

---Clears all pollution on this surface.
function LuaSurface.clear_pollution() end

---Gets the resource amount of all resources on this surface
---@return dictionary string → uint @
function LuaSurface.get_resource_counts() end

---Gets a random generated chunk position or 0,0 if no chunks have been generated on this surface.
---@return ChunkPosition @
function LuaSurface.get_random_chunk() end

---Clears this surface deleting all entities and chunks on it.
---@param ignore_characters boolean @Whether characters on this surface that are connected to or associated with players should be ignored (not destroyed)
function LuaSurface.clear(ignore_characters) end

---Gets the script areas that match the given name or if no name is given all areas are returned.
---@param name string @
---@return array of ScriptArea @
function LuaSurface.get_script_areas(name) end

---Gets the first script area by name or id.
---@param key string | uint @The name or id of the area to get
---@return ScriptArea @
function LuaSurface.get_script_area(key) end

---Sets the given script area to the new values.
---@param id uint @The area to edit
---@param area ScriptArea @
function LuaSurface.edit_script_area(id, area) end

---Adds the given script area.
---@param area ScriptArea @
---@return uint @
function LuaSurface.add_script_area(area) end

---Removes the given script area.
---@param id uint @
---@return boolean @
function LuaSurface.remove_script_area(id) end

---Gets the script positions that match the given name or if no name is given all positions are returned.
---@param name string @
---@return array of ScriptPosition @
function LuaSurface.get_script_positions(name) end

---Gets the first script position by name or id.
---@param key string | uint @The name or id of the position to get
---@return ScriptPosition @
function LuaSurface.get_script_position(key) end

---Sets the given script position to the new values.
---@param id uint @The position to edit
---@param area ScriptPosition @
function LuaSurface.edit_script_position(id, area) end

---Adds the given script position.
---@param area ScriptPosition @
---@return uint @
function LuaSurface.add_script_position(area) end

---Removes the given script position.
---@param id uint @
---@return boolean @
function LuaSurface.remove_script_position(id) end

---Gets the map exchange string for the current map generation settings of this surface.
---@return string @
function LuaSurface.get_map_exchange_string() end

---Gets the starting area radius of this surface.
---@return double @
function LuaSurface.get_starting_area_radius() end

---Gets the closest entity in the list to this position.
---@param position Position @
---@param entities LuaEntity[] @The Entities to chec
---@return LuaEntity @
function LuaSurface.get_closest(position, entities) end

---Gets train stops matching the given filters.
---@param opts string | string[] | string @Table with the following fields: name :: string or array of string  (optional)force :: ForceSpecification  (optional
---@return array of LuaEntity @
function LuaSurface.get_train_stops(opts) end

---Gets the total amount of pollution on the surface by iterating over all of the chunks containing pollution.
---@return double @
function LuaSurface.get_total_pollution() end

---
---@param prototype EntityPrototypeSpecification @The entity prototype to chec
---@param position Position @The position to chec
---@param use_map_generation_bounding_box boolean @If the map generation bounding box should be used instead of the collision bounding bo
---@param direction defines.direction @
function LuaSurface.entity_prototype_collides(prototype, position, use_map_generation_bounding_box, direction) end

---
---@param prototype string @The decorative prototype to chec
---@param position Position @The position to chec
function LuaSurface.decorative_prototype_collides(prototype, position) end

---
---@param property_names string[] @Names of properties (e.g. "elevation") to calculat
---@param positions Position[] @Positions for which to calculate property value
---@return dictionary string → array of double @
function LuaSurface.calculate_tile_properties(property_names, positions) end

---Returns all the entities with force on this chunk for the given force.
---@param position ChunkPosition @The chunk's position
---@param force LuaForce | string @Entities of this force will be returned
---@return array of LuaEntity @
function LuaSurface.get_entities_with_force(position, force) end

---@class LuaTechnology Reload this technology from its prototype.
---@field force LuaForce @ [Read-only] 
---@field name string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field prototype LuaTechnologyPrototype @ [Read-only] The prototype of this technology.
---@field enabled boolean @ [Read-Write] 
---@field visible_when_disabled boolean @ [Read-Write] 
---@field upgrade boolean @ [Read-only] 
---@field researched boolean @ [Read-Write] 
---@field prerequisites table<string, LuaTechnology> @ [Read-only] 
---@field research_unit_ingredients Ingredient[] @ [Read-only] 
---@field effects Modifier[] @ [Read-only] 
---@field research_unit_count uint @ [Read-only] 
---@field research_unit_energy double @ [Read-only] 
---@field order string @ [Read-only] 
---@field level uint @ [Read-Write] The current level of this technology. For level-based technology writing to this is the same as researching the technology to the *previous* level. Writing the level will set LuaTechnology::enabled to true.
---@field research_unit_count_formula string @ [Read-only] The count formula used for this infinite research or nil if this isn't an infinite research.

---Reload this technology from its prototype.
function LuaTechnology.reload() end

---@class LuaTechnologyPrototype 
---@field name string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field enabled boolean @ [Read-only] If this technology prototype is enabled by default (enabled at the beginning of a game).
---@field hidden boolean @ [Read-only] If this technology prototype is hidden.
---@field visible_when_disabled boolean @ [Read-only] If this technology will be visible in the research GUI even though it is disabled.
---@field upgrade boolean @ [Read-only] If the is technology prototype is an upgrade to some other technology.
---@field prerequisites table<string, LuaTechnologyPrototype> @ [Read-only] 
---@field research_unit_ingredients Ingredient[] @ [Read-only] 
---@field effects Modifier[] @ [Read-only] 
---@field research_unit_count uint @ [Read-only] 
---@field research_unit_energy double @ [Read-only] 
---@field order string @ [Read-only] 
---@field level uint @ [Read-only] 
---@field max_level uint @ [Read-only] 
---@field research_unit_count_formula string @ [Read-only] The count formula used for this infinite research or nil if this isn't an infinite research.

---@class LuaTile What type of things can collide with this tile?
---@field name string @ [Read-only] 
---@field prototype LuaTilePrototype @ [Read-only] 
---@field position Position @ [Read-only] The position this tile references.
---@field hidden_tile string @(optional) [Read-only] 
---@field surface LuaSurface @ [Read-only] The surface this tile is on.

---What type of things can collide with this tile?
---@param layer CollisionMaskLayer @
---@return boolean @
function LuaTile.collides_with(layer) end

---Orders deconstruction of this tile by the given force.
---@param force ForceSpecification @The force whose robots are supposed to do the deconstruction
---@param player PlayerSpecification @The player to set the last_user to if any
---@return LuaEntity @
function LuaTile.order_deconstruction(force, player) end

---Cancels deconstruction if it is scheduled, does nothing otherwise.
---@param force ForceSpecification @The force who did the deconstruction order
---@param player PlayerSpecification @The player to set the last_user to if any
function LuaTile.cancel_deconstruction(force, player) end

---@class LuaTilePrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field collision_mask CollisionMask @ [Read-only] 
---@field collision_mask_with_flags CollisionMaskWithFlags @ [Read-only] 
---@field layer uint @ [Read-only] 
---@field autoplace_specification AutoplaceSpecification @ [Read-only] Autoplace specification for this prototype. nil if none.
---@field walking_speed_modifier float @ [Read-only] 
---@field vehicle_friction_modifier float @ [Read-only] 
---@field map_color Color @ [Read-only] 
---@field decorative_removal_probability float @ [Read-only] 
---@field automatic_neighbors boolean @ [Read-only] 
---@field allowed_neighbors table<string, LuaTilePrototype> @ [Read-only] 
---@field needs_correction boolean @ [Read-only] If this tile needs correction logic applied when it's generated in the world..
---@field mineable_properties table @(optional) [Read-only] 
---@field next_direction LuaTilePrototype @ [Read-only] The next direction of this tile or nil - used when a tile has multiple directions (such as hazard concrete)
---@field items_to_place_this SimpleItemStack[] @ [Read-only] 
---@field can_be_part_of_blueprint boolean @ [Read-only] 
---@field emissions_per_second double @ [Read-only] 

---@class LuaTrain Get the amount of a particular item stored in the train.
---@field manual_mode boolean @ [Read-Write] 
---@field speed double @ [Read-Write] 
---@field max_forward_speed double @ [Read-only] 
---@field max_backward_speed double @ [Read-only] 
---@field weight double @ [Read-only] 
---@field carriages LuaEntity[] @ [Read-only] 
---@field locomotives table<string, LuaEntity> @ [Read-only] 
---@field cargo_wagons LuaEntity[] @ [Read-only] 
---@field fluid_wagons LuaEntity[] @ [Read-only] 
---@field schedule TrainSchedule @ [Read-Write] The trains current schedule or nil if empty. Set to nil to clear.
---@field state defines.train_state @ [Read-only] 
---@field front_rail LuaEntity @ [Read-only] 
---@field back_rail LuaEntity @ [Read-only] 
---@field rail_direction_from_front_rail defines.rail_direction @ [Read-only] 
---@field rail_direction_from_back_rail defines.rail_direction @ [Read-only] 
---@field front_stock LuaEntity @ [Read-only] 
---@field back_stock LuaEntity @ [Read-only] 
---@field station LuaEntity @ [Read-only] The train stop this train is stopped at or nil.
---@field has_path boolean @ [Read-only] If this train has a path.
---@field path_end_rail LuaEntity @ [Read-only] The destination rail this train is currently pathing to or nil.
---@field path_end_stop LuaEntity @ [Read-only] The destination train stop this train is currently pathing to or nil.
---@field id uint @ [Read-only] The unique train ID.
---@field passengers LuaPlayer[] @ [Read-only] The player passengers on the train
---@field riding_state RidingState @ [Read-only] The riding state of this train.
---@field killed_players table<uint, uint> @ [Read-only] The players killed by this train.
---@field kill_count uint @ [Read-only] The total number of kills by this train.
---@field path LuaRailPath @ [Read-only] The path this train is using or nil if none.
---@field signal LuaEntity @ [Read-only] The signal this train is arriving or waiting at or nil if none.

---Get the amount of a particular item stored in the train.
---@param item string @Item name to count. If not given, counts all items
---@return uint @
function LuaTrain.get_item_count(item) end

---Get a mapping of the train's inventory.
---@return dictionary string → uint @
function LuaTrain.get_contents() end

---Remove some items from the train.
---@param stack ItemStackSpecification @The amount and type of items to remov
---@return uint @
function LuaTrain.remove_item(stack) end

---Insert a stack into the train.
---@param stack ItemStackSpecification @
function LuaTrain.insert(stack) end

---Clear all items in this train.
function LuaTrain.clear_items_inside() end

---Checks if the path is invalid and tries to re-path if it isn't.
---@param force boolean @Forces the train to re-path regardless of the current path being valid or not
---@return boolean @
function LuaTrain.recalculate_path(force) end

---Get the amount of a particular fluid stored in the train.
---@param fluid string @Fluid name to count. If not given, counts all fluids
---@return double @
function LuaTrain.get_fluid_count(fluid) end

---Gets a mapping of the train's fluid inventory.
---@return dictionary string → double @
function LuaTrain.get_fluid_contents() end

---Remove some fluid from the train.
---@param fluid Fluid @
---@return double @
function LuaTrain.remove_fluid(fluid) end

---Inserts the given fluid into the first available location in this train.
---@param fluid Fluid @
---@return double @
function LuaTrain.insert_fluid(fluid) end

---Clears all fluids in this train.
function LuaTrain.clear_fluids_inside() end

---Go to the station specified by the index in the train's schedule.
---@param index uint @
function LuaTrain.go_to_station(index) end

---Gets all rails under the train.
---@return array of LuaEntity @
function LuaTrain.get_rails() end

---@class LuaTransportLine Remove all items from this transport line.
---@field hash_operator uint @ [Read-only] Get the number of items on this transport line.
---@field owner LuaEntity @ [Read-only] 
---@field output_lines LuaTransportLine[] @ [Read-only] 
---@field input_lines LuaTransportLine[] @ [Read-only] 
---@field bracket_operator LuaItemStack @ [Read-only] The indexing operator.

---Remove all items from this transport line.
function LuaTransportLine.clear() end

---Count some or all items on this line.
---@param item string @Prototype name of the item to count. If not specified, count all items
---@return uint @
function LuaTransportLine.get_item_count(item) end

---Remove some items from this line.
---@param items ItemStackSpecification @Items to remove
---@return uint @
function LuaTransportLine.remove_item(items) end

---Can an item be inserted at a given position?
---@param position float @Where to insert an item
---@return boolean @
function LuaTransportLine.can_insert_at(position) end

---Can an item be inserted at the back of this line?
---@return boolean @
function LuaTransportLine.can_insert_at_back() end

---Insert items at a given position.
---@param position float @Where on the line to insert the items
---@param items ItemStackSpecification @Items to insert
---@return boolean @
function LuaTransportLine.insert_at(position, items) end

---Insert items at the back of this line.
---@param items ItemStackSpecification @
---@return boolean @
function LuaTransportLine.insert_at_back(items) end

---Get counts of all items on this line.
---@return dictionary string → uint @
function LuaTransportLine.get_contents() end

---Returns whether the associated internal transport line of this line is the same as the others associated internal transport line.
---@param other LuaTransportLine @
---@return boolean @
function LuaTransportLine.line_equals(other) end

---@class LuaTrivialSmokePrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field color Color @ [Read-only] 
---@field start_scale double @ [Read-only] 
---@field end_scale double @ [Read-only] 
---@field movement_slow_down_factor double @ [Read-only] 
---@field duration uint @ [Read-only] 
---@field spread_duration uint @ [Read-only] 
---@field fade_away_duration uint @ [Read-only] 
---@field fade_in_duration uint @ [Read-only] 
---@field glow_fade_away_duration uint @ [Read-only] 
---@field cyclic boolean @ [Read-only] 
---@field affected_by_wind boolean @ [Read-only] 
---@field show_when_smoke_off boolean @ [Read-only] 
---@field glow_animation boolean @ [Read-only] 
---@field render_layer RenderLayer @ [Read-only] 

---@class LuaUnitGroup Make a unit a member of this group. Has the same effect as giving a group_command with this group to the unit.
---@field members LuaEntity[] @ [Read-only] 
---@field position Position @ [Read-only] 
---@field state defines.group_state @ [Read-only] 
---@field force LuaForce @ [Read-only] 
---@field surface LuaSurface @ [Read-only] 
---@field group_number uint @ [Read-only] The group number for this unit group.
---@field is_script_driven boolean @ [Read-only] Whether this unit group is controlled by a script or by the game engine.
---@field command Command @ [Read-only] The command given to this group or nil is the group has no command.
---@field distraction_command Command @ [Read-only] The distraction command given to this group or nil is the group currently isn't distracted.

---Make a unit a member of this group. Has the same effect as giving a group_command with this group to the unit.
---@param unit LuaEntity @
function LuaUnitGroup.add_member(unit) end

---Give this group a command.
---@param command Command @
function LuaUnitGroup.set_command(command) end

---Make this group autonomous. Autonomous groups will automatically attack polluted areas. Autonomous groups aren't considered to be script driven
function LuaUnitGroup.set_autonomous() end

---Make the group start moving even if some of its members haven't yet arrived.
function LuaUnitGroup.start_moving() end

---Dissolve this group. Its members won't be destroyed, they will be merely unlinked from this group.
function LuaUnitGroup.destroy() end

---@class LuaVirtualSignalPrototype 
---@field name string @ [Read-only] 
---@field order string @ [Read-only] 
---@field localised_name LocalisedString @ [Read-only] 
---@field localised_description LocalisedString @ [Read-only] 
---@field special boolean @ [Read-only] If this is a special signal
---@field subgroup LuaGroup @ [Read-only] 

---@class LuaVoidEnergySourcePrototype 
---@field emissions double @ [Read-only] 
---@field render_no_network_icon boolean @ [Read-only] 
---@field render_no_power_icon boolean @ [Read-only] 

---@class LocalisedString 

---@class GameViewSettings Parameters that affect the look and control of the game. Updating any of the member attributes here  will immediately take effect in the game engine.
---@field show_controller_gui boolean @ [Read-Write] 
---@field show_minimap boolean @ [Read-Write] 
---@field show_research_info boolean @ [Read-Write] 
---@field show_entity_info boolean @ [Read-Write] 
---@field show_alert_gui boolean @ [Read-Write] 
---@field update_entity_selection boolean @ [Read-Write] 
---@field show_rail_block_visualisation boolean @ [Read-Write] 
---@field show_side_menu boolean @ [Read-Write] 
---@field show_map_view_options boolean @ [Read-Write] 
---@field show_quickbar boolean @ [Read-Write] 
---@field show_shortcut_bar boolean @ [Read-Write] 

---@class TileProperties Properties of a tile. Updating any of the member attributes here will immediately take effect in the game  engine.
---@field tier_from_start double @ [Read-Write] 
---@field roughness double @ [Read-Write] 
---@field elevation double @ [Read-Write] 
---@field available_water double @ [Read-Write] 
---@field temperature double @ [Read-Write] 

---@class DisplayResolution 

---@class PersonalLogisticParameters 

---@class Position Coordinates of a tile in a map.  Positions may be specified either as a dictionary with x, y as keys,  or simply as an array with two elements.

---@class ChunkPosition Coordinates of a chunk in a LuaSurface where each integer x/y represents a different chunk.  This uses the same format as Position. You can translate a Position to a chunk position by dividing the x/y values by 32.

---@class TilePosition Coordinates of a tile in a chunk on a LuaSurface where each integer x/y represents a different tile.  This uses the same format as Position except it rounds any x/y down to whole numbers.

---@class ChunkPositionAndArea A ChunkPosition with an added bounding box for the area of the chunk.
---@field x x @  
---@field y y @  
---@field area area @  

---@class GuiLocation Screen coordinates of a GUI element in a LuaGui.  This uses the same format as Position except it rounds any x/y down to whole numbers.

---@class OldTileAndPosition 

---@class Tags A dictionary of string to the 4 basic Lua types: string, boolean, number, table.

---@class SmokeSource A table:

---@class Vector A vector is a two-element array containing the x and y components. Unlike Positions, vectors don't use the  x, y keys.

---@class BoundingBox Two positions, specifying the top-left and bottom-right corner of the box, respectively. Like with Position,  the names of the members may be omitted.  When read from the game, the third member "orientation" is present if it is non-zero, however it is ignored when  provided to the game.

---@class ScriptArea An area defined using the map editor.

---@class ScriptPosition A position defined using the map editor.

---@class Color Red, green, blue and alpha values, all in range [0, 1] or all in range [0, 255] if any value is > 1. All values here are optional; color channels default to 0,  the alpha channel defaults to 1. Similar to Position, Color allows the short-hand notation of passing an array of exactly 3 or 4 numbers.  The game usually expects colors to be in pre-multiplied form (color channels are pre-multiplied by alpha).

---@class ColorModifier Same as Color, but red, green, blue and alpha values can be any floating point number, without any special handling o range [1, 255].

---@class PathFindFlags A table with one or more of the following values.

---@class MapViewSettings What is shown in the map view. If a field is not given, that setting will not be changed.

---@class MapSettings Various game-related settings. See data/base/prototypes/map-settings.lua for a description  of all attributes. Updating any of the attributes will immediately take effect in the game engine.

---@class DifficultySettings Technology and recipe difficulty settings.

---@class MapExchangeStringData The data that can be extracted from a map exchange string, as a plain table.
---@field map_settings map_settings @  
---@field map_gen_settings map_gen_settings @  

---@class Fluid Fluid is represented as a table

---@class Ingredient An ingredient is a table

---@class Product 
---@field type string @  .
---@field name name @  :  Prototype name of the result.
---@field amount amount @(optional)  must all be specified.
---@field temperature temperature @(optional)  :  The fluid temperature of this product. Has no effect if type is &#x27;&quot;item&quot;&#x27;.
---@field amount_min amount_min @(optional)  is specified.
---@field amount_max amount_max @(optional)  is specified.
---@field probability probability @(optional)  :  A value in range [0, 1]. Item or fluid is only given with this probability;      otherwise no product is produced.
---@field catalyst_amount catalyst_amount @(optional)  :  How much of this product is a catalyst.

---@class Loot Loot is an array of loot items. Each loot item is a table:

---@class Modifier The effect that is applied when a technology is researched. It is a table that contains at least the field  type. A modifier may also have other fields depending on the type.

---@class Offer A single offer on a market entity.
---@field price price @  :  List of prices.
---@field offer offer @  modifier.

---@class AutoplaceSpecification Specifies how probability and richness are calculated when placing something on the map.  Can be specified either using probability_expression and richness_expression  or by using all the other fields.
---@field probability_expression probability_expression @  
---@field richness_expression richness_expression @  
---@field coverage coverage @  
---@field sharpness sharpness @  
---@field max_probability max_probability @  
---@field placement_density placement_density @  
---@field richness_base richness_base @  
---@field richness_multiplier richness_multiplier @  
---@field richness_multiplier_distance_bonus richness_multiplier_distance_bonus @  
---@field starting_area_size starting_area_size @  
---@field order order @  
---@field default_enabled default_enabled @  
---@field peaks peaks @(optional)  
---@field influence influence @  
---@field max_influence max_influence @  
---@field min_influence min_influence @  
---@field richness_influence richness_influence @  
---@field noisePersistence noisePersistence @  
---@field noise_layer noise_layer @(optional)  :  Prototype name of the noise layer
---@field noise_octaves_difference noise_octaves_difference @  
---@field d_optimal d_optimal @  is the dimension name; this attribute may occur multiple times, once for each        dimension, every time with a different prefix.
---@field d_range d_range @  is the dimension name.
---@field d_top_property_limit d_top_property_limit @  is the dimension name.
---@field d_max_range d_max_range @  is the dimension name.
---@field control control @(optional)  :  Control prototype name
---@field tile_restriction tile_restriction @(optional)  
---@field first first @(optional)  :  Tile prototype name
---@field second second @(optional)  :  Second prototype name
---@field force force @  
---@field random_probability_penalty random_probability_penalty @  

---@class NoiseExpression A fragment of a functional program used to generate coherent noise, probably for purposes related to terrain generation.  These can only be meaningfully written/modified during the data load phase.  More detailed information is  in the wiki.
---@field type type @  :  Names the type of the expression and determines what other fields are required.

---@class Resistances Dictionary of resistances toward each damage type. It is a dictionary indexed by damage type names (see  data/base/prototypes/damage-type.lua). Each resistance is a table:

---@class MapGenSize A floating point number specifying an amount.  For backwards compatibility, MapGenSizes can also be specified as one of the following strings,  which will be converted to a number (when queried, a number will always be returned):

---@class AutoplaceSettings 
---@field treat_missing_as_default treat_missing_as_default @  :  If missing autoplace names for this type should be default enabled.
---@field settings settings @  
---@field frequency frequency @  
---@field size size @  
---@field richness richness @  

---@class CliffPlacementSettings 
---@field name name @  :  Name of the cliff prototype.
---@field cliff_elevation_0 cliff_elevation_0 @  :  Elevation at which the first row of cliffs is placed.      The default is 10, and this cannot be set from the map generation GUI.
---@field cliff_elevation_interval cliff_elevation_interval @  :  Elevation difference between successive rows of cliffs.      This is inversely proportional to &#x27;frequency&#x27; in the map generation GUI.      Specifically, when set from the GUI the value is 40 / frequency.
---@field richness richness @  :  Corresponds to &#x27;continuity&#x27; in the GUI.      This value is not used directly, but is used by the &#x27;cliffiness&#x27; noise expression,      which in combination with elevation and the two cliff elevation properties drives cliff placement      (cliffs are placed when elevation crosses the elevation contours defined by cliff_elevation_0 and cliff_elevation_interval      when &#x27;cliffiness&#x27; is greater than 0.5).      The default &#x27;cliffiness&#x27; expression interprets this value such that larger values result in longer unbroken walls of cliffs,      and smaller values (between 0 and 1) result in larger gaps in cliff walls.

---@class MapGenSettings 
---@field terrain_segmentation terrain_segmentation @  , below).
---@field water water @  , below).
---@field autoplace_controls autoplace_controls @  
---@field frequency frequency @  ,          then scale is shown in the map generator GUI instead of frequency.
---@field size size @  :  For things that are placed as spots, size is proportional to the area of each spot.          For continuous features, size affects how much of the map is covered with the thing,          and is called &#x27;coverage&#x27; in the GUI.
---@field richness richness @  is false, because enemy base autoplacement doesn&#x27;t use richness.
---@field default_enable_all_autoplace_controls default_enable_all_autoplace_controls @  :  If autoplace_controls not defined should be default-enabled.
---@field autoplace_settings autoplace_settings @  
---@field cliff_settings cliff_settings @  :  Map generation settings for entities of the type &quot;cliff&quot;.
---@field seed seed @  :  The random seed used to generated this map.
---@field width width @  :  Width in tiles. If 0, the map has infinite width.
---@field height height @  :  Height in tiles. If 0, the map has infinite height.
---@field starting_area starting_area @  :  Size of the starting area.
---@field starting_points starting_points @  :  Positions of the starting areas.
---@field peaceful_mode peaceful_mode @  :  Whether peaceful mode is enabled for this map.
---@field property_expression_names property_expression_names @  .

---@class SignalID 
---@field type type @  .
---@field name name @(optional)  :  Name of the item, fluid or virtual signal.

---@class Signal An actual signal transmitted by the network.
---@field signal signal @  :  ID of the signal.
---@field count count @  :  Value of the signal.

---@class UpgradeFilter 
---@field type type @  .
---@field name name @(optional)  :  Name of the item, or entity.

---@class InfinityInventoryFilter A single filter used by an infinity-filters instance.
---@field name name @  :  Name of the item.
---@field count count @(optional)  :  The count of the filter.
---@field mode mode @(optional)  
---@field index index @  :  The index of this filter in the filters list.

---@class InfinityPipeFilter A single filter used by an infinity-pipe type entity.
---@field name name @  :  Name of the fluid.
---@field percentage percentage @(optional)  :  The fill percentage the pipe (e.g. 0.5 for 50%). Can&#x27;t be negative.
---@field temperature temperature @(optional)  :  The temperature of the fluid. Defaults to the default/minimum temperature of the fluid.
---@field mode mode @(optional)  

---@class HeatSetting The settings used by a heat-interface type entity.
---@field temperature temperature @(optional)  :  The target temperature. Defaults to the minimum temperature of the heat buffer (15).
---@field mode mode @(optional)  .

---@class FluidBoxConnection A definition of a fluidbox connection point.
---@field max_underground_distance max_underground_distance @(optional)  :  The maximum tile distance this underground connection can connect at if this is an underground pipe.
---@field type type @  :  The connection type: &quot;input&quot;, &quot;output&quot;, or &quot;input-output&quot;.
---@field positions positions @  :  The 4 cardinal direction connection points for this pipe

---@class ArithmeticCombinatorParameters 
---@field first_signal first_signal @(optional)  .
---@field second_signal second_signal @(optional)  .
---@field first_constant first_constant @(optional)  .
---@field second_constant second_constant @(optional)  .
---@field operation operation @(optional)  .
---@field output_signal output_signal @(optional)  :  Specifies the signal to output.

---@class ConstantCombinatorParameters This is an array of tables with the following fields:

---@class ComparatorString A string, one of: "<", ">", "=", "≥", "≤", "≠"

---@class DeciderCombinatorParameters 
---@field first_signal first_signal @(optional)  :  Defaults to blank.
---@field second_signal second_signal @(optional)  .
---@field constant constant @(optional)  .
---@field comparator comparator @(optional)  .
---@field output_signal output_signal @(optional)  :  Defaults to blank.
---@field copy_count_from_input copy_count_from_input @(optional)  .

---@class CircuitCondition 
---@field comparator comparator @(optional)  .
---@field first_signal first_signal @(optional)  :  Defaults to blank
---@field second_signal second_signal @(optional)  .
---@field constant constant @(optional)  .

---@class CircuitConditionSpecification 
---@field condition condition @  
---@field fulfilled fulfilled @(optional)  :  Is the condition currently fulfilled?

---@class Filter 
---@field index index @  :  Position of the corresponding filter slot.
---@field name name @  :  Item prototype name of the item to filter.

---@class PlaceAsTileResult 
---@field result result @  :  The tile prototype.
---@field condition_size condition_size @  
---@field condition condition @  

---@class RaiseEventParameters A table - the parameters required to raise a given game event.  See the event being raised for what parameters are required.

---@class SimpleItemStack An item stack may be specified either as a string (in which case it represents a full stack containing the  specified item), or as the following table:

---@class Command Commands can be given to enemies and unit groups. It is a table:

---@class PathfindFlags 
---@field allow_destroy_friendly_entities allow_destroy_friendly_entities @(optional)  :  Allows pathing through friendly entities. Default false.
---@field allow_paths_through_own_entities allow_paths_through_own_entities @(optional)  :  Allows the pathfinder to path through entities of the same force. Default false.
---@field cache cache @(optional)  :  Enables path caching. This can be more efficient, but can fail to respond to changes in the environment. Default true.
---@field prefer_straight_paths prefer_straight_paths @(optional)  :  Tries to path in straight lines. Default false.
---@field low_priority low_priority @(optional)  :  Sets lower priority on the path request, might mean it takes longer to find a path, at the expense of speeding up others. Default false.
---@field no_break no_break @(optional)  :  The pathfinder won&#x27;t break in the middle of processing this pathfind, no matter how much work is needed. Default false.

---@class ForceSpecification A force may be specified in one of two ways.

---@class TechnologySpecification A technology may be specified in one of three ways.

---@class SurfaceSpecification A surface may be specified in one of three ways.

---@class PlayerSpecification A player may be specified in one of three ways.

---@class ItemStackSpecification An item may be specified in one of the following ways.

---@class EntityPrototypeSpecification An entity prototype may be specified in one of the following ways.

---@class ItemPrototypeSpecification An item prototype may be specified in one of the following ways.

---@class WaitCondition 
---@field type type @  .
---@field compare_type compare_type @  array.
---@field ticks uint @(optional)  .
---@field condition CircuitCondition @(optional)  .

---@class TrainScheduleRecord 
---@field station station @(optional)  :  Name of the station.
---@field rail rail @(optional)  is present.
---@field wait_conditions wait_conditions @  
---@field temporary temporary @(optional)  :  Only present when the station is temporary, the value is then always true.

---@class TrainSchedule 
---@field current current @  :  Index of the currently active record
---@field records records @  

---@class GuiArrowSpecification Used for specifying where a GUI arrow should point to. It is a table:

---@class AmmoType 
---@field action action @(optional)  
---@field target_type target_type @  (fires in a direction).
---@field clamp_position clamp_position @(optional)  .
---@field category category @  :  Ammo category of this ammo.
---@field energy_consumption energy_consumption @(optional)  .

---@class BeamTarget 
---@field entity entity @(optional)  :  The target entity.
---@field position position @(optional)  :  The target position.

---@class RidingState It is a table with two fields:
---@field acceleration acceleration @  
---@field direction direction @  

---@class SpritePath It is specified by string.  It can be either the name of a  sprite prototype defined in the data phase or a path in form "type/name". Supported types are.

---@class SoundPath A sound specification defined by a string.  It can be either the name of a  sound prototype defined in the data phase or a path in the form "type/name". Supported types are.

---@class ModConfigurationChangedData 
---@field old_version old_version @  if the mod wasn&#x27;t previously present (i.e. it was just added).
---@field new_version new_version @  if the mod is no longer present (i.e. it was just removed).

---@class ConfigurationChangedData 
---@field old_version old_version @(optional)  :       Old version of the map. Present only when loading map version other than the current version.
---@field new_version new_version @(optional)  :       New version of the map. Present only when loading map version other than the current version.
---@field mod_changes mod_changes @  :       Dictionary of mod changes. It is indexed by mod name.
---@field mod_startup_settings_changed mod_startup_settings_changed @  :       True when mod startup settings have changed since the last time this save was loaded.
---@field migration_applied migration_applied @  :       True when mod prototype migrations have been applied since the last time this save was loaded.

---@class EffectValue 
---@field bonus bonus @  means 60% increase.

---@class Effects This is a mapping of effect name to effect values given as a dictionary string → EffectValue.

---@class EntityPrototypeFlags This is a set of flags given as a dictionary string → boolean. When a flag is set, it is present  in the dictionary with the value true. Unset flags aren't present in the dictionary at all.  So, the boolean value is meaningless and exists just for easy table lookup if a flag is set.

---@class ItemPrototypeFlags This is a set of flags given as dictionary string → boolean. When a flag is set, it is present  in the dictionary with the value true. Unset flags aren't present in the dictionary at all.  So, the boolean value is meaningless and exists just for easy table lookup if a flag is set.

---@class CollisionMaskLayer A string specifying a collision mask layer.

---@class CollisionMask This is a set of masks given as a dictionary CollisionMaskLayer → boolean. Only set masks are present in the  dictionary and they have the value true. Unset flags aren't present at all.

---@class CollisionMaskWithFlags A CollisionMask but also includes any flags this mask has.  Flags such as:

---@class TriggerTargetMask This is a set of trigger target masks given as a dictionary string → boolean.

---@class TriggerEffectItem 
---@field type type @  .
---@field repeat_count repeat_count @  
---@field affects_target affects_target @  
---@field show_in_tooltip show_in_tooltip @  

---@class TriggerDelivery 
---@field type type @  .
---@field source_effects source_effects @  
---@field target_effects target_effects @  

---@class TriggerItem 
---@field type type @  .
---@field action_delivery action_delivery @(optional)  
---@field source_effects source_effects @  
---@field entity_flags entity_flags @(optional)  :  The trigger will only affect entities that contain      any of these flags.
---@field ignore_collision_condition ignore_collision_condition @  
---@field collision_mask collision_mask @  :  The trigger will only affect entities that would collide with given      collision mask.
---@field trigger_target_mask trigger_target_mask @  
---@field force force @  .
---@field repeat_count repeat_count @  

---@class Trigger An array of TriggerItem

---@class AttackParameters 
---@field range range @  :  Maximum range for attack.
---@field min_range min_range @  :  Minimum range for attack (used e.g. with flamethrower turrets).
---@field turn_range turn_range @  is      the full circle).
---@field fire_penalty fire_penalty @  :  When searching for the nearest enemy to attack, fire_penalty is added to the enemy&#x27;s      distance if it is on fire.
---@field min_attack_distance min_attack_distance @  and attack from that distance. Used for spitters.
---@field damage_modifier damage_modifier @  
---@field ammo_consumption_modifier ammo_consumption_modifier @  
---@field cooldown cooldown @  
---@field warmup warmup @  
---@field movement_slow_down_factor movement_slow_down_factor @  
---@field movement_slow_down_cooldown movement_slow_down_cooldown @  
---@field ammo_type ammo_type @(optional)  
---@field ammo_categories ammo_categories @(optional)  

---@class CapsuleAction 
---@field type type @  .
---@field attack_parameters AttackParameters @(optional)  .
---@field equipment equipment @(optional)  . It is the equipment      prototype name.

---@class SelectionModeFlags This is a set of flags given as a dictionary string → boolean. Set flags are present in the dictionary  with the value true; unset flags aren't present at all.

---@class LogisticFilter 
---@field index index @  :  The index this filter applies to.
---@field name name @  :  The item name for this filter.
---@field count count @  :  The count for this filter.

---@class ModSetting 
---@field value value @  :  The value of the mod setting. The type depends on the setting.

---@class Any Any basic type (string, number, boolean) plus tables.

---@class ProgrammableSpeakerParameters 
---@field playback_volume playback_volume @  
---@field playback_globally playback_globally @  
---@field allow_polyphony allow_polyphony @  

---@class ProgrammableSpeakerAlertParameters 
---@field show_alert show_alert @  
---@field show_on_map show_on_map @  
---@field icon_signal_id icon_signal_id @  
---@field alert_message alert_message @  

---@class ProgrammableSpeakerCircuitParameters 
---@field signal_value_is_pitch signal_value_is_pitch @  
---@field instrument_id instrument_id @  
---@field note_id note_id @  

---@class ProgrammableSpeakerInstrument 
---@field name name @  
---@field notes notes @  

---@class Alignment A string that specifies where a gui element should be.

---@class NthTickEvent 
---@field tick tick @  
---@field nth_tick nth_tick @  

---@class ScriptRenderTarget 
---@field entity entity @(optional)  
---@field entity_offset entity_offset @(optional)  
---@field position position @(optional)  

---@class MouseButtonFlags This is a set of flags given as a dictionary string → boolean. When a flag is set, it is present  in the dictionary with the value true. Unset flags aren't present in the dictionary at all.

---@class CursorBoxRenderType It is specified by string.

---@class ForceCondition It is specified by string.

---@class RenderLayer A value between 0 and 255 inclusive represented by one of the following named string or string version of the value (for example "27" and "decals" are both valid).  Higher values are rendered on top of lower values.

---@class CliffOrientation 

---@class ItemPrototypeFilters An array of filters. Each filter is a table:

---@class ModSettingPrototypeFilters An array of filters. Each filter is a table:

---@class TechnologyPrototypeFilters An array of filters. Each filter is a table:

---@class DecorativePrototypeFilters An array of filters. Each filter is a table:

---@class AchievementPrototypeFilters An array of filters. Each filter is a table:

---@class FluidPrototypeFilters An array of filters. Each filter is a table:

---@class EquipmentPrototypeFilters An array of filters. Each filter is a table:

---@class TilePrototypeFilters An array of filters. Each filter is a table:

---@class RecipePrototypeFilters An array of filters. Each filter is a table:

---@class EntityPrototypeFilters An array of filters. Each filter is a table:

