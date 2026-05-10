-- TODO: Update documentation about SmartAdd and other if need
name = "Item Damage Tuner"
description = "Fully adjustable item damage.\n\nBase: +-10 per click\nFloat: +-0.1 per click\nFinal damage = Base + Float.\n\nSet any value from 0 to 9999.9 for each item individually!"
author = "Storymiralias"
version = "1.1.0"

forumthread = ""

api_version = 10

all_clients_require_mod = true
client_only_mod = false

dst_compatible = true
server_filter_tags = {"Item damage tuner", "Individual item damage tuner", "Options", "Weapons"} --TODO: More useful tags

icon = "modicon.tex"
icon_atlas = "modicon.xml"

--- Generates a table of integer options 
-- Ranges from 0 to 9990 with step of 10
-- @return table: An Array of entries, each containing {description: string, data: number}
local function IntegerOptions()
	local t = {}
	local count = 1  
	for i = 0, 9990, 10 do
		t[count] = {description = "" ..i, data = i}
		count = count + 1
	end
	return t
end

--- Generates a table of float options (0.0 to 9.9, step 0.1)
-- @return table: An array of entries, each containing {description: string, data: number}
local function FloatOptions()
	local t = {}
	local count = 1
	for i = 0, 99 do 
		local val = i / 10
		t[count] = {description = "" .. val, data = val}
		count = count + 1
	end
	return t
end

-- Persistent cache for option tables to optimize memory usage during mod initialization
local int_opts = IntegerOptions()
local float_opts = FloatOptions()

--- Decomposes a raw damage value into its base and fractional components
-- Formats the ID into a display-friendly label
-- @param id string: The internal prefab identifier (e.g., "SPEAR")
-- @param damage number: The original constant damage value
-- @return table: A structure containing {id: string, label: string, default_int: number, default_fl: number}
local function SmartAdd(id, damage, manual_label)
	
	local def_float = (damage + 0.001) % 10
	local def_float_rou = def_float - (def_float % 0.1)
	local def_int = damage - (damage % 10)
	
	-- Apply title case formatting for UI presentation
	local label_name = manual_label or (id:sub(1,1):upper()) .. (id:sub(2):lower())

	return {id = id, label = label_name, default_int = def_int, default_fl = def_float_rou}
end

-- Registry of items to be exposed in the mod configuration interface 
local items_to_add = { --TODO: Add labels for each item manualy; Check real base damage
	{ is_header = true, label = "Melee Weapons", hover = "Base + Float = Final damage of the selected item. See the Workshop page for more info."},
	-- Melee Weapons
	
	{ is_header = true, label = "Beginner"},
	-- Beginner Stage
	SmartAdd("SPEAR", 34),
	SmartAdd("FENCE_ROTATOR", 34, "Fencing Sword"),
	SmartAdd("BULLKELP_ROOT", 27.2, "Bullkelp Stalk"),
	SmartAdd("HAMBAT", 59.5, "Ham Bat"),
	
	{ is_header = true, label = "Intermediate"},
	-- Intermediate Stage
	SmartAdd("SPIKE", 51, "Tentacle Spike"),
	SmartAdd("WHIP", 27.2, "Tail o'Three Cats"),
	SmartAdd("NIGHTSTICK", 28.9, "Morning Star"),
	SmartAdd("CUTLESS", 27.2),
	SmartAdd("OARS.MONKEY", 51, "Battle Paddle"), --TODO: Works differently. "MONKEY" is a prefix? 
	{ is_header = true, label = "Exclusive"},
	SmartAdd("WATHGRITHR_SPEAR", 42.5, "Battle Spear"),
	-- Character Exclusive
	SmartAdd("WATHGRITHR_SHIELD", 51, "Battle Rönd"),
	SmartAdd("POCKETWATCH_DEPLETED", 81.6, "Alarming Clock"), --TODO: Works even more differently
	
	{ is_header = true, label = "Advanced"},
	-- Advanced Stage (Magic, Ruins and Surface)
	SmartAdd("NIGHTSWORD", 68, "Dark Sword"),
	SmartAdd("BATBAT", 42.5, "Bat Bat"),
	SmartAdd("GLASSCUTTER", 68, "Glass Cutter"), --TODO: Works differenttly
	SmartAdd("RUINS_BAT", 59.5, "Thulecite Club"),
	
	{ is_header = true, label = "Boss Drop"},
	-- Boss Drop or Craft 
	SmartAdd("SHIELDOFTERROR", 51, "Shield of Terror"),
	SmartAdd("RABBITKINGSPEAR", 51, "Rabbit King Cudgel"),
	SmartAdd("TRIDENT", 51, "Strident Trident"), --TODO: Works differenttly
	
	{ is_header = true, label = "Endgame"},
	-- Endgame (Rifts and Ancient Archive)
	SmartAdd("SWORD_LUNARPLANT", 38, "BrightShade Sword"),
	SmartAdd("SHADOW_BATTLEAXE", 38, "Shadow Maul"), --TODO: Works different
	SmartAdd("VOIDCLOTH_SCYTHE", 38, "Shadow Reaper"),
	{ is_header = true, label = "Exclusive"},
	-- Character Exclusive
	SmartAdd("SPEAR_WATHGRITHR_LIGHTNING", 59.5, "Elding Spear"),
	SmartAdd("SPEAR_WATHGRITHR_LIGHTNING_CHARGED", 59.5, "Charged Elding Spear"),
	
	
	--{ is_header = true, label = "Ranged Weapon"},
	-- Ranged Weapon
	-- SmartAdd("", ),
	
		--[[ Tools Character exclusive
	SmartAdd("DUMBBELL", 17)
	SmartAdd("DUMBBELL_GOLDEN", 27.2, "Dumbell golden")
	SmartAdd("DUMBBELL_MARBELL", 40.8, "Dumbell marble") ]]
	--[[ Character exclusive
	SmartAdd("DUMBBELL_GEM", 68)]]

}

local c = 1
configuration_options = {}

--- Orchestrates the generation of the configuration_options table
-- Transforms simplified item data into the standard format required by the game engine
-- Handles both functional settings (Base/Float) and UI visual elements (headers)
for i = 1, #items_to_add do

	local item = items_to_add[i]

	if not item.is_header then 
		-- Section: Base Damage (Integer component)
		configuration_options[c] = {
			name = item.id .."_BASE",
			label = item.label .." Base",
			hover = "Default is ".. item.default_int,
			options = int_opts,
			default = item.default_int,	
		}
		c = c + 1	
		-- Section: Float Damage (Fractional component)
		configuration_options[c] = {
			name = item.id .."_FLOAT",
			label = item.label .." Float",
			hover = "Default is ".. item.default_fl,
			options = float_opts,
			default = item.default_fl,
		}
		c = c + 1	
	else
		-- Section: UI Decorative Headers
		-- Used to group items by category in the options menu
		configuration_options[c] = {
		name = "HEADER_" ..i,
		label = item.label,
		hover = item.hover,
		options = {{description = "", data = ""}}, default = ""}
		c = c + 1
	end
end
