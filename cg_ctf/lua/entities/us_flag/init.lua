util.AddNetworkString("SendToAll")
util.AddNetworkString("SendToOne")
util.AddNetworkString("CaptureFlag")
AddCSLuaFile("entities/us_flag/cl_init.lua")
AddCSLuaFile("entities/us_flag/shared.lua")
include("entities/us_flag/shared.lua")

usflagTaken = false

function ENT:SpawnFunction( ply, trace )
    local ent = ents.Create("us_flag")
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
end

local function SendToAll(msg, ply)
    usflagTaken = true
    net.Start("SendToAll")
    net.WriteTable(msg)
    net.Broadcast()
    end
end

local function SendToOne(msg, ply)
    usflagTaken = true
    net.Start("usflagTaken")
    net.WriteTable(msg)
    net.Send(ply)
end

local function CaptureFlag(ply, msg)
    ply:SelectWeapon("weapon_empty_hands")
    ply:StripWeapon("weapon_taliban_flag_swep")
    local team = 2
    net.Start("CaptureFlag")
    net.WriteTable(msg)
    net.WriteInt(team, 16)
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
    if(alliance == true and ply:HasWeapon("weapon_taliban_flag_swep") == false) then-- check if they are ally then say you can't take your own team's flag!
        local msg = {Color(14,98,224 ), "[CTF] ",fac_colours[0], " You can't take your own team's flag "}
        SendToOne(msg, ply)
    elseif(alliance == false and usflagTaken == false) then
        local msg = {Color(14,98,224 ), "[CTF] ", fac_colours[player_faction], ply:Name(), fac_colours[0], " has taken the ", fac_colours[1], "US ", fac_colours[0], "Flag"}
        ply:Give("weapon_us_flag_swep")
        ply:SetWeapon("weapon_us_flag_swep")
        SendToAll(msg, ply)
    elseif(alliance == false and usflagTaken == true) then
        local msg = {Color(14,98,224 ), "[CTF] ", fac_colours[0], " There is no flag to be taken? "}
        SendToOne(msg, ply)
    elseif(alliance == true and ply:HasWeapon("weapon_taliban_flag_swep") == true) then
        local msg = {Color(14,98,224 ), "[CTF] ", fac_colours[player_faction], ply:Name(), fac_colours[0], " has captured the ", fac_colours[2], "Taliban ", fac_colours[0], "Flag"}
        CaptureFlag(ply, msg)
end
    -- else statement
    -- chat message saying you can't take your own flag like how intel does it
    -- this is where the swep will be given as well as checks to see they are either allied to the team, also checking its a player, defining the player that HasFlag or I can just check when they are returning if they have the enemy swep
    -- change body group of the entity, give the swep to ply, also announce the person has taken the team's flag 
    -- The ent use is too generic so will split it up here, will need to add checks like if its the first take and all that in the main func then here will do the body group and chat message
