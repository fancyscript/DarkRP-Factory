ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Factory"
ENT.Author = "Chovski"
ENT.Spawnable = false


function ENT:initVars() -- Set config constants here.
	self.model = "models/props_vehicles/generatortrailer01.mdl"
	self.metalClass = "factory_metal"
	self.damage = 500
	self.itemBaseTime = 0
	self.DisplayName = "Factory"
	self.MinTimer = 60
	self.MaxTimer = 300
	self.SeizeReward = 1000
	self:SetmetalMax(100)
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "price")
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("String", 0, "productionItem")
	self:NetworkVar("Int", 2, "metalCost")
	self:NetworkVar("Int", 3, "metalMax")
	self:NetworkVar("Int", 4, "metalCount")
	self:NetworkVar("String", 1, "productionID")
	self:NetworkVar("Bool", 1, "ableToProduce")

end

PRODUCTION_TABLE = {}

	PRODUCTION_TABLE.Battery = "printer_battery"
	PRODUCTION_TABLE.Wrench = "stove_wrench"


TIME_TABLE = {}

	TIME_TABLE.Battery = 30
	TIME_TABLE.Wrench = 10

METAL_TABLE = {}

	METAL_TABLE.Battery = 7
	METAL_TABLE.Wrench = 4