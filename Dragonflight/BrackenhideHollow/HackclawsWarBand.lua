if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hackclaw's War Band", 2520, 2471)
if not mod then return end
mod:RegisterEnableMob(
	186122, -- Rira Hackclaw
	186124, -- Gashtooth
	186125  -- Tricktotem
)
mod:SetEncounterID(2570)
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

