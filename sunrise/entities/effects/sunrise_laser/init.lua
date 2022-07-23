/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

local Laser = Material("trails/physbeam")

function EFFECT:Init(data)
	self.Ent		= data:GetEntity()
	if !self.Ent then return end
	self.StartPos	= self.Ent:GetPos()
	self.ExpPos		= data:GetOrigin()
	self.Scale		= data:GetMagnitude()/1000
	self.Emitter	= ParticleEmitter(self.ExpPos)
	self.Time		= CurTime()+1
	self.Size		= self.Time-CurTime()
	self:SetRenderBounds(-1*NilVect*100000,NilVect*100000)
	for i=3,9 do
		local part = self.Emitter:Add("particle/light01",self.ExpPos)
		part:SetVelocity(ZeroVect)
		part:SetDieTime(4)
		part:SetStartAlpha(math.Rand(230, 250))
		part:SetEndAlpha(0)
		part:SetStartSize((((90-i)*math.Rand(3,4))^1.2)*self.Scale)
		part:SetEndSize((((100-i)*math.Rand(5,6))^1.2)*self.Scale)
		part:SetRoll(math.Rand(20,80))
		part:SetRollDelta(math.random(-1,1))
		part:SetColor(255,226,174)
		part:VelocityDecay(true)
	end
	local part2 = self.Emitter:Add("effects/sunflare",self.ExpPos)
	part2:SetDieTime(3)
	part2:SetStartAlpha(math.Rand(230,250))
	part2:SetStartSize(3800*self.Scale)
	part2:SetEndSize(50*self.Scale)
	part2:SetColor(255,226,174)
end

function EFFECT:Think()
	if self.Ent and self.Ent:IsValid() then
		self.StartPos = self.Ent:GetPos()
	else
		return false
	end
	self.Size = self.Time-CurTime()
	return (self.Time >= CurTime())
end

function EFFECT:Render()
	if !self.Ent then return end
	render.SetMaterial(Laser) 
	render.DrawBeam(self.StartPos,self.ExpPos,0.3,0,0,Color(255,255,122.5,255))
end
