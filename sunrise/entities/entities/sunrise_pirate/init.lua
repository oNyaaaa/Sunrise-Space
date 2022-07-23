/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

local PirateChaseVector = Vector(0,50,0)

ENT.Acc = 0.5
ENT.Weap = "Citizen_Laser"
ENT.Speed = 0
ENT.Cargo = {}
ENT.Money = 50
ENT.Shield = 50
ENT.Damage = 5
ENT.DieSize = 2
ENT.aHealth = 50
ENT.NextShot = 0
ENT.MaxCargo = 25
ENT.IsPirate = true
ENT.MaxSpeed = 100
ENT.ShotDelay = 2
ENT.NextShield = 0
ENT.Acceleration = 8

function ENT:Initialize()
	DebugPrint("Pirate Spawned")
	self:SetModel("models/thesunrise/balduran/pirate_frig1.mdl")
	
	self:SetClass(GetRandomPirateShip())
	
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:StartMotionController()
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:EnableGravity(false)
	end
	self.Trail = util.SpriteTrail(self,0,Color(150,150,150,150),false,2,0,1.2,0.125,"trails/physbeam.vmt")
end

function ENT:TakeDMG(a,b)
	a = math.Round(a)
	self.NextShield = CurTime()+10
	if !self.Target and self.Target != self then
		self.Target = b
	end
	if self.Shield > 0 then
		self.Shield = math.Clamp(self.Shield-tonumber(a),0,100)
		return
	end
	self.aHealth = self.aHealth-a
	if self.aHealth <= 0 then
		self:Die(b)
	end
end

function ENT:GiveMoney(a)
	self.Money = self.Money+a
end

function ENT:SetSpeed(a)
	self.Speed = a
end

function ENT:GetSpeed()
	return self.Speed or 0
end

function ENT:GetMaxSpeed()
	return self.MaxSpeed
end

function ENT:Think()
	if self.NextShield <= CurTime() then
		self.Shield = math.Clamp(self.Shield+1,0,100)
		self.NextShield = CurTime()+0.5
	end
	/*if SUNRISE_AIDISABLED then
		self.Target = nil
		return
	end*/
	if !self.Target or !self.Target:IsValid() then
		self:FindTarget()
		return
	end
	if self.Target and self.Target:GetHP() > 0 and !(self.Target.IsDocked and self.Target:IsDocked()) and self.Target:GetPos():Distance(self:GetPos()) < 3000 then
		self:SetSpeed(math.Clamp(self:GetSpeed()+self.Acceleration,0,self.MaxSpeed))
		if self:GetPos():Distance(self.Target:GetPos()) <= CW_GetWeaponRange(self.Weap) then
			self:Shoot(self.Target)
		end
	else
		self:SetSpeed(math.Clamp(self:GetSpeed()-self.Acceleration,0,self.MaxSpeed))
		self.Target = nil
	end
	if self:GetSpeed() <= 0 then
		self:GetPhysicsObject():Sleep()
	else
		self:GetPhysicsObject():Wake()
		//self:GetPhysicsObject():AddVelocity(NilVect)
	end
end

function ENT:FindTarget()
	for _,v in pairs(ents.FindInSphere(self:GetPos(),2300)) do 
		if v.IsShip and v:GetHP() > 0 and !v:IsWarping() and v != self and !v.IsPirate then
			self.Target = v
			break
		end
	end
end

function ENT:IsWarping()
	return false
end

function ENT:GetHP()
	return self.aHealth or 0
end

function ENT:Shoot(ent)
	if ent and ent:IsValid() and self.NextShot <= CurTime() then
		local td = {}
		td.start = self:GetPos()
		td.endpos = ent:GetPos()+Vector(math.random(-self.Acc,self.Acc),math.random(-self.Acc,self.Acc),math.random(-self.Acc,self.Acc))
		td.filter = {self}
		local t = util.TraceLine(td)
		CW_GetFunction(self.Weap)(t,self,self.Damage,ent)
		self.NextShot = CurTime()+self.ShotDelay
	end
end

function ENT:PhysicsUpdate(phys,dtime)
	if !self.Target or !self.Target:IsValid() or self.Target:GetHP() < 1 then return end
	local Pos = self.Target:GetPos()
	local Dist = self:GetPos():Distance(self.Target:GetPos())
	local Ang
	if Dist < 50 then
		Pos = self.Target:LocalToWorld(PirateChaseVector)
		Ang = self.Target:GetAngles()
	end
	Ang = Ang or (Pos-self:GetPos()):Angle()
	phys:Wake()
	local pr = {}
	pr.secondstoarrive	= 20
	pr.pos				= self:GetPos()+self:GetForward()*(self:GetSpeed()/6)
	pr.angle			= Ang
	pr.maxangular		= 5000
	pr.maxangulardamp	= 10000
	pr.maxspeed			= 1000000
	pr.maxspeeddamp		= 10000
	pr.dampfactor		= 0.05
	pr.teleportdistance	= 0
	pr.deltatime		= deltatime
	phys:ComputeShadowControl(pr)
end

function ENT:Die(a)
	local ed = EffectData()  
	ed:SetStart(self:GetForward())  
	ed:SetOrigin(self:GetPos())  
	ed:SetRadius(self.DieSize)
	ed:SetMagnitude(self.DieSize)
	util.Effect("sunrise_playerdeath",ed)
	self:EmitSound("ambient/explosions/explode_9.wav",100,40)
	
	local e = ents.Create("sunrise_wreck")
	e:SetMoney(math.random(2500,5000))
	e:SetPos(self:GetPos())
	e:SetAngles(self:GetAngles())
	e:Spawn()
	e:Activate()
	
	GAMEMODE:NPCKilled(self,a)
	self:Remove()
end

function ENT:SetClass(a)
	self:SetModel(a.Model)
	self.Shield = a.Shield
	self.aHealth = a.Health
	self.Damage = a.Dmg
	self.MaxSpeed = a.MaxSpeed
	self.Acceleration = a.Acceleration
	self.DieSize = a.DieSize
	self.Money = a.Money
end
