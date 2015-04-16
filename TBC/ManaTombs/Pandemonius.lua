-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Pandemonius", 732, 534)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18341)
mod.toggleOptions = {
	32358, -- Dark Shell
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Shell", 32358, 38759)
	self:Death("Win", 18341)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Shell(_, spellId, _, _, spellName)
	self:Message(32358, LCL["casting"]:format(spellName), "Attention", spellId)
	self:Bar(32358, spellName, 6, spellId)
end
