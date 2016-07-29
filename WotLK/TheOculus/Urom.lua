-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Mage-Lord Urom", 528)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod:RegisterEnableMob(27655)
mod.toggleOptions = {
	{51121, "WHISPER"}, -- Time Bomb
	51110, -- Arcane Explosion
}

-------------------------------------------------------------------------------
--  Locals

local pName = UnitName("player")

-------------------------------------------------------------------------------
--  Localization

local BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")
local LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TimeBomb", 51121, 59376)
	self:Log("SPELL_CAST_START", "ArcaneExplosion", 51110, 59377)
	self:Death("Win", 27655)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:TimeBomb(player, spellId, _, _, spellName)
	self:TargetMessage(51121, spellName, player, "Personal", spellId, "Alert")
	self:Whisper(51121, player, BCL["you"]:format(spellName))
	self:Bar(51121, player..": "..spellName, 6, spellId)
end

function mod:ArcaneExplosion(_, spellId, _, _, spellName)
	self:Message(51110, LCL["casting"]:format(spellName), "Attention", spellId)
	self:Bar(51110, spellName, 8, spellId)
end
