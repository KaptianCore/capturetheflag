AddCSLuaFile( "cl_capturetheflag.lua" )
AddCSLuaFile( "sh_capturetheflag.lua" )
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

hook.Add( "PlayerSwitchWeapon", "DisableWeaponSwitch", function( ply, oldWeapon, newWeapon)
	if(oldWeapon == "weapon_taliban_flag_swep" or "weapon_us_flag_swep") then
		return false
	else
		return true
	end
end )

hook.Add("PlayerDeath", "FlagDroppedCheck", function( victim, inflictor, attacker)
	if(victim:HasWeapon("weapon_taliban_flag_swep")) then 
		BroadcastFlagDropped(victim, "Taliban", 2)
	elseif(victim:HasWeapon("weapon_us_flag_swep")) then 
		BroadcastFlagDropped(victim, "US", 1)
	end
end )