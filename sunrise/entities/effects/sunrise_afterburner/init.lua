/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/
local NilVect = Vector(-1)
function EFFECT:Init(data)
	self.Ent = data:GetEntity()
	self.Scale = data:GetScale()
	self.Magnitude = data:GetMagnitude()
	self.LastPos = self.Ent:GetPos()+NilVect
	self:SetRenderBounds(-1*NilVect*100000,NilVect*100000)
end

function EFFECT:Think()
	return self.Ent:IsValid()
end

function EFFECT:Render()
	if self.Ent and self.Ent:IsValid() and self.LastPos != self.Ent:GetPos() then
		self.Emitter = ParticleEmitter(self.Ent:GetPos())
		local part = self.Emitter:Add("sprites/orangeflare1",self.Ent:GetPos())
		part:SetVelocity(self.LastPos-self.Ent:GetPos())
		part:SetDieTime(self.Magnitude)
		part:SetStartAlpha(230)
		part:SetEndAlpha(0)
		part:SetStartSize(self.Scale)
		part:SetEndSize(0)
		part:SetRoll(math.Rand(20,80))
		part:SetRollDelta(math.random(-1,1))
		part:SetColor(0,0,200)
		self.Emitter:Finish()
		self.LastPos = self.Ent:GetPos()
	end
end
