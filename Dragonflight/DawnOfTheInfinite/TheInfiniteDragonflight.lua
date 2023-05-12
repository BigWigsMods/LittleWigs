if select(4, GetBuildInfo()) < 100105 then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chrono-Lord Deios and the Infinite Dragonflight", 2579, 2538)
if not mod then return end
mod:RegisterEnableMob() -- Chrono-Lord Deios
mod:SetEncounterID(2673)
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

