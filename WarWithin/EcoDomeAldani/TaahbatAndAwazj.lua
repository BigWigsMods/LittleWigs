if not BigWigsLoader.isNext then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Taah'bat and A'wazj", 2830, 2676)
if not mod then return end
mod:RegisterEnableMob(
	234933, -- Taah'bat
	237514 -- A'wazj
)
mod:SetEncounterID(3108)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

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
