include('shared.lua')

function ENT:Initialize()
	self.Emitter = ParticleEmitter(self:GetPos())
end

function ENT:Draw()
	self:DrawModel()
	if self:GetNWBool("SetFlame",false) == false then return end
	local flames = self.Emitter:Add("sprites/glow04_noz",self:GetPos())
	flames:SetVelocity(self:GetForward()*-2)
	flames:SetDieTime(0.1)
	flames:SetStartAlpha(255)
	flames:SetEndAlpha(0)
	flames:SetStartSize(math.random(1,2))
	flames:SetRoll(math.random(0,360))
	flames:SetAirResistance(10)
	flames:SetColor(255,235,215,255)
end