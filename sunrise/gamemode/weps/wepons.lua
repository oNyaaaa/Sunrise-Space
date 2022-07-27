local Weapons = {}
local WepTbl = {}

function Weapons.Add(tool,func)
    table.insert(WepTbl,{tool,func})
end

Weapons.Add("Miner",function(self,ship)
    if cooldown == nil then cooldown = 0 end
    if cooldown >= CurTime() then return end
    cooldown = CurTime() + 2
    local ent = self:GetTrace(ship)
    if ent == NULL then return end
    if not IsValid(ent.Entity) then return end
    if ent.Entity:GetPos():Distance(ship:GetPos()) <= 500 then
        local ed = EffectData()
        ed:SetEntity(ent.Entity)
        ed:SetStart(ship:GetPos())
        util.Effect("sunrise_mininglaser",ed)
        ship:EmitSound("sunrise/weapons/laser_0"..tostring(math.random(1,2))..".wav", 100,50)
    end
end)

function WepShoot(self,ply)
    for k,v in pairs(WepTbl) do
        if v[1] == "Miner" then
            v[2](self,ply)
        end
    end
end
