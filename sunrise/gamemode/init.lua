AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

AddCSLuaFile("hud/hud.lua")

GM.Folder = "sunrise"

local SpawnOffset = 500

function GM:PlayerSpawn(ply)
    ply:SetNWInt("DeathTimer",60)
    ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    ply.ent = ents.Create("sr_playership")
    local pos = ""
		for _,v in pairs(ents.FindByClass("sunrise_station")) do
			pos = v:GetPos()
		end
		
		pos.x = math.random(pos.x - SpawnOffset, pos.x + SpawnOffset)
		pos.y = math.random(pos.y - SpawnOffset, pos.y + SpawnOffset)
		pos.z = math.random(pos.z - SpawnOffset, pos.z + SpawnOffset)

        ply.ent:SetPos(pos)
        ply.ent.GetShipOwner = ply
        ply.ent:Spawn()
        ply.ent:Activate()
    ply:Spectate( OBS_MODE_CHASE )
	ply:SpectateEntity( ply.ent )
end



local meta = FindMetaTable("Entity")

function meta:GetOwner_OfShip()
    return self.GetShipOwner
end

function GM:PlayerDeath(ply,inf,attk)
    if ply.ent then ply.ent:Remove() end
end