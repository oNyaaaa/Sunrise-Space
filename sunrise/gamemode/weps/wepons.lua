local Weapons = {}
local WepTbl = {}

function Weapons.Add(tool,func)
    table.insert(WepTbl,{tool,func})
end

function Weapons.DmgTake(targ)
    local Dmg = DamageInfo()
    Dmg:SetAttacker(targ)
    Dmg:SetInflictor(targ)
    Dmg:SetDamage(10)
end

Weapons.Add("Miner",function(self,ship)
    if cooldown == nil then cooldown = 0 end
    if cooldown >= CurTime() then return end
    cooldown = CurTime() + 2
    local ent = self:GetTrace(ship)
    if ent == NULL then return end
    if not IsValid(ent) then return end
    if ent:GetPos():Distance(ship:GetPos()) <= 500 then
        if ent:GetClass() == "sunrise_asteroid" then 
            ship:SetNWInt("Rock",ship:GetNWInt("Rock")+math.random(5,10))
            Cargo:Set(ship,{Name = "Rock", Amt = ship:GetNWInt("Rock")}) 
            local ed = EffectData()
            ed:SetEntity(ent)
            ed:SetStart(ship:GetPos())
            util.Effect("sunrise_mininglaser",ed)
            ship:EmitSound("sunrise/weapons/laser_0"..tostring(math.random(1,2))..".wav", 100,50)
        end
    end
end)

Weapons.Add("Lazor",function(self,ship)
    if cooldown == nil then cooldown = 0 end
    if cooldown >= CurTime() then return end
    cooldown = CurTime() + 2
    local ent = self:GetTrace(ship,100)
    if ent == NULL then return end
    if not IsValid(ent) then return end
    if ent:GetPos():Distance(ship:GetPos()) <= 500 then
       // Weapons.DmgTake(ship)
        local ed = EffectData()
	    ed:SetEntity(ent)
	    ed:SetOrigin(ship:GetPos())
	    ed:SetMagnitude(0.3)
	    util.Effect("sunrise_laser",ed)
        if ent.TakeDMG != nil then ent:TakeDMG(10) end
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

Weapons.Add("Lazor_Pirate",function(self,ship)
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
            v[2](self,ply)
        end
    end
end

function WepShootPirate(self,ply)
    for k,v in pairs(WepTbl) do
        if v[1] == "Lazor_Pirate" then
            v[2](self,ply)
        end
    end
end
