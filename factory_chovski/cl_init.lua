include("shared.lua")

function ENT:Initialize()
	self:initVars()
end

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	local owner = self:Getowning_ent()
	owner = "Owner: " .. ((IsValid(owner) and owner:Nick()) or "unknown")

	surface.SetFont("HUDNumber5")
	local text = self.DisplayName
	local TextWidth = surface.GetTextSize(text)
	local TextWidth2 = surface.GetTextSize(owner)
	local TextWidth3 = surface.GetTextSize(self:GetproductionID())

	Ang:RotateAroundAxis(Ang:Forward(), 90)

	cam.Start3D2D(Pos + (Ang:Up() * 25) + (Ang:Forward() * -30) + (Ang:Right() * -60), Ang, 0.11)
		draw.RoundedBox( 6, -TextWidth * 2.75, -50, 300, 200, Color( 89, 15, 217, 150 ) )
		draw.DrawText(text, "HUDNumber5", -TextWidth, -50, Color(0,0,0,255), TEXT_ALIGN_CENTER)
		draw.DrawText(owner, "HUDNumber5", -TextWidth, -10,  Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)
		draw.DrawText(("Product: " .. self:GetproductionID()), "HUDNumber5", -TextWidth, 30, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)
		draw.DrawText(("Metal: " .. self:GetmetalCount()), "HUDNumber5", -TextWidth, 70, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)
		draw.DrawText(("Required: " .. ((self:GetmetalCost() - self:GetmetalCount() > -1 and self:GetmetalCost() - self:GetmetalCount()) or 0)), "HUDNumber5", -TextWidth, 110, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)
	cam.End3D2D()
end

function ENT:Think()
	return
end

local function CreateMenu()
	-- Menu pops up here
	local Frame = vgui.Create("DFrame")
	Frame:SetSize(500,300)
	Frame:SetPos(ScrW()*0.33, ScrH()*0.33)
	Frame:SetTitle("Factory Console")
	Frame:SetVisible(true)
	Frame:SetDraggable(true)
	Frame:ShowCloseButton(true)
	Frame:MakePopup()

	local ProductionLabel = vgui.Create("DLabel", Frame)
	ProductionLabel:SetPos(40,40)
	ProductionLabel:SetText("Choose Item to Produce:")
	ProductionLabel:SizeToContents()

	local BatteryButton = vgui.Create("DButton", Frame)
	BatteryButton:SetText("Printer Batteries")
	BatteryButton:SetPos(40,80)
	BatteryButton:SetSize(150,50)

	BatteryButton.DoClick = function()
		net.Start("SetProduction")
		net.WriteEntity(self)
		net.WriteString("printer_battery")
		net.SendToServer()
	end

	local WrenchButton = vgui.Create("DButton", Frame)
	WrenchButton:SetText("Stove Wrenches")
	WrenchButton:SetPos(210,80)
	WrenchButton:SetSize(150,50)

	WrenchButton.DoClick = function()
		net.Start("SetProduction")
		net.WriteEntity(self)
		net.WriteString("stove_wrench")
		net.SendToServer()
	end

	local ProduceButton = vgui.Create("DButton", Frame)
	ProduceButton:SetText("Produce!")
	ProduceButton:SetPos(80, 150)
	ProduceButton:SetSize(200, 20)

	ProduceButton.DoClick = function()
		net.Start("StartProduction")
		net.WriteEntity(self)
		net.SendToServer()
	end

end

--usermessage.Hook("FactoryUsed", CreateMenu)