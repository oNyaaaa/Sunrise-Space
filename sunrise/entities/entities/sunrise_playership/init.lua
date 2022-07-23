/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
	sunrise_playership\init.lua
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
util.PrecacheSound("dse/ambient/loop_engine_s1.wav")
ENT.PlayerShip = true
ENT.NextWarpCooldownAdd = 0
ENT.NextTargetSelect = 0
ENT.NextShieldCharge = 0
ENT.WarpCooldown = 0
ENT.UnDockTimer = 0
ENT.Upgrades = {}
ENT.NextFire = 0
ENT.NextWarp = 0
ENT.Locked = false
ENT.Cargo = {}


-- Following variables can be changed
ENT.WarpHeatAddition = 0.01 -- The amount of heat added every second.
ENT.ShieldRecharge = 5 -- Shield added every second when not attacked
ENT.Acceleration = 4 -- Acceleration speed
ENT.RotateSpeed = 1 -- Rotate speed.
ENT.ViewHeight = 2 -- The height added to the camara position
ENT.Warpspeed = 800 -- Warpspeed
ENT.WarpDelay = 12 -- Delay between warps.
ENT.MaxShield = 100 -- Maximum shield strength.
ENT.DieSize = 1 -- Explosion size on death.
ENT.MaxHP = 50 -- Maximum health.
ENT.WeaponClass = 0

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
	self:SecondInit()
	
end

function ENT:SecondInit()
	self:StartMotionController()
	self:SetShield(self.MaxShield)
	self:SetHP(self.MaxHP)
	self:SetViewHeight(self.ViewHeight)
	self:SetNWInt("Type",1)
end

function ENT:Think()
	local ply = self:GetPlayer()
	if !ply or !ply:IsValid() then
		self:Remove()
		return
	end
	if ply:Health() <= 0 then
		self:Die()
		return
	end
	if self:GetTarget() then
		if !self:GetTarget():IsValid() then
			self:SetTarget(nil)
		elseif math.ceil((self:GetTarget():GetPos():Distance(self:GetPos()))/SpeedDevider) >= 600 then
			self:SetTarget(nil)
		end
	end
	if !self:IsDocked() then
		if ply:KeyDown(IN_SPEED) then
			if self.NextWarp <= CurTime() then
				self:SetNWBool("Warping",true)
				self:SetSpeed(self.Warpspeed)
			end
		else
			self:SetNWBool("Warping",false)
			if self:GetSpeed() > self:GetMaxSpeed() then
				self:SetSpeed(self:GetMaxSpeed())
			end
		end
		if ply:KeyDown(IN_FORWARD) and !self:IsWarping() then
			self:SetSpeed(math.Clamp(self:GetSpeed()+self.Acceleration,0,self:GetMaxSpeed()))
		end
		if ply:KeyDown(IN_BACK) and !self:IsWarping() then
			if self:GetSpeed() > 0 then
				self:SetSpeed(math.Clamp(self:GetSpeed()-self.Acceleration,0,self:GetMaxSpeed()))
			end
		end
		if ply:KeyDown(IN_USE) and self.NextTargetSelect <= CurTime() then
			local tr = self:GetTrace(2000)
			if tr.Entity and tr.Entity:IsValid() then

				if tr.Entity.PlayerShip == true and tr.Entity:GetPlayer().New == true then
					chat.AddText(ply,Color(50,255,50,0),"You cannot target a player under Newbie protection!")
				else
					if tr.Entity.PlayerShip and ply.New then
						chat.AddText(ply,Color(50,255,50,0),"Your Newbie protection does allow you to target other pilots!")
					else
						self:SetTarget(tr.Entity)
						DebugPrint("Targetted valid entity : "..tostring(tr.Entity))
					end
				end
			else
				DebugPrint("Targetted invalid target : "..tostring(tr.Entity))
			end
			self.NextTargetSelect = CurTime()+0.1
		end
		if ply:KeyDown(IN_ATTACK) and !self:IsWarping() and !self.Locked then
			self:Shoot()
		end
	else
		self:SetHP(self:GetHP()+0.5)
	end
	if self.NextShieldCharge <= CurTime() and !self:IsWarping() then
		self:SetShield(self:GetShield()+self.ShieldRecharge)
		self.NextShieldCharge = CurTime()+0.5
	end
	if self:IsWarping() then
		if self.WarpCooldown >= 30 then -- Warp engine overload.
			self.NextWarp = CurTime()+self.WarpCooldown+10
			self:SetNWBool("Warping",false)
			if self:GetSpeed() > self:GetMaxSpeed() then
				self:SetSpeed(self:GetMaxSpeed())
			end
			self.WarpCooldown = 0
		else
			if self.NextWarpCooldownAdd <= CurTime() then
				self.WarpCooldown = math.Clamp(self.WarpCooldown+self.WarpHeatAddition,2,30)
				self.NextWarpCooldownAdd = CurTime()+1
			end
		end
	elseif self.WarpCooldown > 0 then
		self.NextWarp = CurTime()+self.WarpCooldown
		self.WarpCooldown = 0
	end
	self:NextThink(CurTime()+0.2)
	return true
