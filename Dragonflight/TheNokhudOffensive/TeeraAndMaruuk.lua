if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Teera And Maruuk", 2516, 2478)
if not mod then return end
mod:RegisterEnableMob(
	186339, -- Teera
	186338  -- Maruuk
)
mod:SetEncounterID(2581)
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

