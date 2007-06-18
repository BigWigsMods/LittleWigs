------------------------------
--      Are you local?      --
------------------------------

local name = AceLibrary("Babble-Zone-2.2")["The Black Morass"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..name)
local wave = 1

local BB = AceLibrary("Babble-Boss-2.2")
local boss = BB["Medivh"]
local boss1 = BB["Chrono Lord Deja"]
local boss2 = BB["Temporus"]
local boss3 = BB["Aeonus"]
BB = nil

L:RegisterTranslations("enUS", function() return {
	cmd = "Blackmorass",

	next_portal = "Next Portal",

	portal = "Portal Warnings",
	portal_desc = "Announce approximate warning messages for the next portal.",

	portalbar = "Portal Bars",
	portalbar_desc = "Display approximate timer bars for the next portal.",

	portal_bar = "~%s: Wave %s",
	multiportal_bar = "~Multiple portals at once",

	portal_warning20s = "%s in ~20 seconds!",
	portal_warning140s = "%s in ~140 seconds!",

	engage_trigger = "^The time has come! Gul'dan",
	disable_trigger = "We will triumph. It is only a matter... of time.",
	disable_warning = "%s has been saved!",

	-- These triggers generate warnings & bars bars based on mob deaths
	death_trigger1 = "No! The rift...", --Time-Keeper/Lord
	death_trigger2 = "You will never defeat us all!", --Time-Keeper/Lord
	death_trigger3 = "You will accomplish nothing!", --Time-Keeper/Lord
	death_trigger4 = "Time... is on our side.", --Chrono Lord Deja
	death_trigger5 = "My death means... little.", -- Temporus

	-- These triggers generate a bar indicating that a second portal will open if the current portal's elite is not defeated
	-- I am not sure if it is possible for a second portal to open on a boss fight
	spawn_trigger1 = "Let the siege begin!",--Time-Keeper/Lord
	spawn_trigger2 = "History is about to be rewritten!", --Time-Keeper/Lord
	spawn_trigger3 = "The sands of time shall be scattered to the winds!", --Time-Keeper/Lord

	-- Bosses
	frenzy = "Aeonus - Frenzy",
	frenzy_desc = "Warn when Aeonus goes into a frenzy.",
	frenzy_trigger = "%s goes into a frenzy!",
	frenzy_warning = "Frenzy Alert!",

	hasten = "Temporus - Hasten",
	hasten_desc = "Warns when Temporus gains hasten.",
	hasten_trigger = "Temporus gains Hasten.",
	hasten_warning = "Temporus gains Hasten!",
} end )

L:RegisterTranslations("zhTW", function() return {
	next_portal = "下一個傳送門",

	portal = "傳送門警報",
	portal_desc = "廣播下一個傳送門即將開啟的警報訊息",

	portalbar = "傳送門計時條",
	portalbar_desc = "顯示下一個傳送門的計時條",

	portal_bar = "~%s: Wave %s",
	multiportal_bar = "同時存在多個傳送門",

	portal_warning20s = "20 秒後 %s 波！",
	portal_warning140s = "140 秒後 %s 波！",

	engage_trigger = "^The time has come! Gul'dan",

	-- These triggers generate warnings & bars bars based on mob deaths
	death_trigger1 = "不!裂縫……", --Time-Keeper/Lord
	death_trigger2 = "你永遠也不會擊敗我們全部的人!", --Time-Keeper/Lord
	death_trigger3 = "你會一無所成!", --Time-Keeper/Lord
	death_trigger4 = "時間……是站在我們這一邊的。", --Chrono Lord Deja
	death_trigger5 = "我的死……微不足道。", -- Temporus

	-- These triggers generate a bar indicating that a second portal will open if the current portal's elite is not defeated
	-- I am not sure if it is possible for a second portal to open on a boss fight
	spawn_trigger1 = "Let the siege begin!",--Time-Keeper/Lord
	spawn_trigger2 = "History is about to be rewritten!", --Time-Keeper/Lord
	spawn_trigger3 = "The sands of time shall be scattered to the winds!", --Time-Keeper/Lord
} end )

