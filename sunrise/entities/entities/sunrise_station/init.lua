/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.IgnoreWarpCollide = true

function ENT:Initialize()
	self:SetModel("models/thesunrise/mainstation.mdl")
	--self:SetModel("models/thesunrise/ts_spacestation.mdl") -- Somehow this model is invisible.
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Sleep()
	end
end

function ENT:Think()
	for _, v in pairs(ents.FindInSphere(self:GetPos(),60)) do
		if v.IsPlayerVessel and v:GetPhysicsObject():GetVelocity():Length() < 1 and v:CanDock() and !v.WantsToDock and v:GetPlayer() and v:GetPlayer():IsValid() then
			v.WantsToDock = true
			--v:GetPlayer():ConCommand("sun_opendockmenu")
			umsg.Start("sun_opendockmenu",v:GetPlayer())
			umsg.End()
		end
	end
	self:NextThink(CurTime()+1)
end
