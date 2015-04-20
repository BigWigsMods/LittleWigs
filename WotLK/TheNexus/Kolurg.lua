
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Commander Kolurg", 520, 833)
if not mod then return end
mod:RegisterEnableMob(26798)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		29544, -- Frightening Shout
	}
end

function mod:OnBossEnable()
	-- XXX revise this module

	self:Death("Win", 26798)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

