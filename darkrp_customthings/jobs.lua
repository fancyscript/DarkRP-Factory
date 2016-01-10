--[[---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------

This file contains your custom jobs.
This file should also contain jobs from DarkRP that you edited.

Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the job to this file and edit it.

The default jobs can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomJobFields


Add jobs under the following line:
---------------------------------------------------------------------------]]
TEAM_FACTOWNER = DarkRP.createJob("Factory Owner", {
   color = Color(71, 5, 90, 255),
   model = {"models/player/magnusson.mdl"},
   description = [[Buy metal and turn it into useful items with your factories. Sell your products to other players or the NPC buyer.

Hire workers to manage your factories and make sure they don't run out of resources or get jammed!]],
   weapons = {},
   command = "factoryowner",
   max = 2,
   salary = 45,
   admin = 0,
   vote = false,
   hasLicense = true,
   candemote = true,
   -- CustomCheck
   medic = false,
   chief = false,
   mayor = false,
   hobo = false,
   cook = false,
   category = "Factory",
})

TEAM_FACTORY = DarkRP.createJob("Factory Worker", {
   color = Color(185, 15, 235, 255),
   model = {"models/player/hostage/hostage_02.mdl"},
   description = [[Work with a factory owner to keep the factory up and running. 
Buy metal to load the factory and make sure it doesn't jam.]],
   weapons = {},
   command = "factoryworker",
   max = 6,
   salary = 35,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = true,
   -- CustomCheck
   medic = false,
   chief = false,
   mayor = false,
   hobo = false,
   cook = false,
   category = "Factory",
})







--[[---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------]]
GAMEMODE.DefaultTeam = TEAM_CITIZEN


--[[---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------]]
GAMEMODE.CivilProtection = {
	[TEAM_POLICE] = true,
	[TEAM_CHIEF] = true,
	[TEAM_MAYOR] = true,
}

--[[---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------]]
DarkRP.addHitmanTeam(TEAM_MOB)
