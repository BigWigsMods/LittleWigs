------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Warchief Kargath Bladefist"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil

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
	bdwarn_desc = "칼춤에 대한 예측 타이머입니다.",
	bdwarn_alert = "칼춤까지 5초 전!",

	bdbar = "칼춤 바",
	bdbar_desc = "칼춤에 대한 예측 초읽기 표시입니다.",
	bdbar_display = "~칼춤",
} end)

L:RegisterTranslations("zhTW", function() return {
	engage_trigger1 = "^我被叫做刃拳是有原因的。你馬上就會知道了。",
	engage_trigger2 = "^我會把肉從你的骨頭上切出來!",
	engage_trigger3 = "^我們的部落才是真正的部落!唯一的部落!",

	bdwarn = "劍刃之舞",
	bdwarn_desc = "估算劍刃之舞計時器",
	bdwarn_alert = "劍刃之舞持續 5 秒，散開!",

	bdbar = "劍刃之舞計時條",
	bdbar_desc = "顯示估算劍刃之舞倒數",
	bdbar_display = "劍刃之舞",
} end)

L:RegisterTranslations("zhCN", function() return {
	engage_trigger1 = "^我这“刃拳”的名号可不是白来的！",--check
	engage_trigger2 = "^我要把你碎尸万段",
	engage_trigger3 = "^我们才是",

	bdwarn = "刃舞",
	bdwarn_desc = "预计刃舞发动时间。",
	bdwarn_alert = "刃舞 持续5秒，散开！",

	bdbar = "刃舞计时条",
	bdbar_desc = "显示刃舞下次发动时间。",
	bdbar_display = "<刃舞>",
} end)

L:RegisterTranslations("frFR", function() return {
	engage_trigger1 = "^On m'appelle", -- à vérifier
	engage_trigger2 = "^Je vais vous découper", -- à vérifier
	engage_trigger3 = "^Nous sommes la", -- à vérifier

	bdwarn = "Danse des lames",
	bdwarn_desc = "Délais estimés avant les Danses des lames.",
	bdwarn_alert = "5 sec. avant Danse des lames !",

	bdbar = "Barre Danse des lames",
	bdbar_desc = "Affiche un compte à rebours d'estimation pour la Danse des lames.",
	bdbar_display = "~Danse des lames",
} end)

L:RegisterTranslations("deDE", function() return {
	engage_trigger1 = "^Man nennt",
	engage_trigger2 = "^Ich werde",
	engage_trigger3 = "^Wir sind",

	bdwarn = "Klingentanz",
	bdwarn_desc = "Gesch\195\164tzte Zeit bis Klingentanz",
	bdwarn_alert = "5 Sekunden bis zum Klingentanz!",

	bdbar = "Klingentanz-Leiste",
	bdbar_desc = "Zeite Countdown-Sch\195\164tzung f\195\182r Klingentanz",
	bdbar_display = "~Klingentanz",
} end)

L:RegisterTranslations("ruRU", function() return {
	engage_trigger1 = "^Я обращаюсь к вам!",
	engage_trigger2 = "^Я порублю вас!",
	engage_trigger3 = "^Мы! Будим! Есть!",

	bdwarn = "Танец клинков",
	bdwarn_desc = "Показывать таймер до танцующих клинков",
	bdwarn_alert = "5 СЕКУНД ДО ТАНЦУЮЩИХ КЛИНКОВ!",

	bdbar = "Панель для танцующих клинков",
	bdbar_desc = "Показывать время до танца клинков",
	bdbar_display = "~Танец клинков",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod.zonename = BZ["The Shattered Halls"]
mod.enabletrigger = boss
mod.guid = 16808
mod.toggleoptions = {"bdwarn", "bdbar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	db = self.db.profile
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
	if db.bdwarn then
		self:DelayedMessage(25, L["bdwarn_alert"], "Urgent")
	end
	if db.bdbar then
		self:Bar(L["bdbar_display"], 30, "Ability_DualWield")
	end
	if db.bdbar or db.bdwarn then
		self:ScheduleEvent("bladedance", self.DanceSoon, 35, self)
	end
end
