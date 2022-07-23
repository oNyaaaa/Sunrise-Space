/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Resource = "Minerals"
ENT.Difficulty = 6

function ENT:Initialize()
	self:SetModel("models/thesunrise/balduran/roid"..math.random(1,6)..".mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(true)
	local ed = EffectData()
	ed:SetEntity(self)
	util.Effect("sunrise_asteroidcloud",ed)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Sleep()
	end
end

function ENT:KeyValue(key,val)
	if key == "Resource" then
		self.Resource = val
	elseif key == "Difficulty" then
		self.Difficulty = math.Clamp(tonumber(val),0,14)
	elseif key == "Color" then
		local col = string.Explode(" ",tostring(val))
		self:SetColor(col[1] or 255,col[2] or 255,col[3] or 255,255)
	end
end

function ENT:GetDifficulty()
	return self.Difficulty or 8
end

function ENT:GetResource()
	return self.Resource or "Minerals"
end
