-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Quagmirran", 728, 572)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod:RegisterEnableMob(17942)
mod.toggleOptions = {"bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 17942)
end
