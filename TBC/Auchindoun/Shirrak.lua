-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Shirrak the Dead Watcher", 722, 523)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18371)
mod.toggleOptions = {
	"focus", -- Focus Fire
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Shirrak the Dead Watcher", "enUS", true)
if L then
	--@do-not-package@
	L["focus"] = "Focus Fire"
	L["focus_desc"] = "Warn which player is being Focus Fired."
	L["focus_message"] = "%s has Focus Fire"--@end-do-not-package@
	--@localization(locale="enUS", namespace="Auchindoun/Shirrak", format="lua_additive_table", handle-unlocalized="ignore")@
end

L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Shirrak the Dead Watcher")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Death("Win", 18371)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, _, _, _, player)
	self:Message("focus", L["focus_message"]:format(player), "Attention", 32300)
end
