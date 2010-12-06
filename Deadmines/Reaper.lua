-- XXX Ulic: Need logs and suggestions

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Foe Reaper 5000", "The Deadmines")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43778)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 43778)
end

-------------------------------------------------------------------------------
--  Event Handlers

