/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

ENT.Base			= "base_ai" 
ENT.Type			= "ai"
ENT.Author			= "Sunrise team"
ENT.Category		= "SNPCs"
ENT.PrintName		= "Dockingmanager"
ENT.Spawnable		= false
ENT.AdminSpawnable	= false

ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance(bUsingAnim)
	self.AutomaticFrameAdvance = bUsingAnim
end
