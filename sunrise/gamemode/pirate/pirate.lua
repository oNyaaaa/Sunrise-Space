/*
	Sunrise - A new era
	Do not edit or change unless with premission of the sunrise dev's
*/

PIRATES = {}

local MaxPirates = 25
local PirateSpawnVect = 1000
local PirateSpawnLocalVect = 1000
local PirateSpawnDelay = 15

function GM:CreatePirate(t)
	if(table.Count(ents.FindByClass("sunrise_pirate")) >= MaxPirates) then
		return
	end
	local tab = ents.FindByClass("sunrise_asteroidfield")
	local Pos = Vector(math.Rand(-PirateSpawnVect,PirateSpawnVect),math.Rand(-PirateSpawnVect,PirateSpawnVect),math.Rand(-PirateSpawnVect,PirateSpawnVect))
	if table.Count(tab) > 0 then
		Pos = table.Random(tab):GetPos()+Vector(math.Rand(-PirateSpawnLocalVect,PirateSpawnLocalVect),math.Rand(-PirateSpawnLocalVect,PirateSpawnLocalVect),math.Rand(-PirateSpawnLocalVect,PirateSpawnLocalVect))
	end
	
	local tur = ents.FindInSphere( Pos, 2000 )
	for _,v in pairs(tur) do
		if v:GetClass() == "sunrise_laserturret" then
			return
		end
	end	
	
	if !util.IsInWorld(Pos) then
		return
	end
	local e = ents.Create(t or "sunrise_pirate")
	e:SetPos(Pos)
	e:Spawn()
	e:Activate()
end
timer.Create("CreatePirate",PirateSpawnDelay,0,GM.CreatePirate)

function AddNewPirateShip(name, Model, Shield, Health, Dmg, MaxSpeed, Acceleration, DieSize, Money, WreckModel, Diff)
	local Ship = { name = name, Model = Model, Shield = Shield, Health = Health, Dmg = Dmg, MaxSpeed = MaxSpeed, Acceleration = Acceleration, DieSize = DieSize, WreckModel = WreckModel, Diff = Diff}
	table.insert(PIRATES, Ship)
	//DebugPrint("New Pirate class created. Name = "..name..", Model = "..Model)
end

AddNewPirateShip("T1", "models/thesunrise/balduran/pirate_shuttle1.mdl", 100, 100, 10, 140, 5, 0.6, 50, "models/thesunrise/shuttle_wreck.mdl", 1)
AddNewPirateShip("T2", "models/thesunrise/balduran/pirate_shuttle2.mdl", 200, 150, 15, 140, 6, 0.6, 100, "models/thesunrise/balduran/shuttle2_wreck.mdl", 60)
AddNewPirateShip("T3", "models/thesunrise/shuttlepirate.mdl", 300, 200, 25, 100, 5, 0.6, 300, "models/thesunrise/shuttle_wreck.mdl",65)
AddNewPirateShip("T4", "models/thesunrise/balduran/pirate_frig5.mdl", 400, 400, 40, 70, 4, 0.8, 600, "models/thesunrise/balduran/frigate5_wreck.mdl",70)
AddNewPirateShip("T5", "models/thesunrise/balduran/pirate_frig1.mdl", 600, 500, 60, 80, 4, 0.8, 800, "models/thesunrise/frigate_wreck.mdl",75)
AddNewPirateShip("T6", "models/thesunrise/balduran/pirate_cruiser3.mdl", 1500, 500, 100, 7, 5, 1, 1500, "models/thesunrise/balduran/cruiser3_wreck.mdl",80)
AddNewPirateShip("T7", "models/thesunrise/balduran/juggernaught1.mdl", 10000, 5000, 300, 60, 2, 8, 1000000, "models/thesunrise/titan_wreck.mdl",85)
AddNewPirateShip("T8", "models/thesunrise/balduran/pirate_cruiser1.mdl", 2000, 1000, 150, 8, 5, 1, 2000, "models/thesunrise/cruiser_wreck.mdl",90)
AddNewPirateShip("T9", "models/thesunrise/balduran/titan1.mdl", 10000, 5000, 450, 50, 2, 10, 1000000, "models/thesunrise/titan_wreck.mdl",91)


function GetRandomPirateShip()
	local p = table.Random(PIRATES)
	local dif = math.random(100)
	
	if p.Diff > dif then
		return GetRandomPirateShip()
	end
	
	return p
end