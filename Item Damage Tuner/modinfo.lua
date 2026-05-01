
name = "Item Damage Tuner"
description = "Fully adjustable item damage.\n\nBase: +-10 per click\nFloat: +-0.1 per click\nFinal damage = Base + Float.\n\nSet any value from 0 to 9999.9 for each item individually."
author = "Storymiralias"
version = "1.0.0"

forumthread = ""

api_version = 10

all_clients_require_mod = true
client_only_mod = false

dst_compatible = true
server_filter_tags = {"Item Damage Tuner", "Options", "Weapons"}

icon = "modicon.tex"
icon_atlas = "modicon.xml"

--- Generates a table of integer options 
-- Ranges from 0 to 9990 with step of 10
-- @return table: An Array of entries, each containing {description: number, data: number}
local function IntegerOptions()
	local t = {}
	local count = 1  
	for i = 0, 9990, 10 do
		t[count] = {description = i, data = i}
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
local function SmartAdd(id, damage)
	local def_float = damage % 10	
	local def_int = damage - def_float	
	
	-- Apply title case formatting for UI presentation
	local label_name = (id:sub(1,1):upper()) .. (id:sub(2):lower())

	return {id = id, label = label_name, default_int = def_int, default_fl = def_float}
end

-- Registry of items to be exposed in the mod configuration interface 
local items_to_add = {
	-- Melee Weapons
	{ is_header = true, label = "--- Melee Weapons ---", hover = "Base + Float = Final damage of the selected item. See the Workshop page for more info" },
	SmartAdd("SPEAR", 34)
	
}

local c = 1
local configuration_options = {}

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
		configuration_options[c] = {name = "HEADER_" ..i, label = item.label, hover = "Base + Float = Final damage of the selected item. See the Workshop page for more info"}
	end
end
