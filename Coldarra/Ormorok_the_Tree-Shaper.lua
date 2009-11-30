-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ormorok the Tree-Shaper", "The Nexus")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod:RegisterEnableMob(26794)
mod.toggleOptions = {
	47981, -- Spell Reflect
	48017, -- Frenzy
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Reflection", 47981)
	self:Log("SPELL_AURA_REMOVED", "ReflectionRemoved", 47981)
	self:Log("SPELL_CAST_SUCCESS", "Frenzy", 48017, 57086)
	self:Death("Win", 26794)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Reflection(_, spellId, _, _, spellName)
	self:Message(47981, spellName, "Attention", spellId)
	self:Bar(47981, spellName, 15, spellId)
end

function mod:ReflectionRemoved(_, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName)
end

function mod:Frenzy(_, spellId)
	self:Message(48017, LCL["frenzied"]:format(mod.displayName), "Important", spellId)
end
