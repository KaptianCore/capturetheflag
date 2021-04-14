AddCSLuaFile( "cl_capturetheflag.lua" )
AddCSLuaFile( "sh_capturetheflag.lua" )
util.AddNetworkString("FlagCaptured")
util.AddNetworkString("FlagDropped")
util.AddNetworkString("FlagTaken")

fac_colours = {
	[0]    = Color(255, 255, 255), -- Neutral :P
    [1]    = Color(3, 3, 252),     -- US 
    [2]    = Color(252, 3, 3),     -- Taliban
    [101]  = Color(0, 87, 46),     -- RU
    [102]  = Color(58,191,244),    -- UN
    [103]  = Color(227,254,0),     -- PLA
    [104]  = Color(255,88,0),      -- AUS
}
-- local player_faction = GAMEMODE:GetRegiment(ply):GetAbsoluteParent() -- Uncommented until done (since need GM)
local player_faction = 103
function BroadcastFlagTaken(ply, team, teamid)
	local msg = {Color(14,98,224 ), "[CTF] ", fac_colours[player_faction], ply:Name(), fac_colours[0], " has taken the ", fac_colours[2], team, fac_colours[0], "Flag"}
	net.Start("FlagTaken")
	net.WriteTable(msg)
	net.WriteInt(teamid, 16)
	if ply then 
		net.Send(ply)
	else
		net.Broadcast()
	end

function BroadcastFlagDropped(ply, team, teamid)
	local msg = {Color(14,98,224 ), "[CTF] ", fac_colours[player_faction], ply:Name(), fac_colours[0], " has dropped the ", fac_colours[2], team, fac_colours[0], " Flag"}
	net.Start("FlagDropped")
	net.WriteTable(msg)
	net.WriteInt(teamid, 16)
	if ply then 
		net.Send(ply)
	else
		net.Broadcast()
	end

function BroadcastFlagCaptured(ply, team, teamid)
	net.Start("FlagCaptured")
	net.WriteTable(msg)
	net.WriteInt(teamid, 16)
	if ply then 
		net.Send(ply)
	else
		net.Broadcast()
	end

hook.Add( "PlayerSwitchWeapon", "DisableWeaponSwitch", function( ply, oldWeapon, newWeapon)
	if(oldWeapon == "weapon_taliban_flag_swep" or "weapon_us_flag_swep") then
		return false
	else
		return true
end )

hook.Add("PlayerDeath", "FlagDroppedCheck", function( victim, inflictor, attacker)
	if(victim:HasWeapon("weapon_taliban_flag_swep")) then 
		BroadcastFlagDropped(victim, "Taliban", 2)
	elseif(victim:HasWeapon("weapon_us_flag_swep")) then 
		BroadcastFlagDropped(victim, "US", 1)
end )