------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Ley-Guardian Eregos"]

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Eregos",
	
	planarshift = "Planar Shift",
	planarshift_desc = "Warns for Planar Shift",

	planarshiftbar = "Planar Shift Bar",
	planarshiftbar_desc = "Display a bar for the duration of Planar Shift.",

	planarshift_message = "Planar Shift",
	planarshift_expire_message = "Planar Shift ends in 5 sec",
	
	enragedassault = "Enraged Assault",
	enragedassault_desc = "Warns for Enraged Assault",

	enragedassultbar = "Enraged Assult Bar",
	enragedassultbar_desc = "Display a bar for the duraction of Enraged Assult.",

	enragedassault_message = "Enraged Assault",
	
	log = "|cffff0000"..boss.."|r: This boss needs data, please consider turning on your /combatlog or transcriptor and submit the logs.",
} end )

L:RegisterTranslations("koKR", function() return {
	planarshift = "차원 이동",
	planarshift_desc = "차원 이동을 알립니다.",

	planarshiftbar = "차원 이동 바",
	planarshiftbar_desc = "차원 이동의 지속 시간을 바로 표시합니다.",

	planarshift_message = "차원 이동",
	planarshift_expire_message = "5초 후 차원 이동 종료",
	
	enragedassault = "맹렬한 격노",
	enragedassault_desc = "맹렬한 격노를 알립니다.",

	enragedassultbar = "맹렬한 격노 바",
	enragedassultbar_desc = "맹렬한 격노의 지속시간을 바로 표시합니다.",

	enragedassault_message = "맹렬한 격노",
	
	log = "|cffff0000"..boss.."|r: 해당 보스의 데이터가 필요합니다. 채팅창에 /전투기록 , /대화기록 을 입력하여 기록된 데이터를 보내주시기 바랍니다.",
} end )

L:RegisterTranslations("frFR", function() return {
	planarshift = "Transfert planaire",
	planarshift_desc = "Prévient de l'arrivée des Transferts planaires.",

	planarshiftbar = "Transfert planaire - Barre",
	planarshiftbar_desc = "Affiche une barre indiquant la durée du Transfert planaire.",

	planarshift_message = "Transfert planaire",
	planarshift_expire_message = "Fin du Transfert planaire dans 5 sec.",

	enragedassault = "Assaut enragé",
	enragedassault_desc = "Prévient de l'arrivée des Assauts enragés.",

	enragedassultbar = "Assaut enragé - Barre",
	enragedassultbar_desc = "Affiche une barre indiquant la durée de l'Assaut enragé.",

	enragedassault_message = "Assaut enragé",
} end )

L:RegisterTranslations("zhTW", function() return {
	planarshift = "界域轉換",
	planarshift_desc = "當施放界域轉換時發出警報。",

	planarshiftbar = "界域轉換計時條",
	planarshiftbar_desc = "當界域轉換持續時顯示計時條。",

	planarshift_message = "界域轉換！",
	planarshift_expire_message = "界域轉換 5秒后結束！",
	
	enragedassault = "狂怒襲擊",
	enragedassault_desc = "當施放狂怒襲擊時發出警報。",

	enragedassultbar = "狂怒襲擊計時條",
	enragedassultbar_desc = "當狂怒襲擊持續時顯示計時條。",

	enragedassault_message = "狂怒襲擊！",
	
	log = "|cffff0000"..boss.."|r：缺乏數據，請考慮開啟戰斗記錄（/combatlog）或 Transcriptor 記錄并提交戰斗記錄，謝謝！",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	planarshift = "位面转移",
	planarshift_desc = "当施放位面转移时发出警报。",

	planarshiftbar = "位面转移计时条",
	planarshiftbar_desc = "当位面转移持续时显示计时条。",

	planarshift_message = "位面转移！",
	planarshift_expire_message = "位面转移 5秒后结束！",
	
	enragedassault = "暴怒攻击",
	enragedassault_desc = "当施放暴怒攻击时发出警报。",

	enragedassultbar = "暴怒攻击计时条",
	enragedassultbar_desc = "当暴怒攻击持续时显示计时条。",

	enragedassault_message = "暴怒攻击！",
	
	log = "|cffff0000"..boss.."|r：缺乏数据，请考虑开启战斗记录（/combatlog）或 Transcriptor 记录并提交战斗记录，谢谢！",
} end )

L:RegisterTranslations("ruRU", function() return {
	planarshift = "Сдвиг плоскости",
	planarshift_desc = "Предупреждать о Сдвиге плоскости",

	planarshiftbar = "Полоса Сдвига плоскости",
	planarshiftbar_desc = "Отображать полосу продолжительности Сдвига плоскости.",

	planarshift_message = "Сдвиг плоскости",
	planarshift_expire_message = "Конец Сдвига плоскости через 5 сек",
	
	enragedassault = "Яростный натиск",
	enragedassault_desc = "Предупреждать о Яростном натиске",

	enragedassultbar = "Полоса Яростного натиска",
	enragedassultbar_desc = "Отображать полосу продолжительности Яростного натиска.",

	enragedassault_message = "Яростный натиск",
	
	log = "|cffff0000"..boss.."|r: Для этого босса необходимы правильные данные. Пожалуйста, включите запись логов (команда /combatlog) или установите аддон transcriptor, и пришлите получившийся файл (или оставьте ссылку на файл в комментариях на curse.com).",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Oculus"]
mod.enabletrigger = {boss} 
mod.guid = 27656
mod.toggleoptions = {"planarshift", "planarshiftbar", -1, "enragedassault", "enragedassult", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	BigWigs:Print(L["log"])
	self:AddCombatListener("SPELL_AURA_APPLIED", "PlanarShift", 51162)
	self:AddCombatListener("SPELL_AURA_APPLIED", "EnragedAssault", 51170)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:PlanarShift(_, spellId, _, _, spellName)
	if self.db.profile.planarshift then
		self:IfMessage(L["planarshift_message"], "Important", spellId)
		self:DelayedMessage(13, L["planarshift_expire_message"], "Attention")
	end
	if self.db.profile.planarshiftbar then
		self:Bar(spellName, 18, spellId)
	end
end

function mod:EnragedAssault(player, spellId, _, _, spellName)
	if self.db.profile.enragedassult then
		self:IfMessage(L["enragedassault_message"], "Important", spellId)
	end
	if self.db.profile.enragedassultbar then
		self:Bar(spellName, 12, spellId)
	end
end
