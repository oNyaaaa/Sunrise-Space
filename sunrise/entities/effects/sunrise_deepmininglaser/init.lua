/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

local Laser = Material("trails/physbeam")

function EFFECT:Init(data)
	self.Ent		= data:GetEntity()
	self.EndPos		= data:GetStart()
	self.Time		= CurTime()+3
	self.StartPos	= self.Ent:GetPos()
	self.Emitter	= ParticleEmitter(self.StartPos)
	self:SetRenderBounds(-1*NilVect*100000,NilVect*100000)
	for k=3,9 do
		local part = self.Emitter:Add("particle/light01",self.EndPos)
		part:SetVelocity(ZeroVect)
		part:SetDieTime(4)
		part:SetStartAlpha(math.Rand(230, 250))
		part:SetEndAlpha(0)
		part:SetStartSize((((50-k)*math.Rand(3,4))^1.2)*0.001)
		part:SetEndSize((((60-k)*math.Rand(5,6))^1.2)*0.001)
		part:SetRoll(math.Rand(20,80))
		part:SetRollDelta(math.random(-1,1))
		part:SetColor(0,213,106)
		part:VelocityDecay(true)
	end
end

function EFFECT:Think()
	self.StartPos = self.Ent:GetPos()
	return (self.Time >= CurTime())
end

function EFFECT:Render()
	render.SetMaterial(Laser)  
	render.DrawBeam(self.StartPos,self.EndPos,0.3,0,0,Color(0,213,106,255))
end
