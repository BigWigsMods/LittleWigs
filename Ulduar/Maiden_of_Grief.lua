------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Maiden of Grief"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "MaidenofGrief",

	engage_trigger = "You shouldn't have come...now you will die!",

	shock = "Shock of Sorrow",
	shock_desc = "Warn for the casting of Shock of Sorrow.",
	shock_message = "Casting Shock of Sorrow",
} end)

L:RegisterTranslations("deDE", function() return {
} end)

L:RegisterTranslations("frFR", function() return {
	engage_trigger = "Vous n'auriez jamais du venir ici… Maintenant, vous allez mourir !",

	shock = "Shock of Sorrow",
	shock_desc = "Prévient quand Shock of Sorrow est incanté.",
	shock_message = "Shock of Sorrow en incantation",
} end)

L:RegisterTranslations("koKR", function() return {
} end)

L:RegisterTranslations("zhCN", function() return {
	engage_trigger = "You shouldn't have come...now you will die!", -- not yet

	shock = "悲伤震荡",
	shock_desc = "当施放悲伤震荡时发出警报。",
	shock_message = "正在施放 悲伤震荡！",
} end)

L:RegisterTranslations("zhTW", function() return {
	engage_trigger = "You shouldn't have come...now you will die!", -- not yet

	shock = "哀傷震擊",
	shock_desc = "當施放哀傷震擊時發出警報。",
	shock_message = "正在施放 哀傷震擊！",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	engage_trigger = "You shouldn't have come...now you will die!",

	shock = "Шок от горя",
	shock_desc = "Предупреждать о применении шока от горя.",
	shock_message = "Применяется шок от горя",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Ulduar"
mod.zonename = BZ["Halls of Stone"]
mod.enabletrigger = boss
mod.guid = 27975
mod.toggleoptions = {"shock", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Shock", 50760, 59726)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Shock(_, spellId)
	if self.db.profile.shock then
		self:IfMessage(L["shock_message"], "Urgent", spellId)
		self:Bar(L["shock_message"], 4, spellId)
	end
end
