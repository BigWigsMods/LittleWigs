-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Devourer of Souls", "The Forge of Souls")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "The Frozen Halls"
mod:RegisterEnableMob(36502)
mod.toggleOptions = {
	69051, -- Mirrored Soul
	68912, -- Wailing Soul
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Devourer of Souls", "enUS", true)
if L then
	--@do-not-package@
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Frozen_Halls/Devourer_of_Souls", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Devourer of Souls")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Mirror", 69051)
	self:Log("SPELL_AURA_REMOVED", "MirrorRemoved", 69051)
	self:Log("SPELL_AURA_APPLIED", "Wailing", 68912)
	self:Death("Win", 36502)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Mirror(unit, spellId, _, _, spellName)
	if unit == mod.displayName then return end
	self:TargetMessage(69051, spellName, unit, "Personal", spellId, "Alert")
	self:Bar(69051, unit..": "..spellName, 8, spellId)
	self:PrimaryIcon(69051, unit)
end

function mod:MirrorRemoved(unit, spellId, _, _, spellName)
	if unit == mod.displayName then return end
	self:PrimaryIcon(69051, false)
end

function mod:Wailing(player, spellId, _, _, spellName)
	self:Message(68912, spellName, "Important", spellId)
	self:Bar(68912, spellName, 15, spellId)
end
