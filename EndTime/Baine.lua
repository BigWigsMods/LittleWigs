-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Echo of Baine", 820)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(54431)
mod.toggleOptions = {
	{"ej:4140", "ICON"},-- Pulverize
	"ej:4141", -- Throw Totem
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["totemDrop"] = "Totem dropped"
L["totemThrow"] = "Totem thrown by %s"--@end-do-not-package@
--@localization(locale="enUS", namespace="EndTime/Baine", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE", "Pulvarize")
	self:RegisterEvent("SPELL_SUMMON", "TotemDown")
	self:Log("SPELL_AURA_REMOVED", "TotemUp", 101614)
	self:Death("Win", 54431)
end

function mod:OnEngage()
	self:Bar(101626, LW_CL["next"]:format(GetSpellInfo(101626)), 25, 101626)
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	local pulverize = GetSpellInfo(101626)
	local function clearIcon()
		mod:PrimaryIcon("ej:4140")
	end
	function mod:Blitz(_, msg, _, _, _, player)
		if msg:find(pulverize) then
			if player then
				self:TargetMessage("ej:4140", pulverize, player, "Important", 101626, "Alert")
				self:PrimaryIcon("ej:4140", player)
				self:ScheduleTimer(clearIcon, 4)
			else
				self:Message("ej:4140", pulverize, "Important", 101626, "Alert")
			end
		end
	end
end

function mod:TotemDown()
	mod:Message("ej:4141", L["totemDrop"], "Important", 101614, "Alarm")
	self:Bar("ej:4141", L["totemDrop"], 20, 101614)
end

function mod:TotemUp(player)
	mod:Message("ej:4141", L["totemThrow"]:format(player), "Positive", 101614, "Info")
	self:SendMessage("BigWigs_StopBar", self, L["totemDrop"])
end