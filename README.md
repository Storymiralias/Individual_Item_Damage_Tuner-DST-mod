# Individual_Item_Damage_Tuner-DST-mod

Fully adjustable item damage. Set any value from 0 to 9999.9 for each item individually.

# Adding New Items 

1. Add the internal prefab name to the `prefix_table` at the end of `modmain.lua`:
```lua
local prefix_table = {
    "SPEAR",
    "ITEM_NAME", -- Adding a new item here
}
```

2. Add the name and default damage to the `items_to_add` list in `modinfo.lua`:
```lua
local items_to_add = {
    --Melee Weapons
    { is_header = true, label = "Melee Weapons", hover = "Base + Float = Final damage of the selected item. See the Workshop page for more info" },
    SmartAdd("SPEAR", 34),
    SmartAdd("ITEM_NAME", [NUMBER VALUE]), -- Adding a new item here
}
```

3. Initialization is handled automatically.
