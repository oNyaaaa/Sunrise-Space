/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

ENT.Type				= "anim"
ENT.Base				= "base_anim"
ENT.Author				= "Sunrise team"
ENT.Purpose				= "For the Sunrise gamemode"
ENT.Contact				= "PM one of the sunrise member on FP"
ENT.PrintName			= "Player ship"
ENT.Category			= "Sunrise"
ENT.Spawnable			= false
ENT.AdminSpawnable		= false

ENT.IgnoreWarpCollide = true
ENT.IsPlayerVessel = true
ENT.IsShip = true

local Mins = Vector(-9,-10,-5)
local Maxs = Vector(27,6,5)

function ENT:GetTrace(a)
	if (a or -1) <= 0 then return {} end
	local ply = self:GetPlayer()
	local td = {}
	td.start = (self:GetPos()+ply:GetAimVector():GetNormal()*-self:GetViewDistance())+Vector(0,0,self:GetViewHeight())
	td.endpos = self:GetPos()+(ply:GetAimVector()*(a or 500))
	td.filter = {ply,self}
	td.mins = Mins
	td.maxs = Maxs
	return util.TraceHull(td)
end

function ENT:GetPlayer()
	return self:GetNWEntity("Player")
end

function ENT:GetShield()
	return self:GetNWInt("Shield",0)
end

function ENT:GetMaxShield()
	return GetShipTable(self:GetType()).Shield
end

function ENT:GetHP()
	return self:GetNWInt("Health",0) or 0
end

function ENT:GetMaxHP()
	return GetShipTable(self:GetType()).Health
end

function ENT:IsDocked()
	return self:GetPlayer():IsDocked()
end

function ENT:IsWarping()
	return (self:GetNWBool("Warping",false) and self:GetSpeed() > self:GetMaxSpeed())
end

function ENT:GetSelectedWeapon()
	return self:GetNWString("SelectedItem")
end

function ENT:GetViewDistance()
	return GetShipTable(self:GetType()).ViewDistance
end

function ENT:GetSpeed()
	return self:GetNWInt("Speed",0)
end

function ENT:GetMaxSpeed()
	return GetShipTable(self:GetType()).MaxSpeed
end

function ENT:GetType()
	return self:GetNWInt("Type")
end

function ENT:GetDrone()
	return self:GetPlayer():GetDrone()
end

function ENT:GetMaxCargo()
	return GetShipTable(self:GetType()).CargoSize
end

function ENT:GetViewHeight()
	return self:GetNWInt("ViewHeight") or 0
end

function ENT:GetTarget()
	return self:GetNWEntity("Target")
end

function ENT:WeaponClass()
	return self:GetNWInt("WeaponClass")
end