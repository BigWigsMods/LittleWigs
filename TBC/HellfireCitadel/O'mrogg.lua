-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Warbringer O'mrogg", 710, 568)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(16809)
mod.toggleOptions = {"bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 16809)
end
