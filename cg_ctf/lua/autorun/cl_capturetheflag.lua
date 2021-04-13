include('sh_capturetheflag.lua')
include('sv_capturetheflag.lua')

local function HandleFlagDropped(len, ply)
	chat.AddText(unpack(net.ReadTable()))
end
net.Receive("FlagDropped", HandleFlagDropped)

local function HandleFlagTaken(len, ply)
	chat.AddText(unpack(net.ReadTable()))
end
net.Receive("FlagTaken", HandleFlagTaken)

local function HandleFlagReturned(len, ply)
	chat.AddText(unpack(net.ReadTable()))
end
net.Receive("FlagReturned", HandleFlagReturned)

local function HandleFlagCaptured(len, ply)
	chat.AddText(unpack(net.ReadTable()))
end
net.Receive("FlagCaptured", HandleFlagCaptured)