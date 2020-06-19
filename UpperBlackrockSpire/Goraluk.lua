--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Goraluk Anvilcrack", 229)
if not mod then return end
mod:RegisterEnableMob(10899)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:Death("Win", 10899)
end
