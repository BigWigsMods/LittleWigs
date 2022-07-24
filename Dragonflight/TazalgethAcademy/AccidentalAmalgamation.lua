--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Accidental Amalgamation", 2526) -- TODO journal ID
if not mod then return end
mod:RegisterEnableMob(186951) -- Accidental Amalgamation
mod:SetEncounterID(2563)
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

