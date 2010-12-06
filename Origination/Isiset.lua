-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Isiset", "Halls of Origination")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39587)
mod.toggleOptions = {
	74373, -- Veil of Sky
	74137, -- Supernova
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Veil", 74372, 74133, 74373)
	self:Log("SPELL_AURA_REMOVED", "VeilRemoved", 74372, 74133, 74373)
	self:Log("SPELL_CAST_START", "Supernova", 74136, 74137, 76670, 90758)

	self:Death("Win", 39587)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Veil(_, spellId, _, _, spellName)
	self:Message(74373, spellName, "Urgent", spellId)
	self:Bar(74373, spellName, 60, spellId)
end

function mod:VeilRemoved(_, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName)
end

function mod:Supernova(_, spellId, _, _, spellName)
	self:Message(74137, LCL["casting"]:format(spellName), "Urgent", spellId, "Alert")
	self:Bar(74137, spellName, 5, spellId)
end