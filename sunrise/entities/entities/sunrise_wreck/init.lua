/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Cargo = {}
ENT.MaxCargo = -1
ENT.IgnoreWarpCollide = true

function ENT:Initialize()
	self:SetModel("models/thesunrise/balduran/shuttle2_wreck.mdl")
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE) 
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Sleep()
		phys:EnableMotion(false)
	end
end

function ENT:Think()
	for _,v in pairs(ents.FindInSphere(self:GetPos(),10)) do
		if v.IsPlayerVessel then
			
			if self:GetMoney() != 0 then
				v:GetPlayer():AddMoney(tonumber(self.Money))
			end
			
			for k,a in pairs(self:GetCargo()) do
				v:GetPlayer():AddItem(k, a)
			end
			
			local ed = EffectData()
			ed:SetOrigin(self:GetPos())
			ed:SetStart(self:GetPos())
			ed:SetScale(3)
			ed:SetMagnitude(1)
			util.Effect("sunrise_wreckpickup",ed)
			self:Remove()
			return
		end
	end
	self:NextThink(CurTime()+0.4)
	return true
end

function ENT:SetCargo(a)
	self.Cargo = a or {}
end

function ENT:GetCargo(a)
	return self.Cargo or {}
end

function ENT:SetMoney(am)
	self.Money = tonumber(am)
end

function ENT:GetMoney()
	return self.Money or 0
end
