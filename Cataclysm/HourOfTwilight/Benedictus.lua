-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Benedictus", 819)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(54938)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
--@end-do-not-package@
--@localization(locale="enUS", namespace="HourOfTwilight/Benedictus", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 54938)
end

-------------------------------------------------------------------------------
--  Event Handlers
