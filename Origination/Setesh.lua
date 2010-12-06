-- XXX Ulic: Need logs and suggestions

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Setesh", "Halls of Origination")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39732)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 39732)
end

-------------------------------------------------------------------------------
--  Event Handlers

