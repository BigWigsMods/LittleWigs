if select(4, GetBuildInfo()) < 100105 then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tyr, the Infinite Keeper", 2579, 2526)
if not mod then return end
mod:RegisterEnableMob() -- Tyr
mod:SetEncounterID(2670)
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

