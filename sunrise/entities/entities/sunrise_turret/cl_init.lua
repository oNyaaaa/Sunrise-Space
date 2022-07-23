/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

include('shared.lua')

function ENT:Initialize()
	self:SetModelScale(Vector(2,2,2))
end

function ENT:Draw()
	self:DrawModel()
end
