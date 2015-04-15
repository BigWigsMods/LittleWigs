-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Blood Guard Porung", 710, 728)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(20923)
mod.toggleOptions = {"bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 20923)
end
