hook.Add("Think", "MyAimTrace", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    local tr = util.TraceLine({
        start = ply:EyePos(),
        endpos = ply:EyePos() + ply:GetAimVector() * 3000,
        filter = ply
    })

    RPGXSP.loookAtEntity = tr.Entity
end)