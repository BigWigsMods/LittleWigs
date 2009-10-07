-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Herald Volazj", "Ahn'kahet: The Old Kingdom")
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod:RegisterEnableMob(29311)
mod.defaultToggles = {"MESSAGE"}
mod.toggleOptions = {
	57496, -- Insanity
	57949, -- Shiver
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Insanity", 57496)
	self:Log("SPELL_AURA_APPLIED", "Shiver", 57949, 59978)
	self:Log("SPELL_AURA_REMOVED", "ShiverRemoved", 57949, 59978)
	self:Death("Win", 29311)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Insanity(_, spellId, _, _, spellName)
	self:Message(57496, LCL["casting"]:format(spellName), "Important", spellId)
end

function mod:Shiver(player, spellId, _, _, spellName)
	self:Message(57949, spellName..": "..player, "Important", spellId)
	self:Bar(57949, player..": "..spellName, 15, spellId)
end

function mod:ShiverRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
