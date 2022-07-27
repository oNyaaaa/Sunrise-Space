/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

local meta = FindMetaTable("Player")

local dockmdls = {
	"models/player/combine_soldier.mdl",
	"models/player/police.mdl",
	"models/player/combine_super_soldier.mdl",
}

function meta:Dock()
	local ship = self
	local spawn = table.Random(ents.FindByClass("sunrise_playerdockspawn"))
	local ships = ship.ent
	local phys = ships:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity(self:GetForward() * 0)
	end
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

	self.cDock = true
end

function meta:UnDock()
	local ship = self
	self:StripWeapons()
	self:StripAmmo()
	if ship.ent and ship.ent:IsValid() then
		//ship.ent:GetPhysicsObject():Wake()
		//ship:SetPlayer(self)
		self:SetNWBool("Docked",false)
		//ship.UnDockTimer = CurTime()+10
		//Wreturn
	end
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
	self:SpectateEntity( self.ent )
	self.cDock = false
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
	local ship = ply //self:GetOwner_OfShip()
	ship.WantsToDock = false
	//ship:SetDocked(false)
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