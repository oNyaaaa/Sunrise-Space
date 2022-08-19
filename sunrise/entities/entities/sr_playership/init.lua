AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/thesunrise/balduran/shuttle1-1.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:EnableGravity(false)
	end
	//self.Trail = util.SpriteTrail(self,0,Color(150,150,150,150),false,2,0,1.2,0.125,"trails/physbeam.vmt")
	self:SetNWFloat("Health",100)
end

function ENT:TakeDMG(a)
	self:SetNWFloat("Health",self:GetNWFloat("Health")-a)
	if tonumber(self:GetNWFloat("Health")) <= 0 then
		self:Die(b)
	end
end

function ENT:Die()
	local ply = self:GetOwner_OfShip()
	if not IsValid(ply) then return end
	local e = ents.Create("sunrise_wreck")
	//local MoneyLose = math.Round(ply:GetMoney()/10)
	//e:SetMoney(MoneyLose)
	//ply:SubtractMoney(MoneyLose)
	//e:SetCargo(ply.Cargo)
	//ply:ResetCargo()
	e:SetPos(self:GetPos())
	e:SetAngles(self:GetAngles())
	e:Spawn()
	e:Activate()
	//if self.WreckModel then
	//	e:SetModel(self.WreckModel)
	//end
	local ed = EffectData()  
	ed:SetStart(self:GetForward())  
	ed:SetOrigin(self:GetPos())  
	ed:SetRadius(1)
	ed:SetMagnitude(1)
	util.Effect("sunrise_playerdeath",ed)
	self:EmitSound("ambient/explosions/explode_9.wav",100,40)
	ply:Spectate(OBS_MODE_CHASE)
	ply:SpectateEntity(e)
	ply:KillSilent()
	self:Remove()
	ply.IsHostile = false
end

function ENT:PhysicsCollide(data,physobj)
	local ent = data.HitEntity
	if ent then
		self:Die(ent or GetWorldEntity())
	end
end

local Mins = Vector(-9,-10,-5)
local Maxs = Vector(27,6,5)

function ENT:GetTrace(a)
	if (a or -1) <= 0 then return {} end
	local ply = self:GetOwner_OfShip()
	local td = {}
	td.start = (self:GetPos()+ply:GetAimVector():GetNormalized()*-1)+Vector(0,0,2)
	td.endpos = self:GetPos()+(ply:GetAimVector()*(a or 500))
	td.filter = {ply,self}
	td.mins = Mins
	td.maxs = Maxs
	return util.TraceHull(td)
end

function ENT:Think()
	
	for _,v in pairs(ents.FindInSphere(self:GetPos(),500)) do
		if v:GetClass() == "sunrise_wreck" then
			v:Remove()
		end
	end
    local ship = self:GetOwner_OfShip()
    local phys = self:GetPhysicsObject()
	if ship:GetNWBool("Docked",false) == true then
		phys:SetVelocity(self:GetForward() * 0)
        return
    end
    if IsValid(ship) and IsValid(phys) then
		if ship:KeyDown(IN_ATTACK) then
			WepShoot(self,ship)
		end
		if ship:KeyDown(IN_USE) then
			local trg = self:GetTrace(10000)
			if trg.Entity && IsValid(trg.Entity) then
				ship:SetNWEntity("LockedOnTarg",trg.Entity)
			end	
		end
		if ship:KeyDown(IN_SPEED) and ship:KeyDown(IN_ATTACK2) then
			phys:SetVelocity(self:GetForward() * 200)
			self:SetAngles(ship:EyeAngles())
			self:SetNWBool("SetFlame",true)
			self:SetNWBool("SetFlameLength",true)
			return
		end
		if ship:KeyDown(IN_SPEED) then
			phys:SetVelocity(self:GetForward() * 200)
			//self:SetAngles(ship:EyeAngles())
			self:SetNWBool("SetFlame",true)
			self:SetNWBool("SetFlameLength",true)
			return
		end
        if ship:KeyDown(IN_ATTACK2) and not ship:KeyDown(IN_FORWARD) then
            self:SetAngles(ship:EyeAngles())
			self:SetNWBool("SetFlame",false)
			self:SetNWBool("SetFlameLength",false)
        end
        if ship:KeyDown(IN_FORWARD) and ship:KeyDown(IN_ATTACK2) then
            self:SetAngles(ship:EyeAngles())
            phys:SetVelocity(self:GetForward() * 100)
			self:SetNWBool("SetFlame",true)
			self:SetNWBool("SetFlameLength",false)
        end
        if ship:KeyDown(IN_FORWARD) then
            phys:SetVelocity(self:GetForward() * 100)
			self:SetNWBool("SetFlame",true)
			self:SetNWBool("SetFlameLength",false)
        end
        if ship:KeyDown(IN_BACK) then
            phys:SetVelocity(self:GetForward() * 0)
			self:SetNWBool("SetFlame",false)
			self:SetNWBool("SetFlameLength",false)
        end
    end
    
end

