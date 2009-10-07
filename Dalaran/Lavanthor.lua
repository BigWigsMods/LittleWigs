-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Lavanthor", "The Violet Hold")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod:RegisterEnableMob(29312, 32237)
mod.toggleOptions = {"bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 29312, 32237)
end
