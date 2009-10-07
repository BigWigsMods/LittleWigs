-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Mage-Lord Urom", "The Oculus")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod:RegisterEnableMob(27655)
mod.toggleOptions = {
	{51121, "WHISPER"}, -- Time Bomb
	51110, -- Arcane Explosion
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local pName = UnitName("player")

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Mage-Lord Urom", "enUS", true)
if L then
	--@do-not-package@
	L["timeBombWhisper_message"] = "You have the Time Bomb!"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Coldarra/Mage_Lord_Urom", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Mage-Lord Urom")
mod.locale = L

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
	self:Message(51121, spellName..": "..player, "Attention", spellId)
	self:Whisper(51121, player, L["timeBombWhisper_message"])
	self:Bar(51121, player..": "..spellName, 6, spellId)
end

function mod:ArcaneExplosion(_, spellId, _, _, spellName)
	self:Message(51110, L["arcaneExplosion"], "Attention", spellId)
	self:Bar(51110, spellName, 8, spellId)
end
