/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

function EFFECT:Init(data)
	self.StartPos	= data:GetOrigin()
	self.Scale		= 0.01
	self.Emitter	= ParticleEmitter(self.StartPos)
	self:SetModel(Model("models/zup/shields/1024_shield.mdl"))
	self:SetPos(self.StartPos)
	self:SetRenderBounds(-1*NilVect*100000,NilVect*100000)
	for i=3,9 do
		local part = self.Emitter:Add("particle/light01",self.StartPos)
		part:SetVelocity(ZeroVect)
		part:SetDieTime(1)
		part:SetStartAlpha(math.Rand(230, 250))
		part:SetEndAlpha(0)
		part:SetStartSize((((90-i)*math.Rand(3,4))^1.2)*self.Scale)
		part:SetEndSize((((100-i)*math.Rand(5,6))^1.2)*self.Scale)
		part:SetRoll(math.Rand(20,80))
		part:SetRollDelta(math.random(-1,1))
		part:SetColor(50,65,252)
		part:VelocityDecay(true)
	end
	local part2 = self.Emitter:Add("effects/sunflare",self.StartPos)
	part2:SetDieTime(0.5)
	part2:SetStartAlpha(math.Rand(230,250))
	part2:SetStartSize(3800*self.Scale)
	part2:SetEndSize(50*self.Scale)
	part2:SetColor(50,65,252)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
