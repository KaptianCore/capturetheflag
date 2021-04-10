AddCSLuaFile()

SWEP.Base         = "weapon_base"
SWEP.PrintName    = ""
SWEP.Category     = ""
SWEP.Author       = ""
SWEP.Instructions = [[]]

SWEP.HoldType       = "ar2"
SWEP.Slot           = 1
SWEP.SlotPos        = 0
SWEP.Weight         = 5
SWEP.AutoSwitchTo   = true
SWEP.AutoSwitchFrom = false

SWEP.Spawnable      = true
SWEP.AdminSpawnable = true

SWEP.ViewModelFlip  = true
SWEP.UseHands       = false
SWEP.DrawCrosshair  = true

SWEP.Primary.Delay       = 0.08
SWEP.Primary.Recoil      = 1.9
SWEP.Primary.Automatic   = true
SWEP.Primary.Damage      = 20
SWEP.Primary.Cone        = 0.025
SWEP.Primary.Ammo        = "smg1"
SWEP.Primary.ClipSize    = 45
SWEP.Primary.ClipMax     = 90
SWEP.Primary.DefaultClip = 45
SWEP.Primary.Sound       = Sound("Weapon_AK47.Single")

SWEP.Secondary.Delay       = 1

SWEP.AmmoEnt = ""

SWEP.ViewModelFOV  = 72
SWEP.ViewModel  = ""
SWEP.WorldModel = ""


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
