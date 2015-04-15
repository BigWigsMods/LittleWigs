-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Prince Taldaram", 522)
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod:RegisterEnableMob(29308)
mod.toggleOptions = {
	55959, -- Embrace of the Vampyr
	55931, -- Summon Sphere
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["embraceFade"] = "Embrace of the Vampyr Fades"
L["embraceGain"] = "Embrace of the Vampyr Gained"
L["sphere_message"] = "Conjuring Flame Sphere"--@end-do-not-package@
--@localization(locale="enUS", namespace="Dragonblight/Prince_Taldaram", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnEnable()
	self:Log("SPELL_AURA_APPLIED", "Embrace", 55959, 59513)
	self:Log("SPELL_AURA_REMOVED", "EmbraceRemoved", 55959, 59513)
	self:Log("SPELL_CAST_START", "Sphere", 55931)
	self:Death("Win", 29308)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Embrace(_, spellId, _, _, spellName)
	self:Message(55959, L["embraceGain"], "Important", spellId)
	self:Bar(55959, spellName, 20, spellId)
end

function mod:EmbraceRemoved(_, spellId, _, _, spellName)
	self:Message(55959, L["embraceFade"], "Positive", spellId)
	self:SendMessage("BigWigs_StopBar", self, spellName)
end

function mod:Sphere(_, spellId, _, _, spellName)
	self:Message(55931, L["sphere_message"], "Important", spellId)
	self:Bar(55931, "~"..spellName, 10, spellId)
end
