/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

include('shared.lua')

function ENT:Initialize()
	self:SetModelScale(self:GetModelScale() * 2,0.1)
end

function ENT:Draw()
	self:DrawModel()
end
