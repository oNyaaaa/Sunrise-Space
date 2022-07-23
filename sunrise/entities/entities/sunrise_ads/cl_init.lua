include("shared.lua")

ENT.RenderGroup = RENDERGROUP_OPAQUE

function ENT:Create_HTML(image)
	image = image or "https://st2.depositphotos.com/1010751/11974/v/600/depositphotos_119743150-stock-illustration-sunrise-logo-design-vector-graphic.jpg"
	self.HTML = vgui.Create("HTML")
	self.HTML:SetSize(1025,513)
	self.HTML:SetHTML([[
		<html>
			<head>
				<style type="text/css">
					body, html{
						padding:0px 0px 0px 0px;
						margin:0px 0px 0px 0px;
						text-align: center;
						vertical-align:100%;
						height:100%;
					}
				</style>
			</head>
			<body scroll="no">
				<img src="]]..image..[[" />
			</body>
		</html>
	]])
   self.HTML:SetPaintedManually(true)
end

function ENT:Set_Image(image)
	image = image or "https://st2.depositphotos.com/1010751/11974/v/600/depositphotos_119743150-stock-illustration-sunrise-logo-design-vector-graphic.jpg"
	self.HTML:SetHTML([[
		<html>
			<head>
				<style type="text/css">
					body, html{
						padding:0px 0px 0px 0px;
						margin:0px 0px 0px 0px;
						text-align: center;
						vertical-align:100%;
						height:100%;
					}
				</style>
			</head>
			<body scroll="no">
				<img src="]]..image..[[" />
			</body>
		</html>
	]])
end

function ENT:Initialize()
	self:Create_HTML()
    self:SetRenderBounds(Vector(-3000,-3000,-3000),Vector(3000,3000,3000))
end

function ENT:OnRemove()
	if self.HTML and self.HTML:IsValid() then
		self.HTML:Remove()
		self.HTML = nil
	end
end

function ENT:Draw()
	self:DrawModel()
	local obbmax = self:OBBMaxs()
	local obbmin = self:OBBMins()
	obbmax.x = obbmax.x-0.79
	obbmax.y = obbmin.y+1.9
	obbmax.z = obbmax.z-7.5
	local pos = self:LocalToWorld(obbmax)
	local ang = self:GetAngles()
    ang:RotateAroundAxis(ang:Right(),-90)
    ang:RotateAroundAxis(ang:Up(),90)
	if self.HTML and self.HTML:IsValid() then
		self.HTML:SetPaintedManually(false)
		cam.Start3D2D(pos,ang,0.0555)
			self.HTML:PaintManual()
		cam.End3D2D()
		self.HTML:SetPaintedManually(true)
		local NWString = self:GetNWString("ImageURL")
		if self.LastImage != NWString then
			self:Set_Image(NWString)
			self.LastImage = NWString
			DebugPrint("Changed the url clientside")
		end
	else
		self:Create_HTML()
	end
end

function ENT:IsTranslucent()
	return true
end
