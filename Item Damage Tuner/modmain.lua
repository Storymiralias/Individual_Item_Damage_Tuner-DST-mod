
local prefix_table = {"SPEAR"}

-- Коротко: TUNING[prefix.."_DAMAGE"]
local function FinalDamage(prefix)
	
	local base = GetModConfigData(prefix .. "_BASE") or 0
	local float = GetModConfigData(prefix .. "_FLOAT") or 0
	
	local sum = base + float
	
	TUNING[prefix .. "_DAMAGE"] = sum	
end

-- "value" и будет значением из таблицы
for index, value in pairs (prefix_table) do 
	
	FinalDamage(value)
end


