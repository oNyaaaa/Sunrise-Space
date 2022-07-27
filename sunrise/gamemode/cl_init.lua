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

//

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
		//for k,v in pairs(Cargo) do
			//if v > 0 then
				self:AddLine("test","test")
			//end
		//end
	end
	
	QMenu.ItemList:ItemUpdateList()
	
	local EquipButton = vgui.Create( "DButton", QMenu.Inventory )
	EquipButton:SetText( "Equip" )
	EquipButton:SetPos( 520, 25 )
	EquipButton:SetSize( 150, 20 )
	EquipButton.DoClick = function()
		local item = QMenu.ItemList:GetSelected()[1]
		if(item) then
			RunConsoleCommand("sun_select",item:GetColumnText(1))
		end
	end
	

	QMenu.Fleets = vgui.Create("DPanel", QMenu.Tabs)
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
	end
	
	
	
	/*
	QMenu.Stats = vgui.Create("DPanel", QMenu.Tabs)
	QMenu.Stats:SetPos(5,5)
	QMenu.Stats:SetSize(590,390)
	*/
	
	
	
	
    QMenu:SetVisible( false )
	
	QMenu.Tabs:AddSheet( "Inventory", QMenu.Inventory, "gui/silkicons/user", false, false )
	QMenu.Tabs:AddSheet( "Fleets", QMenu.Fleets, "gui/silkicons/user", false, false )
	
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
