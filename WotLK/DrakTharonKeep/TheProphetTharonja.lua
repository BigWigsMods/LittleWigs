-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("The Prophet Tharon'ja", 534)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod:RegisterEnableMob(26632)
mod.toggleOptions = {"stages"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 26632)
end
