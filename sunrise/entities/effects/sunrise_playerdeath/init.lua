/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

function EFFECT:Init(data)
	self.StartPos	= data:GetOrigin()
	self.Scale		= data:GetMagnitude()/25
	self.Emitter	= ParticleEmitter(self.StartPos)	
	self:SetRenderBounds(-1*-Vector(0.1)*100000,-Vector(0.1)*100000)
	for i=1,360 do
		for k=22,22 do
			local part = self.Emitter:Add("particle/Explode"..math.random(1,2),self.StartPos)
			local dir = (i-180)
			part:SetVelocity(Vector(math.cos(dir),math.sin(dir),0)*k*self.Scale*3)
			part:SetDieTime(7)
			part:SetStartAlpha(math.Rand(230, 250))
			part:SetEndAlpha(0)
			part:SetStartSize(30*self.Scale)
			part:SetEndSize(0)
			part:SetRoll(math.Rand(20,80))
			part:SetRollDelta(math.random(-1,1))
			part:SetColor(100,150, 255)
			local part1 = self.Emitter:Add("sprites/orangeflare1",self.StartPos)
			part1:SetVelocity(Vector(math.cos(dir),math.sin(dir),0)*k*self.Scale*3)
			part1:SetDieTime(5)
			part1:SetStartAlpha(math.Rand(230, 250))
			part1:SetEndAlpha(0)
			part1:SetStartSize(100*self.Scale)
			part1:SetEndSize(0)
			part1:SetRoll(math.Rand(20,80))
			part1:SetRollDelta(math.random(-1,1))
			part1:SetColor(0,0,255)
		end
	end
	for i=1,360 do
		for k=22,22 do
			local part = self.Emitter:Add("particle/Explode"..math.random(1,2),self.StartPos)
			local dir = (i-180)
			part:SetVelocity(Vector(math.sin(dir),math.cos(dir),math.cos(dir))*k*self.Scale*3)
			part:SetDieTime(7)
			part:SetStartAlpha(math.Rand(230, 250))
			part:SetEndAlpha(0)
			part:SetStartSize(30*self.Scale)
			part:SetEndSize(0)
			part:SetRoll(math.Rand(20,80))
			part:SetRollDelta(math.random(-1,1))
			part:SetColor(100,150, 255)
			local part1 = self.Emitter:Add("sprites/orangeflare1",self.StartPos)
			part1:SetVelocity(Vector(math.sin(dir),math.cos(dir),math.cos(dir))*k*self.Scale*3)
			part1:SetDieTime(5)
			part1:SetStartAlpha(math.Rand(230, 250))
			part1:SetEndAlpha(0)
			part1:SetStartSize(100*self.Scale)
			part1:SetEndSize(0)
			part1:SetRoll(math.Rand(20,80))
			part1:SetRollDelta(math.random(-1,1))
			part1:SetColor(0,0,255)
		end
	end
	for i=1,360 do
		for k=22,22 do
			local part = self.Emitter:Add("particle/Explode"..math.random(1,2),self.StartPos)
			local dir = (i-180)
			part:SetVelocity(Vector(math.sin(dir),math.cos(dir),math.sin(dir))*k*self.Scale*3)
			part:SetDieTime(7)
			part:SetStartAlpha(math.Rand(230, 250))
			part:SetEndAlpha(0)
			part:SetStartSize(30*self.Scale)
			part:SetEndSize(0)
			part:SetRoll(math.Rand(20,80))
			part:SetRollDelta(math.random(-1,1))
			part:SetColor(100,150, 255)
			local part1 = self.Emitter:Add("sprites/orangeflare1",self.StartPos)
			part1:SetVelocity(Vector(math.sin(dir),math.cos(dir),math.sin(dir))*k*self.Scale*3)
			part1:SetDieTime(5)
			part1:SetStartAlpha(math.Rand(230, 250))
			part1:SetEndAlpha(0)
			part1:SetStartSize(100*self.Scale)
			part1:SetEndSize(0)
			part1:SetRoll(math.Rand(20,80))
			part1:SetRollDelta(math.random(-1,1))
			part1:SetColor(0,0,255)
		end
	end
	for i=1, 1 do
		local part2 = self.Emitter:Add("effects/sunflare",self.StartPos)
		part2:SetDieTime(3)
		part2:SetStartAlpha(math.Rand(230,250))
		part2:SetStartSize(1300*self.Scale)
		part2:SetEndSize(50*self.Scale)
		part2:SetColor(255,226,174)
	end
	for i=1,30 do
		local part = self.Emitter:Add("particle/Explode"..math.random(1,2), self.StartPos+Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1)))
		part:SetDieTime(10)
		part:SetStartAlpha(math.Rand(230,250))
		part:SetStartSize(math.Rand(100,150)*self.Scale)
		part:SetEndSize(math.Rand(15,20)*self.Scale)
		part:SetRoll(math.Rand(480,540))
		part:SetRollDelta(math.Rand(-1,1))
		part:SetColor(100, 150, 255)
		//part:VelocityDecay(true)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
