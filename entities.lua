--[[---------------------------------------------------------------------------
DarkRP custom entities
---------------------------------------------------------------------------

This file contains your custom entities.
This file should also contain entities from DarkRP that you edited.

Note: If you want to edit a default DarkRP entity, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the entity to this file and edit it.

The default entities can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua#L111

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomEntityFields

Add entities under the following line:
---------------------------------------------------------------------------]]

DarkRP.createEntity("Factory", {

	ent = "factory_chovski",
	model = "models/props_vehicles/generatortrailer01.mdl",
	price = 500,
	max = 3,
	cmd = "buyfactory",

	allowed = {TEAM_FACTOWNER} -- Or whatever team your factory owner/workers are.

})


DarkRP.createEntity("Metal", {

	ent = "factory_metal",
	model = "models/gibs/scanner_gib02.mdl",
	price = 150,
	max = 100,
	cmd = "buyfactorymetal",

	allowed = {TEAM_FACTORY, TEAM_FACTOWNER} -- Or whatever team your factory owner/workers are.

})
