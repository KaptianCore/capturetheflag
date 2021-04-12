util.AddNetworkString("TakenFlag")
AddCSLuaFile("entities/taliban_flag/cl_init.lua")
AddCSLuaFile("entities/taliban_flag/shared.lua")
include("entities/taliban_flag/shared.lua")

local flagTaken = false

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

local function SendTakenFlag(msg, ply)
    TakenFlag = true
    net.Start("TakenFlag")
    net.WriteTable(msg)
    if ply then 
        net.Send(ply)
    else
        net.Broadcast()
    end
end

function ENT:Use(ply)
    self:SetUseType(SIMPLE_USE)
    if (not ply:IsPlayer()) then 
        return
    end

    -- local player_faction = GAMEMODE:GetRegiment(ply):GetAbsoluteParent() -- Uncommented until done (since need GM)
    -- if (GAMEMODE:IsAlly(1, player_faction)) then -- Uncommented until done (since need GM)
    local alliance = true -- Temp value since can't test without gamemode
    local player_faction = 103
    local fac_colours = {
        [0]    = Color(255, 255, 255), -- Neutral :P
        [1]    = Color(3, 3, 252),     -- US 
        [2]    = Color(252, 3, 3),     -- Taliban
        [101]  = Color(0, 87, 46),     -- RU
        [102]  = Color(58,191,244),    -- UN
        [103]  = Color(227,254,0),     -- PLA
        [104]  = Color(255,88,0),      -- AUS
    }
    if(alliance) then-- check if they are ally then say you can't take your own team's flag!
        local msg = {Color(14,98,224 ), "[CTF] ",fac_colours[0], " You can't take your own team's flag "}
        SendTakenFlag(msg, ply)
    end
elseif(TakenFlag ==  true) then
        local msg = {Color(14,98,224 ), "[CTF] ",fac_colours[0], " There is no flag to be taken? "}
        SendTakenFlag(msg, ply)
        return
    end

    -- else statement
    -- chat message saying you can't take your own flag like how intel does it
    -- this is where the swep will be given as well as checks to see they are either allied to the team, also checking its a player, defining the player that HasFlag or I can just check when they are returning if they have the enemy swep
end

local function TakeFlag()
    local msg = {Color(14,98,224 ), "[CTF] ", fac_colours[player_faction], ply:Name(), fac_colours[0], " has taken the ", fac_colours[2], "Taliban ", fac_colours[0], "Flag"}
    if(alliance == true) then
        SendTakenFlag(msg, ply)
        -- change body group of the entity, give the swep to ply, also announce the person has taken the team's flag 
    end
    -- The ent use is too generic so will split it up here, will need to add checks like if its the first take and all that in the main func then here will do the body group and chat message
end

local function ReturnFlag()
    TakenFlag = false
    -- Will check that it's this side's flag and will also check they are either allied or the team this flag belongs to

end

local function CaptureFlag()
    -- this will check they are either allied to this entity's team or is that team, as well as check that it's the other side's flag and strip the swep from them and re enable the body group for the opposite side entity.
end