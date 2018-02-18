-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("The Prophet Tharon'ja", 534, 591)
if not mod then return end
--mod.otherMenu = "Zul'Drak"
mod:RegisterEnableMob(26632)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"stages",
	}
end

function mod:OnBossEnable()
	self:Death("Win", 26632)
end
