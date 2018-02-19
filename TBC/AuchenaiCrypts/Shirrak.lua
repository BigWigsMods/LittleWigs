-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Shirrak the Dead Watcher", 558, 523)
if not mod then return end
--mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18371)

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.focus = "Focus Fire"
	L.focus_desc = "Warn which player is being Focus Fired."
	L.focus_message = "%s has Focus Fire"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"focus", -- Focus Fire
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Death("Win", 18371)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, _, _, _, player)
	self:Message("focus", "Attention", nil, L.focus_message:format(player), 32300) -- 32300 is Focus Fire
end
