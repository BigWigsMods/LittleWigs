-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ozruk", "The Stonecore")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(42188)
mod.toggleOptions = {
	78939, -- Elementium Bulwark
	80467, -- Enrage
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local enraged = GetSpellInfo(80467)

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["engage_trigger"] = "None may pass into the World's Heart!"--@end-do-not-package@
--@localization(locale="enUS", namespace="Stonecore/Ozruk", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()
LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Bulwark", 78939)
	self:Log("SPELL_AURA_REMOVED", "BulwarkRemoved", 78939)
	
	self:Log("SPELL_AURA_APPLIED", "Enraged", 80467)

	self:Yell("Engage", L["engage_trigger"])
	
	self:Death("Win", 42188)
end

function mod:OnEngage()
	self:Bar(80467, enraged, 90, 80467)
	mod:DelayedMessage(80467, 75, LCL["soon"]:format(enraged), "Attention")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Bulwark(_, _, _, _, spellName)
	local bossId = self:GetUnitIdByGUID(42188)
	if bossId then
		self:Message(78939, spellName, "Important", 78939)
		self:Bar(78939, spellName, 10, 78939)
	end
end

function mod:BulwarkRemoved(_, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName)
end

function mod:Enraged(_, spellId, _, _, spellName)
	self:Message(80467, spellName, "Important", spellId, "Long")
end