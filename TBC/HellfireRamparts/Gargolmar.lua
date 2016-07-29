-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Watchkeeper Gargolmar", 797, 527)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(17306)
mod.toggleOptions = {"stages"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 17306)
end
