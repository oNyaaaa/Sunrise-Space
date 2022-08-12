include('shared.lua')

function ENT:Initialize()
	self.Emitter = ParticleEmitter(self:GetPos())
end

function ENT:Draw()
	self:DrawModel()
	if self:GetNWBool("SetFlame",false) == false then return end
	local flames = self.Emitter:Add("sprites/glow04_noz",self:GetPos())
	flames:SetVelocity(self:GetForward()*-524)
	if self:GetNWBool("SetFlameLength",false) == true then
		flames:SetStartLength(100)
	else
		flames:SetStartLength(10)
	end
	flames:SetDieTime(0.5)
	flames:SetStartAlpha(255)
	flames:SetEndAlpha(0)
	flames:SetStartSize(math.random(1,2))
	flames:SetRoll(math.random(0,360))
	flames:SetEndSize(0)
	flames:SetAirResistance(100000)
	flames:SetColor(255,235,215,255)
end