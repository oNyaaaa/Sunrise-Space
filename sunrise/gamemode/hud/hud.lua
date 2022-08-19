local function TopBar()

	local GOverlay = surface.GetTextureID( "gui/center_gradient" )

	local cargo = 0

	local Wide = ScrW()
	local Tall = 37
 
	local X = 0
	local Y = -1
	
	local ply = LocalPlayer()
	
	draw.RoundedBox(0, X, Y, Wide, Tall, Color(0,0,0,200))
	surface.SetDrawColor( 100,100,100,255 )
	surface.DrawOutlinedRect( X-0, Y-0, Wide+0, Tall+0 )

	surface.SetTexture( GOverlay )
	surface.SetDrawColor( 150, 150, 150, 75)
	surface.DrawTexturedRect( X, Y, Wide, Tall )
	
	//for k, v in pairs( Cargo ) do
		//cargo = cargo + v
	//end
	
	sunrisetime = os.date("%I:%M:%S %p")
	draw.SimpleText("Time - "..sunrisetime, "Default", Wide-75, 17, Color(255, 255, 255, 255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	draw.SimpleText("Money: "..tostring(LocalPlayer():GetNWInt("Money",0)),"Default",50,17,Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	//draw.SimpleText("Cargo: "..tostring(cargo).."/"..tostring(LocalPlayer():GetShip():GetMaxCargo()),"Hud",150,17,Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
end

local function DrawHP()
	local MaxHP = 100 //LocalPlayer():GetShip():GetMaxHP()
	local HP = tonumber(LocalPlayer():GetShip():GetNWFloat("Health",0)) //LocalPlayer():GetShip():GetHP()
	local MaxShield = 100//LocalPlayer():GetShip():GetMaxShield()
	local Shield = 100 //LocalPlayer():GetShip():GetShield()

	draw.RoundedBox(6, 110, ScrH() - 140, 250, 120, Color(0,0,0,150))
	
	local Wide = 230 
	local Tall = 20 

	//and the position  
	local X = 120
	local Y = ScrH() - 30 - Tall
	
	Y = Y - 40

	//create a fraction of our health, so we can do some nice and smooth resizing  
	local Frac = math.Clamp(HP / MaxHP,0,1)
	
	draw.RoundedBox(4, X - 3, Y - 3, 236, 26, Color(90,18,18,255))
	
	surface.SetDrawColor(180 ,16 ,29 ,255)
	surface.DrawRect(X,Y,Wide * Frac,Tall)
	
	draw.SimpleText(math.Round((HP / MaxHP) * 100) .. "%", "Default", X + 120, Y + 10 , Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	
	Y = Y - 40
	
	/*Frac = math.Clamp(Shield / MaxShield,0,1)

	draw.RoundedBox(4, X - 3, Y - 3, 236, 26, Color(18,34,79,255))

	surface.SetDrawColor(73 ,98 ,166 ,255)
	surface.DrawRect(X,Y,Wide * Frac,Tall)

	draw.SimpleText(math.Round((Shield / MaxShield) * 100) .. "%", "Default", X + 120, Y + 10 , Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	*/
end

local function DrawSpaceObjects()
	local ply = LocalPlayer()
	if ply:GetNWBool("Docked",false) == true then
        return
    end
	for _,v in pairs(ents.FindByClass("sunrise_pirate")) do
		if v:GetPos():Distance(LocalPlayer():GetPos()) <= 2000 then
			local spos2 = v:GetPos():ToScreen()
			surface.SetDrawColor(222,8,8,167)
			surface.DrawLine(spos2.x-2,spos2.y-5,spos2.x+2,spos2.y-5)
			surface.DrawLine(spos2.x-2,spos2.y+5,spos2.x+2,spos2.y+5)
			surface.DrawLine(spos2.x-5,spos2.y-2,spos2.x-5,spos2.y+2)
			surface.DrawLine(spos2.x+5,spos2.y-2,spos2.x+5,spos2.y+2)
		end
	end
	for _,v in pairs(ents.FindByClass("sunrise_asteroidfield")) do
		local spos = v:GetPos():ToScreen()
		//if ply:GetShip():GetTarget() == v then
			//surface.SetDrawColor(50,222,50,190)
		//else
			surface.SetDrawColor(222,222,222,190)
		//end
		surface.DrawLine(spos.x-2,spos.y-5,spos.x+2,spos.y-5)
		surface.DrawLine(spos.x-2,spos.y+5,spos.x+2,spos.y+5)
		surface.DrawLine(spos.x-5,spos.y-2,spos.x-5,spos.y+2)
		surface.DrawLine(spos.x+5,spos.y-2,spos.x+5,spos.y+2)
		draw.SimpleText(tostring(math.ceil((ply:GetPos():Distance(v:GetPos())))).." km.","TargetIDSmall",spos.x+20,spos.y-10,Color(200,200,255,200))
		draw.SimpleText("Asteroid Field "..tostring(v:EntIndex()),"TargetIDSmall",spos.x+20,spos.y-2,Color(255,255,255,200))
	end
	for _,v in pairs(ents.FindByClass("sunrise_station")) do
		//if ply:GetShip():GetTarget() == v then
			//surface.SetDrawColor(50,222,50,190)
		//else
			surface.SetDrawColor(222,222,222,190)
		//end
		local spos = v:GetPos():ToScreen()
		surface.SetDrawColor(222,222,222,190)
		surface.DrawOutlinedRect(spos.x-7,spos.y-7,15,15)
		draw.SimpleText(tostring(math.ceil((ply:GetPos():Distance(v:GetPos())))).." km.", "TargetIDSmall",spos.x+20,spos.y-10,Color(200,200,255,200))
		draw.SimpleText("Station","TargetIDSmall",spos.x+20,spos.y-2,Color(255,255,255,200))
	end
	for _,v in pairs(ents.FindByClass("sunrise_jumpgate")) do
		//if ply:GetShip():GetTarget() == v then
			//surface.SetDrawColor(50,222,50,190)
		//else
			surface.SetDrawColor(222,222,222,190)
		//end
		local spos = v:GetPos():ToScreen()
		surface.SetDrawColor(222,222,222,190)
		surface.DrawOutlinedRect(spos.x-7,spos.y-7,15,15)
		draw.SimpleText(tostring(math.ceil((ply:GetPos():Distance(v:GetPos()))/SpeedDevider)).." km.", "TargetIDSmall",spos.x+20,spos.y-10,Color(200,200,255,200))
		draw.SimpleText("Jumpgate","TargetIDSmall",spos.x+20,spos.y-2,Color(255,255,255,200))
	end
	/*for _,v in pairs(self:GetAllShips()) do
		local distance = math.ceil((ply:GetPos():Distance(v:GetPos()))/SpeedDevider)
		if v != ply:GetShip() and distance < 600 then
			local spos = v:GetPos():ToScreen()
			if ply:GetShip():GetTarget() == v then
				if v.Target == self then
					surface.SetDrawColor(Color(2,2,222,255))
					surface.DrawOutlinedRect(spos.x-15,spos.y-15,spos.x+30,spos.y+30)
				else
					surface.SetDrawColor(50,222,50,190)
				end
			else
				if v.Target == self then
					surface.SetDrawColor(Color(255,0,0,255))
					surface.DrawOutlinedRect(spos.x-15,spos.y-15,spos.x+30,spos.y+30)
				else
					surface.SetDrawColor(222,222,222,190)
				end
			end
			local txt = "Pirate"
			local Col = Color(255,2,2,200)
			if v.GetPlayer and v:GetPlayer() and v:GetPlayer():IsValid() then
				txt = "Player "..tostring(v:GetPlayer():Name())
				Col = Color(200,255,200,200)
			elseif v.IsPolice then
				txt = "Interstellar Protection Officer"
				Col = Color(0,0,255,200)
			end
			surface.DrawLine(spos.x-10,spos.y-10,spos.x-10,spos.y-5)
			surface.DrawLine(spos.x-10,spos.y-10,spos.x-5,spos.y-10)
			surface.DrawLine(spos.x+10,spos.y-10,spos.x+10,spos.y-5)
			surface.DrawLine(spos.x+10,spos.y-10,spos.x+5,spos.y-10)
			surface.DrawLine(spos.x-10,spos.y+10,spos.x-10,spos.y+5)
			surface.DrawLine(spos.x-10,spos.y+10,spos.x-5,spos.y+10)
			surface.DrawLine(spos.x+10,spos.y+10,spos.x+10,spos.y+5)
			surface.DrawLine(spos.x+10,spos.y+10,spos.x+5,spos.y+10)
			draw.SimpleText(tostring(distance).." km.","TargetIDSmall",spos.x+20,spos.y-10,Color(200,200,255,200))
			draw.SimpleText(tostring(txt),"TargetIDSmall", spos.x+20,spos.y,Col)
			draw.SimpleText(tostring(v:GetNWString("OwnerName")),"TargetIDSmall", spos.x,spos.y+10,Color(255,200,100,200),1)
			draw.SimpleText(tostring(v:GetNWString("OwnerFaction")),"TargetIDSmall", spos.x,spos.y+20,Color(100,200,200,200),1)
		end
	end*/
end
local DermaPanel = NULL 
function Sun_OpenDockMenu(um)
	if DermaPanel and IsValid(DermaPanel) then return end
	DermaPanel = vgui.Create( "DFrame" )
	
	local Width = 150
	local Height = 75
	DermaPanel:SetPos(((ScrW() - Width) * 0.5),((ScrH() - Height) * 0.5))
	DermaPanel:SetSize(Width, Height)
	DermaPanel:SetTitle("Do you want to dock?")
	DermaPanel:SetVisible(true)
	DermaPanel:SetDraggable(false)
	DermaPanel:ShowCloseButton(false)
	DermaPanel:MakePopup()

	local DPO = vgui.Create( "DPanel", DermaPanel )
		DPO:SetPos( DPO:GetWide()-56, DPO:GetTall() )
		DPO:SetSize( 135, 45 )
		DPO.Paint = function()
			surface.SetDrawColor( 0, 0, 0, 255 )
			surface.DrawRect( 0, 3, DPO:GetWide(), DPO:GetTall() )
	end

	
	local Yes = vgui.Create( "DButton" )
	Yes:SetParent( DermaPanel )
	Yes:SetText( "Yes" )
	Yes:SetPos( 15, 30 )
	Yes:SetSize( 55, 35 )
	Yes.DoClick = function ()
		RunConsoleCommand("sun_dodock")
		DermaPanel:Close()
		DermaPanel = NULL 
	end
	
	local No = vgui.Create("DButton")
	No:SetParent( DermaPanel )
	No:SetText( "No" )
	No:SetPos( 80, 30  )
	No:SetSize( 55, 35 )
	No.DoClick = function ()
		RunConsoleCommand("sun_stopdock")
		DermaPanel:Close()
		DermaPanel = NULL 
	end

end
net.Receive("sun_opendockmenu",Sun_OpenDockMenu)
local DermaPanel2 = NULL 
function Sun_OpenUndockMenu(um)
	if DermaPanel2 and IsValid(DermaPanel2) then return end
	local DermaPanel2 = vgui.Create( "DFrame" )
	local Width = 150
	local Height = 75
	DermaPanel2:SetPos(((ScrW() - Width) * 0.5),((ScrH() - Height) * 0.5))
	DermaPanel2:SetSize(Width, Height)
	DermaPanel2:SetTitle("Do you want to undock?")
	DermaPanel2:SetVisible(true)
	DermaPanel2:SetDraggable(false)
	DermaPanel2:ShowCloseButton(false)
	DermaPanel2:MakePopup()

local DPO = vgui.Create( "DPanel", DermaPanel2 )
	DPO:SetPos( DPO:GetWide()-56, DPO:GetTall() )
	DPO:SetSize( 135, 45 )
	DPO.Paint = function()
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawRect( 0, 3, DPO:GetWide(), DPO:GetTall() )
end

	
	local Yes = vgui.Create("DButton",DermaPanel2)
	Yes:SetText( "Yes" )
	Yes:SetPos( 15, 30 )
	Yes:SetSize( 55, 35 )
	Yes.DoClick = function()
		RunConsoleCommand("sun_doundock")
		DermaPanel2:Close()
		DermaPanel2 = NULL
	end
	
	local No = vgui.Create("DButton",DermaPanel2)
	No:SetText( "No" )
	No:SetPos( 80, 30  )
	No:SetSize( 55 , 35 )
	No.DoClick = function()
		RunConsoleCommand("sun_stopundock")
		DermaPanel2:Close()
		DermaPanel2 = NULL
	end
end
net.Receive("sun_openundockmenu",Sun_OpenUndockMenu)


function DrawSpeed()
	//local txt = "Warping"
	//if !LocalPlayer():GetShip():IsWarping() then
	if IsValid(LocalPlayer():GetNWEntity("Ship",nil)) then
		local txt = "Speed: "..tostring(math.Round(LocalPlayer():GetNWEntity("Ship",nil):GetVelocity():Length()/2)).." KM/s"
	//end
		draw.SimpleText(txt,"Default",ScrW()*0.5,ScrH()-50,Color(255,255,255,255),1)
	end
end

function DrawSkills()

	local ply = LocalPlayer()

	local Wide = 150
	local Tall = 300
 
	local X = 0
	local Y = 100
	
	draw.RoundedBox(0, X, Y, Wide, Tall, Color(0,0,0,200))
	
	surface.SetDrawColor(100,100,100,255)
	surface.DrawOutlinedRect( X, Y, Wide, Tall )

	Y = Y + 15
	
	draw.SimpleText("Skills", "Default", Wide/2 + X, Y , Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	
	Y = Y + 15
	X = X + 5
	
	//for i = 1,3 do
	//for k,v in pairs(Skill) do
	
		local lvl = 0//ply:GetSkill(k)
		local xp = 0//ply:GetSkillXP(k)
		local sk = 0//ply:GetSkillSK(k)

		draw.RoundedBox(2, X, Y, Wide - 10, 35, Color(100,100,100,255))
		draw.RoundedBox(2, X+2, Y+2.45, Wide - 14.5, 31, Color(10,10,10,255))
		draw.SimpleText("Level: "..tostring(lvl), "Default", X+10, Y+10 , Color(255,255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
		draw.RoundedBox(2, X, Y + 45, Wide - 10, 35, Color(100,100,100,255))
		draw.RoundedBox(2, X+2, Y+2.45+ 45, Wide - 14.5, 31, Color(10,10,10,255))
		draw.SimpleText("XP: "..tostring(xp), "Default", X+10, Y+15+40, Color(255,255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
		draw.RoundedBox(2, X, Y + 95, Wide - 10, 35, Color(100,100,100,255))
		draw.RoundedBox(2, X+2, Y+2.45+ 95, Wide - 14.5, 31, Color(10,10,10,255))
		draw.SimpleText("Skill: "..tostring(sk), "Default", X+10, Y+15+90 , Color(255,255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
		
		Y = Y + 45
	
	//end
	//end
end

function SkillsBar()
	local ply = LocalPlayer()

	local Wide = 150
	local Tall = 80
 
	local X = ScrW()-151
	local Y = 100
	
	draw.RoundedBox(0, X, Y, Wide, Tall, Color(0,0,0,200))
	
	surface.SetDrawColor(100,100,100,255)
	surface.DrawOutlinedRect( X, Y, Wide, Tall )

	Y = Y + 15
	
	draw.SimpleText("Action Bar", "Default", Wide/2 + X, Y , Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	
	Y = Y + 15
	X = X + 5
	
		local lvl = 0
		local xp = 0
		local sk = 0

		draw.RoundedBox(2, X, Y, Wide - 10, 35, Color(100,100,100,255))
		draw.RoundedBox(2, X+2, Y+2.45, Wide - 14.5, 31, Color(10,10,10,255))
		draw.SimpleText("Using: "..tostring(lvl), "Default", X+10, Y+10 , Color(255,255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)

		Y = Y + 45

end

function GetHeadPos( ply )
	local BoneIndx = ply:LookupBone("ValveBiped.Bip01_Head1")
	local BonePos, BoneAng = ply:GetBonePosition( BoneIndx )
	
	return BonePos
end

function DrawPlayers()
	local k = nil
	local v = nil
	local maxdistance = 2048
	local maxfullalpha = 512
	
	local playerm = surface.GetTextureID("gui/silkicons/user")
	local vipm = surface.GetTextureID("gui/silkicons/star")
	local devm = surface.GetTextureID("gui/silkicons/wrench")
	local amat = surface.GetTextureID("gui/silkicons/shield")
	local mapmat = surface.GetTextureID("gui/silkicons/world")
	
	for k, v in pairs(player.GetAll()) do
		if v != NULL and v:IsValid() and v:Nick() != LocalPlayer():Nick() and v:GetColor() and v:GetNWBool("Docked",false) == true then
		
			Position = v:GetShootPos()
			if v:GetNetworkedBool("Ragdolled") and ents.GetByIndex( v:GetNetworkedInt( "Ragdoll" ) ) != NULL then
				r = ents.GetByIndex( v:GetNetworkedInt( "Ragdoll" ) )
				if r != NULL then Position = r:GetPos() end
			end
		
			local pDistance = LocalPlayer():GetShootPos():Distance( Position )
			
			//Check if the player is even visible (e.g. no wall in between)
			local tracedata = {}
			tracedata.start = LocalPlayer():GetShootPos()
			tracedata.endpos = Position
			local trace = util.TraceLine(tracedata)
			
			if pDistance < maxdistance and pDistance > 64 and v:Alive() and trace.HitWorld == false then
				//Calculate alpha
				local dAlpha = 128
				if pDistance > maxfullalpha then
					dAlpha = 128 - math.Clamp((pDistance - maxfullalpha) / (maxdistance-maxfullalpha)*128, 0, 128)
				end
				
				if v:GetNetworkedBool("Ragdolled") and ents.GetByIndex( v:GetNetworkedInt( "Ragdoll" ) ) != NULL then
					dPos = GetHeadPos( r ):ToScreen()
				else
					dPos = GetHeadPos( v ):ToScreen()
				end
				
				dPos.y = dPos.y - 75
				dPos.y = dPos.y + (100 * (GetHeadPos(v):Distance(LocalPlayer():GetShootPos()) / 2048)) * 0.5
				
				//Icon
				if v:Team() == 6 then
					Icon = playerm
				elseif v:Team() == 5 then
					Icon = vipm
				elseif v:Team() == 4 then
					Icon = mapmat
				elseif v:Team() == 3 then
					Icon = amat
				elseif v:Team() == 2 then
					Icon = amat
				else
					Icon = devm
				end
				
				Nick = v:Nick()
				
				surface.SetFont( "ScoreboardText" )
				local w = surface.GetTextSize( Nick )
				local teamColor = team.GetColor( v:Team() )
				ow = w
				w = w + 26
				
				draw.RoundedBox( 6, dPos.x-((w+10)/2), dPos.y-10, w+10, 25, Color(0, 0, 0, dAlpha) )
				draw.DrawText( Nick, "ScoreboardText", dPos.x + 14, dPos.y-6, Color(teamColor.r, teamColor.g, teamColor.b, dAlpha), 1 )
				surface.SetTexture( Icon )
				surface.SetDrawColor( 255, 255, 255, dAlpha)
				surface.DrawTexturedRect(dPos.x - (ow / 2) - 12, dPos.y - 6, 16, 16)
			end
		end
	end
end

function GetTrace(self,ship,a)
	// a <= 0 then return {} end
	local ply = ship
	local td = {}
	td.start = self:GetPos()
	td.endpos = self:GetPos()+(ply:GetAimVector()*(a or 500))
	td.filter = {ply,self}
	td.mins = Mins
	td.maxs = Maxs
	return util.TraceHull(td)
end

function GM:HUDPaint()
	local ply = LocalPlayer()
	if !ply or !ply:IsValid() then return end
	if ply:GetNWInt("DeathTimer") > CurTime() and ply:GetNWBool("loaded") then
		draw.SimpleText("You have died. Respawning in " ..tostring(math.ceil(ply:GetNWInt("DeathTimer")-CurTime())),"Default",ScrW()*0.5,ScrH()*0.5,Color(255,255,255,255),1)
	end
	if not ply:Alive() then return end
	local x, y
	
	if ( LocalPlayer()== LocalPlayer() && LocalPlayer():ShouldDrawLocalPlayer() ) then
		local trace =  GetTrace(LocalPlayer():SetNWEntity("Ship",self),LocalPlayer()) 
		
		local coords = trace.HitPos:ToScreen()
		x, y = coords.x, coords.y

	else
		x, y = ScrW() / 2.0, ScrH() / 1.7 
	end
	
	local scale = 10 
	local LastShootTime = 0 

	scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))

	surface.SetDrawColor( 0, 255, 0, 255 )
	
-- Draw a crosshair
	local gap = 1 * scale
	local length = gap + 1 * scale

	surface.DrawLine( x - length, y, x - gap, y )	
	surface.DrawLine( x + length, y, x + gap, y )	
	surface.DrawLine( x, y - length, x, y - gap )	
	surface.DrawLine( x, y + length, x, y + gap )	

	SkillsBar()
	TopBar()
	DrawHP()
	DrawSpaceObjects()
	DrawSpeed()
	DrawSkills()
	DrawPlayers()
end

local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudCrosshair"] = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then
		return false
	end
end)