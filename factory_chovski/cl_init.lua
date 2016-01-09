include("shared.lua")

function ENT:Initialize()
	self:initVars()
end

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	local owner = self:Getowning_ent()
	owner = "Owner: " .. (IsValid(owner) and owner:Nick()) or "unknown"

	surface.SetFont("HUDNumber5")
	local text = self.DisplayName
	local TextWidth = surface.GetTextSize(text)
	local TextWidth2 = surface.GetTextSize(owner)
	local TextWidth3 = surface.GetTextSize(self.productionItem)

	Ang:RotateAroundAxis(Ang:Forward(), 90)

	cam.Start3D2D(Pos + (Ang:Up() * 25) + (Ang:Forward() * -40) + (Ang:Right() * -60), Ang, 0.11)
		draw.RoundedBox( 6, -TextWidth - 50, -50, 300, 200, Color( 89, 15, 217, 150 ) )
		draw.DrawText(text, "HUDNumber5", -TextWidth * 0.5, -50, Color(0,0,0,255), TEXT_ALIGN_RIGHT)
		draw.DrawText(owner, "HUDNumber5", -TextWidth * 0.5, -10,  Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)
		draw.DrawText((self.producing and self.productionItem) or "Not Producing", "HUDNumber5", -TextWidth * 0.5, 30, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)
	cam.End3D2D()
end

function ENT:Think()
	return
end

local function CreateMenu()
	-- Menu pops up here
	local Frame = vgui.Create("DFrame")
	Frame:SetPos(5,5)
	Frame:SetSize(600,600)
	Frame:SetTitle("Factory Console")
	Frame:SetVisible(true)
	Frame:SetDraggable(true)
	Frame:ShowCloseButton(true)
	Frame:MakePopup()

end

usermessage.Hook("FactoryUsed", CreateMenu)