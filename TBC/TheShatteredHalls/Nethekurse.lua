
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Grand Warlock Nethekurse", 710, 566)
if not mod then return end
mod:RegisterEnableMob(16807)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		30496, -- Lesser Shadow Fissure
	}
end

function mod:OnBossEnable()
	-- XXX revise this module

	self:Death("Win", 16807)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

