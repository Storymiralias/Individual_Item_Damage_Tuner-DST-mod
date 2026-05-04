
--- Validates, calculates and applies final damage value to the TUNING table 
-- @param prefix string: The item identifier (e.g., "SPEAR")
local function FinalDamage(prefix)
	 
	if prefix == nil or prefix == "" then
		print("[Item Damage Tuner] WARNING: Empty prefix entry found in prefix_table!")
	
	-- Check for the existence of the corresponding TUNING constant before assignment
	elseif TUNING[prefix .. "_DAMAGE"] then
			
		-- Fallback to 0 prevents crashes if config data missing
		local base = GetModConfigData(prefix .. "_BASE") or 0 
		local float = GetModConfigData(prefix .. "_FLOAT") or 0
				
		-- Update the global tuning table with the combined configuration value
		TUNING[prefix .. "_DAMAGE"] = base + float
		
	else
		-- Log an error to the console for invalid prefix entries
		print("[Item Damage Tuner] WARNING: Invalid prefix [".. tostring(prefix) .."] found in prefix_table!")
	end	
end

local prefix_table = { --TODO: Fix all prefixes "spear" -> "SPEAR" and e.t.c.
	-- Start Melee Weapons
	--SmartAdd("spear_wathgrithr", 42.5)
	
	-- Beginner and intermediate stage (Basic and personal)
	"SPEAR",
	"hambat",
	"BULLKELP_ROOT",
	"tentaclespike",
	"battlepaddle",
	"cutless",
	
	--[[ Character exclusive
	"dumbbell",
	"dumbbell_golden",
	"dumbbell_marbell",
	"pocketwatch_weapon",]]
	
	-- Advanced Stage (Magic, Ruins and Surface)
	"whip",
	"nightsword",
	"ruins_bat",
	"glasscutter",
	"nightstick",
	
	--[[ Character exclusive
	"dumbbell_gem",]]
	
	-- Boss Drop or Craft 
	"shield_terror",
	"rabbitkingspear",
	"trident",

	-- Endgame (Rifts and Ancient Archive)
	"sword_lunarplant",
	"shadow_battleaxe",
	"voidcloth_scythe",
	"shadow_pillar",
	
		--[[ Character exclusive
	"spear_wathgrithr_lightning",
	"spear_wathgrithr_ice",]]
	
	-- Ranged Weapon 
}

for _, value in pairs (prefix_table) do 
	
		FinalDamage(value)			
end


