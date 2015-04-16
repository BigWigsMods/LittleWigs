-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Temporus", 733)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod:RegisterEnableMob(17880)
mod.toggleOptions = {31458, "bosskill"}

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Black Morass Reset", "enUS", true)
if L then
	--@do-not-package@
	L["reset_trigger"] = "No! Damn this feeble, mortal coil!"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Black_Morass/Reset", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Black Morass Reset")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Hasten", 31458)
	self:Log("SPELL_AURA_REMOVED", "HastenRemoved", 31458)
	self:Death("Win", 17880)
	self:Yell("OnDisable", L["reset_trigger"])
end

-------------------------------------------------------------------------------
--  Event Hanlders

function mod:Hasten(_, spellId, _, _, spellName)
	self:Message(31458, spellName, "Important", spellId)
	self:Bar(31458, spellName, 10, spellId)
end

function mod:HastenRemoved(_, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName)
end
