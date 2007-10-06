------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Warlord Kalithresh"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Kalithresh",

	spell = "Spell Reflection",
	spell_desc = "Warn for Spell Reflection",
	spell_trigger = "gains Spell Reflection.$",
	spell_message = "Spell Reflection!",

	rage = "Warlord's Rage",
	rage_desc = "Warn for channeling of rage",
	rage_trigger1 = "^%s begins to channel",
	rage_trigger2 = "This is not nearly over...",
	rage_message = "Warlord is channeling!",
} end )

L:RegisterTranslations("zhTW", function() return {
	spell = "法術反射",
	spell_desc = "法術反射警報",
	spell_trigger = "獲得了法術反射的效果。$",
	spell_message = "法術反射！ 法系停火！",

	rage = "督軍之怒",
	rage_desc = "督軍之怒警報",
	rage_trigger1 = "^%s開始從附近的蒸餾器輸送……",
	rage_trigger2 = "這離結束還差的遠……",
	rage_message = "即將發動督軍之怒！ DPS 蒸餾器！",
} end )

L:RegisterTranslations("frFR", function() return {
	spell = "Renvoi de sort",
	spell_desc = "Préviens quand Kalithresh renvoye les sorts.",
	spell_trigger = "gagne Renvoi de sort.$",
	spell_message = "Renvoi de sort !",

	rage = "Rage du seigneur de guerre",
	rage_desc = "Préviens quand Kalithresh canalise de la rage.",
	rage_trigger1 = "^%s commence à canaliser un transfert du distillateur qui se trouve à côté…",
	rage_trigger2 = "C’est loin d’être terminé…",
	rage_message = "Canalisation en cours !",
} end )

L:RegisterTranslations("deDE", function() return {
	spell = "Zauberreflexion",
	spell_desc = "Warnt vor Zauberreflexion",
	spell_trigger = "bekommt 'Zauberreflexion'.$",
	spell_message = "Zauberreflexion!",

	rage = "Zorn des Kriegsf\195\188rsten",
	rage_desc = "Warnt, wenn Kalithresh kanalisiert",
	rage_trigger1 = "^%s beginnt Energien aus dem nahegelegenen Destillierer zu ziehen...",
	rage_trigger2 = "Wir sind noch lange nicht am Ende...",
	rage_message = "Kalithresh kanalisiert!",
} end )

L:RegisterTranslations("koKR", function() return {
	spell = "주문 반사",
	spell_desc = "주문 반사에 대한 경고",
	spell_trigger = "주문 반사 효과를 얻었습니다.$",
	spell_message = "주문 반사!",

	rage = "장군의 분노",
	rage_desc = "분노의 채널링에 대한 알림",
	rage_trigger1 = "^%s begins to channel", -- check
	rage_trigger2 = "아직 끝나지 않았다...",
	rage_message = "장군 채널링!",
} end )

--Chinese Translation: 月色狼影@CWDG
--CWDG site: http://Cwowaddon.com
--督军卡利瑟里斯
L:RegisterTranslations("zhCN", function() return {
	spell = "法术反射",
	spell_desc = "法术反射警报",
	spell_trigger = "获得了法术反射的效果",
	spell_message = "法术反射!",

	rage = "督军之怒",
	rage_desc = "督军之怒警报",
	rage_trigger1 = "^%s开始从附近的蒸馏器里吸取着什么……",
	rage_trigger2 = "还没完呢……",
	rage_message = "督军之怒 即将发动！ DPS！",
} end )

L:RegisterTranslations("esES", function() return {
	spell = "Reflejo de Hechizos",
	spell_desc = "Avisa cuando Kalithresh refleja hechizos",
	spell_trigger = "gana Reflejo de hechizos.$",
	spell_message = "Reflejo de Hechizos!",

	rage = "Warlord's Rage",
	rage_desc = "Avisa cuando Kalithresh est\195\161 canalizando ira",
	rage_trigger1 = "^%s comienza a canalizar",
	rage_trigger2 = "Esto todav\195\173a no ha terminado...", 
	rage_message = "Kalithresh est\195\161 canalizando ira!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Steamvault"]
mod.enabletrigger = boss 
mod.toggleoptions = {"spell", "rage", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE", "Channel")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Channel")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS(msg)
	if self.db.profile.spell and msg:find(L["spell_trigger"]) then
		self:Message(L["spell_message"], "Attention")
	end
end

function mod:Channel(msg)
	if not self.db.profile.rage then return end
	if msg:find(L["rage_trigger1"]) or msg == L["rage_trigger2"] then
		self:Message(L["rage_message"], "Urgent")
	end
end
