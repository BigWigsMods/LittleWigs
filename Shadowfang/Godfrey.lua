-- XXX Ulic: Not yet implemented

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Lord Godfrey", "Shadowfang Keep")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(1)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 1)
end

-------------------------------------------------------------------------------
--  Event Handlers

