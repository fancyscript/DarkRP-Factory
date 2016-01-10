ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Factory Metal"
ENT.Author = "Chovski"
ENT.Spawnable = false


function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "price")
	self:NetworkVar("Entity", 0, "owning_ent")
end