if select(4, GetBuildInfo()) < 100105 then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Iridikron the Stonescaled", 2579, 2537)
if not mod then return end
mod:RegisterEnableMob() -- Iridikron the Stonescaled
mod:SetEncounterID(2669)
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

