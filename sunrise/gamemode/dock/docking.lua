/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

local meta = FindMetaTable("Player")

local dockmdls = {
	"models/player/Group01/male_02.mdl",
	"models/player/Group01/Male_01.mdl",
	"models/player/Group01/Female_01.mdl",
	"models/player/Group01/male_09.mdl",
	"models/player/Group01/male_07.mdl",
	"models/player/Group01/Male_05.mdl",
	"models/player/Group01/male_06.mdl",
	"models/player/Group01/Female_07.mdl",
	"models/player/Group01/male_08.mdl",
	"models/player/Group01/Male_04.mdl"
}

function meta:Dock()

	local spawn = table.Random(ents.FindByClass("sunrise_playerdockspawn"))

	self:SetNWBool("Docked",true)
	self.SpawnShip = false
	self:UnSpectate()
	//self:Spawn()
	self.SpawnShip = true
	self:SetMoveType(MOVETYPE_WALK)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawViewModel(true)
	self:DrawWorldModel(true)

	self:SetModel( dockmdls[math.random(1,#dockmdls)])

	self:SetPos(spawn:GetPos())

	
end

function meta:UnDock()
	local ship = self
	self:StripWeapons()
	self:StripAmmo()
	//if ship and ship:IsValid() then
		//ship:GetPhysicsObject():Wake()
		//ship:SetPlayer(self)
		self:SetNWBool("Docked",false)
		//ship.UnDockTimer = CurTime()+10
		//Wreturn
	//end
	self:SetNWBool("Docked",false)
	//self:Spectate( OBS_MODE_CHASE )
	//self:SpectateEntity( ship.ent )
	-- This part is for when the ship does not exists, i have no idea where to place the ship.
	//local ship = ents.Create("sr_playership")
	//ship:SetPos(self:GetPos()) -- Where to place it?
	//ship:SetPlayer(self)
	//ship:Spawn()
	//ship:Activate()
	self:Spectate( OBS_MODE_CHASE )
	self:SpectateEntity( ship.ent )
	//self:SetShip(ship)
end

function Sun_DoDock(ply)
	ply:Dock()
	//if self:GetOwner_OfShip().WantsToDock then
		//self:GetOwner_OfShip():SetDocked(true)
	//end
	//self:GetOwner_OfShip().WantsToDock = false
end
concommand.Add("sun_dodock",Sun_DoDock)

function Sun_StopDock(ply)
	local ship = self:GetOwner_OfShip()
	ship.WantsToDock = false
	ship:SetDocked(false)
	ship.WantsToDock = false
	ship.UnDockTimer = CurTime()+10
end
concommand.Add("sun_stopdock",Sun_StopDock)

function Sun_DoUndock(ply)
	///if ply.CanUndock then
		ply:UnDock()
	//end
end
concommand.Add("sun_doundock",Sun_DoUndock)

function Sun_StopUnDock(ply)
	ply.CanUndock = false
end
concommand.Add("sun_stopundock",Sun_StopUnDock)