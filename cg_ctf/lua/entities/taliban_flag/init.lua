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

function ENT:Touch(ply)
    if(!ply:IsPlayer) then 
        return
    end
    local player_faction = ply:GAMEMODE.GetRegiment():GetAbsoluteParent()
    if (GAMEMODE.IsAlly(1, player_faction)) then 
        -- change body group of the entity, give the swep to ply, also announce the person has taken the team's flag
    end
else
    -- chat message saying you can't take your own flag like how intel does it
    -- this is where the swep will be given as well as checks to see they are either allied to the team, also checking its a player, defining the player that HasFlag or I can just check when they are returning if they have the enemy swep
end