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
	
	engage_trigger1 = "I despise all of your kind!",
	engage_trigger2 = "Your head will roll!",
	engage_trigger3 = "Ba'ahn tha sol'dorei!", --check
	engage_message = "Engaged - channeling in ~15sec!",

	spell = "Spell Reflection",
	spell_desc = "Warn for Spell Reflection",
	spell_trigger = "gains Spell Reflection.$",
	spell_message = "Spell Reflection!",

	rage = "Warlord's Rage",
	rage_desc = "Warn for channeling of rage",
	rage_trigger1 = "^%s begins to channel",
	rage_trigger2 = "This is not nearly over...",
	rage_message = "Warlord is channeling!",
	rage_soon = "channeling soon!",
	rage_soonbar = "~Possible channeling",
} end )

L:RegisterTranslations("zhTW", function() return {
        engage_trigger1 = "我瞧不起你們族人!",
	engage_trigger2 = "你會人頭落地!",
	--engage_trigger3 = "Ba'ahn tha sol'dorei!",
	engage_message = "開戰 - 15 秒後可能輸送!",
	
	spell = "法術反射",
	spell_desc = "法術反射警報",
	spell_trigger = "獲得了法術反射的效果。$",
	spell_message = "法術反射! 法系停火!",

	rage = "督軍之怒",
	rage_desc = "督軍之怒警報",
	rage_trigger1 = "^%s開始從附近的蒸餾器輸送……",
	rage_trigger2 = "這離結束還差的遠……",
	rage_message = "即將發動督軍之怒! 快打蒸餾器!",
	rage_soon = "即將輸送!",
	rage_soonbar = "~可能輸送",
} end )

L:RegisterTranslations("frFR", function() return {
	--engage_trigger1 = "I despise all of your kind!",
	--engage_trigger2 = "Your head will roll!",
	--engage_trigger3 = "Ba'ahn tha sol'dorei!",
	--engage_message = "Engaged - channeling in ~15sec!",
	
	spell = "Renvoi de sort",
	spell_desc = "Préviens quand Kalithresh renvoye les sorts.",
	spell_trigger = "gagne Renvoi de sort.$",
	spell_message = "Renvoi de sort !",

	rage = "Rage du seigneur de guerre",
	rage_desc = "Préviens quand Kalithresh canalise de la rage.",
	rage_trigger1 = "^%s commence à canaliser un transfert du distillateur qui se trouve à côté…",
	rage_trigger2 = "C’est loin d’être terminé…",
	rage_message = "Canalisation en cours !",
	--rage_soon = "channeling soon!",
	--rage_soonbar = "~Possible channeling",
} end )

L:RegisterTranslations("deDE", function() return {
	--engage_trigger1 = "I despise all of your kind!",
	--engage_trigger2 = "Your head will roll!",
	--engage_trigger3 = "Ba'ahn tha sol'dorei!",
	--engage_message = "Engaged - channeling in ~15sec!",
	
	spell = "Zauberreflexion",
	spell_desc = "Warnt vor Zauberreflexion",
	spell_trigger = "bekommt 'Zauberreflexion'.$",
	spell_message = "Zauberreflexion!",

	rage = "Zorn des Kriegsf\195\188rsten",
	rage_desc = "Warnt, wenn Kalithresh kanalisiert",
	rage_trigger1 = "^%s beginnt Energien aus dem nahegelegenen Destillierer zu ziehen...",
	rage_trigger2 = "Wir sind noch lange nicht am Ende...",
	rage_message = "Kalithresh kanalisiert!",
	--rage_soon = "channeling soon!",
	--rage_soonbar = "~Possible channeling",
} end )

L:RegisterTranslations("koKR", function() return {
	engage_trigger1 = "네 종족은 정말 싫어!",
	engage_trigger2 = "곧 너희들의 시체가 산을 이룰 것이다.",
	engage_trigger3 = "바안탈소 도레이!",
	engage_message = "전투 시작 - 약 15초이내 채널링!",
	
	spell = "주문 반사",
	spell_desc = "주문 반사에 대한 경고",
	spell_trigger = "주문 반사 효과를 얻었습니다.$",
	spell_message = "주문 반사!",

	rage = "장군의 분노",
	rage_desc = "분노의 채널링에 대한 알림",
	rage_trigger1 = "^%s begins to channel", -- check
	rage_trigger2 = "아직 끝나지 않았다...",
	rage_message = "장군 채널링!",
	rage_soon = "잠시후 채널링!",
	rage_soonbar = "~채널링 대기시간",
} end )

L:RegisterTranslations("zhCN", function() return {
	--engage_trigger1 = "I despise all of your kind!",
	--engage_trigger2 = "Your head will roll!",
	--engage_trigger3 = "Ba'ahn tha sol'dorei!",
	--engage_message = "Engaged - channeling in ~15sec!",
	
	spell = "法术反射",
	spell_desc = "法术反射警报",
	spell_trigger = "获得了法术反射的效果。$",
	spell_message = "法术反射!",

	rage = "督军之怒",
	rage_desc = "督军之怒警报",
	rage_trigger1 = "^%s开始从附近的蒸馏器里吸取着什么……",--check
	rage_trigger2 = "还没完呢……",
	rage_message = "督军之怒 即将发动！ DPS！",
	--rage_soon = "channeling soon!",
	--rage_soonbar = "~Possible channeling",
} end )

L:RegisterTranslations("esES", function() return {
	--engage_trigger1 = "I despise all of your kind!",
	--engage_trigger2 = "Your head will roll!",
	--engage_trigger3 = "Ba'ahn tha sol'dorei!",
	--engage_message = "Engaged - channeling in ~15sec!",
	
	spell = "Reflejo de Hechizos",
	spell_desc = "Avisa cuando Kalithresh refleja hechizos",
	spell_trigger = "gana Reflejo de hechizos.$",
	spell_message = "Reflejo de Hechizos!",

	rage = "Warlord's Rage",
	rage_desc = "Avisa cuando Kalithresh est\195\161 canalizando ira",
	rage_trigger1 = "^%s comienza a canalizar",
	rage_trigger2 = "Esto todav\195\173a no ha terminado...", 
	rage_message = "Kalithresh est\195\161 canalizando ira!",
	--rage_soon = "channeling soon!",
	--rage_soonbar = "~Possible channeling",
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
		self:Bar(L["spell"], 8, "Spell_Shadow_AntiShadow")
	end
end

function mod:Channel(msg)
    if self.db.profile.engage and (msg == L["engage_trigger1"] or msg == L["engage_trigger2"] or msg:find(L["engage_trigger3"])) then
		self:Message(L["engage_message"], "Attention")
		self:Bar(L["rage_soonbar"], 15, "Spell_Nature_WispSplode")
	elseif self.db.profile.rage and (msg:find(L["rage_trigger1"]) or msg == L["rage_trigger2"]) then
		self:Message(L["rage_message"], "Urgent")
	end
end

