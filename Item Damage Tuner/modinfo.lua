
name = "Item Damage Tuner"
description = "Fully adjustable item damage.\n\nBase: +-10 per click\nFloat: +-0.1 per click\nFinal damage = Base + Float.\n\nSet any value from 0 to 9999.9 for each item individually."
author = "Storymiralias"
version = "1.0.0"

forumthread = ""
-- id = "" | Individual Item Damage Tuner (This will be the name in the Workshop)

api_version = 10
-- priority = 0

all_clients_require_mod = true
client_only_mod = false

dst_compatible = true
server_filter_tags = {"Item Damage Tuner", "Options", "Weapons"}

icon = "modicon.tex"
icon_atlas = "modicon.xml"

-- Base options generator
local function IntegerOptions()
	local t = {}
	local count = 1  
	for i = 0, 9990, 10 do
		t[count] = {description = i, data = i}
		count = count + 1
	end
	return t
end
-- Float options generator
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

-- Optimized to reduce function calls
local int_opts = IntegerOptions()
local float_opts = FloatOptions()

-- Mod settings
configuration_options = {

{name = "",
label = "Melee Weapons",
hover = "Base + Float = Final damage of the selected item. See the Workshop page for more info.",
options = {{description = "", data = ""},},
default = "",
},
	{
		name = "SPEAR_BASE",
		label = "Spear Base",
		hover = "Default is 30",
		options = int_opts,
		default = 30,	
	},
		
	{
		name = "SPEAR_FLOAT",
		label = "Spear Float",
		hover = "Default is 4",
		options = float_opts,
		default = 4,	
	},
	
}
