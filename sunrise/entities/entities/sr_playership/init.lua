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
	self.Trail = util.SpriteTrail(self,0,Color(150,150,150,150),false,2,0,1.2,0.125,"trails/physbeam.vmt")
	
end

function ENT:Die(a)
	local ply = self:GetOwner_OfShip()
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


function ENT:Think()
    local ship = self:GetOwner_OfShip()
    local phys = self:GetPhysicsObject()
    if IsValid(ship) and IsValid(phys) then
        if ship:KeyDown(IN_ATTACK2) and not ship:KeyDown(IN_FORWARD) then
            self:SetAngles(ship:EyeAngles())
        end
        if ship:KeyDown(IN_FORWARD) and ship:KeyDown(IN_ATTACK2) then
            self:SetAngles(ship:EyeAngles())
            phys:SetVelocity(self:GetForward() * 100)
        end
        if ship:KeyDown(IN_FORWARD) then
            phys:SetVelocity(self:GetForward() * 100)
        end
        if ship:KeyDown(IN_BACK) then
            local phys = self:GetPhysicsObject()
            phys:SetVelocity(self:GetForward() * 0)
        end
    end
    
end

