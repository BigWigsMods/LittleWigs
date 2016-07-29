-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("The Black Stalker", 726, 579)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod:RegisterEnableMob(17882)
mod.toggleOptions = {"stages"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 17882)
end
