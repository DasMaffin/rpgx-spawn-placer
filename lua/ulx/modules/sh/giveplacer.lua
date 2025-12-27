function ulx.giveplacer( calling_ply)
    if not IsValid(calling_ply) then return end

    calling_ply:Give( "weapon_spawn_placer" )
    calling_ply:SelectWeapon( "weapon_spawn_placer" )
end

local giveplacer = ulx.command( "Utility", "ulx giveplacer", ulx.giveplacer, "!giveplacer" )
giveplacer:defaultAccess( ULib.ACCESS_ADMIN )
giveplacer:help( "Give yourself the spawn placer" )