-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Forgemaster Throngus", "Grim Batol")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(40177)
mod.toggleOptions = {
	76481, -- Personal Phalanx
	75007, -- Encumbered
	74981, -- Dual Blades
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Phalanx", 74908)
	self:Log("SPELL_AURA_APPLIED", "Encumbered", 75007)
	self:Log("SPELL_AURA_APPLIED", "Blades", 74981)

	self:Death("Win", 40177)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Phalanx(_, spellId, _, _, spellName)
	self:Message(74908, spellName, "Important", spellId, "Alert")
	self:Bar(74908, spellName, 30, spellId)
	self:DelayedMessage(74908, 25, LCL["ends"]:format(spellName, 5), "Attention")
end

function mod:Encumbered(_, spellId, _, _, spellName)
	self:Message(75007, spellName, "Important", spellId, "Alert")
	self:Bar(75007, spellName, 30, spellId)
	self:DelayedMessage(75007, 25, LCL["ends"]:format(spellName, 5), "Attention")
end

function mod:Blades(_, spellId, _, _, spellName)
	self:Message(74981, spellName, "Important", spellId, "Alert")
	self:Bar(74981, spellName, 30, spellId)
	self:DelayedMessage(74981, 25, LCL["ends"]:format(spellName, 5), "Attention")
end