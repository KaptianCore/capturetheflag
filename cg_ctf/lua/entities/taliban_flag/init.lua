AddCSLuaFile("entities/taliban_flag/cl_init.lua")
AddCSLuaFile("entities/taliban_flag/shared.lua")
include("entities/taliban_flag/shared.lua")

function ENT:SpawnFunction( ply, trace )
    local ent = ents.Create( "taliban_flag" )
    ent:SetPos(trace.HitPos + trace.HitNormal * 8);
	ent:SetAngles(ply:GetAngles());
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel("models/ctf/ctf_flag.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if(phys:IsValid()) then
        phys:Wake()     
    end
    self:Activate();
    -- add the options menu thing to it (look at notepad for it ) + team as 1 or 2 and set the skin as 1 or 2 depending on the team
end

function ENT:Use(ply)
    if (not ply:IsPlayer()) then 
        return
    end
    local fac_colours = {
        [0]    = Color(255, 255, 255), -- Neutral :P
        [1]    = Color(3, 3, 252),     -- US 
        [2]    = Color(252, 3, 3),     -- Taliban
        [101]  = Color(0, 87, 46),     -- RU
        [102]  = Color(58,191,244),    -- UN
        [103]  = Color(227,254,0),     -- PLA
        [104]  = Color(255,88,0),      -- AUS
    }
    -- local player_faction = GAMEMODE:GetRegiment(ply):GetAbsoluteParent() -- Uncommented until done (since need GM)
    -- if (GAMEMODE:IsAlly(1, player_faction)) then -- Uncommented until done (since need GM)
    local alliance = true -- Temp value since can't test without gamemode
    local player_faction = 1
    if(alliance == true) then
        for k, v in pairs(player.GetAll()) do 
            chat.AddText(Color( 14,98,224 ), "[CTF] ", fac_colours[player_faction], ply:Name(), fac_colours[0], "has taken the", fac_colours[2], "Taliban", fac_colours[0], "Flag")
        end 
    end
        -- change body group of the entity, give the swep to ply, also announce the person has taken the team's flag 
    else
    -- chat message saying you can't take your own flag like how intel does it
    -- this is where the swep will be given as well as checks to see they are either allied to the team, also checking its a player, defining the player that HasFlag or I can just check when they are returning if they have the enemy swep
    end
end