/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

schdPatrol = ai_schedule.New("AIFighter Chase")

schdPatrol:EngTask("TASK_WAIT_FOR_MOVEMENT",0)

ENT.NextRandomSounda = 0
ENT.NextRandomSound = 0
ENT.NextDamageSound = 0
ENT.NextSound = 0

ENT.UseSounds =	{
					"vo/canals/gunboat_getin.wav",
					"vo/canals/gunboat_herelook.wav",
					"vo/canals/shanty_hey.wav",
					"vo/npc/male01/answer05.wav",
					"vo/npc/male01/answer25.wav",
					"vo/npc/male01/answer30.wav",
					"vo/npc/male01/busy02.wav",
					"vo/npc/male01/gordead_ans15.wav",
					"vo/npc/male01/hi01.wav",
					"vo/npc/male01/hi02.wav",
					"vo/npc/male01/squad_affirm03.wav",
					"vo/npc/male01/vanswer05.wav",
					"vo/npc/male01/vquestion01.wav",
					"vo/trainyard/male01/cit_foodline02.wav",
					"vo/trainyard/male01/cit_pedestrian01.wav"
				}

ENT.DamageSounds =	{
						"vo/canals/male01/stn6_shellingus.wav",
						"vo/Citadel/br_no.wav",
						"vo/Citadel/br_ohshit.wav",
						"vo/coast/cardock/le_whohurt.wav",
						"vo/coast/odessa/male01/nlo_cubdeath01.wav",
						"vo/coast/odessa/male01/nlo_cubdeath02.wav",
						"vo/npc/Barney/ba_damnit.wav",
						"vo/npc/Barney/ba_pain01.wav",
						"vo/npc/Barney/ba_pain02.wav",
						"vo/npc/Barney/ba_pain03.wav",
						"vo/npc/Barney/ba_pain04.wav",
						"vo/npc/Barney/ba_pain05.wav",
						"vo/npc/Barney/ba_pain06.wav",
						"vo/npc/Barney/ba_pain07.wav",
						"vo/npc/Barney/ba_pain08.wav",
						"vo/npc/Barney/ba_pain09.wav",
						"vo/npc/Barney/ba_pain10.wav",
						"vo/npc/male01/gethellout.wav",
						"vo/npc/male01/gordead_ans04.wav",
						"vo/npc/male01/gordead_ans05.wav",
						"vo/npc/male01/gordead_ans06.wav",
						"vo/npc/male01/gordead_ques10.wav",
						"vo/npc/male01/help01.wav",
						"vo/npc/male01/hitingut01.wav",
						"vo/npc/male01/hitingut02.wav",
						"vo/npc/male01/imhurt01.wav",
						"vo/npc/male01/imhurt02.wav",
						"vo/npc/male01/myarm01.wav",
						"vo/npc/male01/myarm02.wav",
						"vo/npc/male01/mygut02.wav",
						"vo/npc/male01/myleg01.wav",
						"vo/npc/male01/myleg02.wav",
						"vo/npc/male01/ohno.wav",
						"vo/npc/male01/no01.wav",
						"vo/npc/male01/ow01.wav",
						"vo/npc/male01/ow02.wav",
						"vo/npc/male01/pain01.wav",
						"vo/npc/male01/pain02.wav",
						"vo/npc/male01/pain03.wav",
						"vo/npc/male01/pain04.wav",
						"vo/npc/male01/pain05.wav",
						"vo/npc/male01/pain06.wav",
						"vo/npc/male01/pain07.wav",
						"vo/npc/male01/pain08.wav",
						"vo/npc/male01/pain09.wav",
						"vo/npc/male01/startle01.wav",
						"vo/npc/male01/startle02.wav",
						"vo/npc/male01/strider_run.wav",
						"vo/npc/male01/watchout.wav"
					}

ENT.RandomSound =	{
						"vo/canals/boxcar_go_nag01.wav",
						"vo/canals/boxcar_go_nag04.wav",
						"vo/canals/shanty_go_nag01.wav",
						"vo/coast/odessa/male01/nlo_cheer03.wav",
						"vo/k_lab/ba_guh.wav",
						"vo/npc/male01/doingsomething.wav",
						"vo/npc/male01/gordead_ans01.wav",
						"vo/npc/male01/gordead_ans19.wav",
						"vo/npc/male01/gordead_ques16.wav",
						"vo/npc/male01/littlecorner01.wav",
						"vo/npc/male01/question02.wav",
						"vo/npc/male01/question05.wav",
						"vo/npc/male01/question06.wav",
						"vo/npc/male01/question09.wav",
						"vo/npc/male01/question11.wav",
						"vo/npc/male01/question13.wav",
						"vo/npc/male01/question22.wav",
						"vo/npc/male01/question23.wav",
						"vo/npc/male01/question27.wav",
						"vo/npc/male01/question26.wav",
						"vo/npc/male01/question28.wav",
						"vo/npc/male01/uhoh.wav",
						"vo/npc/male01/vanswer14.wav",
						"vo/npc/male01/waitingsomebody.wav",
						"vo/npc/male01/whoops01.wav"
					}
/*
function ENT:Initialize()
	self:SetModel("models/Humans/Group01/male_07.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetSolid(SOLID_BBOX) 
	self:SetMoveType(MOVETYPE_STEP)
	self:SetUseType(SIMPLE_USE)
	self:CapabilitiesAdd(CAP_MOVE_GROUND | CAP_USE | CAP_AUTO_DOORS | CAP_OPEN_DOORS | CAP_TURN_HEAD | CAP_ANIMATEDFACE)
	self:SetMaxYawSpeed(5000)
end
*/

function ENT:Initialize()
	self:SetModel("models/thesunrise/TerminalClean.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetUseType(SIMPLE_USE)
	self:SetMaxYawSpeed(5000)
end

function ENT:OnTakeDamage(dmg)
	if self.NextRandomSound <= CurTime() and self.NextSound <= CurTime() and self.NextDamageSound <= CurTime() then
		local sound = table.Random(self.DamageSounds)
		self:EmitSound(sound,100,100)
		self.NextDamageSound = CurTime()+(SoundDuration(sound)+0.2)
		self.NextRandomSounda = math.Clamp(self.NextRandomSounda,CurTime()+15,CurTime()+10000)
	end
end


function ENT:Think()
	
	
	
	/*
	if self.NextRandomSound <= CurTime() and self.NextRandomSounda <= CurTime() and self.NextSound <= CurTime() and self.NextDamageSound <= CurTime() then
		local sound = table.Random(self.RandomSound)
		self:EmitSound(sound,100,100)
		self.NextRandomSound = CurTime()+SoundDuration(sound)+0.1
		self.NextRandomSounda = CurTime()+math.random(40,50)
	end*/
end


function ENT:AcceptInput(inp,ply,caller)    
	if inp == "Use" and ply:IsPlayer() and ply:KeyPressed(32) then
		umsg.Start("sun_shop",ply)
		umsg.End()
		/*if self.NextRandomSound <= CurTime() and self.NextSound <= CurTime() and self.NextDamageSound <= CurTime() then
			local sound = table.Random(self.UseSounds)
			self:EmitSound(sound,100,100)
			self.NextSound = CurTime()+(SoundDuration(sound)+1)
			self.NextRandomSounda = math.Clamp(self.NextRandomSounda,CurTime()+15,CurTime()+10000)
		end*/
	end
end

function ENT:SelectSchedule()
	self:StartSchedule(schdPatrol)
end
