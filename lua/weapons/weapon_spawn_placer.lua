SWEP.PrintName = "Basic Toolgun"
SWEP.Author = "You"
SWEP.Purpose = "Placeholder Toolgun SWEP"
SWEP.Instructions = "Left click / Right click - empty"
SWEP.Base = "weapon_base"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_toolgun.mdl"
SWEP.WorldModel = "models/weapons/w_toolgun.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "None"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "None"

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

local index = 0
function SWEP:PrimaryAttack()
    if CLIENT and (RPGXSP.Settings.SelectedNPCs == nil or #RPGXSP.Settings.SelectedNPCs == 0) then        
        notification.AddLegacy("You must select an NPC to spawn. Press right click to open the configuration menu.", NOTIFY_ERROR, 5)
        surface.PlaySound("buttons/button10.wav")
        return
    end
    local tr = util.TraceLine({
        start = self:GetOwner():EyePos(),
        endpos = self:GetOwner():EyePos() + self:GetOwner():GetAimVector() * 10000, -- 10k units forward
        filter = self:GetOwner()
    })

    if tr.Hit then
        if SERVER then
            local ent = ents.Create("point_marker")
            ent:SetPos(tr.HitPos)
            ent:SetIndex(index)
            ent:Spawn()
            index = index + 1
        end
    end
end

function SWEP:SecondaryAttack()
    if SERVER then
        net.Start("OpenPlacerConfiguration")
        net.Send(self:GetOwner())
    end
end

net.Receive("OpenPlacerConfiguration", function()
    RPGXSP:ToggleHelpMenu()
end)