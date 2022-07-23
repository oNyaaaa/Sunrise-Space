AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_phx/rt_screen.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:DrawShadow(false)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Sleep()
	end
end

function ENT:SetImage(image)
	self:SetNWString("ImageURL",image)
	DebugPrint("Changed image url to: "..image)
end

function ENT:SetConnect(name, url)
	self:SetNWString("name",name)
	self:SetNWString("url",url)
	DebugPrint("Changed name to: "..name)
	DebugPrint("Changed url to: "..url)
end

function ENT:Use(ply)    
	if ply and ply:IsPlayer() then
		umsg.Start("connect_ads", ply)
			umsg.String( self:GetNWInt(name))
			umsg.String( self:GetNWInt(url))
		umsg.End()
	end
end