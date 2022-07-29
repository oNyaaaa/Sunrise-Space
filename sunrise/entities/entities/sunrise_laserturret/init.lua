/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

local Vect = Vector(0,0,5)

ENT.Weap = "Citizen_Laser"
ENT.Damage = 50
ENT.NumShots = 1 -- Howmany times we need to shoot.
ENT.ShotDelay = 0.5 -- Delay between shots when we fire multiple shots.
ENT.NextFireDelay = 1 -- The delay between shots.

ENT.NextFire = 0
ENT.IgnoreWarpCollide = true

function ENT:Initialize()
	self:SetModel("models/thesunrise/laserturret.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Sleep()
	end
end

function ENT:Think()
	if !self.Deployer then
		self.Deployer = "Global"
	end
	if !self.Target or !self.Target:IsValid() or self.Target:GetPos():Distance(self:GetPos()) >= 500 then
		self.Target = nil
		self:FindTarget()
		return
	end
	if self.Target:GetPos():Distance(self:GetPos()) < 500 and self.NextFire <= CurTime() then
		//if self.Target.IsPirate == true or self.Target.IsHostile == true then
			self:Shoot(self.Target)
		//end
	end
	self:NextThink(CurTime()+0.1)
end

function ENT:GetHP()
	return self.aHealth or 0
end

function ENT:FindTarget()
	for _,v in pairs(ents.FindInSphere(self:GetPos(),500)) do
		if v.IsPirate or v.IsHostile == true then
			self:SetNWEntity("Ship",v.ent)
			self.Target = self:GetNWEntity("Ship",nil)
			break
		end
	end
end

function ENT:SetWeapon(wep)
	self.Weap = tostring(wep)
end

function ENT:GetWeapon()
	return self.Weap
end

function ENT:KeyValue(k,v)
	if k == "Weapon" then
		self.Weap = v
	end
end

function ENT:Shoot(ent)
	local func = function(a,b,c,d)
		local ed = EffectData()
		ed:SetEntity(d) 
		ed:SetOrigin(b:GetPos())
		ed:SetMagnitude(1.5)
		util.Effect("sunrise_laser",ed)
		self:TakeDMG(self.Target)
		self.Target:EmitSound("sunrise/weapons/laser_0"..tostring(math.random(1,2))..".wav", 100,50)
	end
	if ent and ent:IsValid() and self.NextFire <= CurTime() and type(func) == "function" then
		local td = {}
		td.start = self:GetPos()
		td.endpos = ent:GetPos()
		td.filter = {self}
		local t = util.TraceLine(td)
		for i=1,self.NumShots do
			timer.Simple(i*self.ShotDelay, function() func(t,self,self.Damage,ent) end)
		end
		self.NextFire = CurTime()+(self.NextFireDelay+(self.NumShots/2))
	end
end

function ENT:TakeDMG(a)
	if not IsValid(a) then return end
	a.Health_Ship = a.Health_Ship - 50
	if a.Health_Ship <= 0 then a:Die() end
	return
end

function ENT:Die()
	local ed = EffectData()
	ed:SetOrigin(self:GetPos())
	ed:SetMagnitude(5)
	util.Effect("sunrise_turretdeath",ed)
	self:Remove()
end