end

function ENT:SetSpeed(a)
	self:SetNWInt("Speed",a or 0)
end

function ENT:GiveDrone(a)
	return self:GetPlayer():GiveDrone(a)
end

function ENT:SetTarget(targ)
	self:SetNWEntity("Target",targ)
end

function ENT:Shoot()
	if !self:GetTarget() or !self:GetTarget():IsValid() or self:GetTarget():IsWorld() then
		self:GetPlayer():ChatPrint("Select a valid target first.")
		return
	end
	local wep = self:GetSelectedWeapon()
	DebugPrint("Shooting with weapon : "..tostring(CW_GetWeapon(wep)).." ID : "..tostring(wep).." at target : "..tostring(self:GetTarget()))
	if self.NextFire <= CurTime() and CW_GetWeapon(wep) then
		if self:GetTarget():GetPos():Distance(self:GetPos()) <= CW_GetWeaponRange(wep) then
			local a = CW_GetFunction(wep)(self:GetTrace(1000000),self,nil,self:GetTarget())
			if type(a) == "number" then
				self.NextFire = CurTime()+a
			elseif a == true or a == nil then
				self.NextFire = CurTime()+(CW_GetCooldown(wep) or 2)
			else
				self.NextFire = CurTime()+0.05
			end
		end
	end
end

function ENT:PhysicsCollide(data,physobj)
	local ent = data.HitEntity
	if ent and ent.IsPlanet or (self:IsWarping() and !data.HitEntity.IgnoreWarpCollide) then
		self:Die(ent or GetWorldEntity())
	end
end

function ENT:SetViewHeight(a)
	return self:SetNWInt("ViewHeight",a)
end

function ENT:SetPlayer(ply)
	self:SetNWEntity("Player",ply)
	ply:Spectate(OBS_MODE_CHASE)
	ply:SpectateEntity(self)
	ply:SetMoveType(MOVETYPE_OBSERVER)
	ply:SetSolid(SOLID_NONE)
	ply:DrawViewModel(false)
	ply:DrawWorldModel(false)
end

function ENT:TakeDMG(a,b)
	if self:IsDocked() or self.Locked then return false end
	local ed = EffectData()
	ed:SetEntity(self)
	util.Effect("shield",ed)
	GAMEMODE:PlayerShipAttacked(self,b)
	a = math.Round(a)
	self.NextShieldCharge = CurTime()+10
	if self:GetShield() > 0 then
		self:SetShield(self:GetShield()-tonumber(a))
		return
	end
	self:SetHP(self:GetHP()-a)
	if self:GetHP() <= 0 then
		self:Die(b)
	end
end

function ENT:SetShield(a)
	self:SetNWInt("Shield",math.Clamp(a or 0,0,self:GetMaxShield()))
end

function ENT:SetHP(a)
	if a <= 0 then self:Die() end
	self:SetNWInt("Health",math.Clamp(a,0,math.Clamp(a,0,self:GetMaxShield())))
end

function ENT:SetDocked(a)
	if a then
		self:GetPlayer():Dock()
	else
		self:GetPlayer():UnDock()
	end
end

function ENT:CanDock()
	return (self.UnDockTimer <= CurTime() and !self:IsDocked())
