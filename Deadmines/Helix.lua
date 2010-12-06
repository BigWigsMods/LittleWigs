-- XXX Ulic: Need logs and suggestions

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Helix Gearbreaker", "Deadmines")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(47296) -- Possibly 42655 or 42753
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 47296) -- Possibly 42655 or 42753
end

-------------------------------------------------------------------------------
--  Event Handlers

