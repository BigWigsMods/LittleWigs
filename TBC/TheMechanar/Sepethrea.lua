--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nethermancer Sepethrea", 730, 564)
if not mod then return end
mod:RegisterEnableMob(19221)
-- mod.engageId = 1930 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
	}
end

function mod:OnBossEnable()
	self:Death("Win", 19221)
end

--------------------------------------------------------------------------------
-- Event Handlers
--
