-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Elder Nadox", "Ahn'kahet: The Old Kingdom")
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod:RegisterEnableMob(29309)
mod.toggleOptions = {
	"guardian",
	56130, -- Brood Plague
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["guardian"] = "Summon Guardians"
L["guardian_desc"] = "Warn when Elder Nadox summons Guardians."--@end-do-not-package@
--@localization(locale="enUS", namespace="Dragonblight/Elder_Nadox", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Log("SPELL_AURA_APPLIED", "BroodPlague", 56130, 59467)
	self:Log("SPELL_AURA_REMOVED", "BroodPlagueRemoved", 56130, 59467)
	self:Death("Win", 29309)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CHAT_MSG_RAID_BOSS_EMOTE(event, msg)
	self:Message("guardian", msg, "Important")
end

function mod:BroodPlague(player, spellId, _, _, spellName)
	self:Message(56130, spellName..": "..player, "Attention", spellId)
	self:Bar(56130, player..": "..spellName, 30, spellId)
end

function mod:BroodPlagueRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end

