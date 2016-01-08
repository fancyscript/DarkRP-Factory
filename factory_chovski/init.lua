AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:StartSound()
	self.sound = CreateSound(self, Sound("")) -- Add a sound file here.
	self.sound:SetSoundLevel(52)
	self.sound:PlayEx(1, 100)
end


function ENT:PostInit()
	-- Stuff to do on factory spawn
	self.metalMax = 10
	self.metalCount = 0
end


local function ENT:Initialize()
	self:initVars()
	self:SetModel(self.model)
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	self:PosInit()
end

function ENT:OnTakeDamage(dmg)
	self:TakePhysicsDamage(dmg)

	self.damage = (self.damage or 500) - dmg:GetDamage()
	if self.damage <= 0 then
		self:Destruct()
		self:Remove()
	end
end


function ENT:Destruct()
	local vPoint = self.GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale:(1)
	util.Effect("Explosion", effectdata)

	if IsValid(self:getowning_ent()) then
		DarkRP.notify(self:Getowning_ent(), 1, 4, "Oh no! Your Factory exploded!")
	end
end


function ENT:OnRemove()
	if self.sound then
		self.sound:Stop()
	end
end


function ENT:Use(activator, caller)
	if (!activator.IsPlayer()) then
		return
	end

	-- Send the umsg to client to pop up a menu
	umsg.Start("FactoryUsed", caller)
	umsg.End()

end


function ENT:Touch(ent)
	local metalEnts = ents:FindByModel("models/gibs/scanner_gib02.mdl") -- Put metal model here

	if(table.HasValue(metalEnts, ent)) then
		
		ent:Remove()

		if (self.metalCount < self.metalMax) then
			self.metalCount += 1
		end

		else
			DarkRP.notify(self:Getowning_ent(), 1, 4, "Your Factory is already full!")
		end

	end
end


function ENT:Produce(item)
	if not item then return end

	-- Start the effects of production
	self:StartSound()
	self.sparking = true

	-- Start a timer for creating the item
	local time = math.random(self.MinTimer, self.MaxTimer) + (self.itemBaseTime or 0)
	timer.Simple(time, function self:CreateItem(item) end)
end


function ENT:CreateItem(item)
	local itemPos = self:GetPos()
	item:SetPos(Vector(itemPos.x, itemPos.y, itemPos.z + 35))
	item.nodupe = true
	item:Spawn()

	self.sparking = false

	if self.sound then
		self.sound:Stop()
	end
end


function ENT:Think()
	if self.sparking then
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetMagnitude(1)
		effectdata:SetScale(1)
		effectdata:SetRadius(2)
		util.Effect("Sparks", effectdata)
	end
end