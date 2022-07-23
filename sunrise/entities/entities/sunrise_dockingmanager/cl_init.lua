/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

include('shared.lua')

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw()
	self:DrawModel()
end

function ENT:DrawTranslucent()
	self:Draw()
end

function ENT:BuildBonePositions(NumBones,NumPhysBones)
end

function ENT:SetRagdollBones(bIn)
	self.m_bRagdollSetup = bIn
end

function ENT:DoRagdollBone(PhysBoneNum,BoneNum)
end
language.Add("sunrise_dockingmanager","Dock manager")
