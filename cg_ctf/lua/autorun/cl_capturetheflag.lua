include("sv_capturetheflag.lua")
util.AddNetworkString("FlagCaptured")
util.AddNetworkString("FlagDropped")
util.AddNetworkString("FlagTaken")

local function HandleFlagDropped(len, ply)
	chat.AddText(unpack(net.ReadTable()))
	if (teamid == 1) then
		usflagTaken = false
	elseif (teamid == 2) then
		tflagTaken = false
	end
	-- local team_flag = ents.FindByName(team_ents[net.ReadInt(16)]) 	
	-- Re Enable Body Group For Team's Flag
	-- team_flag:SetBodygroup(0, 0) -- may have to set it to 1 idk	
end
net.Receive("FlagDropped", HandleFlagDropped)

local function HandleFlagTaken(len, ply)
	chat.AddText(unpack(net.ReadTable()))
	if (teamid == 1) then
		usflagTaken = true
	elseif (teamid == 2) then
		tflagTaken = true
	end
end
net.Receive("FlagTaken", HandleFlagTaken)

local function HandleFlagCaptured(len, ply)
	chat.AddText(unpack(net.ReadTable()))
	local teamid = net.ReadInt(16)
	if (teamid == 1) then
		usflagTaken = false
	elseif (teamid == 2) then
		tflagTaken = false
	end
	-- local team_flag = ents.FindByName(team_ents[net.ReadInt(16)])
	-- Re Enable Body Group For Team's Flag
	-- team_flag:SetBodygroup(0, 0) -- may have to set it to 1 idk	
end
net.Receive("CaptureFlag", HandleFlagCaptured)