ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Factory"
ENT.Author = "Chovski"
ENT.Spawnable = false

function ENT:initVars()
	self.model = "models/props_vehicles/generatortrailer01.mdl"
	self.metalModel = "models/gibs/scanner_gib02.mdl"
	self.metalCount = 0
	self.metalMax = 10
	self.touchCooldown = false
	self.damage = 500
	self.sparking = false
	self.producing = false
	self.productionItem = ""
	self.DisplayName = "Factory"
	self.MinTimer = 100
	self.MaxTimer = 300
	self.SeizeReward = 1000
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "price")
	self:NetworkVar("Entity", 0, "owning_ent")
end
