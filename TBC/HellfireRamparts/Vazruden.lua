-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Vazruden", 797, 529)
if not mod then return end
--mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(17537, 17536) -- Vazruden, Nazan <Vazruden's Mount>

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"stages",
	}
end

function mod:OnBossEnable()
	self:Death("Win", 17537)
end
