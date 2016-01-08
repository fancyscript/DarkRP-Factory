ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Factory"
ENT.Author = "Chovski"
ENT.Spawnable = false

function ENT:initVars()
	self.model = "models/Items/battery.mdl"
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
