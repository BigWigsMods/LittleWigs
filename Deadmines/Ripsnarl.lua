-- XXX Ulic: Need logs and suggestions

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Admiral Ripsnarl", "The Deadmines")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(47626) -- Possibly 42778
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 47626) -- Possibly 42778
end

-------------------------------------------------------------------------------
--  Event Handlers

