# nx-weedfarm 0.1.1_BETA
Simple Weedfarming script using QB-Core and CircleMinigame

# Originally created by TRClassic, modified by Nexiii
https://github.com/trclassic92/tr-orangefarm

# Dependencies (QB):
- [CircleMinigame](https://github.com/trclassic92/CircleMinigame)
- [qb-inventory](https://github.com/qbcore-framework/qb-inventory)
- [ox_target](https://github.com/overextended/ox_target) (Config Option)
- [qb-target](https://github.com/qbcore-framework/qb-target) (Config Option)
- [ox_lib](https://github.com/overextended/ox_lib)
- [qb-core](https://github.com/qbcore-framework/qb-core)


# Install QBCore-
Step 1. Copy this at the bottom of [qb]/qb-core/shared/items.lua

```
--NX Weedfarm
["dirtymoney"]                   = {["name"] = "dirtymoney",                    ["label"] = "Dirty Money",              ["weight"] = 0,         ["type"] = "item",      ["image"] = "dirtymoney.png",       ["unique"] = false,		    ["useable"] = true,     ["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "The ill-gotten proceeds of criminal activity."},
['cannabis'] 					 = {['name'] = 'cannabis', 						['label'] = 'Cannabis', 				['weight'] = 25, 		['type'] = 'item', 		['image'] = 'cannabis.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'bulb of cannabis, could be packed'},
['weed_baggy'] 			 	     = {['name'] = 'weed_baggy', 					['label'] = 'Weed Baggy', 			    ['weight'] = 75, 		['type'] = 'item', 		['image'] = 'weed_baggy.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'bunch of cannabis in a baggy, could be selled'},

```

Step 2. Move the images from the nx-weedfarm/images to [qb]/qb-inventory/html/images

Step 3. Ensure it in your config or just drag and drop it in [qb] (should start everything in [qb])
