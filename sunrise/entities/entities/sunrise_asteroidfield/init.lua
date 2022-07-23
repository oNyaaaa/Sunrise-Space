/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Ents = {}
ENT.Amount = 10
ENT.Radius = 1000
ENT.Resource = "Minerals"
ENT.Difficulty = 6

function ENT:Initialize()
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Sleep()
	end
	self:CreateAsteroids()
end

function ENT:CreateAsteroids()
	for _,v in pairs(self.Ents) do
		if v and v:IsValid() then
			v:Remove()
		end
	end
	self.Ents = {}
	for i=1,self.Amount or 10 do
		if self.Ents[i] and self.Ents[i]:IsValid() then
			self.Ents[i]:Remove()
		end
		self.Ents[i] = ents.Create("sunrise_asteroid")
		self.Ents[i]:SetPos(self:GetPos()+Vector(math.Rand(self.Radius,-self.Radius),math.Rand(self.Radius,-self.Radius),math.Rand(self.Radius,-self.Radius)))
		self.Ents[i]:SetAngles(Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)))
		self.Ents[i]:Spawn()
		self.Ents[i]:Activate()
		self.Ents[i]:KeyValue("Resource",self.Resource)
		self.Ents[i]:KeyValue("Difficulty",self.Difficulty)
	end
end

function SIM_IsValidItem(i)
	if i != nil and i != NULL then
		return i
	end
	return NULL
end

function ENT:KeyValue(key,val)
	if key == "Resource" and SIM_IsValidItem(val) then
		self.Resource = val
	elseif key == "Difficulty" then
		self.Difficulty = math.Clamp(tonumber(val),0,14)
	elseif key == "Radius" then
		self.Radius = tonumber(val)
	elseif key == "Amount" then
		self.Amount = tonumber(val)
	elseif key == "Color" then
		//print(key,val)
		local col = string.Explode(" ",tostring(val))
			self:SetColor(Color(col[1] or 255,col[2] or 255,col[3] or 255,255))
		//else
		//	self:SetColor(255,255,255,255)
		//end
	end
end
