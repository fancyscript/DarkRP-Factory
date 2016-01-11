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

    self.touchCooldown = false
    self.damage = 500
    self.sparking = false
    self.producing = false

    local phys = self:GetPhysicsObject()
    phys:Wake()

    self:SetproductionItem(PRODUCTION_TABLE.Battery)
    timer.Simple(0.5, function() self:Produce() end)
end
 
function ENT:StartSound()
	self.sound = CreateSound(self, Sound("vehicles/v8/v8_start_loop1.wav"))
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
    local vPoint = self:GetPos()
    local effectdata = EffectData()
    effectdata:SetStart(vPoint)
    effectdata:SetOrigin(vPoint)
    effectdata:SetScale(1)
    util.Effect("Explosion", effectdata)
    DarkRP.notify(self:Getowning_ent(), 1, 4, "Oh no! Your Factory exploded!") -- If ent exist player is valid
end
 
function ENT:Use( Activator, Caller )	

	if Activator:IsPlayer() then
        if not self.producing then
            self:Produce()
        end
		--umsg.Start("FactoryUsed", Caller)
		--umsg.End()
		
	end
	
end
 
function ENT:Touch(ent)
    if(not self.touchCooldown) then
	    if(ent:GetClass() == self.metalClass) then
	    	self.touchCooldown = true
	        if (self:GetmetalCount() < self:GetmetalMax()) then
	        	ent:Remove()
	            self:SetmetalCount(self:GetmetalCount() + 1)
	            DarkRP.notify(self:Getowning_ent(), 0, 4, "Metal added to Factory! (" .. self:GetmetalCount() .. "/" .. self:GetmetalMax() .. ")")
	  		else
	        	DarkRP.notify(self:Getowning_ent(), 1, 4, "Your Factory is already full!")
	    	end
	    end
	    timer.Simple(3, function() self.touchCooldown = false end)
	end
end
 
function ENT:Produce()

    self.producing = true

    -- Check metal count
    local metalCount = self:GetmetalCount()
    local metalCost = self:GetmetalCost()

    if(metalCount < metalCost) then
        DarkRP.notify(self:Getowning_ent(), 1, 4, "Not enough metal to produce!")
        self:SetableToProduce(false)
        self.producing = false
        return
    end
    -- Start the effects of production
    self:StartSound()
    self.sparking = true
 
    -- Start a timer for creating the item
    local time = math.random(self.MinTimer, self.MaxTimer) + (self.itemBaseTime)
    timer.Simple(time, function() self:CreateItem(self:GetproductionItem()) end)

    
end
 
function ENT:CreateItem(ent)

    self:SetmetalCount(self:GetmetalCount() - self:GetmetalCost())
    local itemPos = self:GetPos()
    local item = ents.Create(ent)
    item:SetPos(Vector(itemPos.x - 4, itemPos.y - 2, itemPos.z + 72))
    item.nodupe = true
    item:Spawn()
 
    self.sparking = false
    self.producing = false
 
    if self.sound then
        self.sound:Stop()
    end

    self:Produce()

end
 
function ENT:Think()
	
    if self.sparking then
        local effectdata = EffectData()
        local effectPos = self:GetPos()
        effectdata:SetOrigin(Vector(effectPos.x - 7, effectPos.y - 2, effectPos.z + 72))
        effectdata:SetMagnitude(1)
        effectdata:SetScale(1)
        effectdata:SetRadius(2)
        util.Effect("SMOKE", effectdata)
    end

    if not self.producing then

        if(self:GetproductionItem() == PRODUCTION_TABLE.Battery) then
            self:SetproductionID("Batteries")
            self.itemBaseTime = TIME_TABLE.Battery
            self:SetmetalCost(METAL_TABLE.Battery)
        elseif(self:GetproductionItem() == PRODUCTION_TABLE.Wrench) then
            self:SetproductionID("Wrenches")
            self.itemBaseTime = TIME_TABLE.Wrench
            self:SetmetalCost(METAL_TABLE.Wrench)
        else
            return
        end
    end
end
 
function ENT:OnRemove() -- always remove at the end
    if self.sound then
        self.sound:Stop()
    end
end

----------------------------------------------------------
-- Receiving input from client (not used right now)
----------------------------------------------------------

util.AddNetworkString("SetProduction")

net.Receive("SetProduction", function(len, ply)
	sentFactory = net.ReadEntity()
	if (IsValid(ply) and IsValid(sentFactory)) then
		sentFactory:SetproductionItem(net.ReadString())
        sentFactory:NextThink()
		timer.Simple(0.5, DarkRP.notify(ply, 1, 4, "Production set to " .. sentFactory:GetproductionID()))
	end
end)

---------------------------------------------------------------------------------------------------------------------

util.AddNetworkString("StartProduction")

net.Receive("StartProduction", function(len, ply)
    sentFactory = net.ReadEntity()
    if IsValid(ply) and IsValid(sentFactory) then
        sentFactory:SetableToProduce(true)
        while(sentFactory:GetableToProduce()) do
            sentFactory:Produce()
        end
    end
end)