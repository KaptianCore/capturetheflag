util.AddNetworkString("SendToAll")
util.AddNetworkString("SendToOne")
util.AddNetworkString("CaptureFlag")
AddCSLuaFile("entities/us_flag/cl_init.lua")
AddCSLuaFile("entities/us_flag/shared.lua")
include("entities/us_flag/shared.lua")

usflagTaken = false

local tblMessages = {
    [1] = {Color(14,98,224 ), "[CTF] ", Color(255,255,255), " You can't take your own team's flag "},
    [2] = {Color(14,98,224 ), "[CTF] ", faction_colour, ply:Name(), Color(255,255,255), " has taken the ", Color(3, 3, 252), "US ", Color(255,255,255), "Flag"},
    [3] = {Color(14,98,224 ), "[CTF] ", Color(255,255,255), " There is no flag to be taken? "}
    [4] = {Color(14,98,224 ), "[CTF] ", faction_colour, ply:Name(), Color(255,255,255), " has captured the ", Color(252, 3, 3), "Taliban ", Color(255,255,255), "Flag"}
}

function ENT:SpawnFunction( ply, trace )
  local ent = ents.Create("us_flag")
  ent:SetPos(trace.HitPos + trace.HitNormal * 8);
  ent:SetAngles(ply:GetAngles());
  ent:Spawn()
  ent:Activate()
end

function ENT:Initialize()
  self:SetModel("models/ctf/ctf_flag.mdl")
  self:SetSkin(1)
  self:PhysicsInit(SOLID_VPHYSICS)
  self:SetMoveType(MOVETYPE_VPHYSICS)
  self:SetSolid(SOLID_VPHYSICS)
  local phys = self:GetPhysicsObject()
  if (phys:IsValid()) then
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
    local alliance = GAMEMODE:IsAlly(1, player_faction)
    local faction_colour = GAMEMODE:GetColourObject(player_faction)
    if alliance then
        if not ply:HasWeapon("weapon_taliban_flag_swep") then
            SendToOne(tblMessages[1], ply)
        else -- ply does have weapon
            CaptureFlag(ply, tblMessages[4])
        end
      else -- if not alliance
        if not tFlagTaken then
            ply:Give("weapon_us_flag_swep")
            ply:SetWeapon("weapon_us_flag_swep")
            SendToAll(tblMessages[2], ply)
        else
            SendToOne(tblMessages[3], ply)
        end
      end
end
