-- XXX Ulic: Need logs and suggestions

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Vanessa VanCleef", "Deadmines")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(42373) -- Possibly 42371
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 42372) -- Possibly 42371
end

-------------------------------------------------------------------------------
--  Event Handlers

