
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Yor", 732, 536)
if not mod then return end
mod:RegisterEnableMob(22930)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34716, -- Stomp
	}
end

function mod:OnBossEnable()
	-- XXX revise this module

	self:Death("Win", 22930)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

