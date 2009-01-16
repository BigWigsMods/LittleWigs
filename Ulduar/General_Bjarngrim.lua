------------------------------
--      Are you local?      --
------------------------------

local boss = BB["General Bjarngrim"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Bjarngrim",

	mortalStrike = "Mortal Strike",
	mortalStrike_desc = "Warn when some has Mortal Strike debuff.",
	mortalStrike_message = "Mortal Strike: %s",

	mortalStrikeBar = "Mortal Strike Bar",
	mortalStrikeBar_desc = "Show a bar for the duration of the Mortal Strike debuff.",

	berserker = "Berserker Aura",
	berserker_desc = "Warn when General Bjarngrim gains and loses Berserker Aura.",
	berserker_applied = "Gained Berserker Aura",
	berserker_removed = "Berserker Aura Fades",
} end)

L:RegisterTranslations("deDE", function() return {
	mortalStrike = "T\195\182dlicher Sto\195\159",
	mortalStrike_desc = "Warnungn wenn jemand von T\195\182dlicher Sto\195\159 betroffen ist.",
	mortalStrike_message = "T\195\182dlicher Sto\195\159: %s",

	mortalStrikeBar = "T\195\182dlicher Sto\195\159-Anzeige",
	mortalStrikeBar_desc = "Eine Leiste mit der verbleibenden Debuff-Dauer von T\195\182dlicher Sto\195\159 anzeigen.",
	
	berserker = "Berserkeraura",
	berserker_desc = "Warnung wenn General Bjarngrim die Berserkeraura erh\195\164lt bzw. verliert.",
	berserker_applied = "Berserkeraura ist aktiv!",
	berserker_removed = "Berserkeraura ist ausgelaufen!",	
} end)

L:RegisterTranslations("frFR", function() return {
	mortalStrike = "Frappe mortelle",
	mortalStrike_desc = "Prévient quand un joueur subit les effets de la Frappe mortelle.",
	mortalStrike_message = "Frappe mortelle : %s",

	mortalStrikeBar = "Frappe mortelle - Barre",
	mortalStrikeBar_desc = "Affiche une barre indiquant la durée de la Frappe mortelle.",

	berserker = "Aura de berserker",
	berserker_desc = "Prévient quand le Général Bjarngrim gagne et perd son Aura de berserker.",
	berserker_applied = "Aura de berserker gagnée",
	berserker_removed = "Aura de berserker disparue",
} end)

L:RegisterTranslations("koKR", function() return {
	mortalStrike = "죽음의 일격",
	mortalStrike_desc = "죽음의 일격 디버프가 걸린 플레이어를 알립니다.",
	mortalStrike_message = "죽음의 일격: %s",

	mortalStrikeBar = "죽음의 일격 바",
	mortalStrikeBar_desc = "죽음의 일격 디버프가 지속되는 바를 표시합니다.",

	berserker = "광폭 오라",
	berserker_desc = "장군 뱌른그림의 광폭 오라 획득과 사라짐을 알립니다.",
	berserker_applied = "광폭 오라 획득",
	berserker_removed = "광폭 오라 사라짐",
} end)

L:RegisterTranslations("zhCN", function() return {
	mortalStrike = "致死打击",
	mortalStrike_desc = "当玩家中了致死打击减益时发出警报。",
	mortalStrike_message = "致死打击：>%s<！",

	mortalStrikeBar = "致死打击计时条",
	mortalStrikeBar_desc = "当致死打击减益持续时显示计时条。",

	berserker = "狂暴光环",
	berserker_desc = "当比亚格里将军获得狂暴光环或消退时发出警报。",
	berserker_applied = "获得 狂暴光环！",
	berserker_removed = "狂暴光环 消退！",
} end)

L:RegisterTranslations("zhTW", function() return {
	mortalStrike = "致死打擊",
	mortalStrike_desc = "當玩家中了致死打擊減益時發出警報。",
	mortalStrike_message = "致死打擊：>%s<！",

	mortalStrikeBar = "致死打擊計時條",
	mortalStrikeBar_desc = "當致死打擊減益持續時顯示計時條。",

	berserker = "狂暴者光環",
	berserker_desc = "當畢亞格林將軍獲得狂暴者光環或消退時發出警報。",
	berserker_applied = "獲得 狂暴者光環！",
	berserker_removed = "狂暴者光環 消退！",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	mortalStrike = "Смертельный удар",
	mortalStrike_desc = "Предупреждать, когда кто-нибудь получает дебафф от смертельного удара.",
	mortalStrike_message = "Смертельный удар: %s",

	mortalStrikeBar = "Полоса смертельного удара",
	mortalStrikeBar_desc = "Отображение полосы продолжительности дебаффа от смертельного удара.",

	berserker = "Аура берсерка",
	berserker_desc = "Предупреждать, когда Генерал Бьярнгрин получает или снемает Аура берсерка.",
	berserker_applied = "Применена Аура берсерка",
	berserker_removed = "Аура берсерка рассеялась",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Ulduar"
mod.zonename = BZ["Halls of Lightning"]
mod.enabletrigger = boss
mod.guid = 28586
mod.toggleoptions = {"mortalStrike", "mortalStrikeBar", -1, "berserker", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "MortalStrike", 16856)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Berserker", 41107)
	self:AddCombatListener("SPELL_AURA_REMOVED", "BerserkerRemoved", 41107)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:MortalStrike(player, spellId)
	if self.db.profile.mortalStrike then
		self:IfMessage(L["mortalStrike_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.mortalStrikeBar then
		self:Bar(L["mortalStrike_message"]:format(player), 5, spellId)
	end
end

function mod:Berserker(target, spellId)
	if self.db.profile.beserker and (target == boss) then
		self:IfMessage(L["berserker_applied"]:format(player), "Urgent", spellId)
	end
end

function mod:BerserkerRemoved(player, spellId)
	if self.db.profile.beserker and (target == boss) then
		self:IfMessage(L["berserker_removed"], "Attention", spellId)
	end
end
