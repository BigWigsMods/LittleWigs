
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Grand Menagerie", 2441, 2454)
if not mod then return end
mod:RegisterEnableMob(
	176555, -- Achillite
	176556, -- Alcruux
	176705  -- Venza Goldfuse
)
mod.engageId = 2441

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
