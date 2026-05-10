
--- Validates, calculates and applies final damage value to the TUNING table 
-- @param prefix string: The item identifier (e.g., "SPEAR")
local function FinalDamage(prefix)

	if prefix == nil or prefix == "" then
		print("[Item Damage Tuner] WARNING: Empty prefix entry found in prefix_table!")
	end

	-- Fallback to 0 prevents crashes if config data missing
	local base = GetModConfigData(prefix:gsub("%.", "_") .. "_BASE") or 0 
	local float = GetModConfigData(prefix:gsub("%.", "_") .. "_FLOAT") or 0
	local total = base + float
	
	if prefix:find("%.") then

		local current = TUNING
		
		for part in prefix:gmatch("([^.]+)") do
			if current then current = current[part] end
		end 
	
		if type(current) == "table" and current.DAMAGE then
		current.DAMAGE = total
		end

	if type(current) == "table" and current.DAMAGE then
    print("[Item Damage Tuner] SUCCESS: Found " .. prefix .. ". Old damage: " .. tostring(current.DAMAGE))
    current.DAMAGE = total
    print("[Item Damage Tuner] NEW damage: " .. tostring(current.DAMAGE))
	end --TODO: Check result

	-- Check for the existence of the corresponding TUNING constant before assignment
	else 
	
		if TUNING[prefix .. "_DAMAGE"] then
				-- Update the global tuning table with the combined configuration value
				TUNING[prefix .. "_DAMAGE"] = total
		else
				-- Log an error to the console for invalid prefix entries
				print("[Item Damage Tuner] WARNING: Invalid prefix [".. tostring(prefix) .."] found in prefix_table!")
		end		
	end	
end

local prefix_table = {
	-- Start Melee Weapons
	
	-- Beginner Stage
	"SPEAR",
	"FENCE_ROTATOR",
	"BULLKELP_ROOT",
	"HAMBAT",
	
	-- Intermediate Stage
	"SPIKE",
	"WHIP",
	"NIGHTSTICK",
	"CUTLESS",
	"OARS.MONKEY",
	-- Character Exclusive
	"WATHGRITHR_SPEAR",
	"WATHGRITHR_SHIELD",
	"POCKETWATCH_DEPLETED",
	
	-- Advanced Stage
	"NIGHTSWORD",
	"BATBAT",
	"GLASSCUTTER",
	"RUINS_BAT",
	
	-- Boss Drop or Craft 
	"SHIELDOFTERROR",
	"RABBITKINGSPEAR",
	"TRIDENT",

	-- Endgame (Rifts and Ancient Archive)
	"SWORD_LUNARPLANT",
	"SHADOW_BATTLEAXE",
	"VOIDCLOTH_SCYTHE",
	-- Character Exclusive
	"SPEAR_WATHGRITHR_LIGHTNING",
	"SPEAR_WATHGRITHR_LIGHTNING_CHARGED",
	

	-- Ranged Weapon 
	
	
	-- Tools
		--[[ Character exclusive
	"DUMBBELL",
	"DUMBBELL_GOLDEN",
	"DUMBBELL_MARBELL",]]
	
		
	--[[ Character exclusive
	"DUMBBELL_GEM",]]
	
}

for _, value in pairs (prefix_table) do 
	
		FinalDamage(value)			
end