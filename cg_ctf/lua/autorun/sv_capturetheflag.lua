AddCSLuaFile( "cl_capturetheflag.lua" )
fac_colours = {
    [1]    = Color(3, 3, 252),     -- US 
    [2]    = Color(252, 3, 3),     -- Taliban
}
local player_faction = GAMEMODE:GetRegiment(ply):GetAbsoluteParent() 
local faction_colour = GAMEMODE:GetColourObject(player_faction)
function BroadcastFlagTaken(ply, team, teamid)
	local msg = {Color(14,98,224 ), "[CTF] ", faction_colour, ply:Name(), Color(255,255,255), " has taken the ", fac_colours[teamid], team, Color(255,255,255), " Flag"}
	net.Start("FlagTaken")
	net.WriteTable(msg)
	net.WriteInt(teamid, 16)
	if ply then 
		net.Send(ply)
	else
		net.Broadcast()
	end
end

function BroadcastFlagDropped(ply, team, teamid)
	local msg = {Color(14,98,224 ), "[CTF] ", faction_colour, ply:Name(), Color(255,255,255), " has dropped the ", fac_colours[teamid], team, Color(255,255,255), " Flag"}
	net.Start("FlagDropped")
	net.WriteTable(msg)
	net.WriteInt(teamid, 16)
	if ply then 
		net.Send(ply)
	else
		net.Broadcast()
	end
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
end
local tblFlagWeapons = {
	["weapon_taliban_flag_swep"] = true,
	["weapon_us_flag_swep"] = true,
}
hook.Add( "PlayerSwitchWeapon", "DisableWeaponSwitch", function( ply, oldWeapon, newWeapon)
	if tblFlagWeapons[oldWeapon] then
		return false
	end
	return true
end )

hook.Add( "PlayerDeath", "FlagDroppedCheck", function( victim, inflictor, attacker)
	if(victim:HasWeapon("weapon_taliban_flag_swep")) then 
		BroadcastFlagDropped(victim, "Taliban", 2)
	elseif(victim:HasWeapon("weapon_us_flag_swep")) then 
		BroadcastFlagDropped(victim, "US", 1)
	else
		return
	end
end )