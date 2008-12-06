------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Krystallus"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Krystallus",

	shatter = "Shatter",
	shatter_desc = "Warn for Ground Slam and Shatter.",
	shatter_warn = "Ground Slam - Shatter in ~8 sec",
	shatter_message = "Shatter",

	shatterBar = "Shatter Bar",
	shatterBar_desc = "Show a bar for the approximate time until Shatter.",
	shatterBar_message "~Shatter",
} end)

L:RegisterTranslations("deDE", function() return {
	shatter = "Zertrümmern",
	shatter_desc = "Warnt vor Erde erschüttern und Zertrümmern.",
	shatter_warn = "Erde erschüttern - Zertrümmern in ~8 Sek!",
	shatter_message = "Zertrümmern!",
} end)

L:RegisterTranslations("frFR", function() return {
	shatter = "Fracasser",
	shatter_desc = "Prévient de l'arrivée du Heurt terreste et du Fracasser qui s'en suit.",
	shatter_warn = "Heurt terrestre - Fracasser dans ~8 sec !",
	shatter_message = "Fracasser !",

	shatterBar = "Fracasser - Barre",
	shatterBar_desc = "Affiche une barre indiquant le délai approximatif avant le prochain Fracasser.",
	shatterBar_message "~Fracasser",
} end)

L:RegisterTranslations("koKR", function() return {
	shatter = "산산조각",
	shatter_desc = "발 구르기와 산산조각을 알립니다.",
	shatter_warn = "발 구르기 - 약 8초 후 산산조각!",
	shatter_message = "산산조각!",
	
	shatterBar = "산산조각 바",
	shatterBar_desc = "산산조각 사용까지의 남은 시간을 바를 표시합니다.",
	shatterBar_message "~Shatter",
} end)

L:RegisterTranslations("zhCN", function() return {
	shatter = "碎裂",
	shatter_desc = "当施放砸击地面和碎裂时发出警报。",
	shatter_warn = "砸击地面 - 约8秒后，碎裂！",
	shatter_message = "碎裂！",

	shatterBar = "碎裂计时条",
	shatterBar_desc = "当碎裂之前显示大致计时条。",
	shatterBar_message "<碎裂>",
} end)

L:RegisterTranslations("zhTW", function() return {
	shatter = "粉碎",
	shatter_desc = "當施放大地猛擊和粉碎時發出警報。",
	shatter_warn = "大地猛擊 - 約8秒后，粉碎！",
	shatter_message = "粉碎！",

	shatterBar = "粉碎計時條",
	shatterBar_desc = "當粉碎之前顯示大致計時條。",
	shatterBar_message "<粉碎>",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	shatter = "Раскалывание",
	shatter_desc = "Предупреждать об ударе земли и раскалывании.",
	shatter_warn = "Удар Земли - Раскалывание через ~8 сек!",
	shatter_message = "Раскалывание!",
	
	shatterBar = "Полоса раскалывания",
	shatterBar_desc = "Отображать полосу с отсчетом времени то Раскалывания.",
	shatterBar_message "~Раскалывание",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Ulduar"
mod.zonename = BZ["Halls of Stone"]
mod.enabletrigger = boss
mod.guid = 27977
mod.toggleoptions = {"shatter", "shatterBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Slam", 50833)
	self:AddCombatListener("SPELL_CAST_START", "Shatter", 50810, 61546)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Slam(_, spellId, _, _, spellName)
	if self.db.profile.shatter then
		self:IfMessage(L["shatter_warn"], "Urgent", spellId)
	end
	if self.db.profile.shatterBar then
		self:Bar(L["shatterBar_message"], 8, spellId)
	end
end

function mod:Shatter(_, spellId)
	if self.db.profile.shatterBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["shatterBar_message"])
	end
	if self.db.profile.shatter then
		self:IfMessage(L["shatter_message"], "Urgent", spellId)
	end
end
