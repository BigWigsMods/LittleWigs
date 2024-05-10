if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ol' Waxbeard", 2651, 2569)
if not mod then return end
mod:RegisterEnableMob(
	210149, -- Ol' Waxbeard (boss)
	210153 -- Ol' Waxbeard (mount)
)
mod:SetEncounterID(2829)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {

	}
end

function mod:OnBossEnable()

end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

