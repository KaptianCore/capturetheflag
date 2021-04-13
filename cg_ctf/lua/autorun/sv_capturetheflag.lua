AddCSLuaFile( "cl_capturetheflag.lua" )
AddCSLuaFile( "sh_capturetheflag.lua" )
util.AddNetworkString("FlagCaptured")
util.AddNetworkString("FlagDropped")
util.AddNetworkString("FlagPickedUp")
util.AddNetworkString("FlagReturned")

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
local player_faction = 103
function BroadcastFlagTaken(ply, team)
	local msg = {Color(14,98,224 ), "[CTF] ", fac_colours[player_faction], ply:Name(), fac_colours[0], " has taken the ", fac_colours[2], team, fac_colours[0], "Flag"}
	net.Start("FlagTaken")
	net.WriteTable(msg)
	if ply then 
		net.Send(ply)
	else
		net.Broadcast()
	end

function BroadcastFlagDropped(ply, team)
	net.Start("FlagDropped")
	net.WriteTable(msg)
	if ply then 
		net.Send(ply)
	else
		net.Broadcast()
	end

function BroadcastFlagReturned(ply, team)
	-- local msg = {Color(14,98,224 ), "[CTF] ", fac_colours[player_faction], ply:Name(), fac_colours[0], " has taken the ", fac_colours[2], "Taliban ", fac_colours[0], "Flag"}
	net.Start("FlagReturned")
	net.WriteTable(msg)
	if ply then 
		net.Send(ply)
	else
		net.Broadcast()
	end

function BroadcastFlagCaptured(ply, team)
	net.Start("FlagCaptured")
	net.WriteTable(msg)
	if ply then 
		net.Send(ply)
	else
		net.Broadcast()
	end
