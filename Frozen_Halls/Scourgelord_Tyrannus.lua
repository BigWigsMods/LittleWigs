if not QueryQuestsCompleted then return end
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Scourgelord Tyrannus", "Pit of Saron")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "The Frozen Halls"
mod:RegisterEnableMob(36658)
mod.toggleOptions = {
	{69172, "ICON"}, -- Overlords Brand
	{69275, "ICON"}, -- Mark of Rimefang
	69629, -- Unholy Power
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Scourgelord Tyrannus", "enUS", true)
if L then
	--@do-not-package@
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Frozen_Halls/Scourgelord_Tyrannus", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Scourgelord Tyrannus")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Brand", 69172)
	self:Log("SPELL_AURA_REMOVED", "BrandRemoved", 69172)
	self:Log("SPELL_AURA_APPLIED", "Mark", 69275)
	self:Log("SPELL_AURA_REMOVED", "MarkRemoved", 69275)
	self:Log("SPELL_AURA_APPLIED", "Power", 69629, 69167)
	self:Death("Win", 36658)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Brand(player, spellId, _, _, spellName)
	self:TargetMessage(69172, spellName, player, "Personal", spellId, "Alert")
	self:Bar(69172, player..": "..spellName, 8, spellId)
	self:PrimaryIcon(69172, player)
end

function mod:BrandRemoved()
	self:PrimaryIcon(69172, false)
end

function mod:Mark(player, spellId, _, _, spellName)
	self:TargetMessage(69275, spellName, player, "Personal", spellId, "Alert")
	self:Bar(69275, player..": "..spellName, 7, spellId)
	self:SecondaryIcon(69275, player)
end

function mod:MarkRemoved()
	self:SecondaryIcon(69275, false)
end

function mod:Power(_, spellId, _, _, spellName)
	self:Message(69629, spellName, "Important", spellId)
	self:Bar(69629, spellName, 10, spellId)
end
