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

	-- To let people know of possible issues with this module
	note = "Please note:  This module is know to not work 100% accurately ALL the time, it will be updated/fixed as time permits",
	
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

	portal_warning20s = "20 秒後 %s ！",
	portal_warning140s = "140 秒後 %s ！",

	engage_trigger = "^時候到了!古爾丹",
	disable_trigger = "我們會獲勝。這只是……時間的問題。",
	disable_warning = "%s 獲救了！",

	-- These triggers generate warnings & bars bars based on mob deaths
	death_trigger1 = "不!裂縫……", --Time-Keeper/Lord
	death_trigger2 = "你永遠也不會擊敗我們全部的人!", --Time-Keeper/Lord
	death_trigger3 = "你會一無所成!", --Time-Keeper/Lord
	death_trigger4 = "時間……是站在我們這一邊的。", --Chrono Lord Deja
	death_trigger5 = "我的死……微不足道。", -- Temporus

	-- These triggers generate a bar indicating that a second portal will open if the current portal's elite is not defeated
	-- I am not sure if it is possible for a second portal to open on a boss fight
	spawn_trigger1 = "繼續戰鬥!不要畏縮!",--Time-Keeper/Lord
	spawn_trigger2 = "歷史要改寫了!", --Time-Keeper/Lord
	spawn_trigger3 = "時間的沙塵將被散落風中!", --Time-Keeper/Lord

	-- Bosses
	frenzy = "艾奧那斯 - 狂亂",
	frenzy_desc = "艾奧那斯狂亂時發出警報",
	frenzy_trigger = "%s獲得了狂亂的效果。",
	frenzy_warning = "艾奧那斯狂亂了！",

	hasten = "坦普拉斯 - 迅速",
	hasten_desc = "坦普拉斯獲得迅速時發出警報",
	hasten_trigger = "坦普拉斯獲得了迅速的效果。",
	hasten_warning = "坦普拉斯獲得了迅速！",
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
	disable_trigger = "우리는 승리한다. 단지 시간문제일 뿐...", -- check
	disable_warning = "%s|1을;를; 지켰습니다!",

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

L:RegisterTranslations("frFR", function() return {
	note = "Attention : ce module n'est pas précis à 100% à tous les coups, cela sera corrigé quand le temps le permettra.",

	next_portal = "Proch. portail",

	portal = "Alertes des portails",
	portal_desc = "Préviens régulièrement quand apparaîtra le prochain portail.",

	portalbar = "Barres des portails",
	portalbar_desc = "Indique l'apparition probable du prochain portail via une barre temporelle.",

	portal_bar = "~%s : Vague %s",
	multiportal_bar = "~Plusieurs portails en même temps",

	portal_warning20s = "%s dans ~20 sec. !",
	portal_warning140s = "%s dans ~140 sec. !",

	engage_trigger = "^L'heure est venue ! Gul'dan",
	disable_trigger = "Nous triompherons. Ce n'est qu'une question... de temps.",
	disable_warning = "%s a été sauvé !",

	-- These triggers generate warnings & bars bars based on mob deaths
	death_trigger1 = "Non ! La faille…", --Time-Keeper/Lord
	death_trigger2 = "Vous ne pourrez jamais nous vaincre tous !", --Time-Keeper/Lord
	death_trigger3 = "Vous n'arriverez à rien !", --Time-Keeper/Lord
	death_trigger4 = "Le temps... est avec nous.", --Chrono Lord Deja
	death_trigger5 = "Ma mort ne signifie... rien.", -- Temporus

	-- These triggers generate a bar indicating that a second portal will open if the current portal's elite is not defeated
	-- I am not sure if it is possible for a second portal to open on a boss fight
	spawn_trigger1 = "Que le siège commence !",--Time-Keeper/Lord
	spawn_trigger2 = "L'histoire va être réécrite !", --Time-Keeper/Lord
	spawn_trigger3 = "Les sables du temps vont être dispersés aux quatre vents !", --Time-Keeper/Lord

	-- Bosses
	frenzy = "Aeonus - Frénésie",
	frenzy_desc = "Préviens quand Aeonus est pris de frénésie.",
	frenzy_trigger = "%s est pris de frénésie !",
	frenzy_warning = "Frénésie !",

	hasten = "Temporus - Précipiter",
	hasten_desc = "Préviens quand Temporus gagne Précipiter.",
	hasten_trigger = "Temporus gagne Précipiter.",
	hasten_warning = "Temporus gagne Précipiter !",
} end )

