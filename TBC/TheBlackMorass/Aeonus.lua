-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Aeonus", 733)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod:RegisterEnableMob(17881)
mod.toggleOptions = {37605, "bosskill"}

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
	self:Log("SPELL_AURA_APPLIED", "Enrage", 37605)
	self:Log("SPELL_AURA_REMOVED", "EnrageRemoved", 37605)
	self:Death("Win", 17881)
	self:Yell("OnDiable", L["reset_trigger"])
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Enrage(_, spellId, _, _, spellName)
	self:Message(37605, L["frenzy_message"], "Important", spellId)
	self:Bar(37605, spellName, 8, spellId)
end

function mod:EnrageRemoved(_, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName)
end
