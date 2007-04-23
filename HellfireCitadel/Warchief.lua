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
	
	bdwarn = "Warn for Blade Dance",
	bdwarn_desc = "Estimated Blade Dance timers",
	bdwarn_alert = "5 seconds until Blade Dance!",

	bdbar = "Blade Dance Bar",
	bdbar_desc = "Display count down estimate for Blade Dance",
	bdbar_display = "Blade Dance",
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
	if msg == L["engage_trigger"] then
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
