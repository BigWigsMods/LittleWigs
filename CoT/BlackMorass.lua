------------------------------
--      Are you local?      --
------------------------------

local name = AceLibrary("Babble-Zone-2.2")["The Black Morass"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..name)
local wave = 0

local BB = AceLibrary("Babble-Boss-2.2")
local boss = BB["Medivh"]
local boss1 = BB["Chrono Lord Deja"]
local boss2 = BB["Temporus"]
local boss3 = BB["Aeonus"]

L:RegisterTranslations("enUS", function() return {
	cmd = "Blackmorass",

	next_portal = "Next Wave",

	portal = "Wave Warnings",
	portal_desc = "Announce approximate warning messages for the next wave.",

	portalbar = "Wave Bars",
	portalbar_desc = "Display approximate timer bars for the next wave.",

	portal_bar = "~%s: Wave %s",
	multiportal_bar = "~Until Multiple waves",

	portal_warning15s = "%s in ~15 seconds!",
	portal_warning140s = "%s in ~140 seconds!",

	disable_trigger = "We will triumph. It is only a matter... of time.",
	disable_warning = "%s has been saved!",

	death_trigger = "(.+) dies%.",
	reset_trigger = "No! Damn this feeble, mortal coil!",
	
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

	portal_warning15s = "15 秒後 %s !",
	portal_warning140s = "140 秒後 %s !",

	disable_trigger = "我們會獲勝。這只是……時間的問題。",
	disable_warning = "%s 獲救了!",

	-- Bosses
	frenzy = "艾奧那斯 - 狂亂",
	frenzy_desc = "艾奧那斯狂亂時發出警報",
	frenzy_trigger = "%s獲得了狂亂的效果。",
	frenzy_warning = "艾奧那斯狂亂了!",

	hasten = "坦普拉斯 - 迅速",
	hasten_desc = "坦普拉斯獲得迅速時發出警報",
	hasten_trigger = "坦普拉斯獲得了迅速的效果。",
	hasten_warning = "坦普拉斯獲得了迅速!",
} end )

L:RegisterTranslations("koKR", function() return {
	next_portal = "다음 차원문",

	portal = "차원문 경고",
	portal_desc = "다음 차원문에 대한 접근 경고 메세지를 알립니다.",

	portalbar = "차원문 바",
	portalbar_desc = "다음 차원문에 대한 접근 타이머 바를 표시합니다.",

	portal_bar = "~%s: %s 균열",
	multiportal_bar = "~차원문 겹침",

	portal_warning15s = "약 15초 이내 %s!",
	portal_warning140s = "약 140초 이내 %s!",

	disable_trigger = "우리는 승리한다. 단지 시간문제일 뿐...", -- check
	disable_warning = "%s|1을;를; 지켰습니다!",

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
	next_portal = "Proch. portail",

	portal = "Alertes des portails",
	portal_desc = "Préviens régulièrement quand apparaîtra le prochain portail.",

	portalbar = "Barres des portails",
	portalbar_desc = "Indique l'apparition probable du prochain portail via une barre temporelle.",

	portal_bar = "~%s : Vague %s",
	multiportal_bar = "~Plusieurs portails en même temps",

	portal_warning15s = "%s dans ~15 sec. !",
	portal_warning140s = "%s dans ~140 sec. !",

	disable_trigger = "Nous triompherons. Ce n'est qu'une question... de temps.",
	disable_warning = "%s a été sauvé !",

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
	next_portal = "下一传送门",

	portal = "传送门警告",
	portal_desc = "通知全队注意下一传送门即将打开!.",

	portalbar = "传送门记时条",
	portalbar_desc = "显示下一个传送们打开的计时",

	portal_bar = "~%s: 波 %s",
	multiportal_bar = "~同时存在多个传送门",

	portal_warning15s = "15秒后 - %s !",
	portal_warning140s = "140秒后 %s !",

	disable_trigger = "我们会胜利的。这只是个……时间问题。",
	disable_warning = "%s 获救了",
	death_trigger = "(.+)死亡了。",
	--reset_trigger = "No! Damn this feeble, mortal coil!",

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

	portal_warning15s = "%s in ~15 Sekunden!",
	portal_warning140s = "%s in ~140 Sekunden!",

	disable_trigger = "Wir werden siegen. Es ist nur eine Frage der Zeit...",
	disable_warning = "%s wurde gerettet!",

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
mod.synctoken = "The Black Morass"
mod.enabletrigger = boss
mod.toggleoptions = {"portal", "portalbar", -1, "hasten", -1, "frenzy", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("UPDATE_WORLD_STATES")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["reset_trigger"] then
		self:TriggerEvent("BigWigs_RebootModule", self)
		wave = 0
	end
	if msg == L["disable_trigger"] then
		if self.db.profile.bosskill then self:Message(L["disable_warning"]:format(boss), "Bosskill", nil, "Victory") end
		BigWigs:ToggleModuleActive(self, false)
	end
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

function mod:CHAT_MSG_COMBAT_HOSTILE_DEATH(msg)
	mob = select(3, msg:find(L["death_trigger"]))
	if not ((mob == boss1) or (mob == boss2) or (mob == boss3)) then return end
	if self.db.profile.portal then
		self:Message(L["portal_warning140s"]:format(L["next_portal"]), "Attention")
	end
	if self.db.profile.portalbar then
		self:Bar(L["portal_bar"]:format(L["next_portal"],wave+1), 125, "INV_Misc_ShadowEgg")
	end
end

-- Thanks to Ammo and Mecdemort for their work on the MountHyjal Wave timers which these new BM timers were based on
function mod:UPDATE_WORLD_STATES()
	if self.zonename ~= GetRealZoneText() then return end
	local _, _, text = GetWorldStateUIInfo(2)
	local num = tonumber((text or ""):match("(%d+)") or nil)
	if num and num > wave then
		wave = wave + 1		
		if self.db.profile.portal then
			if wave == 6 then
				self:Message(L["portal_warning15s"]:format(boss1), "Attention")
			elseif wave == 12 then
				self:Message(L["portal_warning15s"]:format(boss2), "Attention")
			elseif wave == 18 then
				self:Message(L["portal_warning15s"]:format(boss3), "Attention")
			else
				self:Message(L["portal_warning15s"]:format(L["next_portal"]), "Attention")
			end
		end
		if self.db.profile.portalbar then
			self:TriggerEvent("BigWigs_StopBar", self, L["multiportal_bar"])
			self:Bar(L["multiportal_bar"], 127, "INV_Misc_ShadowEgg")			
			if wave == 6 then
				self:Bar(L["portal_bar"]:format(boss1,wave), 15, "INV_Misc_ShadowEgg")
			elseif wave == 12 then
				self:Bar(L["portal_bar"]:format(boss2,wave), 15, "INV_Misc_ShadowEgg")
			elseif wave == 18 then
				self:Bar(L["portal_bar"]:format(boss3,wave), 15, "INV_Misc_ShadowEgg")
			else
				self:Bar(L["portal_bar"]:format(L["next_portal"],wave), 15, "INV_Misc_ShadowEgg")
			end
		end
	end
end
