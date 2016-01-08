include("shared.lua")

function ENT:Initialize()
	self:initVars()
end

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	local owner = self:Getowning_ent()
	owner = (IsValid(owner) and owner:Nick()) or "unknown"

	surface.SetFont("HUDNumber5")
	local text = self.DisplayName
	local TextWidth = surface.GetTextSize(text)
	local TextWidth2 = surface.GetTextSize(owner)
	local TextWidth3 = surface.GetTextSize(self.productionItem)

	Ang:RotateAroundAxis(Ang:Up(), 90)

	cam.Start3D2D(Pos + Ang:Up() * 11.5, Ang, 0.11)
		draw.WordBox(2, -TextWidth * 0.5, -30, text, "HUDNumber5", Color(140, 0, 0, 100), Color(255, 255, 255, 255))
		draw.WordBox(2, -TextWidth2 * 0.5, 18, owner, "HUDNumber5", Color(140, 0, 0, 100), Color(255, 255, 255, 255))
		draw.WordBox(2, -TextWidth3 * 0.5, 18, owner, "HUDNumber5", Color(140, 0, 0, 100), Color(255, 255, 255, 255))
	cam.End3D2D()
end

function ENT:Think()
	
end

local function CreateMenu()
	-- Menu pops up here
	return
end

usermessage.Hook("FactoryUsed", CreateMenu())