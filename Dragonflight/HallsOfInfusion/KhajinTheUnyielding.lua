--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Khajin the Unyielding", 2527) -- TODO journal ID
if not mod then return end
mod:RegisterEnableMob(189727) -- Khajin the Unyielding
mod:SetEncounterID(2617)
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

