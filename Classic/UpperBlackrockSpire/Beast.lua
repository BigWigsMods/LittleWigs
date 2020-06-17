--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Beast", 1583)
if not mod then return end
mod:RegisterEnableMob(10430)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:Death("Win", 10430)
end
