-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Echo of Jaina", 756) -- XXX Not correct
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(54445)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
--@end-do-not-package@
--@localization(locale="enUS", namespace="EndTime/Jaina", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 54445)
end

-------------------------------------------------------------------------------
--  Event Handlers
