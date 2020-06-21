--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sneed's Shredder", 389)
if not mod then return end
mod:RegisterEnableMob(642)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.bossName = "Sneed's Shredder"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.bossName
end

function mod:OnBossEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")

	self:Death("Win", 642)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end
