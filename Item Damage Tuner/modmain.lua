
-- Used only in this file
local prefix_table = { --TODO
	-- Melee Weapons
	"SPEAR",
	
}

--- Calculates the final damage for a given item prefix (item name, example "SPEAR")
local function FinalDamage(prefix)
	
	-- Verify if the corresponding TUNING constant exists
	if TUNING[prefix .. "_DAMAGE"] then
		
		local base = GetModConfigData(prefix .. "_BASE") or 0 -- 0 is protection against missing config data to ensure game stability 
		local float = GetModConfigData(prefix .. "_FLOAT") or 0
		
		local sum = base + float
		-- Apply the sum of base and float to the global tuning table
		TUNING[prefix .. "_DAMAGE"] = sum
		
	else
		print("[Item Damage Tuner]WARNING:INCORRECT PREFIX [".. tostring(prefix) .."] DETECTED!") -- TODO
	end	
end

for _, value in pairs (prefix_table) do 
	
		FinalDamage(value)			
end


