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

	shock = "Shock of Sorrow",
	shock_desc = "Warn for the casting of Shock of Sorrow.",

	shockBar = "Shock of Sarrow Bar",
	shockBar_desc = "Display a casting bar for Shock of Sarrow",

	shock_message = "Casting Shock of Sorrow",
} end)

L:RegisterTranslations("deDE", function() return {
} end)

L:RegisterTranslations("frFR", function() return {
	shock = "Horion de chagrin",
	shock_desc = "Prévient quand Horion de chagrin est incanté.",
	shock_message = "Horion de chagrin en incantation",
} end)

L:RegisterTranslations("koKR", function() return {
	engage_trigger = "여기에 오지 말았어야 했다...이제 죽음을 맞이할 테니!",

	shock = "슬픔의 충격",
	shock_desc = "슬픔의 충격 시전을 알립니다.",
	shock_message = "슬픔의 충격 시전",
} end)

L:RegisterTranslations("zhCN", function() return {
	shock = "悲伤震荡",
	shock_desc = "当施放悲伤震荡时发出警报。",
	shock_message = "正在施放 悲伤震荡！",
} end)

L:RegisterTranslations("zhTW", function() return {
	shock = "哀傷震擊",
	shock_desc = "當施放哀傷震擊時發出警報。",
	shock_message = "正在施放 哀傷震擊！",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
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
mod.toggleoptions = {"shock", "shockBar", "bosskill"}
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

function mod:Shock(_, spellId, _, _, spellName)
	if self.db.profile.shock then
		self:IfMessage(L["shock_message"], "Urgent", spellId)
	end
	if self.db.profile.shockBar then
		self:Bar(spellName, 4, spellId)
	end
end
