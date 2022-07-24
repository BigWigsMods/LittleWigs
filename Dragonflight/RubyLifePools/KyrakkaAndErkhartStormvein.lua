if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kyrakka and Erkhart Stormvein", 2521, 2503)
if not mod then return end
mod:RegisterEnableMob(
	193435, -- Kyrakka
	190485  -- Erkhart Stormvein
)
mod:SetEncounterID(2623)
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

