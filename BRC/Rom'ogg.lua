-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Rom'ogg Bonecrusher", "Blackrock Caverns")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39665)
mod.toggleOptions = {
	75543, -- The Skullcracker
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Skullcracker", 75543)
	self:Death("Win", 39665)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Skullcracker(_, spellId, _, _, spellName)
	self:Bar(75543, spellName, 12, spellId)
	self:Message(75543, LCL["casting"]:format(spellName), "Attention", spellId)
end