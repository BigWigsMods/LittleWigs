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

	engage_trigger = "Crush....",

	shatter = "Shatter",
	shatter_desc = "Warn for Ground Slam and Shatter.",
	shatter_warn = "Ground Slam - Shatter in ~8 sec!",
	shatter_message = "Shatter!",
} end)

L:RegisterTranslations("deDE", function() return {
} end)

L:RegisterTranslations("frFR", function() return {
	engage_trigger = "Écraser…",

	shatter = "Fracasser",
	shatter_desc = "Prévient de l'arrivée du Heurt terreste et du Fracasser qui s'en suit.",
	shatter_warn = "Heurt terrestre - Fracasser dans ~8 sec !",
	shatter_message = "Fracasser !",
} end)

L:RegisterTranslations("koKR", function() return {
} end)

L:RegisterTranslations("zhCN", function() return {
	engage_trigger = "Crush....", -- not yet

	shatter = "碎裂",
	shatter_desc = "当施放砸击地面和碎裂时发出警报。",
	shatter_warn = "砸击地面 - 约8秒后，碎裂！",
	shatter_message = "碎裂！",
} end)

L:RegisterTranslations("zhTW", function() return {
	engage_trigger = "Crush....", -- not yet

	shatter = "粉碎",
	shatter_desc = "當施放大地猛擊和粉碎時發出警報。",
	shatter_warn = "大地猛擊 - 約8秒后，粉碎！",
	shatter_message = "粉碎！",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	engage_trigger = "Crush....",

	shatter = "Раскалывание",
	shatter_desc = "Предупреждать об ударе земли и раскалывании.",
	shatter_warn = "Удар Земли - Раскалывание через ~8 сек!",
	shatter_message = "Раскалывание!",
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
mod.toggleoptions = {"shatter", "bosskill"}
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
		self:Bar(L["shatter_message"], 8, spellId)
	end
end

function mod:Shatter(_, spellId)
	if self.db.profile.shatter then
		self:IfMessage(L["shatter_message"], "Urgent", spellId)
	end
end
