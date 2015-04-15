-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Grand Warlock Nethekurse", 710, 566)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(16807)
mod.toggleOptions = {"bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 16807)
end
