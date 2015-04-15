-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Warchief Kargath Bladefist", 710, 569)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(16808)
mod.toggleOptions = {
	"bdwarn",
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Warchief Kargath Bladefist", "enUS", true)
if L then
	--@do-not-package@
	L["engage_trigger1"] = "I am called"
	L["engage_trigger2"] = "I'll carve"
	L["engage_trigger3"] = "Ours is"

	L["bdwarn"] = "Blade Dance"
	L["bdwarn_desc"] = "Estimated Blade Dance timers."
	L["bdwarn_alert"] = "~5 seconds until Blade Dance!"
	L["bdbar"] = "~Blade Dance"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Hellfire/Warchief", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Warchief Kargath Bladefist")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:Yell("DanceSoon", L["engage_trigger1"], L["engage_trigger2"], L["engage_trigger3"])
	self:Death("Win", 16808)
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	local handle = nil
	function mod:DanceSoon()
		if handle then
			self:CancelTimer(handle)
			self:SendMessage("BigWigs_StopBar", self, L["bdbar"])
		end
		handle = self:ScheduleTimer(DanceSoon, 35)
		self:DelayedMessage("bdwarn", 25, L["bdwarn_alert"], "Urgent", 30739)
		self:Bar("bdwarn", L["bdbar"], 30, 30739)
	end
end
