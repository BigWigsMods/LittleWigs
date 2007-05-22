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

	engage_trigger1 = "^I am called",
	engage_trigger2 = "^I'll carve",
	engage_trigger3 = "^Ours is",

	bdwarn = "Blade Dance",
	bdwarn_desc = "Estimated Blade Dance timers",
	bdwarn_alert = "5 seconds until Blade Dance!",

	bdbar = "Blade Dance Bar",
	bdbar_desc = "Display count down estimate for Blade Dance",
	bdbar_display = "~Blade Dance",
} end)

L:RegisterTranslations("koKR", function() return {
	engage_trigger1 = "^내 별명이",
	engage_trigger2 = "^한 놈도",
	engage_trigger3 = "^우리가 진정한",

	bdwarn = "칼춤",
	bdwarn_desc = "칼춤 지속 시간 타이머",
	bdwarn_alert = "5초 후 칼춤!",

	bdbar = "칼춤 바",
	bdbar_desc = "칼춤의 지속 시간 표시",
	bdbar_display = "~칼춤",
} end)

L:RegisterTranslations("zhTW", function() return {
	cmd = "大酋長卡喀斯·刃拳",

	engage_trigger1 = "^我被叫做刃拳是有原因的。你馬上就會知道了。",
	engage_trigger2 = "^I'll carve",
	engage_trigger3 = "^我們的部落才是真正的部落!唯一的部落!",

	bdwarn = "劍刃之舞",
	bdwarn_desc = "估算劍刃之舞計時器",
	bdwarn_alert = "劍刃之舞持續 5 秒，散開！",

	bdbar = "劍刃之舞計時條",
	bdbar_desc = "顯示估算劍刃之舞倒數",
	bdbar_display = "劍刃之舞",
} end)

L:RegisterTranslations("frFR", function() return {
	engage_trigger1 = "^On m'appelle", -- à vérifier
	engage_trigger2 = "^Je vais vous découper", -- à vérifier
	engage_trigger3 = "^Nous sommes la", -- à vérifier

	bdwarn = "Danse des lames",
	bdwarn_desc = "Délais estimés avant les Danses des lames.",
	bdwarn_alert = "5 sec. avant Danse des lames !",

	bdbar = "Barre Danse des lames",
	bdbar_desc = "Affiche un compte à rebours d'estimation pour la Danse des lames.",
	bdbar_display = "~Danse des lames",
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
	if msg:find(L["engage_trigger1"]) or msg:find(L["engage_trigger2"]) or msg:find(L["engage_trigger3"]) then
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
