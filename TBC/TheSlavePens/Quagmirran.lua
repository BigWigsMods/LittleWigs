
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Quagmirran", 728, 572)
if not mod then return end
mod:RegisterEnableMob(17942)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34780, -- Poison Bolt Volley
	}
end

function mod:OnBossEnable()
	-- XXX revise this module

	self:Death("Win", 17942)
end

--------------------------------------------------------------------------------
-- Event Handlers
--


