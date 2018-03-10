-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Ghaz'an", 726, 577)
if not mod then return end
mod:RegisterEnableMob(18105)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"stages",
	}
end

function mod:OnBossEnable()
	self:Death("Win", 18105)
end