L:RegisterTranslations("zhCN", function() return {
	note = "请注意:  此模块不能完美的工作,在接下来的几周内我们将会完善此模块.同时请发送团队战斗纪录,以便更快的更新.",

	next_portal = "下一传送门",

	portal = "传送门警告",
	portal_desc = "通知全队注意下一传送门即将打开!.",

	portalbar = "传送门记时条",
	portalbar_desc = "显示下一个传送们打开的计时",

	portal_bar = "~%s: 波 %s",
	multiportal_bar = "~同时存在多个传送门",

	portal_warning20s = "20秒后 - %s !",
	portal_warning140s = "140秒后 %s !",

	engage_trigger = "^时机成熟了！古尔丹，命令你的术士们加倍努力！",
	disable_trigger = "我们会胜利的。这只是个……时间问题。",
	disable_warning = "%s 获救了",

	-- These triggers generate warnings & bars bars based on mob deaths
	death_trigger1 = "不！裂缝……", --Time-Keeper/Lord
	death_trigger2 = "别想打败我们！", --Time-Keeper/Lord
	death_trigger3 = "你终将一事无成！", --Time-Keeper/Lord
	death_trigger4 = "时间……在我们的掌握中。", --Chrono Lord Deja
	death_trigger5 = "我的死亡……不值一提。", -- Temporus

	-- These triggers generate a bar indicating that a second portal will open if the current portal's elite is not defeated
	-- I am not sure if it is possible for a second portal to open on a boss fight
	spawn_trigger1 = "继续战斗下去！不要胆怯！",--Time-Keeper/Lord
	spawn_trigger2 = "历史就要被改写了！", --Time-Keeper/Lord
	spawn_trigger3 = "时间之沙将随风而散！", --Time-Keeper/Lord

	-- Bosses
	frenzy = "埃欧努斯 - 狂乱",
	frenzy_desc = "当埃欧努斯进入狂乱时发出警报",
	frenzy_trigger = "%s变得狂怒无比！",
	frenzy_warning = "狂乱!",

	hasten = "坦普卢斯 - 时光加速",
	hasten_desc = "当获得了时光加速时发出警报",
	hasten_trigger = "坦普卢斯获得了时光加速的效果。",
	hasten_warning = "时光加速!",
} end )

L:RegisterTranslations("deDE", function() return {

	next_portal = "N\195\164chstes Portal",

	portal = "Portalwarnungen",
	portal_desc = "Ungef\195\164hre Warnung f\195\188r das n\195\164chste Portal.",

	portalbar = "Portalleiste",
	portalbar_desc = "Zeige ungef\195\164hre Zeitleiste f\195\188r das n\195\164chste Portal..",

	portal_bar = "~%s: Welle %s",
	multiportal_bar = "~Mehrere Portale gleichzeitig",

	portal_warning20s = "%s in ~20 Sekunden!",
	portal_warning140s = "%s in ~140 Sekunden!",

	engage_trigger = "^Die Zeit ist gekommen! Gul'dan",
	disable_trigger = "Wir werden siegen. Es ist nur eine Frage der Zeit...",
	disable_warning = "%s wurde gerettet!",

	-- These triggers generate warnings & bars bars based on mob deaths
	death_trigger1 = "Nein! Nicht das Loch...", --Time-Keeper/Lord
	death_trigger2 = "Ihr werdet uns niemals alle besiegen k?nnen!", --Time-Keeper/Lord
	death_trigger3 = "Ihr werdet nichts erreichen!", --Time-Keeper/Lord
	death_trigger4 = "Die Zeit... ist mit uns.", --Chrono Lord Deja
	death_trigger5 = "Mein Tod hat keine... Bedeutung.", -- Temporus

	-- These triggers generate a bar indicating that a second portal will open if the current portal's elite is not defeated
	-- I am not sure if it is possible for a second portal to open on a boss fight
	spawn_trigger1 = "M\195\182ge die Belagerung beginnen!",--Time-Keeper/Lord
	spawn_trigger2 = "Die Geschichte wird neu geschrieben werden!", --Time-Keeper/Lord
	spawn_trigger3 = "Die Sande der Zeit werden im Winde vergehen!", --Time-Keeper/Lord

	-- Bosses
	frenzy = "Aeonus - Raserei",
	frenzy_desc = "Warnen, wenn Aeonus in Raserei verf\195\164llt.",
	frenzy_trigger = "%s ger\195\164t in Raserei!",
	frenzy_warning = "Raserei! - Einlullender Schuss!",

	hasten = "Temporus - Hasten",
	hasten_desc = "Warnen, wenn Temporus 'Hasten' bekommt",
	hasten_trigger = "Temporus bekommt 'Hasten'.",
	hasten_warning = "Temporus bekommt 'Hasten'!",
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
--	self:RegisterEvent("UPDATE_WORLD_STATES") -- keep this commented out, function is at the bottom for Ulic though
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
	BigWigs:Print(L["note"])
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

--[[ Addded this commented out, it's code to fix the Black Morass module similar to HyjalSummit
-- Someone who does Black Morass more often can use this to fix the module
-- I did do some testing and the GetWorldStateUIInfo() call is the correct one.
-- The whole module can be fixed by using an Enable on hovering over Medivh as well instead of the ZONE_CHANGED hack which is not needed.
function mod:UPDATE_WORLD_STATES()
	if self.zonename ~= GetRealZoneText() then return end -- bail out in case we were left running in another zone
	local uiType, state, text = GetWorldStateUIInfo(2) -- Portals Opened %d/%d, tested and tried, it is GetWorldStateUIInfo(2)
	local num = tonumber((text or ""):match("(%d)") or nil) -- this needs a better match() string '%d/%d' I think
	if num and num > wave then
		-- new portal opened
		-- basically the wave code should be done here. 
	end
end
--]]