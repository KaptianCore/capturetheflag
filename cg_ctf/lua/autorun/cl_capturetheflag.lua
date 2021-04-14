include('sh_capturetheflag.lua')
include('sv_capturetheflag.lua')
local team_ents = {
	[1] = "us_flag"
	[2] = "taliban_flag"
}
local function HandleFlagDropped(len, ply)
	chat.AddText(unpack(net.ReadTable()))
	local team_flag = ents.FindByName(team_ents[net.ReadInt(16)]) 	
	-- Re Enable Body Group For Team's Flag
	-- team_flag:SetBodygroup(0, 0) -- may have to set it to 1 idk	
end
net.Receive("FlagDropped", HandleFlagDropped)

local function HandleFlagTaken(len, ply)
	chat.AddText(unpack(net.ReadTable()))
	local team_flag = ents.FindByName(team_ents[net.ReadInt(16)])
	-- Disable Body Group For Team's Flag
    -- team_flag:SetBodygroup(0, 1) -- may have to set it to 0 idk	 	
end
net.Receive("FlagTaken", HandleFlagTaken)

local function HandleFlagCaptured(len, ply)
	chat.AddText(unpack(net.ReadTable()))
	local team_flag = ents.FindByName(team_ents[net.ReadInt(16)])
	-- Re Enable Body Group For Team's Flag
	-- team_flag:SetBodygroup(0, 0) -- may have to set it to 1 idk	
end
net.Receive("CaptureFlag", HandleFlagCaptured)