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

SWEP.ViewModelFlip  = true
SWEP.UseHands       = false

SWEP.ViewModelFOV  = 72
SWEP.ViewModel = "models/ctf/ctf_flag.mdl"
SWEP.WorldModel = "models/ctf/ctf_flag.mdl"



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
