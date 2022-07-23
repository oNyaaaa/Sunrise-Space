/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

include('shared.lua')

ENT.Mat = Material("effects/sunflare")

function ENT:Draw()
	self:DrawShadow(false)
	render.SetMaterial(self.Mat)
	self.Size = math.Approach(self.Size or 7,math.random(4,11),2)
	render.DrawSprite(self:GetPos(),self.Size,self.Size,Color(255,226,174,240))
end
