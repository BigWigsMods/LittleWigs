
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Blood Guard Porung", 710, 728)
if not mod then return end
mod:RegisterEnableMob(20923)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		15496, -- Cleave
	}
end

function mod:OnBossEnable()
	-- XXX revise this module

	self:Death("Win", 20923)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

