local Weapons = {}

function Weapons.Add(tool,func)
    local Weps = {}

    table.insert(Weps,{tool,func})
    return Weps
end

local WepTbl = Weapons.Add("Miner",function(self,ship)
    //print(ship)
    local ent = self:GetTrace(ship)
    if ent.Entity:GetPos():Distance(ship:GetPos()) <= 500 then
        local ed = EffectData()
        ed:SetEntity(ent.Entity)
        ed:SetStart(ship:GetPos())
        util.Effect("sunrise_mininglaser",ed)
        ship:EmitSound("sunrise/weapons/laser_0"..tostring(math.random(1,2))..".wav", 100,50)
    end
end)

function WepShoot(self,ply)
    WepTbl[1][2](self,ply)
end
