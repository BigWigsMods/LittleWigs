-- XXX Ulic: Need logs and suggestions

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Helix Gearbreaker", "The Deadmines")
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

function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end

-------------------------------------------------------------------------------
--  Event Handlers

