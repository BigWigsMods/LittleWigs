-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("King Ymiron", 524)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod:RegisterEnableMob(26861)
mod.toggleOptions = {
	48294, -- Bane
	48291, -- Rot
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["bane_ended"] = "Bane Fades"--@end-do-not-package@
--@localization(locale="enUS", namespace="Howling_Fjord/King_Ymiron", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Bane", 48294, 59301)
	self:Log("SPELL_AURA_APPLIED", "BaneAura", 48294, 59301)
	self:Log("SPELL_AURA_REMOVED", "BaneAuraRemoved", 48294, 59301)
	self:Log("SPELL_AURA_APPLIED", "Rot", 48291, 59300)
	self:Log("SPELL_AURA_REMOVED", "RotRemoved", 48291, 59300)
	self:Death("Win", 26861)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Bane(_, spellId, _, _, spellName)
	self:Message(48294, LCL["casting"]:format(spellName), "Urgent", spellId)
end

function mod:BaneAura(player, spellId, _, _, spellName, _, _, _, _, dGuid)
	if tonumber(dGuid:sub(-12, -7), 16) ~= 26861 then return end
	self:Bar(48294, spellName, 5, spellId)
end

function mod:BaneAuraRemoved(player, spellId, _, _, spellName, _, _, _, _, dGuid)
	if tonumber(dGuid:sub(-12, -7), 16) ~= 26861 then return end
	self:Message(48294, L["bane_ended"], "Positive", spellId)
	self:SendMessage("BigWigs_StopBar", self, spellName)
end

function mod:Rot(player, spellId, _, _, spellName)
	self:Message(48291, spellName..": "..player, "Urgent", spellId)
	self:Bar(48291, player..": "..spellName, 9, spellId)
end

function mod:RotRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
