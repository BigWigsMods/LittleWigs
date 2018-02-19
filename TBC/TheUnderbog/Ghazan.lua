-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Ghaz'an", 546, 577)
if not mod then return end
--mod.otherMenu = "Coilfang Reservoir"
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
