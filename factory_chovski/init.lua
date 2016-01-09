AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
 
function ENT:Initialize() -- Init the ent first
    self:initVars()
    self:SetModel(self.model)
    self:SetUseType(SIMPLE_USE)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    phys:Wake()
end
 
function ENT:StartSound()
	self.sound = CreateSound(self, Sound("ambient/levels/labs/equipment_printer_loop1.wav"))
    self.sound:SetSoundLevel(60)
    self.sound:PlayEx(1, 100)
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
    effectdata:SetScale(1)
    util.Effect("Explosion", effectdata)
    DarkRP.notify(self:Getowning_ent(), 1, 4, "Oh no! Your Factory exploded!") -- If ent exist player is valid
end
 
function ENT:AcceptInput( Name, Activator, Caller )	

	if Name == "Use" and Caller:IsPlayer() then
		
		umsg.Start("FactoryUsed", Caller) -- Prepare the usermessage to that same player to open the menu on his side.
		umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
		
	end
	
end
 
function ENT:Touch(ent)
    if(not self.touchCooldown) then
	    if(ent:GetModel() == self.metalModel) then
	    	self.touchCooldown = true
	        if (self.metalCount < self.metalMax) then
	        	ent:Remove()
	            self.metalCount = self.metalCount + 1
	            DarkRP.notify(self:Getowning_ent(), 1, 4, "Metal added to Factory! (" .. self.metalCount .. "/" .. self.metalMax .. ")")
	  		else
	        	DarkRP.notify(self:Getowning_ent(), 1, 4, "Your Factory is already full!")
	    	end
	    end
	    timer.Simple(3, function() self.touchCooldown = false end)
	end
end
 
function ENT:Produce(item)
    if not item then return end
 
    -- Start the effects of production
    self:StartSound()
    self.sparking = true
 
    -- Start a timer for creating the item
    local time = math.random(self.MinTimer, self.MaxTimer) + (self.itemBaseTime or 0)
    timer.Simple(time, function() self:CreateItem(item) end)
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
    else 
    	return
    end
end
 
function ENT:OnRemove() -- always remove at the end
    if self.sound then
        self.sound:Stop()
    end
end