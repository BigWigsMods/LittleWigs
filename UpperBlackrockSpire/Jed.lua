--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Jed Runewatcher", 1583)
if not mod then return end
mod:RegisterEnableMob(10509)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:Death("Win", 10509)
end
