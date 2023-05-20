-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Benedictus", 940)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(54938)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 54938)
end

-------------------------------------------------------------------------------
--  Event Handlers
