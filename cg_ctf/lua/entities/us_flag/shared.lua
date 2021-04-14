ENT.Type                = "anim"
ENT.Base                = "base_gmodentity"
ENT.PrintName           = "US Flag"
ENT.Author              = "Kaptian Core"
ENT.Contact             = "github.com/KaptianCore"
ENT.Category            = "CG CTF"
ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:SetupModel()
	self.Entity:SetModel("models/ctf/ctf_flag.mdl")
end