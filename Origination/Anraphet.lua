
-- XXX need english engage trigger!
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Anraphet", "Halls of Origination")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39788)
mod.toggleOptions = {{76184, "FLASHSHAKE"}, 75622, 75603, "bosskill"}
mod.optionHeaders = {
	[76184] = "general",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["engage_trigger"] = " "--@end-do-not-package@
--@localization(locale="enUS", namespace="Origination/Anraphet", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()
BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Alpha", 76184)
	self:Log("SPELL_AURA_APPLIED", "AlphaDebuff", 76956, 91177)
	self:Log("SPELL_CAST_START", "Omega", 75622, 91208)
	self:Log("SPELL_AURA_APPLIED", "Nemesis", 75603, 91174)
	self:Yell("Engage", L["engage_trigger"])
	
	self:Death("Win", 39788)
end

function mod:OnEngage()
	self:Bar(75622, LW_CL["next"]:format(GetSpellInfo(75622)), 45, 75622)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Alpha(_, spellId, _, _, spellName)
	self:Message(76184, LW_CL["casting"]:format(spellName), "Important", spellId, "Info")
end

function mod:AlphaDebuff(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(76184, BCL["you"]:format(spellName), "Personal", spellId, "Alarm")
		self:FlashShake(76184)
	end
end

function mod:Omega(_, spellId, _, _, spellName)
	self:Message(75622, LW_CL["casting"]:format(spellName), "Important", spellId, "Alert")
	self:Bar(75622, LW_CL["next"]:format(spellName), 37, spellId)
end

function mod:Nemesis(player, spellId, _, _, spellName)
	self:TargetMessage(75603, spellName, player, "Urgent", spellId, "Alert")
end

