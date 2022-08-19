Cargo = {}

util.AddNetworkString("Cargo_Resc")

function Cargo:Get(ply) 
    net.Start("Cargo_Resc")
        net.WriteTable(ply.Cargo or {})
    net.Send(ply)
    return ply.Cargo or {}
end

function Cargo:Set(ply,cargo) 
    ply.Cargo[cargo.Name] = cargo
    net.Start("Cargo_Resc")
        net.WriteTable(ply.Cargo or {})
    net.Send(ply)
end

function Cargo:Remove(ply,cargo) 
    ply.Cargo[cargo.Name] = nil
    net.Start("Cargo_Resc")
        net.WriteTable(ply.Cargo or {})
    net.Send(ply)
end