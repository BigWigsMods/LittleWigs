-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Chrono Lord Deja", 733)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod:RegisterEnableMob(17879)
mod.toggleOptions = {"bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 17879)
	self:Yell("OnDiable", L["reset_trigger"])
end
