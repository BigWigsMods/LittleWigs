if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Forge Speakers", 2652, 2590)
if not mod then return end
mod:RegisterEnableMob(
	213217, -- Speaker Brokk
	213216 -- Speaker Dorlita
)
mod:SetEncounterID(2888)
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

