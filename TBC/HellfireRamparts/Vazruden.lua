-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Vazruden", 797, 529)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(17537, 17536)
mod.toggleOptions = {"stages"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 17537)
end
