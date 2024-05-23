# nx-weedfarm
Simple Weedfarming script using QB-Core

originally created by TRClassic, modified by Nexiii
https://github.com/trclassic92/tr-orangefarm

# Dependencies (QB):
- [CircleMinigame](https://github.com/trclassic92/CircleMinigame)
- [qb-inventory](https://github.com/qbcore-framework/qb-inventory)
- [ox_target](https://github.com/overextended/ox_target) (Config Option)
- [qb-target](https://github.com/qbcore-framework/qb-target) (Config Option)
- [ox_lib](https://github.com/overextended/ox_lib)
- [qb-core](https://github.com/qbcore-framework/qb-core)


# Install QBCore
#### Items

qb-core/shared/item.lua

Step 1. Copy this at the bottom at [qb]/qb-core/shared/items.lua
```
--NX Weedfarm
	["dirtymoney"]                   = {["name"] = "dirtymoney",                    ["label"] = "Dirty Money",              ["weight"] = 0,         ["type"] = "item",      ["image"] = "dirtymoney.png",           ["unique"] = false,		["useable"] = true,     ["shouldClose"] = false,    ["combinable"] = nil,  ["description"] = "The ill-gotten proceeds of criminal activity."},
	['cannabis'] 						 = {['name'] = 'cannabis', 						['label'] = 'Cannabis', 				['weight'] = 25, 		['type'] = 'item', 		['image'] = 'cannabis.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Knolle Cannabis'},
	['weed_baggy'] 			 	        = {['name'] = 'weed_baggy', 					['label'] = 'Weed Baggy', 			['weight'] = 75, 		['type'] = 'item', 		['image'] = 'weed_baggy.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Isn Weed Baggy du kek'},

```
#### Images

Step 2. Move the images from the tr-orangefarming/images to [qb]\qb-inventory\html\images

Step 3. Ensure it in your config or just drag and drop it in [qb] (should start everything in [qb])
