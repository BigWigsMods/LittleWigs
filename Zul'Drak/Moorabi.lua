-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Moorabi", "Gundrak")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod:RegisterEnableMob(29305)
mod.toggleOptions = {
	55098, -- Transform
	"bosskill"
}

-------------------------------------------------------------------------------
--  Locals

local spellName = GetSpellInfo(55098)

-------------------------------------------------------------------------------
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Transform", 55098)
	self:Log("SPELL_INTERRUPT", "Interrupt", 32747) -- spellId of Interrupt
	self:Death("Win", 29305)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Transform(_, spellId)
	self:Message(55098, LCL["casting"]:format(spellName), "Urgent", spellId)
	self:Bar(55098, spellName, 4, spellId)
end

function mod:Interrupt(_, _, source)
	self:SendMessage("BigWigs_StopBar", self, LCL["casting"]:format(spellName))
end
