-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Swamplord Musel'ek", 546, 578)
if not mod then return end
--mod.otherMenu = "Coilfang Reservoir"
mod:RegisterEnableMob(17826, 17827)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"stages",
	}
end

function mod:OnBossEnable()
	self:Death("Win", 17826)
end
