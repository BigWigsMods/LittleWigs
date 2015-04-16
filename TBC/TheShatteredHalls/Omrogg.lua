
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Warbringer O'mrogg", 710, 568)
if not mod then return end
mod:RegisterEnableMob(16809)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		30584, -- Fear
	}
end

function mod:OnBossEnable()
	-- XXX revise this module

	self:Death("Win", 16809)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

