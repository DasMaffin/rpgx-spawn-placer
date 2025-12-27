AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Point Marker"
ENT.Spawnable = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.Settings = {}

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Index")
end

function ENT:Initialize()
    self.Settings = table.Copy(RPGXSP.Settings)

    self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
    self:SetNoDraw(false)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)

    self:PhysicsInit(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableMotion(false)
    end
end
