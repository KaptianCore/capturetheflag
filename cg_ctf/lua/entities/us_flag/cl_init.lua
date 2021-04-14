include("entities/us_flag/shared.lua")

function ENT:Draw()
    self:DrawModel()
    self:SetSkin(1)
end



local function RecieveTakenFlag()
    chat.AddText(unpack(net.ReadTable()))
end

net.Receive("TakenFlag", RecieveTakenFlag)
