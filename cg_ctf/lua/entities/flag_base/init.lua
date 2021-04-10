AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel()
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCaptures(0)
    self:SetTeam(0)
    local phys = self:GetPhysicsObject()
    if(phys:IsValid()) then
        phys:Wake()     
    end
    -- add the options menu thing to it (look at notepad for it ) + team as 1 or 2 and set the skin as 1 or 2 depending on the team
end

function ent:getenabled 