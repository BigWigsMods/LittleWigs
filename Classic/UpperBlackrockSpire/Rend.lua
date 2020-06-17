--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Warchief Rend Blackhand", 1583)
if not mod then return end
mod:RegisterEnableMob(10429, 10339) -- Rend, Gyth

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:Death("Win", 10429)
end
