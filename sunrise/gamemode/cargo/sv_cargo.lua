Cargo = {}

util.AddNetworkString("Cargo_Resc")

function Cargo:Get(ply) 
    net.Start("Cargo_Resc")
        net.WriteTable(ply.Cargo or {})
    net.Send(ply)
    return ply.Cargo or {}
end

function Cargo:Set(ply,id,cargo) 
    ply.Cargo[tostring(id)] = cargo
    net.Start("Cargo_Resc")
        net.WriteTable(ply.Cargo or {})
    net.Send(ply)
end