end

function ENT:SelectWeapon(a)
	self:SetNWString("SelectedItem",a)
end

function ENT:PhysicsSimulate(phys,deltatime)
	if self.Locked then self.Speed = 0 end
	local ply = self:GetPlayer()
	if !ply or !ply:IsValid() then	
		self:Remove()
		return
	end
	phys:Wake()
	local pr = {}
	if ply:KeyDown(IN_MOVERIGHT) then
		self.DriftVector = self.DriftVector
		self.DriftSpeed = self.DriftSpeed
	else 
		self.DriftVector = self:GetForward()
		self.DriftSpeed = self:GetSpeed()
	end
	pr.secondstoarrive= self.RotateSpeed
	pr.pos= self:GetPos()+self.DriftVector*(self.DriftSpeed/6)
	pr.maxangular		= 5000
	pr.maxangulardamp	= 10000
	pr.maxspeed			= 1000000
	pr.maxspeeddamp		= 10000
	pr.dampfactor		= 0.8
	pr.teleportdistance	= 5000
	pr.deltatime		= deltatime
	pr.angle			= Angle(self:GetAngles().p,self:GetAngles().y,0)
	if ply:KeyDown(IN_ATTACK2) and !self:IsWarping() then
		pr.angle = Angle(ply:GetAimVector():Angle().p,ply:GetAimVector():Angle().y,(self:GetAngles().y-ply:GetAimVector():Angle().y))
	end
	phys:ComputeShadowControl(pr)
end

function ENT:Die(a)
	local ply = self:GetPlayer()
	local e = ents.Create("sunrise_wreck")
	local MoneyLose = math.Round(ply:GetMoney()/10)
	e:SetMoney(MoneyLose)
	ply:SubtractMoney(MoneyLose)
	e:SetCargo(ply.Cargo)
	ply:ResetCargo()
	e:SetPos(self:GetPos())
	e:SetAngles(self:GetAngles())
	e:Spawn()
	e:Activate()
	if self.WreckModel then
		e:SetModel(self.WreckModel)
	end
	local ed = EffectData()  
	ed:SetStart(self:GetForward())  
	ed:SetOrigin(self:GetPos())  
	ed:SetRadius(self.DieSize)
	ed:SetMagnitude(self.DieSize)
	util.Effect("sunrise_playerdeath",ed)
	self:EmitSound("ambient/explosions/explode_9.wav",100,40)
	ply:Spectate(OBS_MODE_CHASE)
	ply:SpectateEntity(e)
	ply:KillSilent()
	self:Remove()
	ply.IsHostile = false
end

function ENT:SetShipClass(a)
	self:SetNWInt("Type",a)
	local Data = GetShipTable(a)
	if !Data or Data == {} then
		Error("Unable to load shipdata for : "..a)
	end
	self.RotateSpeed = Data.Man
	self:SetModel(Data.Model)
	self:SetSkin(Data.Skin)
	self:SetShield(Data.Shield)
	self:SetHP(Data.Health)
	self.Maxspeed = Data.MaxSpeed
	self.Warpspeed = Data.WarpSpeed
	self.Acceleration = Data.Acceleration
	self.WarpHeatAddition = Data.WarpHeatAddition
	self.DieSize = Data.DieSize
	self.WreckModel = Data.WreckModel
	self.WeaponClass = Data.Class
	self:SetNWInt("WepClass",self.WeaponClass) 
end

function ENT:Lock()
	self.Locked = true
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Sleep()
	end
end

function ENT:UnLock()
	self.Locked = false
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:AddUpgrade(upgr)
	if self.Upgrades[upgr.Slot] then
		self.Upgrades[upgr.Slot].Unload(self)
	end
	self.Upgrades[upgr.Slot] = upgr
	self.Upgrades[upgr.Slot].Load(self)
end

function ENT:UnloadSlot(slot)
	self.Upgrades[slot].Unload(self)
	self.Upgrades[slot] = nil
end

function ENT:HasUpgrade(upgr)
	return self.Upgrades[upgr.Slot] == upgr
end

function ENT:WeaponClass()
	return self.WeaponClass
	end