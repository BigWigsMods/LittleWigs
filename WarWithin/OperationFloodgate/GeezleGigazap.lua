if not BigWigsLoader.isTestBuild then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Geezle Gigazap", 2773, 2651)
if not mod then return end
mod:RegisterEnableMob(226404) -- Geezle Gigazap
mod:SetEncounterID(3054)
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
