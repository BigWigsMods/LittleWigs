------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Warchief Kargath Bladefist"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Warchief",
	
	engage_trigger = "I am called Bladefist for a reason. As you will see.",
	engage_trigger2 = "I'll carve the meat from your bones!",
	
	bdwarn = "Blade Dance",
	bdwarn_desc = "Estimated Blade Dance timers",
	bdwarn_alert = "5 seconds until Blade Dance!",

	bdbar = "Blade Dance Bar",
	bdbar_desc = "Display count down estimate for Blade Dance",
	bdbar_display = "Blade Dance",
} end)

L:RegisterTranslations("koKR", function() return {
	engage_trigger = "내가 블레이드피스트", -- check
	
	bdwarn = "칼춤",
	bdwarn_desc = "칼춤 지속 시간 타이머",
	bdwarn_alert = "5 초 동안 칼춤!",

	bdbar = "칼춤 바",
	bdbar_desc = "칼춤의 지속 시간 표시",
	bdbar_display = "칼춤",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Shattered Halls"]
mod.enabletrigger = boss
mod.toggleoptions = {"bdwarn", "bdbar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg) 
	if msg == L["engage_trigger"] or msg == L["engage_trigger2"] then
		self:DanceSoon()
	end
end

function mod:DanceSoon()
	if self.db.profile.bdwarn then
		self:DelayedMessage(25, L["bdwarn_alert"], "Urgent")
	end
	if self.db.profile.bdbar then
		self:Bar(L["bdbar_display"], 30, "Ability_DualWield")
	end
	if self.db.profile.bdbar or self.db.profile.bdwarn then
		self:ScheduleEvent("bladedance", self.DanceSoon, 35, self)
	end
end
