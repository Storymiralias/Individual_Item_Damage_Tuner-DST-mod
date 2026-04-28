
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

--- Base options generator (0, 10... 9990)
local function IntegerOptions()
	local t = {}
	local count = 1  
	for i = 0, 9990, 10 do
		t[count] = {description = i, data = i}
		count = count + 1
	end
	return t
end
--- Float options generator (0, 0.1... 9.9)
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

-- Cache options to avoid redundant function calls during generation 
local int_opts = IntegerOptions()
local float_opts = FloatOptions()

-- Items data list for compiling cycle below
local items_to_add = {
	-- Melee Weapons
	{ is_header = true, label = "--- Melee Weapons ---", hover = "Base + Float = Final damage of the selected item. See the Workshop page for more info" },
	{ id = "SPEAR", label = "Spear", default_int = 30, default_fl = 4 },
}

local c = 1
local configuration_options = {}

-- Mod options compiling cycle
for i = 1, #items_to_add do

	local item = items_to_add[i]

	if not item.is_header then 
		-- Base
		configuration_options[c] = {
			name = item.id .."_BASE",
			label = item.label .." Base",
			hover = "Default is ".. item.default_int,
			options = int_opts,
			default = item.default_int,	
		}
		c = c + 1
		
		-- Float
		configuration_options[c] = {
			name = item.id .."_FLOAT",
			label = item.label .." Float",
			hover = "Default is ".. item.default_fl,
			options = float_opts,
			default = item.default_fl,
		}
		c = c + 1
	else
		-- Headers Labels
		configuration_options[c] = {name = "HEADER_" ..i, label = item.label, hover = "Base + Float = Final damage of the selected item. See the Workshop page for more info"}
	end
end
