AddCSLuaFile()

SWEP.Base         = "weapon_base"
SWEP.PrintName    = "Taliban Flag SWEP"
SWEP.Category     = ""
SWEP.Author       = ""
SWEP.Instructions = [[]]

SWEP.HoldType       = "ar2"
SWEP.Slot           = 1
SWEP.SlotPos        = 0
SWEP.Weight         = 5
SWEP.AutoSwitchTo   = true
SWEP.AutoSwitchFrom = false
SWEP.Spawnable      = false
SWEP.AdminSpawnable = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelFlip  = true
SWEP.UseHands       = false

SWEP.ViewModelFOV  = 72
SWEP.VElements = {
	["flag"] = { type = "Model", model = "models/ctf/ctf_flag.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-80, -71.968, -7.316), angle = Angle(-89.943, 0, 0), size = Vector(0.748, 0.748, 0.748), color = Color(255, 255, 255, 255), surpresslightning = true, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["flag"] = { type = "Model", model = "models/ctf/ctf_flag.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.917, -5.549, 80), angle = Angle(174.539, 105.589, 0), size = Vector(0.326, 0.326, 0.326), color = Color(255, 255, 255, 255), surpresslightning = true, material = "", skin = 0, bodygroup = {} }
}

SWEP.ViewModel = "models/weapons/c_bugbait.mdl"
SWEP.WorldModel = "models/weapons/c_bugbait.mdl"

function SWEP:PrimaryAttack()
    -- Checks if we have enough ammo to shoot
    if (self:CanPrimaryAttack() == false) then return end

    -- weapon_base: SWEP:ShootBullet(damage, numberOfBullets, aimcone, ammoType, force, tracer)
    -- Shoots a bullet, handles player/weapon animations & applies recoil
    self:ShootBullet(
        self.Primary.Damage,
        1,
        self.Primary.Cone,
        self.Primary.Ammo
    )

    self:TakePrimaryAmmo(1)

    self:EmitSound(self.Primary.Sound)

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end


function SWEP:SecondaryAttack()
    if(!self:CanSecondaryAttack()) then return end

    if SERVER then
        self:GetOwner():ChatPrint("Right click!")
    end

    -- Delay when the gun can next be fired (secondary attack)
    self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
end
