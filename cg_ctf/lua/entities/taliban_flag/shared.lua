ENT.Type                = "anim"
ENT.Base                = "base_gmodentity"
ENT.PrintName           = "Taliban Flag"
ENT.Author              = "Kaptian Core"
ENT.Contact             = ""
ENT.Category            = "Other"
ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:SetupModel()
	self.Entity:SetModel("models/ctf/ctf_flag.mdl")
end