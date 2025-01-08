if not BigWigsLoader.isTestBuild then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Demolition Duo", 2773, 2649)
if not mod then return end
mod:RegisterEnableMob(
	226403, -- Keeza Quickfuse
	226402 -- Bront
)
mod:SetEncounterID(3019)
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
