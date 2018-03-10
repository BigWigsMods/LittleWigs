-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("The Black Stalker", 726, 579)
if not mod then return end
--mod.otherMenu = "Coilfang Reservoir"
mod:RegisterEnableMob(17882)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"stages",
	}
end

function mod:OnBossEnable()
	self:Death("Win", 17882)
end
