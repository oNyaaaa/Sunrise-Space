include("shared.lua")

include("hud/hud.lua")

local HELP = {}
HELP[1] =	{
				"Welcome",
				"Welcome to Sunrise - Space",
				"",
			}

HELP[2] =	{
				"Click here for help",
				"Flying Basics and game controls",
				"",
				"Increase Speed: W",
				"Decrease Speed: S",
				"Select Objects: E",
				"Warp Speed: Shift",
				"Turn Ship: right Mouse Button",
				"Inventory: Q",
				"Fire Equipment: Left Mouse Button",
			}

HELP[4] =	{
				"Docking & Selling",
				"",
				"To dock with the station stop near to the station make sure u see the 'Do you wish to dock?' box.",
				"Now to sell your ore go to the Sunrise console inside the station.",
				"Use the sell tab to sell your items.",
				"You can buy weapons, ships and access your bank aswell",
			}

HELP[5]	=	{
				"Combat & Ammo",
				"",
				"Begin by making sure you have the correct ammo for your weapon Particle Charges, Batteries, or Missiles.",
				"To fight another ship or pirate select them like an asteroid you should see a green box around the selected ship.",
				"Use the Q menu to equip your weapon then use the Left mouse button to fire the weapon at the ship.",
			}

HELP[3] =	{
				"Mining",
				"",
				"The fastest way to earn money is to mine.",
				"To begin mining warp to an asteroid belt new players should use 83 (closest to the station).",
				"Once there get close to an asteroid making sure not to warp into it.",
				"Now select the asteroid with E and then hit Q equip the mining laser of your choice.",
				"Now hold the Left mouse button to fire the mining laser into the asteroid retrieving the ore.",
			}


HELP[6] =	{
				"Weapons information",
				"",
				"Shuttles can only carry Small weapons.",
				"Frigates can carry up to Medium Weapons.",
				"Cruisers can carry up to large weapons",
				"Capital weapons can only be used by the Titan and Dread",
			}

local DONATE = {}
DONATE[1] =	{
				"Donate!",
				"",
			}
local RULES = {}
RULES[1] =	{
				"Rules",
				"",
				"No station camping. This means no hiding in the station from players, also no waiting outside the station for players",
				"",
				"No not constantly trying to attack a person who has attacked you.",
				"",
				"No spawn camping. This means give the player a chance to get away from the spawn point.",
				"",
				"NO FAST WARPING. This is when you disconnect so you will be reset to near the station.",
				"",
				"USE YOUR COMMON SENSE!!",
			}

