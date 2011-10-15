-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Mannoroth and Varo'then", 816)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(54431) -- XXX Not correct
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
--@end-do-not-package@
--@localization(locale="enUS", namespace="HourOfTwilight/Asira", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 54431)  -- XXX Not correct
end

-------------------------------------------------------------------------------
--  Event Handlers
