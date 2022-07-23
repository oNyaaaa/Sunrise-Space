/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_NONE)
	self:SetAngles(Angle(math.Rand(1,360),math.Rand(1,360),math.Rand(1,360)))
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:EnableGravity(false)
		phys:SetVelocity(NilVect)
	end
	self:StartMotionController()
	self.CreateTime = CurTime()+20
	self.Damage = math.random(30,60)
	self.Distance = 15
end

function ENT:SetTarg(e)
	if e and e:IsValid() then
		self.Target = e
	end
end

function ENT:Think()
	if self.CreateTime <= CurTime() then
		self:Explode()
		return
	end
	self:NextThink(CurTime()+0.2)
	return true
end

function ENT:SetDamage(a)
	self.Damage = a
end

function ENT:Explode()
	local pos = self:GetPos()
	for _,v in pairs(ents.FindInSphere(pos,self.Distance)) do
		if v != self:GetOwner() and v:GetOwner() != self:GetOwner() then
			if v.TakeDMG then
				v:TakeDMG(math.random(40,70)-(v:GetPos():Distance(pos)*2),self:GetOwner() or self)
			end
		end
	end
	local ed = EffectData()
	ed:SetOrigin(pos)
	util.Effect("sunrise_pulsemissileexplode",ed)
	self:Remove()
end

function ENT:PhysicsSimulate(phys,deltatime)
	if !self.Target or !self.Target:IsValid() then
		self:Explode()
		return
	end
	phys:Wake()
	local Pos = self.Target:GetPos()
	if Pos:Distance(self:GetPos()) <= math.random(math.Clamp(self.Distance-5,2,100),math.Clamp(self.Distance,3,102)) then
		self:Explode()
	end
	local pr = {}
	pr.secondstoarrive	= 8
	pr.pos				= self:GetPos()+self:GetForward()*30
	pr.maxangular		= 5000
	pr.maxangulardamp	= 10000
	pr.maxspeed			= 1000000
	pr.maxspeeddamp		= 10000
	pr.dampfactor		= 0.05
	pr.teleportdistance	= 0
	pr.deltatime		= deltatime
	pr.angle			= (Pos-self:GetPos()):Angle()
	phys:ComputeShadowControl(pr)
end
