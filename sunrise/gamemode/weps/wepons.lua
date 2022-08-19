local Weapons = {}
WepTbl = {}

function Weapons.Add(tool,sell,price,func)
    table.insert(WepTbl,{tool,sell,price,func})
end

Weps_Sim_Get = {}

function Weps_Sim_Get.Get()
    return WepTbl
end

if SERVER then
    
    concommand.Add("sun_buy",function(ply,cmd,args)
        for _,v in pairs(WepTbl) do
			if v[1] == tostring(args[1]) then
                if ply:GetNWInt("Money",0) >= v[3] then
                    ply:SetNWInt("Money",ply:GetNWInt("Money",0)-v[3])
                    Cargo:Set(ply,{Name = v[1],Amt = math.Round(v[3])}) 
                else 
                    ply:ChatPRint("Not enough "..tostring(v[3]))
                end
            end
		end
    end)


    concommand.Add("sun_sell",function(ply,cmd,args)
        for _,v in pairs(ply.Cargo) do
			if v.Name == tostring(args[1]) then
                //if tonumber(args[2]) <= v.Amt then
                    if v.Name == "Rock" then
                        ply:SetNWInt("Rock",0)
                    end
                    local new_amt_calc = 0
                    for i = 1,v.Amt do new_amt_calc = new_amt_calc + 5 end
                    ply:SetNWInt("Money",ply:GetNWInt("Money",0)+new_amt_calc)
                    Cargo:Remove(ply,{Name = v.Name,Amt = tonumber(v.Amt)})
                //else 
                   // ply:ChatPrint("Not enough "..tostring(v.Name))
                end
            //end
		end
    end)
end



function Weapons.DmgTake(targ)
    local Dmg = DamageInfo()
    Dmg:SetAttacker(targ)
    Dmg:SetInflictor(targ)
    Dmg:SetDamage(10)
end

Weapons.Add("Miner",true,100,function(self,ship)
    if cooldown == nil then cooldown = 0 end
    if cooldown >= CurTime() then return end
    cooldown = CurTime() + 2
    local ent = ship:GetNWEntity("LockedOnTarg",NULL)
    print(ent.Entity)
    if ent.Entity == NULL then return end
    if not IsValid(ent.Entity) then return end
    if ent.Entity:GetPos():Distance(ship:GetPos()) <= 500 then
        if ent.Entity:GetClass() == "sunrise_asteroid" then 
            ship:SetNWInt("Rock",ship:GetNWInt("Rock")+math.random(5,10))
            Cargo:Set(ship,{Name = "Rock", Amt = ship:GetNWInt("Rock")}) 
            local ed = EffectData()
            ed:SetEntity(ent.Entity)
            ed:SetStart(ship:GetPos())
            util.Effect("sunrise_mininglaser",ed)
            ship:EmitSound("sunrise/weapons/laser_0"..tostring(math.random(1,2))..".wav", 100,50)
        end
    end
end)

Weapons.Add("Lazor",true,100,function(self,ship)
    if cooldown == nil then cooldown = 0 end
    if cooldown >= CurTime() then return end
    cooldown = CurTime() + 2
   // local ent = self:GetTrace(ship,100)
    local ent = ship:GetNWEntity("LockedOnTarg",NULL)
    if ent.Entity == NULL then return end
    if not IsValid(ent.Entity) then return end
    if ent.Entity == ship then return end
    if ent.Entity == self then return end
    if ent.Entity:GetPos():Distance(ship:GetPos()) <= 500 then
       // Weapons.DmgTake(ship)
        local ed = EffectData()
	    ed:SetEntity(ent.Entity)
	    ed:SetOrigin(ship:GetPos())
	    ed:SetMagnitude(0.3)
	    util.Effect("sunrise_laser",ed)
        if ent.Entity.TakeDMG != nil then ent.Entity:TakeDMG(10) end
        //d = d or math.random(5,15)
        //targ:TakeDMG(d,ship)
        ship:EmitSound("sunrise/weapons/laser_0"..tostring(math.random(1,2))..".wav", 100,50)
    end
end)

local function PirateTrace(ent)
        local distance = 0
        local pos
        local ConeEnts = ents.FindInSphere(ent:GetPos(), 500)
        for k,v in pairs(ConeEnts) do
                if v:GetClass() == "sr_playership" or v:GetClass() == "sunrise_asteroid" then
                    local dist = v:GetPos():Distance(ent:GetPos())
                    if distance < dist  then
                        pos = v
                    end
                    
                    distance = dist
                end
        end
        return pos,dist
end

Weapons.Add("Lazor_Pirate",false,0,function(self,ship)
    if cooldown == nil then cooldown = 0 end
    if cooldown >= CurTime() then return end
    cooldown = CurTime() + 2
    local ent = PirateTrace(self)
    if ent == NULL then return end
    if not IsValid(ent) then return end
    if ent:GetPos():Distance(ship:GetPos()) <= 500 then
        local ed = EffectData()
	    ed:SetEntity(self)
	    ed:SetOrigin(ent:GetPos())
	    ed:SetMagnitude(0.3)
	    util.Effect("sunrise_laser",ed)
        if ent.TakeDMG != nil then ent:TakeDMG(10) end
        ship:EmitSound("sunrise/weapons/laser_0"..tostring(math.random(1,2))..".wav", 100,50)
    end
end)

function WepShoot(self,ply)
    for k,v in pairs(WepTbl) do
        if v[1] == ply:GetNWString("Cargo_Sel","") then
            v[4](self,ply)
        end
    end
end

function WepShootPirate(self,ply)
    for k,v in pairs(WepTbl) do
        if v[1] == "Lazor_Pirate" then
            v[4](self,ply)
        end
    end
end
