-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Arcurion", 940)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(54590)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 54590)
end

-------------------------------------------------------------------------------
--  Event Handlers
