-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ghaz'an", 726, 577)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod:RegisterEnableMob(18105)
mod.toggleOptions = {"stages"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 18105)
end
