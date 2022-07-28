AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("weps/wepons.lua")

include("shared.lua")
include("cargo/sv_cargo.lua")

AddCSLuaFile("hud/hud.lua")

include("dock/docking.lua")
include("pirate/pirate.lua")

util.AddNetworkString("sun_openundockmenu")
util.AddNetworkString("sun_opendockmenu")

GM.Folder = "sunrise"

hook.Add("PlayerConnect","Server", function()
    if game.GetMap() != "sun_outer-edge" then
        game.ConsoleCommand("changelevel sun_outer-edge\n")
    end
end)

local SpawnOffset = 700

concommand.Add("select_star_attk", function(ply,cmd,args)
    ply:SetNWString("Cargo_Sel",tostring(args[1]))
end)

function GM:PlayerSpawn(ply)
    ply.Cargo = {}
    ply:SetNWString("Cargo_Sel","")
    
    Cargo:Set(ply,1,{Name = "Miner",Amt = 1}) 
    ply:SetNWInt("DeathTimer",60)
    ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    ply.cDock = false
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
        ply:SetNWString("meta_shipmdl",ply.ent:GetModel())
    ply:Spectate( OBS_MODE_CHASE )
	ply:SpectateEntity( ply.ent )
end

local meta = FindMetaTable("Entity")

function GM:CanPlayerSuicide() return false end

function meta:GetOwner_OfShip()
    local ply = self.GetShipOwner
    ply:SetNWEntity("Ship",self)
    return ply
end

function GM:PlayerDeath(ply,inf,attk)
    if ply.ent then ply.ent:Remove() end
    ply.cDock = false
end

timer.Create("Tick", 60, 0, function()
    for k,v in pairs(player.GetAll()) do
        v.cDock = false
    end
end)

hook.Add("Tick", "529391239", function()
    for k,v in pairs(ents.FindByClass("sunrise_station")) do
        for _,ply in pairs(ents.FindInSphere(v:GetPos(), 100)) do
            if ply:IsPlayer() then 
                if ply.Timerz_Dock == nil then ply.Timerz_Dock = 0 end
                if CurTime() >= ply.Timerz_Dock then
                    ply.Timerz_Dock = CurTime() + 5
                    net.Start("sun_opendockmenu")
                    net.Send(ply)
                end
            end
        end
    end
end)