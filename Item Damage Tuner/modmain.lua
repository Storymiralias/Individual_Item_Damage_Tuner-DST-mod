
-- Table is in a different file: Item Damage Tuner/scripts/prefix_table.lua
local prefix_table = require "prefix_table"

-- Shorthand for: TUNING[prefix from table .."_DAMAGE"]
local function FinalDamage(prefix)
	
	local base = GetModConfigData(prefix .. "_BASE") or 0
	local float = GetModConfigData(prefix .. "_FLOAT") or 0
	
	local sum = base + float
	
	-- Check if the item exist in game; otherwise, print a warning
	if TUNING[prefix .. "_DAMAGE"] then
	TUNING[prefix .. "_DAMAGE"] = sum
	else
	print("WARNING:INCORRECT PREFIX [".. tostring(prefix) .."] DETECTED!")
	
	end	
end

-- "value" is a prefix from the table
for index, value in pairs (prefix_table) do 

	FinalDamage(value)
end


