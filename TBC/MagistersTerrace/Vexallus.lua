-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Vexallus", 798, 531)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(24744)
mod.toggleOptions = {
	"adds",
	44335,
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Vexallus", "enUS", true)
if L then
	--@do-not-package@
	L["adds"] = "Pure Energy"
	L["adds_desc"] = "Warn when Pure Energy is discharged."
	L["adds_message"] = "Pure Energy discharged!"
	L["adds_trigger"] = "discharges pure energy!"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="MagistersTerrace/Vexallus", format="lua_additive_table", handle-unlocalized="ignore")@
end

L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Vexallus")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE", "AddSpawned")

	self:Log("SPELL_AURA_APPLIED", "Feedback", 44335)
	self:Log("SPELL_AURA_APPLIED_DOSE", "FeedbackDose", 44335)
	self:Log("SPELL_AURA_REMOVED", "FeedbackRemove", 44335)
	self:Death("Win", 24744)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:AddSpawned(msg)
	if msg:find(L["adds_trigger"]) then
		self:Message("adds", L["adds_message"], "Important")
	end
end

function mod:Feedback(player, spellId, _, _, spellname)
	self:TargetMessage(44335, player, spellname, "Urgent", spellId)
	self:Bar(44335, player..": "..spellName, 30, spellId)
end

function mod:FeedbackDose(player, spellId, _, _, spellName)
	self:Bar(44335, player..": "..spellName, 30, spellId)
end

function mod:FeedbackRemove(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