concommand.Add("sun_openhelp",function()
	local DermaPanel = vgui.Create( "DFrame" ) 
   
	DermaPanel:SetPos(((ScrW() - 700) * 0.5),((ScrH() - 500) * 0.5))
	DermaPanel:SetSize(700, 500)
	DermaPanel:SetTitle("Sunrise - Outer Edge")
	DermaPanel:SetVisible(true) 
	DermaPanel:SetDraggable(false)
	DermaPanel:ShowCloseButton(true)
	DermaPanel:MakePopup() 
	
	local PropertySheet = vgui.Create( "DPropertySheet")
	PropertySheet:SetParent( DermaPanel )
	PropertySheet:SetPos( 5, 30 )
	PropertySheet:SetSize( 690, 462 )
	
	local Help = vgui.Create("DPanelList")
	Help:EnableHorizontal(false)
	Help:EnableVerticalScrollbar(true)
	Help:SetPadding(5)
	Help:SetSpacing(5)
	Help:SetSize((PropertySheet:GetWide() - 10), PropertySheet:GetTall())
	Help:SetPos(0, 0)

	for k,v in pairs(HELP) do
		local cat = vgui.Create("DCollapsibleCategory") 
		cat:SetLabel(v[1])
		local list = vgui.Create("DPanelList",cat)
		list:SetPadding(10)
		for k2,v2 in pairs(v) do
			if k2 != 1 then
				local lab = vgui.Create("DLabel", list)
				lab:SetText(v2)
			lab:SizeToContents()
				list:AddItem(lab)
			end
		end
		list:SetSize(680, 14 * #v)
		cat:SetContents(list)
		cat:SizeToContents()
		cat:InvalidateLayout()
		if k != 1 then
			cat:SetExpanded(false)
		end
		Help:AddItem(cat)
	end
	
	local Donate = vgui.Create( "DPanelList")
	Donate:EnableHorizontal(false)
	Donate:EnableVerticalScrollbar(true)
	Donate:SetPadding(5)
	Donate:SetSpacing(5)
	Donate:SetSize((PropertySheet:GetWide() - 10), PropertySheet:GetTall())
	Donate:SetPos(0, 0)

	for k,v in pairs(DONATE) do
		local cat = vgui.Create("DCollapsibleCategory") 
		cat:SetLabel(v[1])
		local list = vgui.Create("DPanelList",cat)
		list:SetPadding(10)
		for k2,v2 in pairs(v) do
			if k2 != 1 then
				local lab = vgui.Create("DLabel", list)
				lab:SetText(v2)
				lab:SizeToContents()
				list:AddItem(lab)
			end
		end
		list:SetSize(680, 14 * #v)
		cat:SetContents(list)
		cat:SizeToContents()
		cat:InvalidateLayout()
		if k != 1 then
			cat:SetExpanded(false)
		end
		Donate:AddItem(cat)
	end 
	
	local Rules = vgui.Create( "DPanelList")
	Rules:EnableHorizontal(false)
	Rules:EnableVerticalScrollbar(true)
	Rules:SetPadding(5)
	Rules:SetSpacing(5)
	Rules:SetSize((PropertySheet:GetWide() - 10), PropertySheet:GetTall())
	Rules:SetPos(0, 0)
	
	for k,v in pairs(RULES) do
		local cat = vgui.Create("DCollapsibleCategory") 
		cat:SetLabel(v[1])
		local list = vgui.Create("DPanelList",cat)
		list:SetPadding(10)
		for k2,v2 in pairs(v) do
			if k2 != 1 then
				local lab = vgui.Create("DLabel", list)
				lab:SetText(v2)
				lab:SizeToContents()
				list:AddItem(lab)
			end
		end
		list:SetSize(680, 14 * #v)
		cat:SetContents(list)
		cat:SizeToContents()
		cat:InvalidateLayout()
		if k != 1 then
			cat:SetExpanded(false)
		end
		Rules:AddItem(cat)
	end 


	PropertySheet:AddSheet( "Help", Help, "gui/silkicons/user", false, false, "Help" )
	PropertySheet:AddSheet( "Donate", Donate, "gui/silkicons/user", false, false, "Donate" )
	PropertySheet:AddSheet( "Rules", Rules, "gui/silkicons/user", false, false, "Rules" )
	
end)


if Cargo == nil then Cargo = {} end

net.Receive("Cargo_Resc", function()
    local rec = net.ReadTable()
	Cargo = rec
end)

local QMenu

function QMenuPad()
    QMenu = vgui.Create( "DFrame" )
    QMenu:SetTitle( "" )
    QMenu:ShowCloseButton( true )
    QMenu:SetPos(((ScrW() - 700) * 0.5),((ScrH() - 500) * 0.5))
	QMenu:SetSize(700, 500)
    QMenu:SetDraggable( false )
	QMenu.Paint = function() end
	QMenu.OnClose = function() gui.EnableScreenClicker( false ) QMenu = nil end
	
	QMenu.Tabs = vgui.Create( "DPropertySheet")
	QMenu.Tabs:SetParent( QMenu )
	QMenu.Tabs:SetPos( 5, 30 )
	QMenu.Tabs:SetSize( 690, 462 )
	
	QMenu.Inventory = vgui.Create("DPanel", QMenu.Tabs)
	QMenu.Inventory:SetPos(5,5)
	QMenu.Inventory:SetSize(590,390)
	
	QMenu.ItemList = vgui.Create("DListView", QMenu.Inventory)
	QMenu.ItemList:SetPos(15, 15)
	QMenu.ItemList:SetSize(490, 400)
	QMenu.ItemList:SetMultiSelect(false)
	QMenu.ItemList:AddColumn("Name")
	QMenu.ItemList:AddColumn("Amount")
	QMenu.ItemList.ItemUpdateList = function(self)
		self:Clear()
		for k,v in pairs(Cargo) do
			self:AddLine(v.Name,v.Amt)
		end
	end
	
	QMenu.ItemList:ItemUpdateList()
	
	local EquipButton = vgui.Create( "DButton", QMenu.Inventory )
	EquipButton:SetText( "Equip" )
	EquipButton:SetPos( 520, 25 )
	EquipButton:SetSize( 150, 20 )
	EquipButton.DoClick = function()
		local item = QMenu.ItemList:GetSelected()[1]
		if(item) then
			RunConsoleCommand("select_star_attk",tostring(item:GetColumnText(1)))
		end
	end
	

	/*QMenu.Fleets = vgui.Create("DPanel", QMenu.Tabs)
	QMenu.Fleets:SetPos(5,5)
	QMenu.Fleets:SetSize(590,390)
	
	QMenu.FleetList = vgui.Create("DListView", QMenu.Fleets)
	QMenu.FleetList:SetPos(15, 15)
	QMenu.FleetList:SetSize(490, 400)
	QMenu.FleetList:SetMultiSelect(false)
	QMenu.FleetList:AddColumn("Name")
	QMenu.FleetList:AddColumn("Players")
	QMenu.FleetList.FleetUpdateList = function(self)
		self:Clear()
		//for k,v in pairs(FLEETS) do
			self:AddLine("test","test")//k, table.Count(v.Members))
		//end
	end
	
	QMenu.FleetList:FleetUpdateList()
	
	local FleetJoinButton = vgui.Create( "DButton", QMenu.Fleets )
	FleetJoinButton:SetText( "Join" )
	FleetJoinButton:SetPos( 520, 25 )
	FleetJoinButton:SetSize( 150, 20 )
	FleetJoinButton.DoClick = function()
		local item = QMenu.FleetList:GetSelected()[1]
		if(item) then
			RunConsoleCommand("sun_JoinFleet",item:GetColumnText(1))
		end
	end
	
	local FleetCreateButton = vgui.Create( "DButton", QMenu.Fleets )
	FleetCreateButton:SetText( "Create" )
	FleetCreateButton:SetPos( 520, 60 )
	FleetCreateButton:SetSize( 150, 20 )
	FleetCreateButton.DoClick = function()
		RunConsoleCommand("sun_CreateFleet")
	end*/
	
	
	
	/*
	QMenu.Stats = vgui.Create("DPanel", QMenu.Tabs)
	QMenu.Stats:SetPos(5,5)
	QMenu.Stats:SetSize(590,390)
	*/
	
	
	
	
    QMenu:SetVisible( false )
	
	QMenu.Tabs:AddSheet( "Inventory", QMenu.Inventory, "gui/silkicons/user", false, false )
	//QMenu.Tabs:AddSheet( "Fleets", QMenu.Fleets, "gui/silkicons/user", false, false )
	
	gui.SetMousePos( ScrW() / 2, ScrH() / 2 )
 
end

function HideQMenu() 
	if QMenu then
		QMenu:SetVisible( false )
	else
		QMenuPad()
		QMenu:SetVisible( false )
	end
	gui.EnableScreenClicker( false )
end
 
function ShowQMenu()
	if QMenu then
		QMenu:SetVisible( true )
		//QMenu.ItemList:ItemUpdateList()
		//QMenu.FleetList:FleetUpdateList()
	else
		QMenuPad()
		QMenu:SetVisible( true )
	end
	gui.EnableScreenClicker( true )
end


function GM:PlayerBindPress( ply, bind, pressed ) 
	if bind == "gm_showhelp" then
        ply:ConCommand("sun_openhelp")
    end
	if bind == "+menu" then
       	ShowQMenu()
	end
end

SHIPS = {}

GM.DefaultShip = "T1 Buzzfly Shuttle"

function AddNewShip(name, cost, Model, Shield, Health, ViewDistance, MaxSpeed, CargoSize, Acceleration, WarpSpeed, WarpHeatAddition, DieSize, Skin, WreckModel, Man, Class)
	local Ship = { name = name, cost = cost, Model = Model, Shield = Shield, Health = Health, ViewDistance = ViewDistance, MaxSpeed = MaxSpeed, CargoSize = CargoSize, Acceleration = Acceleration, WarpSpeed = WarpSpeed, WarpHeatAddition = WarpHeatAddition, DieSize = DieSize, Skin = Skin, WreckModel = WreckModel, Man = Man, Class = Class}
	table.insert(SHIPS, Ship)
	////DebugPrint("New Ship created. Name = "..name..", cost = "..cost..", Model = "..Model)
end


/*
	Editing the NAMES of them will corrupt a player unless there are another 1 with the same name
*/
AddNewShip("T1 Buzzfly Shuttle", 0, "models/thesunrise/balduran/shuttle1-1.mdl", 100, 50, 20, 100, 20, 4, 800, 0.8, 1, 0, "models/thesunrise/shuttle_wreck.mdl", 1, 0)
AddNewShip("T2 Buzzfly Shuttle", 1500, "models/thesunrise/balduran/shuttle1-2.mdl", 120, 70, 20, 100, 25, 4, 800, 0.8, 1, 2, "models/thesunrise/shuttle_wreck.mdl", 1, 0)
AddNewShip("T3 Buzzfly Shuttle", 3000, "models/thesunrise/balduran/shuttle1-3.mdl", 150, 90, 20, 100, 30, 4, 800, 0.8, 1, 1, "models/thesunrise/shuttle_wreck.mdl", 1, 0)
AddNewShip("T4 Buzzfly Shuttle", 4500, "models/thesunrise/balduran/shuttle1-4.mdl", 200, 110, 20, 110, 45, 4, 850, 0.8, 1, 0, "models/thesunrise/shuttle_wreck.mdl", 1, 0)
AddNewShip("T1 Packmule Shuttle", 2500, "models/thesunrise/balduran/shuttle6-1.mdl", 50, 10, 20, 110, 35, 4, 900, 0.8, 1, 0, "models/thesunrise/balduran/shuttle6_wreck.mdl", 1, 0)
AddNewShip("T1 Cobra Shuttle", 500, "models/thesunrise/balduran/shuttle2-1.mdl", 100, 40, 20, 150, 20, 5, 850, 0.8, 1, 0, "models/thesunrise/balduran/shuttle2_wreck.mdl", 1, 0)
AddNewShip("T2 Cobra Shuttle", 1500, "models/thesunrise/balduran/shuttle2-2.mdl", 110, 40, 20, 200, 20, 5, 1000, 0.7, 1, 2, "models/thesunrise/balduran/shuttle2_wreck.mdl", 1, 0)
AddNewShip("T3 Cobra Shuttle", 3000, "models/thesunrise/balduran/shuttle2-3.mdl", 120, 50, 20, 250, 20, 6, 1200, 0.6, 1, 2, "models/thesunrise/balduran/shuttle2_wreck.mdl", 1, 0)
AddNewShip("T4 Cobra Shuttle", 4500, "models/thesunrise/balduran/shuttle2-4.mdl", 150, 60, 20, 300, 20, 7, 1400, 0.5, 1, 3, "models/thesunrise/balduran/shuttle2_wreck.mdl", 1, 0)
AddNewShip("T1 Groundhog Shuttle", 1000, "models/thesunrise/balduran/shuttle3.mdl", 80, 40, 20, 80, 50, 4, 700, 0.8, 1, 2, "models/thesunrise/balduran/shuttle3_wreck.mdl", 1, 0)
AddNewShip("T1 Talon Shuttle", 3500, "models/thesunrise/balduran/shuttle4.mdl", 200, 200, 20, 150, 10, 4, 1000, 0.7, 1, 0, "models/thesunrise/balduran/shuttle4_wreck.mdl", 1, 0)
AddNewShip("T1 Kushan Frigate", 10000, "models/thesunrise/balduran/frigate1-1.mdl", 300, 200, 30, 320, 70, 16, 2400, 1, 1, 0, "models/thesunrise/frigate_wreck.mdl", 4, 1)
AddNewShip("T2 Kushan Frigate", 16000, "models/thesunrise/balduran/frigate1-2.mdl", 350, 250, 30, 320, 80, 16, 2600, 1, 1, 2, "models/thesunrise/frigate_wreck.mdl", 4, 1)
AddNewShip("T3 Kushan Frigate", 23000, "models/thesunrise/balduran/frigate1-3.mdl", 400, 300, 30, 360, 80, 16, 2800, 1, 1, 3, "models/thesunrise/frigate_wreck.mdl", 4, 1)
AddNewShip("T4 Kushan Frigate", 35000, "models/thesunrise/balduran/frigate1-4.mdl", 450, 350, 30, 400, 90, 16, 3200, 1, 1, 1, "models/thesunrise/frigate_wreck.mdl", 4, 1)
AddNewShip("T5 Kushan Frigate", 60000, "models/thesunrise/balduran/frigate1-5.mdl", 550, 450, 30, 600, 100, 16, 3600, 1, 1, 1, "models/thesunrise/frigate_wreck.mdl", 4, 1)
AddNewShip("T1 Hermes Frigate",65000, "models/thesunrise/balduran/frigate4.mdl", 75, 100, 30, 1500, 50, 24, 6000, 0.1, 1, 0, "models/thesunrise/balduran/frigate4_wreck.mdl", 3, 1)
AddNewShip("T2 Hermes Frigate",150000, "models/thesunrise/balduran/frigate4.mdl", 50, 75, 30, 2100, 75, 24, 7500, 0.1, 2, 0, "models/thesunrise/balduran/frigate4_wreck.mdl", 2.5, 1)
AddNewShip("T1 Mule Frigate", 10000, "models/thesunrise/balduran/frigate5-1.mdl", 100, 100, 30, 300, 100, 16, 2500, 0.5, 1, 1, "models/thesunrise/balduran/frigate5_wreck.mdl", 5, 1)
AddNewShip("T2 Mule Frigate", 16000, "models/thesunrise/balduran/frigate5-2.mdl", 150, 100, 30, 350, 150, 16, 2750, 0.5, 1, 0, "models/thesunrise/balduran/frigate5_wreck.mdl", 5, 1)
AddNewShip("T3 Mule Frigate", 23000, "models/thesunrise/balduran/frigate5-3.mdl", 200, 150, 30, 400, 200, 16, 3000, 0.5, 1, 2, "models/thesunrise/balduran/frigate5_wreck.mdl", 5, 1)
AddNewShip("T4 Mule Frigate", 35000, "models/thesunrise/balduran/frigate5-4.mdl", 200, 150, 30, 450, 250, 16, 3250, 0.5, 1, 3, "models/thesunrise/balduran/frigate5_wreck.mdl", 5, 1)
AddNewShip("T5 Mule Frigate", 60000, "models/thesunrise/balduran/frigate5-5.mdl", 250, 200, 30, 500, 300, 16, 4500, 0.4, 1, 0, "models/thesunrise/balduran/frigate5_wreck.mdl", 5, 1)
AddNewShip("T1 Hammer Frigate", 67000, "models/thesunrise/balduran/frigate5-1.mdl", 600, 500, 30, 240, 30, 16, 2750, 0.5, 1, 0, "models/thesunrise/balduran/frigate5_wreck.mdl", 4, 1)
AddNewShip("T1 Nalaan Frigate", 110000, "models/thesunrise/balduran/frigate_miner.mdl", 200, 100, 30, 325, 400, 16, 3250, 0.5, 1, 0, "models/thesunrise/balduran/frigate_miner_wreck.mdl", 5, 1)
AddNewShip("Turtle Freighter", 500000, "models/thesunrise/balduran/freighter1.mdl", 700, 600, 55, 300, 1200, 8, 4125, 1, 2, 3, "models/thesunrise/balduran/freighter1_wreck.mdl", 7.5, 2)
AddNewShip("T2 Turtle Freighter", 1500000, "models/thesunrise/balduran/freighter1.mdl", 1400, 1300, 55, 400, 2400, 7, 4300, 1, 4, 2, "models/thesunrise/balduran/freighter1_wreck.mdl", 8, 3)
AddNewShip("Nomad Freighter", 500000, "models/thesunrise/balduran/freighter2.mdl", 300, 400, 55, 600, 800, 8, 4800, 1, 2, 0, "models/thesunrise/freighter2_wreck.mdl", 6, 2)
AddNewShip("T1 Armadillo Cruiser", 100000, "models/thesunrise/balduran/cruiser1-1.mdl", 1500, 1000, 40, 480, 30, 12, 4000, 2, 2, 0, "models/thesunrise/cruiser_wreck.mdl", 8, 3)
AddNewShip("T2 Armadillo Cruiser", 800000, "models/thesunrise/balduran/cruiser1-2.mdl", 2500, 2000, 40, 400, 30, 12, 4000, 2, 2, 1, "models/thesunrise/cruiser_wreck.mdl", 8, 3)
AddNewShip("T1 Arrow Cruiser", 100000, "models/thesunrise/balduran/cruiser4-1.mdl", 1100, 550, 40, 560, 35, 40, 5600, 0.7, 2, 1, "models/thesunrise/balduran/cruiser4_wreck.mdl", 6.5, 3)
AddNewShip("T2 Arrow Cruiser", 500000, "models/thesunrise/balduran/cruiser4-2.mdl", 1200, 700, 40, 640, 35, 40, 6000, 0.6, 2, 3, "models/thesunrise/balduran/cruiser4_wreck.mdl", 6.5, 3)
AddNewShip("T3 Arrow Cruiser", 1000000, "models/thesunrise/balduran/cruiser4-3.mdl", 1300, 900, 40, 720, 35, 40, 6400, 0.5, 2, 0, "models/thesunrise/balduran/cruiser4_wreck.mdl", 6.5, 3)
AddNewShip("T1 Orodral Cruiser", 200000, "models/thesunrise/balduran/cruiser3-1.mdl", 700, 400, 40, 400, 450, 3, 4000, 2, 2, 0, "models/thesunrise/balduran/cruiser3_wreck.mdl", 8, 3)
AddNewShip("T2 Orodral Cruiser", 300000, "models/thesunrise/balduran/cruiser3-2.mdl", 750, 420, 40, 400, 500, 3, 4000, 2, 2, 2, "models/thesunrise/balduran/cruiser3_wreck.mdl", 8, 3)
AddNewShip("T3 Orodral Cruiser", 400000, "models/thesunrise/balduran/cruiser3-3.mdl", 800, 450, 40, 400, 550, 3, 4000, 2, 2, 1, "models/thesunrise/balduran/cruiser3_wreck.mdl", 8, 3)
AddNewShip("T1 Freelancer Cruiser", 500000, "models/thesunrise/balduran/cruiser2-2.mdl", 1500, 800, 40, 560, 35, 32, 5600, 0.7, 2, 1, "models/thesunrise/cruiser_wreck.mdl", 8, 3)
AddNewShip("T2 Freelancer Cruiser", 800000, "models/thesunrise/balduran/cruiser2-3.mdl", 1600, 900, 40, 640, 55, 32, 6000, 0.6, 2, 1, "models/thesunrise/cruiser_wreck.mdl", 8, 3)
AddNewShip("T3 Freelancer Cruiser", 1500000, "models/thesunrise/balduran/cruiser2-4.mdl", 1700, 1000, 40, 720, 85, 32, 6400, 0.5, 2, 1, "models/thesunrise/cruiser_wreck.mdl", 8, 3)
AddNewShip("T1 Terran Battle Cruiser", 3000000, "models/thesunrise/articus/battlecruiser3.mdl", 2000, 1500, 40, 800, 120, 60, 7500, 0.4, 2, 1, "models/thesunrise/cruiser_wreck.mdl", 4, 3)
AddNewShip("Phoenix Dreadnought", 15000000, "models/thesunrise/balduran/juggernaught1.mdl", 5000, 7500, 40, 400, 1000, 20, 6500, 1, 7, 1, "models/thesunrise/cruiser_wreck.mdl", 10, 4)
AddNewShip("Juggernaught", 25000000, "models/thesunrise/balduran/juggernaught1.mdl", 8000, 9000, 40, 350, 2800, 150, 6000, 1, 8, 3, "models/thesunrise/cruiser_wreck.mdl", 9.7, 4)
AddNewShip("Raiden Titan", 50000000, "models/thesunrise/balduran/titan1.mdl", 10000, 10000, 40, 300, 3000, 100, 7500, 1, 10, 3, "models/thesunrise/titan_wreck.mdl", 10, 4)
AddNewShip("#INF",1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, "models/thesunrise/balduran/alien_ship.mdl", 100000, 100000, 80, 700, 50000, 240, 10000, 0.1, 1, 0, "models/thesunrise/balduran/frigate4_wreck.mdl", 1, 4)



local meta = FindMetaTable("Player")

function meta:GetShip()
	return self:GetNWEntity("Ship",NULL)
end

function meta:GetType()
	return self:GetNWString("meta_shipmdl","")
end

function GetShipTable(a)
	return SHIPS[tonumber(a)] or ""
end

function ShipIDToString(a)
	return SHIPS[tonumber(a)].name or ""
end

function ShipStringToID(a)
	for k,v in pairs(SHIPS) do
		if v.name == a then
			return k
		end
	end
end

function GetShipPrice(a)
	return SHIPS[a].cost or 0
end

function GetShipValue(a)
	return SHIPS[tonumber(a)].Value or 0
end

function GetShipModel(a)
	return SHIPS[a].Model
end

function GetShipSkin(a)
	return SHIPS[a].Skin
end

function GetShipMan(a)
	return SHIPS[a].Skin
end


function Shop()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos(((ScrW() - 700) * 0.5),((ScrH() - 500) * 0.5))
	DermaPanel:SetSize(700, 500)
	DermaPanel:SetTitle("Shop")
	DermaPanel:SetVisible(true)
	DermaPanel:SetDraggable(false)
	DermaPanel:ShowCloseButton(true)
	DermaPanel:MakePopup()
	
	local PropertySheet = vgui.Create( "DPropertySheet")
	PropertySheet:SetParent( DermaPanel )
	PropertySheet:SetPos( 5, 30 )
	PropertySheet:SetSize( 690, 462 )

	--Sell Tab
	local Sell = vgui.Create( "DPanel" )
	Sell:SetParent( PropertySheet )
	Sell:SetPos( 25, 50 )
	Sell:SetSize( 250, 250 )
	Sell.Paint = function()
		surface.SetDrawColor( 50, 50, 50, 255 )
		surface.DrawRect( 0, 0, Sell:GetWide(), Sell:GetTall() )
	end
 
	local SellList = vgui.Create("DListView")
	SellList:SetParent( Sell )
	SellList:SetPos(5, 5)
	SellList:SetSize(490, 400)
	SellList:SetMultiSelect(false)
	SellList:AddColumn("Name")
	SellList:AddColumn("Amount")
	SellList:AddColumn("Price")
	
	--This is becuse i want to be able to update the list when someone sells somthing
	function SellUpdateList()
		SellList:Clear()
		for k,v in pairs(Cargo) do
			SellList:AddLine(k,v.Name,v.Amt)
		end
	end
	
	SellUpdateList()
	
	local SellNumbers = vgui.Create( "DNumSlider", Sell )
	SellNumbers:SetPos(520, 10)
	SellNumbers:SetSize(150, 50)
	SellNumbers:SetText( "Sell Amount" )
	SellNumbers:SetMin(1)
	SellNumbers:SetMax(1000)
	SellNumbers:SetDecimals(0)
	SellNumbers:SetValue(1)
	
	local SellButton = vgui.Create( "DButton", Sell )
	SellButton:SetText( "Sell" )
	SellButton:SetPos( 520, 60 )
	SellButton:SetSize( 150, 40 )
	SellButton.DoClick = function()
		local item = SellList:GetSelected()[1]
		if item then
			RunConsoleCommand("sun_sell", item:GetColumnText(1), SellNumbers:GetValue())
			////DebugPrint("sun_sell, "..item:GetColumnText(1)..", "..SellNumbers:GetValue())
			timer.Simple(0.5,function() SellUpdateList() end)
		end
	end
	
	PropertySheet:AddSheet( "Sell", Sell, "gui/silkicons/user", false, false, "Sell" )

	--Buy Tab
	local Buy = vgui.Create( "DPanel" )
	Buy:SetParent( PropertySheet )
	Buy:SetPos( 25, 50 )
	Buy:SetSize( 250, 250 )
	Buy.Paint = function()
		surface.SetDrawColor( 50, 50, 50, 255 )
		surface.DrawRect( 0, 0, Buy:GetWide(), Buy:GetTall() )
	end
	
	local BuyList = vgui.Create("DListView")
	BuyList:SetParent( Buy )
	BuyList:SetPos(5, 5)
	BuyList:SetSize(490, 400)
	BuyList:SetMultiSelect(false)
	BuyList:AddColumn("Name")
	BuyList:AddColumn("Price")
	
	--This is becuse i want to be able to update the list when someone sells somthing
	function BuyUpdateList()
		BuyList:Clear()
		//for _,v in pairs(SIM_GetAllItems()) do
		//	BuyList:AddLine(v,SIM_GetPrice(v))
		//end
	end
	
	BuyUpdateList()
	
	local BuyNumbers = vgui.Create( "DNumSlider", Buy )
	BuyNumbers:SetPos(520, 10)
	BuyNumbers:SetSize(150, 50)
	BuyNumbers:SetText( "Buy Amount" )
	BuyNumbers:SetMin(1)
	BuyNumbers:SetMax(10)
	BuyNumbers:SetDecimals(0)
	BuyNumbers:SetValue(1)

	local BuyButton = vgui.Create( "DButton", Buy )
	BuyButton:SetText( "Buy" )
	BuyButton:SetPos( 520, 60 )
	BuyButton:SetSize( 150, 40 )
	BuyButton.DoClick = function()
		local item = BuyList:GetSelected()[1]
		if(item) then
			RunConsoleCommand("sun_buy", item:GetColumnText(1), BuyNumbers:GetValue())
			//DebugPrint("sun_buy, "..item:GetColumnText(1)..", "..BuyNumbers:GetValue())
		end
	end

	PropertySheet:AddSheet( "Buy", Buy, "gui/silkicons/user", false, false, "Buy" )

	--Ship Tab
	local Ship = vgui.Create( "DPanel" )
	Ship:SetParent( PropertySheet )
	Ship:SetPos( 300, 300 )
	Ship:SetSize( 250, 100 )
	Ship.Paint = function()
		surface.SetDrawColor( 50, 50, 50, 255 )
		surface.DrawRect( 0, 0, Ship:GetWide(), Ship:GetTall() )
	end
	
	/*local BuyNumbers2 = vgui.Create( "DNumSlider", Ship )
	BuyNumbers2:SetPos(520, 10)
	BuyNumbers2:SetSize(150, 50)
	BuyNumbers2:SetText( "Insurance Percent" )
	BuyNumbers2:SetMin(1)
	BuyNumbers2:SetMax(100)
	BuyNumbers2:SetDecimals(0)
	BuyNumbers2:SetValue(1)
	
	BuyNumbers:GetValue()
	*/
	//local inLabel= vgui.Create("DLabel", Ship)
	//local price = 0 //GetShipPrice(ShipStringToID(GetShipTable(LocalPlayer():GetType()).name))
	//hook.Add("HUDPaint", "Insurance", function()
	//if BuyNumbers2 then
	//local price = 0 //GetShipPrice(ShipStringToID(GetShipTable(LocalPlayer():GetType()).name))
	//inLabel:SetText("Cost: $"..price * ((BuyNumbers2:GetValue() / 100)*0.1))
	//end
	//end)
	//inLabel:SetPos( 520, 55)
	//inLabel:SetSize( 100, 20)
	
	
	local ShipButton = vgui.Create( "DButton", Ship )
	ShipButton:SetText( "Buy Insurance" )
	ShipButton:SetPos( 520, 370 )
	ShipButton:SetSize( 150, 50 )
	ShipButton.DoClick = function()
		local amount = BuyNumbers2:GetValue()
		if(amount) then
			RunConsoleCommand("sun_insure", amount)
			//DebugPrint("sun_insure, "..amount)
		end
	end
	
	
	local ShipModel = vgui.Create( "DModelPanel", Ship )
	ShipModel:SetPos( 300, 5 )
	ShipModel:SetSize( 300, 300 )
	ShipModel:SetModel( SHIPS[1].Model )
	ShipModel:SetSkin( SHIPS[1].Skin or 0)
	ShipModel:SetAnimSpeed( 0.5 )
	ShipModel:SetAnimated( false )
	ShipModel:SetAmbientLight( Color( 50, 50, 50 ) )
	ShipModel:SetCamPos(Vector(10,14,8))
	ShipModel:SetLookAt(-Vector(1))
	ShipModel:SetFOV( 70 )
	
	local ShipList = vgui.Create("DListView")
	ShipList:SetParent( Ship )
	ShipList:SetPos(5, 5)
	ShipList:SetSize(250, 420)
	ShipList:SetMultiSelect(false)
	ShipList:AddColumn("Name")
	ShipList:AddColumn("Price"):SetFixedWidth( 80 )  
	
	--This is becuse i want to be able to update the list when someone sells somthing
	function ShipUpdateList()
		ShipList:Clear()
		for k,v in pairs(SHIPS) do
			if(v != 0) then
				ShipList:AddLine(ShipIDToString(k),GetShipPrice(k))
			end
		end
	end
	
	ShipUpdateList()
	
	function ShipList:OnRowSelected( LineID, Line )
	
		ShipModel:SetModel(GetShipModel(ShipStringToID(Line:GetValue(1))))
		ShipModel:SetSkin(GetShipSkin(ShipStringToID(Line:GetValue(1))))
		
		ShipItemUpdate(ShipStringToID(Line:GetValue(1)))
	
	end
	
	local ShipButton = vgui.Create( "DButton", Ship )
	ShipButton:SetText( "Buy" )
	ShipButton:SetPos( 520, 370 )
	ShipButton:SetSize( 150, 50 )
	ShipButton.DoClick = function()
		local item = ShipList:GetSelected()[1]
		if(item) then
			RunConsoleCommand("sun_buyship", item:GetColumnText(1))
			//DebugPrint("sun_buyship, "..item:GetColumnText(1))
			timer.Simple(0.5,function() ShipUpdateList() end)
		end
	end
	
	

	
	local hpLabel= vgui.Create("DLabel", Ship)
	hpLabel:SetText("Hp: ")
	hpLabel:SetPos( 260, 360)
	hpLabel:SetSize( 100, 20)
	
	local shLabel= vgui.Create("DLabel", Ship)
	shLabel:SetText("Shield: ")
	shLabel:SetPos( 260, 380)
	shLabel:SetSize( 100, 20)
	
	local spLabel= vgui.Create("DLabel", Ship)
	spLabel:SetText("Speed: ")
	spLabel:SetPos( 260, 400)
	spLabel:SetSize( 100, 20)
	
	
	
	local caLabel= vgui.Create("DLabel", Ship)
	caLabel:SetText("Cargo: ")
	caLabel:SetPos( 360, 360)
	caLabel:SetSize( 100, 20)
	
	local wsLabel= vgui.Create("DLabel", Ship)
	wsLabel:SetText("Warp Speed: ")
	wsLabel:SetPos( 360, 380)
	wsLabel:SetSize( 100, 20)
	
	function ShipItemUpdate(id)
		hpLabel:SetText("Hp: "..SHIPS[tonumber(id)].Health)
		shLabel:SetText("Shield: "..SHIPS[tonumber(id)].Shield)
		spLabel:SetText("Speed: "..SHIPS[tonumber(id)].MaxSpeed/SHIPS[tonumber(id)].Man)
		caLabel:SetText("Cargo: "..SHIPS[tonumber(id)].CargoSize)
		wsLabel:SetText("Warp Speed: "..SHIPS[tonumber(id)].WarpSpeed/SHIPS[tonumber(id)].Man)
		
	end

	PropertySheet:AddSheet( "Ship", Ship, "gui/silkicons/user", false, false, "Ship" )
	
	
	
	

	--Sell Tab
	local SellShip = vgui.Create( "DPanel" )
	SellShip:SetParent( PropertySheet )
	SellShip:SetPos( 25, 50 )
	SellShip:SetSize( 250, 250 )
	
	
	local SellShipButton = vgui.Create( "DButton", SellShip)
	SellShipButton:SetText( "Sell the ship YOU ARE CURRENTLY IN for 80% of the purchase price" )
	SellShipButton:SetPos( 40, 40 )
	SellShipButton:SetSize( 600, 300 )
	SellShipButton.DoClick = function()
		RunConsoleCommand("sun_sellship")
	end
	
	PropertySheet:AddSheet( "Sell Ship", SellShip, "gui/silkicons/user", false, false, "Sell Ship" )
	

	
	
	
	


	--Hangar Tab
	local Hangar2 = vgui.Create( "DPanel" )
	Hangar2:SetParent( PropertySheet )
	Hangar2:SetPos( 25, 50 )
	Hangar2:SetSize( 250, 250 )
	Hangar2.Paint = function()
		surface.SetDrawColor( 50, 50, 50, 255 )
		surface.DrawRect( 0, 0, Hangar2:GetWide(), Hangar2:GetTall() )
	end
 
	local HangarList = vgui.Create("DListView")
	HangarList:SetParent( Hangar2 )
	HangarList:SetSize(250, 420)
	HangarList:SetMultiSelect(false)
	HangarList:AddColumn("Name")
	
	local ShipModel2 = vgui.Create( "DModelPanel", Hangar2 )
	ShipModel2:SetPos( 300, 5 )
	ShipModel2:SetSize( 300, 300 )
	ShipModel2:SetModel( SHIPS[1].Model )
	ShipModel2:SetSkin( SHIPS[1].Skin or 0)
	ShipModel2:SetAnimSpeed( 0.5 )
	ShipModel2:SetAnimated( false )
	ShipModel2:SetAmbientLight( Color( 50, 50, 50 ) )
	ShipModel2:SetCamPos(Vector(10,14,8))
	ShipModel2:SetLookAt(-Vector(1))
	ShipModel2:SetFOV( 70 )
	
	function HangarList:OnRowSelected( LineID, Line )
	
		ShipModel2:SetModel(GetShipModel(ShipStringToID(Line:GetValue(1))))
		ShipModel2:SetSkin(GetShipSkin(ShipStringToID(Line:GetValue(1))))
		
	
	end
	
	
	--This is becuse i want to be able to update the list when someone Hangars somthing

		function HangarUpdateList()
		HangarList:Clear()
		//for k,v in pairs(Hangar) do
				//angarList:AddLine(v)
		//end
	end
	HangarUpdateList()
	
	
	local HangarButton = vgui.Create( "DButton", Hangar2 )
	HangarButton:SetText( "Hangar" )
	HangarButton:SetPos( 520, 370 )
	HangarButton:SetSize( 150, 40 )
	HangarButton.DoClick = function()
		local item = HangarList:GetSelected()[1]
		if item then
			RunConsoleCommand("sun_hangar", item:GetColumnText(1), 1)
			timer.Simple(0.5,function() HangarUpdateList() end)
		end
	end
	
	PropertySheet:AddSheet( "Hangar", Hangar2, "gui/silkicons/user", false, false, "Hangar" )
	
	
	
	
	
	
	
	
	
	
	
	--Bank Tab
	local Bank = vgui.Create( "DPanel" )
	Bank:SetParent( PropertySheet )
	Bank:SetPos( 25, 50 )
	Bank:SetSize( 250, 250 )
	Bank.Paint = function()
		surface.SetDrawColor( 50, 50, 50, 255 )
		surface.DrawRect( 0, 0, Bank:GetWide(), Bank:GetTall() )
		draw.RoundedBox(4, 12, 275, Bank:GetWide()-25, Bank:GetTall()-275, Color(15,15,15,200))
		draw.RoundedBox(4, 12, -50, Bank:GetWide()-25, Bank:GetTall()-225, Color(15,15,15,200))
	end

	local BankInvStore = vgui.Create("DListView")
	BankInvStore:SetParent( Bank )
	BankInvStore:SetPos(375, 25)
	BankInvStore:SetSize(250, 100)
	BankInvStore:SetMultiSelect(false)
	BankInvStore:AddColumn("Item")
	BankInvStore:AddColumn("Amount")

	local BankInv = vgui.Create("DListView")
	BankInv:SetParent( Bank )
	BankInv:SetPos(50, 25)
	BankInv:SetSize(250, 100)
	BankInv:SetMultiSelect(false)
	BankInv:AddColumn("Item")
	BankInv:AddColumn("Amount")
	BankInv.ItemUpdateList = function(self)
		self:Clear()
		for k,v in pairs(Cargo) do
			//if v > 0 then
				self:AddLine(k, v.Name)
			//end
		end
	end
	timer.Simple(0.2,function(self) BankInv:ItemUpdateList() end)

	local DepositButton5 = vgui.Create( "DButton", Bank )
	DepositButton5:SetText( "Transfer to Bank" )
	DepositButton5:SetPos( 95, 130 )
	DepositButton5:SetSize( 150, 20 )
	DepositButton5.DoClick = function()
		chat.AddText(self,Color(200,0,0,0),"This feature is not complete yet!")
	end

	local DepositButton6 = vgui.Create( "DButton", Bank )
	DepositButton6:SetText( "Transfer to Inventory" )
	DepositButton6:SetPos( 425, 130 )
	DepositButton6:SetSize( 150, 20 )
	DepositButton6.DoClick = function()
		chat.AddText(self,Color(200,0,0,0),"This feature is not complete yet!")
	end
	
	local bLabel= vgui.Create("DLabel", Bank)
	bLabel:SetText("Money: ")
	bLabel:SetPos( 315, 290)
	bLabel:SetSize( 100, 20)
	
	function BankUpdate()
		//bLabel:SetText("Money: "..LocalPlayer():GetBank())
	end
	
	BankUpdate()
	
	
	local BankNumbers = vgui.Create( "DNumSlider", Bank )
	BankNumbers:SetPos(25, 300)
	BankNumbers:SetSize(625, 50)
	BankNumbers:SetText( "Amount" )
	BankNumbers:SetMin(1)
	BankNumbers:SetMax(1000000)
	BankNumbers:SetDecimals(0)
	BankNumbers:SetValue(1)
	
	
	
	local DepositButton1 = vgui.Create( "DButton", Bank )
	DepositButton1:SetText( "Deposit" )
	DepositButton1:SetPos( 50, 375 )
	DepositButton1:SetSize( 125, 25 )
	DepositButton1.DoClick = function()
		RunConsoleCommand("sun_bank", 0, BankNumbers:GetValue())
		timer.Simple(0.2,function() BankUpdate() end)
	end
	
	local DepositButton3 = vgui.Create( "DButton", Bank )
	DepositButton3:SetText( "Withdraw" )
	DepositButton3:SetPos( 500, 375 )
	DepositButton3:SetSize( 125, 25 )
	DepositButton3.DoClick = function()
		RunConsoleCommand("sun_bank", 1, BankNumbers:GetValue())
		timer.Simple(0.2,function() BankUpdate() end)
	end
	
	PropertySheet:AddSheet( "Bank", Bank, "gui/silkicons/user", false, false, "Bank" )
	

end
net.Receive("sun_shop",Shop)