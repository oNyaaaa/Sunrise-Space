include('shared.lua')

function ENT:Initialize()
	self.Emitter = ParticleEmitter(self:GetPos())
	self.Body = ClientsideModel(self:GetModel(),RENDERGROUP_TRANSLUCENT)
	self.Body:SetMaterial("Models/effects/vol_light001")
	self.Body:SetPos(self:GetPos()+Vector(0,0,0))
	self:SetParent(self.Body)
end

function ENT:Draw()
	self:DrawModel()
	if self:GetNWBool("SetFlame",false) == false then return end
	self.Body:SetPos(self:GetPos()+Vector(0,0,0))
	local flames = self.Emitter:Add("sprites/glow04_noz",self.Body:GetPos())
	flames:SetVelocity(self:GetForward()*-2)
	flames:SetDieTime(0.1)
	flames:SetStartAlpha(255)
	flames:SetEndAlpha(0)
	flames:SetStartSize(math.random(1,2))
	flames:SetRoll(math.random(0,360))
	flames:SetAirResistance(10)
	flames:SetColor(255,235,215,255)
end