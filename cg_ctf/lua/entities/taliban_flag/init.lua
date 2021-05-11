util.AddNetworkString("SendToAll")
util.AddNetworkString("SendToOne")
util.AddNetworkString("CaptureFlag")
AddCSLuaFile("entities/taliban_flag/cl_init.lua")
AddCSLuaFile("entities/taliban_flag/shared.lua")
include("entities/taliban_flag/shared.lua")

tflagTaken = false
local tblMessages = {
    [1] = {Color(14,98,224 ), "[CTF] ", Color(255,255,255), " You can't take your own team's flag "},
    [2] = {Color(14,98,224 ), "[CTF] ", faction_colour, ply:Name(), Color(255,255,255), " has taken the ", Color(252, 3, 3), "Taliban ", Color(255,255,255), "Flag"},
    [3] = {Color(14,98,224 ), "[CTF] ", Color(255,255,255), " There is no flag to be taken? "},
    [4] = {Color(14,98,224 ), "[CTF] ", faction_colour, ply:Name(), Color(255,255,255), " has captured the ", Color(3, 3, 252), "US ", Color(255,255,255), "Flag"},
}

function ENT:SpawnFunction( ply, trace )
    local ent = ents.Create("taliban_flag")
  ent:SetPos(trace.HitPos + trace.HitNormal * 8);
  ent:SetAngles(ply:GetAngles());
  ent:Spawn()
  ent:Activate()
end

function ENT:Initialize()
    self:SetModel("models/ctf/ctf_flag.mdl")
    self:SetSkin(2)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
  end
    self:Activate();
    -- add the options menu thing to it (look at notepad for it ) + team as 1 or 2 and set the skin as 1 or 2 depending on the team
end

local function SendToAll(msg, ply)
    tflagTaken = true
    net.Start("SendToAll")
    net.WriteTable(msg)
    if ply then 
        net.Send(ply)
    else
        net.Broadcast()
    end
end

local function SendToOne(msg, ply)
    tflagTaken = true
    net.Start("tflagTaken")
    net.WriteTable(msg)
    if ply then 
        net.Send(ply)
    else
        net.Broadcast()
    end
end

local function CaptureFlag(ply, msg)
    -- strip the swep from them and re enable the body group for the opposite side entity.will do the body group via networking
    ply:SelectWeapon("weapon_empty_hands")
    ply:StripWeapon("weapon_us_flag_swep")
    local team = 1
    net.Start("CaptureFlag")
    net.WriteTable(msg)
    net.WriteInt(team, 16)
    if IsValid(ply) and ply:IsPlayer() then
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

    local player_faction = GAMEMODE:GetRegiment(ply):GetAbsoluteParent()
    local alliance = GAMEMODE:IsAlly(2, player_faction)
    local faction_colour = GAMEMODE:GetColourObject(player_faction)
    if alliance then
        if not ply:HasWeapon("weapon_us_flag_swep") then
            SendToOne(tblMessages[1], ply)
        else -- ply does have weapon
            CaptureFlag(ply, tblMessages[4])
        end
      else -- if not alliance
        if not tFlagTaken then
            ply:Give("weapon_taliban_flag_swep")
            ply:SetWeapon("weapon_taliban_flag_swep")
            SendToAll(tblMessages[2], ply)
        else
            SendToOne(tblMessages[3], ply)
        end
      end
end