L:RegisterTranslations("koKR", function() return {
	next_portal = "다음 차원문",

	portal = "차원문 경고",
	portal_desc = "다음 차원문에 대한 접근 경고 메세지를 알립니다.",

	portalbar = "차원문 바",
	portalbar_desc = "다음 차원문에 대한 접근 타이머 바를 표시합니다.",

	portal_bar = "~%s: %s 균열",
	multiportal_bar = "~차원문 겹침",

	portal_warning20s = "약 20초 이내 %s!",
	portal_warning140s = "약 140초 이내 %s!",

	engage_trigger = "^때가 왔다, 굴단!",
	disable_trigger = "We will triumph. It is only a matter... of time.", -- check
	disable_warning = "%s has been saved!",

	-- These triggers generate warnings & bars bars based on mob deaths
	death_trigger1 = "안 돼! 균열을...", --Time-Keeper/Lord
	death_trigger2 = "우리 모두를 꺾지는 못할 것이다!", --Time-Keeper/Lord
	death_trigger3 = "너희는 아무것도 이루지 못할 것이다!", --Time-Keeper/Lord
	death_trigger4 = "시간은... 우리 편이다.", --Chrono Lord Deja
	death_trigger5 = "나의 죽음으로 달라질 것은... 없다.", -- Temporus

	-- These triggers generate a bar indicating that a second portal will open if the current portal's elite is not defeated
	-- I am not sure if it is possible for a second portal to open on a boss fight
	spawn_trigger1 = "공격을 시작하자!",--Time-Keeper/Lord
	spawn_trigger2 = "이제 역사가 다시 쓰일 것이다!", --Time-Keeper/Lord
	spawn_trigger3 = "시간의 모래가 바람에 흩어질지니!", --Time-Keeper/Lord

	-- Bosses
	frenzy = "아에누스 - 광란",
	frenzy_desc = "아에누스가 광란 시 경고합니다.",
	frenzy_trigger = "%s|1이;가; 광란의 상태에 빠집니다!",
	frenzy_warning = "광란 경고!",

	hasten = "템퍼루스 - 독촉",
	hasten_desc = "템퍼루스가 독촉에 걸릴 시 경고합니다.",
	hasten_trigger = "템퍼루스|1이;가; 독촉 효과를 얻었습니다.",
	hasten_warning = "템퍼루스 독촉!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(name)
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Black Morass"]
mod.enabletrigger = boss
mod.toggleoptions = {"portal", "portalbar", -1, "hasten", -1, "frenzy", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))
mod.synctoken = name

------------------------------
--      Initialization      --
------------------------------

function mod:OnRegister()
	self:RegisterEvent("ZONE_CHANGED")
end

function mod:OnDisable()
	self:RegisterEvent("ZONE_CHANGED")
end

function mod:OnEnable()
	self:RegisterEvent("ZONE_CHANGED")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if not self.db.profile.portal and not self.db.profile.portalbar then return end
	if msg == L["death_trigger1"] or msg == L["death_trigger2"] or msg == L["death_trigger3"] or msg == L["death_trigger4"] or msg == L["death_trigger5"] then
		if self.db.profile.portal then
			if wave == 6 then
				self:Message(L["portal_warning20s"]:format(boss1), "Attention")
			elseif wave == 12 then
				self:Message(L["portal_warning20s"]:format(boss2), "Attention")
			elseif wave == 18 then
				self:Message(L["portal_warning20s"]:format(boss3), "Attention")
			elseif wave == 7 or wave == 13 then
				self:Message(L["portal_warning140s"]:format(L["next_portal"]), "Attention")
				self:DelayedMessage(120, L["portal_warning20s"]:format(L["next_portal"]), "Attention")
			else
				self:Message(L["portal_warning20s"]:format(L["next_portal"]), "Attention")
			end
		end
		if self.db.profile.portalbar then
			self:TriggerEvent("BigWigs_StopBar", self, L["multiportal_bar"])
			if wave == 6 then
				self:Bar(L["portal_bar"]:format(boss1,wave), 20, "INV_Misc_ShadowEgg")
			elseif wave == 12 then
				self:Bar(L["portal_bar"]:format(boss2,wave), 20, "INV_Misc_ShadowEgg")
			elseif wave == 18 then
				self:Bar(L["portal_bar"]:format(boss3,wave), 20, "INV_Misc_ShadowEgg")
			elseif wave == 7 or wave == 13 then
				self:Bar(L["portal_bar"]:format(L["next_portal"],wave), 140, "INV_Misc_ShadowEgg")
			else
				self:Bar(L["portal_bar"]:format(L["next_portal"],wave), 20, "INV_Misc_ShadowEgg")
			end
		end
		wave = wave + 1
	end
	if msg:find(L["engage_trigger"]) then
		wave = 1
		self:Bar(L["portal_bar"]:format(L["next_portal"],wave), 15, "INV_Misc_ShadowEgg")
		wave = 2
	end
	if (msg == L["spawn_trigger1"] or msg == L["spawn_trigger2"] or msg == L["spawn_trigger3"]) and self.db.profile.portalbar then
		self:TriggerEvent("BigWigs_StopBar", self, L["multiportal_bar"])
		self:Bar(L["multiportal_bar"], 125, "INV_Misc_ShadowEgg")
	end
	if msg == L["disable_trigger"] then
		if self.db.profile.bosskill then self:Message(L["disable_warning"]:format(boss), "Bosskill", nil, "Victory") end
		BigWigs:ToggleModuleActive(self, false)
	end
end

function mod:ZONE_CHANGED(msg)
	if GetMinimapZoneText() ~= AceLibrary("Babble-Zone-2.2")["The Black Morass"] or BigWigs:IsModuleActive(name) then return end
	BigWigs:EnableModule(name)
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if self.db.profile.frenzy and msg == L["frenzy_trigger"] then
		self:Message(L["frenzy_warning"], "Important", nil, "Alert")
	end
end

function mod:CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS(msg)
	if self.db.profile.hasten and msg == L["hasten_trigger"] then
		self:Message(L["hasten_warning"], "Important", nil, "Alert")
	end
end
