
--- Calculates and applies final damage value to the TUNING table 
-- @param prefix string: The item identifier (e.g., "SPEAR")
local function FinalDamage(prefix)
	-- Check for the existence of the corresponding TUNING constant before assignment
	if TUNING[prefix .. "_DAMAGE"] then
		-- Fallback to 0 prevents crashes if config data missing
		local base = GetModConfigData(prefix .. "_BASE") or 0 
		local float = GetModConfigData(prefix .. "_FLOAT") or 0
		
		local sum = base + float
		-- Update the global tuning table with the combined configuration value
		TUNING[prefix .. "_DAMAGE"] = sum
	else
		-- Log an error to the console for invalid prefix entries
		print("[Item Damage Tuner]WARNING:INCORRECT PREFIX [".. tostring(prefix) .."] DETECTED!") --TODO: Check
	end	
end

local prefix_table = {
	-- Melee Weapons
	"SPEAR",
	
}

for _, value in pairs (prefix_table) do 
	
		FinalDamage(value)			
end


