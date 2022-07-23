
local GlowMat	= Material("models/spawn_effect2")
local ScaleVect	= Vector(0,0,0)

function EFFECT:Init(data)
	self.ParentEntity = data:GetEntity()
	if self.ParentEntity == NULL then return end
	self.Time = 1
	self.LifeTime = CurTime()+self.Time
	self.Entity:SetModel(self.ParentEntity:GetModel())
	self.Entity:SetSkin(self.ParentEntity:GetSkin())
	self.Entity:SetPos(self.ParentEntity:GetPos())
	self.Entity:SetAngles(self.ParentEntity:GetAngles())
	self.Entity:SetParent(self.ParentEntity)
end

function EFFECT:Think()
	if !self.ParentEntity or !self.ParentEntity:IsValid() then return false end
	return self.LifeTime > CurTime()
end

function EFFECT:Render()
	self.Entity:SetColor(255,255,255,1+math.sin(math.Clamp((self.LifeTime-CurTime())/self.Time,0,1)*math.pi)*100)
	local EyeNormal = self.Entity:GetPos()-EyePos()
	EyeNormal:Normalize()
	local Pos = EyePos()+EyeNormal*EyeNormal:Length()*5
	cam.Start3D(Pos,EyeAngles())
		SetMaterialOverride(GlowMat)
			self.Entity:SetModelScale(self.ParentEntity:GetModelScale()+ScaleVect)
			self.Entity:DrawModel()
		SetMaterialOverride(0)
	cam.End3D()
end
