--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Echo of Sylvanas", 938, 323)
if not mod then return end
mod:RegisterEnableMob(54123)
mod.engageId = 1882
mod.respawnTime = 35

--------------------------------------------------------------------------------
-- Initialization
--

-- XXX revise this module
function mod:GetOptions()
	return {
		-3951, --Shriek of the Highborne
	}
end

function mod:OnBossEnable()

end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--
