/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.IP = "192.168.0.101"
ENT.Port = "9337"

function ENT:Initialize()
	self:SetModel("models/thesunrise/balduran/stargate1.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(true)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Sleep()
	end
end

function ENT:Think()
	for _,v in pairs(ents.FindInSphere(self:GetPos(),14)) do
		if v.IsPlayerVessel and v:GetPhysicsObject():GetVelocity():Length() < 1 and (v.LastJumpMenu or 0) <= CurTime() and !v:GetPlayer().JumpCapable then
			v:GetPlayer().JumpCapable = true
			v.LastJumpMenu = CurTime()+20
			v:GetPhysicsObject():Sleep()
			local Adr = self.IP..":"..self.Port
			umsg.Start("sun_openjumpmenu",v:GetPlayer())
				DebugPrint(Adr)
				umsg.String(Adr)
			umsg.End()
		end
	end
end

function ENT:KeyValue(key,val)
	if key == "IP" and CS_IsValidItem(val) then
		self.IP = tostring(val)
	elseif key == "Port" then
		self.Port = tostring(Port)
	end
end
