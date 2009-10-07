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

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Elder Nadox", "enUS", true)
if L then
	L["guardian"] = "Summon Guardians"
	L["guardian_desc"] = "Warn when Elder Nadox summons Guardians."
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Elder Nadox")
mod.locale = L

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

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	self:Message("guardian", msg, "Important")
end

function mod:BroodPlague(player, spellId, _, _, spellName)
	self:Message(56130, spellName..": "..player, "Attention", spellId)
	self:Bar(56130, player..": "..spellName, 30, spellId)
end

function mod:BroodPlagueRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
